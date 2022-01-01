意味アクションとユーザー定義表明
--------------------------------

概要
^^^^

入力文字列を解析し、そこから :cpp:class:`!std::map\<>` を構築したいとする。このような場合、正規表現では不十分である。正規表現マッチの部分で\ **何か**\をしたい。xpressive は、静的正規表現の部分に意味アクションを結びつける方法を提供する。本節ではその方法を説明する。


意味アクション（Semantic Actions）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

以下のコードを考える。xpressive の意味アクションを使って単語と整数の組からなる文字列を解析し、:cpp:class:`!std::map\<>` に詰め込んでいる。 ::

   #include <string>
   #include <iostream>
   #include <boost/xpressive/xpressive.hpp>
   #include <boost/xpressive/regex_actions.hpp>
   using namespace boost::xpressive;

   int main()
   {
       std::map<std::string, int> result;
       std::string str("aaa=>1 bbb=>23 ccc=>456");

       // => で区切られた単語と整数にマッチし、
       // 結果を std::map<> に詰め込む
       sregex pair = ( (s1= +_w) >> "=>" >> (s2= +_d) )
           [ ref(result)[s1] = as<int>(s2) ];

       // 空白で区切られた 1 つ以上の単語・整数の組にマッチする。
       sregex rx = pair >> *(+_s >> pair);

       if(regex_match(str, rx))
       {
           std::cout << result["aaa"] << '\n';
           std::cout << result["bbb"] << '\n';
           std::cout << result["ccc"] << '\n';
       }

       return 0;
   }

このプログラムは以下を印字する。

.. code-block:: console

   1
   23
   456

正規表現 :cpp:var:`!pair` は、パターンとアクションの 2 つの部分からなる。単語のマッチを 1 番目の部分マッチで捕捉し、:regex-input:`=>` で区切られた整数のマッチを 2 番目の部分マッチで捕捉するというのがパターンが表現するところである。アクションは角括弧 :code:`[ ref(result)[s1] = as<int>(s2) ]` の内側である。これは 1 番目の部分マッチを :cpp:var:`!results` 辞書の添字に使用し、そこに2番目の部分マッチを整数に変換した結果を代入するという意味である。

.. note::
   静的正規表現で意味アクションを使用するには、:file:`<boost/xpressive/regex_actions.hpp>` をインクルードしなければならない。

このコードはどのように動作するのだろう？ 静的正規表現の残りの部分だけ見ると括弧の間は式テンプレートになっている。これでアクションがコード化され、後で実行される。式 :cpp:expr:`ref(result)` は :cpp:var:`!result` への遅延参照を作成する。より大きな式である :cpp:expr:`ref(result)[s1]` は辞書に対する添字操作の遅延である。後でこのアクションを実行すると :cpp:var:`!s1` は 1 番目の :cpp:struct:`sub_match\<>` で置換される。同様に :cpp:expr:`as<int>(s2)` を実行すると :cpp:var:`!s2` は 2 番目の :cpp:struct:`sub_match\<>` で置換される。:cpp:func:`as\<>` アクションは引数を Boost.Lexical_cast を使って要求の型に変換する。アクション全体の効果としては、新しい単語・整数の組を辞書に挿入する、となる。

.. note::
   :file:`<boost/ref.hpp>` の関数 :cpp:func:`!boost::ref()` と :file:`<boost/xpressive/regex_actions.hpp>` の :cpp:func:`boost::xpressive::ref()` には重大な違いがある。前者は通常の参照とほぼ同様の振る舞いをする素の :cpp:struct:`reference_wrapper\<>` を返す。一方 :cpp:func:`boost::xpressive::ref()` が返すのは、遅延実行する式内で使用する遅延参照である。これが、:cpp:var:`!result` が :cpp:var:`s1` を受け取る :cpp:func:`!operator[]` をもたないにも関わらず :cpp:expr:`ref(result)[s1]` とする理由である。

部分マッチのプレースホルダ :cpp:var:`s1` 、:cpp:var:`s2` に加えて、アクションが結び付けられている部分式にマッチした文字列を後方参照するのにアクション内で使用するプレースホルダー :cpp:var:`_` がある。例えば以下の正規表現は数字列にマッチし、それらを整数として解釈して結果をローカル変数に代入する。 ::

   int i = 0;
   // ここで _ は (+_d) にマッチしたすべての文字を後方参照する
   sregex rex = (+_d)[ ref(i) = as<int>(_) ];


