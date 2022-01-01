文法と入れ子マッチ
------------------

概要
^^^^

正規表現を C++ の式で表現することの重要な利点の 1 つは、正規表現中から他の C++ コードやデータに容易にアクセスできることである。これにより、他の正規表現で不可能なプログラミングイディオムが可能になる。特に注意していただきたいのは、正規表現が他の正規表現を参照する機能で、これにより正規表現の外部で文法を構築できる。この節では正規表現を他の正規表現に値や参照で組み込む方法、正規表現が他の正規表現を参照したときの振る舞い、解析が成功した後の結果木にアクセスする方法を説明する。


値による正規表現の組み込み
^^^^^^^^^^^^^^^^^^^^^^^^^^

:cpp:struct:`basic_regex\<>` オブジェクトは値のセマンティクスをもつ。正規表現オブジェクトが別の正規表現定義の右辺に現れると、値による組み込みが起こるとみなされる。つまり、入れ子の正規表現のコピーが外側の正規表現に格納される。内側の正規表現は、パターンマッチ時に外側の正規表現により呼び出される。内側の正規表現をマッチに対して完全に消耗すると、マッチを成功させるためにバックトラックが起こる。

単語単位の正規表現検索機能をもつテキストエディタを考える。これを xpressive で実装すると次のようになる。 ::

   find_dialog dlg;
   if( dialog_ok == dlg.do_modal() )
   {
       std::string pattern = dlg.get_text();          // ユーザーが入力したパターン
       bool whole_word = dlg.whole_word.is_checked(); // ユーザーが単語単位のオプションを選択したか？

       sregex re = sregex::compile( pattern );        // パターンのコンパイル

       if( whole_word )
       {
           // 正規表現を単語の先頭、単語の終端表明で囲む
           re = bow >> re >> eow;
       }

       // ... re を使う ...
   }

この行に注目する。 ::

   // 正規表現を単語の先頭、単語の終端表明で囲む
   re = bow >> re >> eow;

この行は既存の正規表現を値で組み込んだ正規表現を新たに作成し、元の正規表現に代入している。元の正規表現のコピーが右辺にあるので、これは期待したとおりに動作する。つまり、新しい正規表現の振る舞いは元の正規表現を単語先頭と単語終端の表明で囲んだものとなる。

.. note::
   既定では正規表現オブジェクトは値で組み込まれるため、:cpp:expr:`re = bow >> re >> eow` は再帰正規表現を定義\ **しない**\ことに注意していただきたい。次の節では、正規表現を参照で組み込んで再帰正規表現を定義する方法を述べる。


参照による正規表現の組み込み
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

再帰正規表現および文脈自由文法を構築するには、値による正規表現の組み込みでは不十分である。正規表現を自己参照的にする必要がある。大半の正規表現エンジンにはそういった能力はないが、xpressive では可能である。

.. tip::
   理論コンピュータ科学者は、自己参照的な正規表現は「正規（正則）」ではないと指摘するかもしれない。そういう意味では、厳密には xpressive は本当は\ **正規**\表現エンジンではない。しかし Larry Wall がかつてこう言ったことがある。「項 [regular expression] は我々のパターンマッチエンジンとともに成長した。言語の必要性と戦うつもりはない。」

次のコードを考える。:cpp:func:`by_ref()` ヘルパを使って、数の合った入れ子の括弧にマッチする再帰正規表現を定義している。 ::

   sregex parentheses;
   parentheses                          // 数の合った括弧群は...
       = '('                            // 最初に 1 つの開き括弧があり...
           >>                           // その後ろに...
            *(                          // 0 か 1 つ以上の...
               keep( +~(set='(',')') )  // 括弧以外のものの塊か...
             |                          // あるいは...
               by_ref(parentheses)      // 数の合った括弧群があり
             )                          //   （これだ、再帰している！）...
           >>                           // その後ろに...
         ')'                            // 1 つの閉じ括弧がある
       ;