アクションの遅延実行
^^^^^^^^^^^^^^^^^^^^

アクションを正規表現のある部分に結び付けてマッチを行うとは、実際にはどういう意味なのか？ アクションが実行されるのはいつなのか？ アクションが繰り返し部分式の一部である場合は、アクションが実行される回数は1度なのか複数回なのか？ また部分式が最初はマッチしていたが正規表現の残りの部分がマッチせず最終的に失敗した場合は、アクションはまったく実行されないのか？

答えは既定では、アクションは\ **遅延**\実行される、である。部分式が文字列にマッチすると、そのアクションはアクションが参照する部分マッチの現在の値とともに待ち行列に置かれる。マッチアルゴリズムがバックトラックしなければならなくなると、アクションは必要に応じて待ち行列から取り出される。アクションが実際に実行されるのは、正規表現全体のマッチが成功した後だけである。:cpp:func:`regex_match()` が制御を返す直前の段階で、これらは待ち行列に追加した順番で一度にすべて実行される。

例として、以下の数字を見つけるたびにカウンタを増やす正規表現を考える。 ::

   int i = 0;
   std::string str("1!2!3?");
   // 感嘆符の付いた数字は数えるが、疑問符付きのものは数えない。
   sregex rex = +( _d [ ++ref(i) ] >> '!' );
   regex_search(str, rex);
   assert( i == 2 );

アクション :cpp:expr:`++ref(i)` は 3 回（数字が見つかるたびに 1 回ずつ）待ち行列に入る。しかし\ **実行**\されるのは 2 回だけ（後ろに :regex-input:`!` 文字がある数字 1 字について 1 回ずつ）である。:regex-input:`?` 文字に遭遇するとマッチアルゴリズムはバックトラックを行い、待ち行列から最後のアクションを削除する。


アクションの即時実行
^^^^^^^^^^^^^^^^^^^^

意味アクションを即時実行したい場合は、そのアクションを含む部分式を :cpp:func:`keep()` で包む。:cpp:func:`keep()` は当該部分式についてバックトラックを無効にし、その部分式の待ち行列に入っているあらゆるアクションを :cpp:func:`keep()` の終了とともに実行する。これにより、あたかも :cpp:func:`keep()` 内の部分式が別の正規表現オブジェクトにコンパイルされ、:cpp:func:`keep()` のマッチングが :cpp:func:`regex_search()` を個別に呼び出して実行されたかのようになる。結果この部分式は文字にマッチしアクションを実行するが、バックトラックも巻き戻しもしない。例えば上の例を以下のように書き換えたとする。 ::

   int i = 0;
   std::string str("1!2!3?");
   // 数字をすべて数える。
   sregex rex = +( keep( _d [ ++ref(i) ] ) >> '!' );
   regex_search(str, rex);
   assert( i == 3 );

部分式 :cpp:expr:`_d [++ref(i) ]` を :cpp:func:`keep()` で包んだ。こうすることでこの正規表現が数字にマッチするとアクションが待ち行列に入り、:regex-input:`!` 文字のマッチを試行する前に即時実行されるようになる。この場合、アクションは 3 回実行される。

.. note::
   :cpp:func:`keep()` と同様、:cpp:func:`before()` と :cpp:func:`after()` 内のアクションも、その部分式がマッチしたときに早期実行される。


遅延関数
^^^^^^^^

ここまで変数と演算子からなる意味アクションの記述方法について見てきたが、意味アクションから関数を呼び出す方法についてはどうだろう？ xpressive にはそのための機構がある。

まず関数オブジェクト型を定義する。以下の例は引数に対して :cpp:func:`!push()` を呼び出す関数オブジェクトである。 ::

   struct push_impl
   {
       // 戻り値の型（tr1::result_of のために必要）
       typedef void result_type;

       template<typename Sequence, typename Value>
       void operator()(Sequence &seq, Value const &val) const
       {
           seq.push(val);
       }
   };

次に xpressive の :cpp:struct:`function\<>` テンプレートを使って :cpp:var:`!push` という名前の関数オブジェクトを定義する。 ::

   // グローバルな "push" 関数オブジェクト。
   function<push_impl>::type const push = {{}};

初期化はいささか奇妙に見えるが、:cpp:var:`!push` を静的に初期化するためである。これは実行時に構築する必要はないということを意味する。以下のように :cpp:var:`!push` を意味アクション内で使用する。 ::

   std::stack<int> ints;
   // 数字がマッチしたら int へキャストし、スタックに積む。
   sregex rex = (+_d)[push(ref(ints), as<int>(_))];