数の合った入れ子のタグに対するマッチは重要なテキスト処理であり、「旧式の」正規表現では不可能なことの 1 つである。:cpp:func:`by_ref()` ヘルパがこれを可能にする。これによりある正規表現を別の正規表現から\ **参照により**\組み込むことができる。右辺が :cpp:var:`!parentheses` を参照で保持しているので、:cpp:var:`!parentheses` に右辺を代入すると循環が生まれ再帰的に実行される。


文法の構築
^^^^^^^^^^

正規表現が自己再帰的になりさえすれば、もう後戻りする必要はない。楽しみにしていたことがすべて可能になる。特に正規表現の外部で文法を構築できるようになる。text-book 文法の例を見よう。ちょっとした計算機だ。 ::

   sregex group, factor, term, expression;

   group       = '(' >> by_ref(expression) >> ')';
   factor      = +_d | group;
   term        = factor >> *(('*' >> factor) | ('/' >> factor));
   expression  = term >> *(('+' >> term) | ('-' >> term));

上で定義した正規表現 :cpp:var:`!expression` は正規表現としては非常に注目すべき動作をする。数式にマッチするのである。例えば入力文字列が :regexp:`foo 9*(10+3) bar` であれば、このパターンは :regex-input:`9*(10+3)` にマッチする。この正規表現がマッチするのは正しい形式の数式、つまり括弧の数が合っており、中置演算子が引数を2つもつ場合のみである。他の正規表現エンジンでこれを試してはいけませんぞ！

この正規表現文法をもっとよく見てみよう。循環していることに注意していただきたい。:cpp:var:`!expression` は :cpp:var:`!term` を使って実装してあり、:cpp:var:`!term` は :cpp:var:`!factor` を使って実装してある。:cpp:var:`!factor` は :cpp:var:`!group` を使って実装してあり、:cpp:var:`!group` は :cpp:var:`!expression` を使って実装してある。というわけでループが閉じている。大抵の場合、循環文法の定義は正規表現オブジェクトの前方宣言とこれら未初期化の正規表現の参照による組み込みにより行う。上の文法では、未初期化の正規表現オブジェクトを参照する必要があるのは1箇所だけである。それが :cpp:var:`!group` の定義であり、:cpp:func:`by_ref()` を使って :cpp:var:`!expression` を参照により組み込んでいる。他の正規表現オブジェクトはすべて初期化済みで値が変化することもないため、値による組み込みで事足りている。

.. tip::
   .. rubric:: ヒント：可能な限り、値による組み込みを使え

   通常、正規表現の組み込みは参照よりも値で行うほうが望ましい。そのほうが分かりやすいし、パターンマッチが少し高速になる。その上、値のセマンティクスは簡単で文法の推論が容易になる。正規表現の「コピー」の負荷については心配しないでいただきたい。各正規表現オブジェクトはコピー間で実装を共有する。


動的正規表現文法
^^^^^^^^^^^^^^^^

:cpp:struct:`regex_compiler\<>` を使用して動的正規表現の外部で文法を構築することもできる。名前付きの正規表現を作成し、他の正規表現から名前で参照するのである。各 :cpp:struct:`regex_compiler\<>` インスタンスは名前と正規表現の対応を保持する。

名前付き動的正規表現を作成するには、正規表現の先頭に :regexp:`(?$name=)` を付ける。:samp:`{name}` は正規表現の名前である。名前付き正規表現を他の正規表現から名前で参照するには :regexp:`(?$name)` とする。名前付き正規表現は他の正規表現から参照する時点では存在していなくても構わないが、正規表現を使用する時点では存在していなければならない。

以下のコード片は、動的正規表現文法を使って上の計算機の例を実装している。 ::

   using namespace boost::xpressive;
   using namespace regex_constants;

   sregex expr;

   {
        sregex_compiler compiler;
        syntax_option_type x = ignore_white_space;

               compiler.compile("(? $group  = ) \\( (? $expr ) \\) ", x);
               compiler.compile("(? $factor = ) \\d+ | (? $group ) ", x);
               compiler.compile("(? $term   = ) (? $factor )"
                                " ( \\* (? $factor ) | / (? $factor ) )* ", x);
        expr = compiler.compile("(? $expr   = ) (? $term )"
                                "   ( \\+ (? $term ) | - (? $term )   )* ", x);
   }

   std::string str("foo 9*(10+3) bar");
   smatch what;

   if(regex_search(str, what, expr))
   {
        // "9*(10+3)" を印字する:
        std::cout << what[0] << std::endl;
   }

静的正規表現の場合と同様、入れ子の正規表現を呼び出すと入れ子のマッチ結果が作成される（以下の「入れ子の結果」を見よ）。結果はマッチした文字列の完全な解析木である。静的正規表現と異なり、動的正規表現は常に値ではなく参照による組み込みとなる。


循環パターンにコピーにメモリ管理まで、まあ何てこと！
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

上の計算機の例で非常に複雑なメモリ管理の問題が持ち上がる。4 つの正規表現オブジェクトは直接・間接的に、また値・参照でお互いを参照している。このうちの 1 つを関数から返し、残りがスコープの外に出るとどうなるのか？ 参照はどうなるのか？ 答えは、正規表現オブジェクトは内部に参照カウントを持つため必要な限り正規表現による参照は保持される、である。よって正規表現オブジェクトを値で渡しても、それがスコープの外に行ってしまった正規表現オブジェクトを参照していたとしても問題は起きない。

参照カウントに詳しい人はおそらくその唯一の弱点についてもご存知と思う。循環参照である。正規表現オブジェクトを参照カウントすると、計算機の例で作成したような循環はどうなるのか？ リークが起こるのか？ 答えはノーであり、リークは起きない。:cpp:struct:`basic_regex\<>` オブジェクトは技巧的な参照追跡コードを使っており、最後の外部参照が無くなったときに循環正規表現文法はクリーンアップされる。そういうわけで心配無用だ。好きなだけ循環文法を作成したり、正規表現オブジェクトを渡したりコピーしていただきたい。高速かつ高効率で、リークや懸垂参照（dangling references）が起きないことが保証されている。


入れ子の正規表現と部分マッチのスコープ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

正規表現を入れ子にすると部分マッチのスコープの問題が持ち上がる。内側と外側の両方の正規表現が同じ部分マッチのベクタを読み書きすると、混乱が起こる。外側の正規表現が書き込んだ部分マッチを内側の正規表現が台無しにするわけだ。例えば、これはどうなるか。 ::

   sregex inner = sregex::compile( "(.)\\1" );
   sregex outer = (s1= _) >> inner >> s1;

外側の正規表現が書き込んだ部分マッチを内側の正規表現が上書きしているが、おそらくこのコードの作者が意図するところではないだろう。内側の正規表現がユーザーから入力である場合は、特に大問題である。内側の正規表現が部分マッチのベクタを破壊するかどうか知る方法が無いのである。これは明らかに許容できるものではない。

代わりにどうするのかというと、入れ子の正規表現を呼び出すたびに自身のスコープを形成する。つまり入れ子の正規表現はそれぞれ対象となる部分マッチのベクタについて自分用のコピーを取得するため、外側の正規表現の部分マッチを内側の正規表現が台無しにする可能性は無くなる。例えば上で定義した正規表現 :cpp:var:`!outer` は、当然 :regex-input:`ABBA` にマッチする。


入れ子の結果
^^^^^^^^^^^^