この方法だとメンバ関数の呼び出しがただの関数呼び出しに見えてしまうことに気付くと思う。意味アクションを、よりメンバ関数呼び出しらしく見えるように記述する方法がある。 ::

   sregex rex = (+_d)[ref(ints)->*push(as<int>(_))];

xpressive は :code:`->*` を認識し、この式を上のコードとまったく同等に扱う。

関数オブジェクトが引数によって戻り値の型を変えなければならない場合は、:cpp:type:`result_type` 型定義の代わりに :cpp:struct:`result\<>` メンバテンプレートを使用するとよい。:cpp:class:`!std::pair\<>` か :cpp:struct:`sub_match\<>` の :cpp:var:`~sub_match::first` メンバを返す :cpp:var:`first` 関数オブジェクトの例である。 ::

   // 組の第 1 要素を返す関数オブジェクト。
   struct first_impl
   {
       template<typename Sig> struct result {};

       template<typename This, typename Pair>
       struct result<This(Pair)>
       {
           typedef typename remove_reference<Pair>
               ::type::first_type type;
       };

       template<typename Pair>
       typename Pair::first_type
       operator()(Pair const &p) const
       {
           return p.first;
       }
   };

   // OK、first(s1) により s1 が参照する部分マッチの先頭を指すイテレータを得る。
   function<first_impl>::type const first = {{}};


ローカル変数を参照する
^^^^^^^^^^^^^^^^^^^^^^

上の例で見たように、:cpp:func:`xpressive::ref()` を使用するとアクション内からローカル変数を参照できる。この変数は正規表現による参照に保持されるが、これらの参照が懸垂しないよう注意が必要である。例えば以下のコードでは、:cpp:func:`!bad_voodoo()` が制御を返すと :cpp:var:`!i` に対する参照が懸垂する。 ::

   sregex bad_voodoo()
   {
       int i = 0;
       sregex rex = +( _d [ ++ref(i) ] >> '!' );
       // エラー！ rex はローカル変数を参照により参照しており、
       // bad_voodoo() が制御を返した後に懸垂する。
       return rex;
   }

意味アクションを記述するときは、すべての参照が懸垂しないよう注意を払わなければならない。1 つの方法は変数を、正規表現が値により保持する共有ポインタにすることである。 ::

   sregex good_voodoo(boost::shared_ptr<int> pi)
   {
       // val() を使って shared_ptr を値で保持する:
       sregex rex = +( _d [ ++*val(pi) ] >> '!' );
       // OK、rex は整数への参照カウントを保持する。
       return rex;
   }

上のコードでは、:cpp:func:`xpressive::val()` を使って共有ポインタを値で保持している。アクション内のローカル変数は既定では値で保持されるため、通常この処理は必要ないが、この場合は必要である。アクションを :cpp:expr:`++*pi` と記述してしまうと即時実行されてしまう。これは :cpp:expr:`++*pi` が式テンプレートでないためである（:cpp:expr:`++*val(pi)` は式テンプレートである）。

アクション内の変数をすべて :cpp:func:`ref()` と :cpp:func:`val()` で包むのはうんざりするかもしれない。これを容易にするために xpressive は :cpp:struct:`reference\<>` および :cpp:struct:`value\<>` テンプレートを提供している。対応を以下の表に示す。

.. list-table:: reference<> と value<>
   :header-rows: 1

   * - これは…
     - …以下と等価である
   * - ::

          int i = 0;

          sregex rex = +( _d [ ++ref(i) ] >> '!' );

     - ::

          int i = 0;
          reference<int> ri(i);
          sregex rex = +( _d [ ++ri ] >> '!' );

   * - ::

          boost::shared_ptr<int> pi(new int(0));

          sregex rex = +( _d [ ++*val(pi) ] >> '!' );

     - ::

          boost::shared_ptr<int> pi(new int(0));
          value<boost::shared_ptr<int> > vpi(pi);
          sregex rex = +( _d [ ++*vpi ] >> '!' );

上で見たように :cpp:struct:`reference\<>` を使用する場合、始めにローカル変数を宣言してから :cpp:struct:`reference\<>` する。:cpp:struct:`local\<>` を使用するとこの 2 段階を 1 つにまとめられる。

.. list-table:: local<> 対 reference<>
   :header-rows: 1

   * - これは…
     - …以下と等価である
   * - ::

          local<int> i(0);

          sregex rex = +( _d [ ++i ] >> '!' );

     - ::

          int i = 0;
          reference<int> ri(i);
          sregex rex = +( _d [ ++ri ] >> '!' );

上の例を :cpp:class:`local\<>` を使用して書き直すと以下のようになる。 ::

   local<int> i(0);
   std::string str("1!2!3?");
   // 感嘆符の付いた数字は数えるが、疑問符付きのものは数えない。
   sregex rex = +( _d [ ++i ] >> '!' );
   regex_search(str, rex);
   assert( i.get() == 2 );

:cpp:func:`local::get()` を使ってローカル変数の値にアクセスしていることに注意していただきたい。また :cpp:struct:`reference\<>` 同様、:cpp:struct:`local\<>` が懸垂参照を作成する可能性があることに注意が必要である。


.. _semantic_actions_and_user_defined_assertions.referring_to_non_local_variables:

非ローカル変数を参照する
^^^^^^^^^^^^^^^^^^^^^^^^

この節の最初で、正規表現を使って単語・整数の組からなる文字列を解析して :cpp:class:`!std::map\<>` に詰め込む例を見た。この例では辞書と正規表現を定義しておき、いずれかがスコープから出る前にそれらを使う必要があった。正規表現を先に定義しておき、異なる複数の辞書に書き込みたい場合はどうすればよいだろうか？ 正規表現オブジェクトに辞書に対する参照を直接組み込むのではなく、:cpp:func:`regex_match()` アルゴリズムに辞書を渡すようにしてはどうか。プレースホルダを定義し、意味アクション内で辞書そのものの代わりに使用する。後でいずれかの正規表現アルゴリズムを呼び出すときに実際の辞書オブジェクトへ参照を束縛できる。以下のようにする。 ::

   // 辞書オブジェクトのプレースホルダを定義する:
   placeholder<std::map<std::string, int> > _map;

   // => で区切られた単語と整数にマッチし、
   // 結果を std::map<> に詰め込む
   sregex pair = ( (s1= +_w) >> "=>" >> (s2= +_d) )
       [ _map[s1] = as<int>(s2) ];

   // 空白で区切られた 1 つ以上の単語・整数の組にマッチする。
   sregex rx = pair >> *(+_s >> pair);

   // 解析する文字列
   std::string str("aaa=>1 bbb=>23 ccc=>456");

   // 結果を書き込む実際の辞書:
   std::map<std::string, int> result;

   // _map プレースホルダを実際の辞書に束縛する
   smatch what;
   what.let( _map = result );

   // マッチを実行し結果の辞書に書き込む
   if(regex_match(str, what, rx))
   {
       std::cout << result["aaa"] << '\n';
       std::cout << result["bbb"] << '\n';
       std::cout << result["ccc"] << '\n';
   }

このプログラムは以下を表示する。

.. code-block:: console

   1
   23
   456

:cpp:struct:`placeholder\<>` を使って :cpp:var:`!_map` を定義しており、これが :cpp:class:`!std::map\<>` 変数の代理となる。意味アクション内でこのプレースホルダを辞書として使用できる。次に :cpp:struct:`match_results` 構造体を定義して :code:`what.let( _map = result );` で実際の辞書をプレースホルダに束縛する。:cpp:func:`regex_match()` 呼び出しは、意味アクション内のプレースホルダを :cpp:var:`!result` への参照で置換したかのように振舞う。

.. note::
   意味アクション内のプレースホルダは\ **実際には**\実行時に変数への参照で置換されない。正規表現オブジェクトはいずれの正規表現アルゴリズムでも変更されることはないので、複数のスレッドで使用しても安全である。

:cpp:struct:`regex_iterator\<>` か :cpp:struct:`regex_token_iterator\<>` を使用する場合は、遅延束縛されたアクションの引数は少し異なる。正規表現イテレータのコンストラクタは、引数の束縛を指定する引数を受け付ける。変数をそのプレースホルダに束縛するのに使用する :cpp:func:`let()` 関数がある。以下のコードに方法を示す。 ::

   // 辞書オブジェクトのプレースホルダを定義する:
   placeholder<std::map<std::string, int> > _map;

   // => で区切られた単語と整数にマッチ
   sregex pair = ( (s1= +_w) >> "=>" >> (s2= +_d) )
       [ _map[s1] = as<int>(s2) ];

   // 解析する文字列
   std::string str("aaa=>1 bbb=>23 ccc=>456");

   // 結果を書き込む実際の辞書:
   std::map<std::string, int> result;

   // regex_iterator を作成し、すべてのマッチを検索する
   sregex_iterator it(str.begin(), str.end(), pair, let(_map=result));
   sregex_iterator end;

   // すべてのマッチについて結果の辞書に書き込む
   while(it != end)
       ++it;

   std::cout << result["aaa"] << '\n';
   std::cout << result["bbb"] << '\n';
   std::cout << result["ccc"] << '\n';