入れ子の正規表現が自身の部分マッチをもつのであれば、マッチ成功後にそれらにアクセスする方法があってしかるべきである。:cpp:func:`regex_match()` か :cpp:func:`regex_search()` の後、:cpp:struct:`match_results\<>` 構造体は入れ子の結果を表す木の頂点のように振舞う。:cpp:struct:`match_results\<>` クラスは、入れ子の正規表現の結果を表す :cpp:struct:`match_results\<>` 構造体の順序付きシーケンスを返す :cpp:func:`nested_results()` メンバ関数を提供する。入れ子の結果の順序は、入れ子の正規表現がマッチした順序と同じである。

前に見た、数の合った入れ子の括弧の正規表現を例にとる。 ::

   sregex parentheses;
   parentheses = '(' >> *( keep( +~(set='(',')') ) | by_ref(parentheses) ) >> ')';

   smatch what;
   std::string str( "blah blah( a(b)c (c(e)f (g)h )i (j)6 )blah" );

   if( regex_search( str, what, parentheses ) )
   {
       // マッチ全体を表示する
       std::cout << what[0] << '\n';

       // 入れ子の結果を表示する
       std::for_each(
           what.nested_results().begin(),
           what.nested_results().end(),
           output_nested_results() );
   }

このプログラムは以下を表示する。

.. code-block:: console

   ( a(b)c (c(e)f (g)h )i (j)6 )
       (b)
       (c(e)f (g)h )
           (e)
           (g)
       (j)

結果がどのように入れ子になるか、それらが見つかった順に格納されていることが分かったと思う。

.. tip::

   :doc:`例 <examples>`\の節にある :ref:`output_nested_results <examples.display_a_tree_of_nested_results>` の定義を見よ。


入れ子の結果のフィルタリング
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1 つの正規表現の中に複数の入れ子の正規表現があり、どの結果がどの正規表現に対応するのか知りたい場合がある。:cpp:func:`basic_regex::regex_id()` と :cpp:func:`match_results::regex_id()` が役に立つ場面である。入れ子の結果を走査しているときに、結果の正規表現 ID と目的の正規表現オブジェクトの ID を比較するとよい。

これを少し容易にするために、xpressive は特定の入れ子正規表現に相当する結果だけを列挙する述語を提供している。これが :cpp:struct:`regex_id_filter_predicate` であり、`Boost.Iterator`_ とともに使用することを意図している。以下のように使用する。 ::

   sregex name = +alpha;
   sregex integer = +_d;
   sregex re = *( *_s >> ( name | integer ) );

   smatch what;
   std::string str( "marsha 123 jan 456 cindy 789" );

   if( regex_match( str, what, re ) )
   {
       smatch::nested_results_type::const_iterator begin = what.nested_results().begin();
       smatch::nested_results_type::const_iterator end   = what.nested_results().end();

       // 名前（name）か整数（integer）だけを選択する述語フィルタを宣言する
       sregex_id_filter_predicate name_id( name.regex_id() );
       sregex_id_filter_predicate integer_id( integer.regex_id() );

       // 正規表現 name の結果だけを走査する
       std::for_each(
           boost::make_filter_iterator( name_id, begin, end ),
           boost::make_filter_iterator( name_id, end, end ),
           output_result
           );

       std::cout << '\n';

       // 正規表現 integer の結果だけを走査する
       std::for_each(
           boost::make_filter_iterator( integer_id, begin, end ),
           boost::make_filter_iterator( integer_id, end, end ),
           output_result
           );
   }

ここで :cpp:func:`!output_results` は :cpp:type:`smatch` を受け取りマッチ全体を表示する単純な関数である。特定の入れ子正規表現に相当する結果だけを選択するのに :cpp:struct:`regex_id_filter_predicate` を :cpp:func:`basic_regex::regex_id()` と `Boost.Iterator`_ の :cpp:func:`!boost::make_filter_iterator()` とともに使っている点に注意していただきたい。このプログラムは以下を表示する。

.. code-block:: console

   marsha
   jan
   cindy
   123
   456
   789


.. _Boost.Iterator: http://www.boost.org/libs/iterator/