このプログラムは以下を出力する。

.. code-block:: console

   1
   23
   456


.. _semantic_actions_and_user_defined_assertions.user_defined_assertions:

ユーザー定義表明
^^^^^^^^^^^^^^^^

正規表現の\ **表明**\については慣れたものだろう。Perl だと表明の例として :regexp:`^` や :regexp:`$` があり、それぞれ文字列の先頭・終端にマッチする。xpressive では新たに表明を定義できる。カスタム表明は、マッチの成否を判断する時点で真でなければならない条件である。カスタム表明をチェックするには xpressive の :cpp:func:`check()` 関数を使用する。

カスタム表明を定義する方法はいくつかある。一番簡単なのは関数オブジェクトを使うことである。長さが 3 文字か 6 文字のいずれかである部分文字列にマッチする部分式が必要であるとする。そのような述語を以下の構造体で定義する。 ::

   // 部分マッチが長さ 3 文字か 6 文字であれば真となる述語。
   struct three_or_six
   {
       bool operator()(sub_match const &sub) const
       {
           return sub.length() == 3 || sub.length() == 6;
       }
   };

この述語を正規表現で使うには以下のようにする。 ::

   // 3 文字か 6 文字の単語にマッチする。
   sregex rx = (bow >> +_w >> eow)[ check(three_or_six()) ] ;

上の正規表現は長さが 3 文字か 6 文字の単語全体にマッチする。述語 :cpp:struct:`!three_or_six` は、カスタム表明が結び付けられた部分式にマッチした部分を後方参照する :cpp:struct:`sub_match\<>` を受け取る。

.. note::
   カスタム表明はマッチの成否に関与する。遅延実行されるアクションとは異なり、カスタム表明は正規表現エンジンがマッチを検索するときに即時実行される。

カスタム表明は意味アクションと同じ構文を用いてインライン定義することもできる。以下は同じカスタム表明をインラインで書き直したものである。 ::

   // 3 文字か 6 文字の単語にマッチする。
   sregex rx = (bow >> +_w >> eow)[ check(length(_)==3 || length(_)==6) ] ;

上記において、:cpp:var:`length()` は引数の :cpp:func:`!length()` メンバ関数を呼び出す遅延関数であり、:cpp:var:`_` は :cpp:struct:`sub_match` を受け取るプレースホルダである。

カスタム表明のインライン記述は、コツが分かってしまえば非常に強力である。（あまり厳密でない意味での）正しい日付にのみマッチする正規表現を書いてみよう。 ::

   int const days_per_month[] =
       {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

   mark_tag month(1), day(2);
   // 「月/日/年」形式の正しい日付を検索する。
   sregex date =
       (
           // 月は 1 以上 12 以下でなければならない
           (month= _d >> !_d)     [ check(as<int>(_) >= 1
                                       && as<int>(_) <= 12) ]
       >>  '/'
           // 日は 1 以上 31 以下でなければならない
       >>  (day=   _d >> !_d)     [ check(as<int>(_) >= 1
                                       && as<int>(_) <= 31) ]
       >>  '/'
           // 年は 1970 以上 2038 以下とする
       >>  (_d >> _d >> _d >> _d) [ check(as<int>(_) >= 1970
                                       && as<int>(_) <= 2038) ]
       )
       // 月ごとの実際の日数を確認する！
       [ check( ref(days_per_month)[as<int>(month)-1] >= as<int>(day) ) ]
   ;

   smatch what;
   std::string str("99/99/9999 2/30/2006 2/28/2006");

   if(regex_search(str, what, date))
   {
       std::cout << what[0] << std::endl;
   }

このプログラムは以下を印字する。

.. code-block:: console

   2/28/2006

インラインのカスタム表明を使って年・月・日の値の範囲チェックを行っていることに注意していただきたい。:regex-input:`99/99/9999` や :regex-input:`2/30/2006` は正しい日付ではないため、この正規表現はマッチしない（99 の月は存在しないし、2 月には 30 日はない）。
