結果へのアクセス
----------------

概要
^^^^

:cpp:func:`regex_match()` および :cpp:func:`regex_search()` の成否が分かるだけでは十分でない場合もある。:cpp:func:`regex_match()` 、:cpp:func:`regex_search()` に :cpp:struct:`match_results\<>` 型のオブジェクトを渡すと、アルゴリズムが完全に成功した後 :cpp:struct:`match_results\<>` に、正規表現のどの部分がシーケンスのどの部分にマッチしたかの追加情報が入る。Perl ではこれらの部分シーケンスを\ **後方参照**\といい、変数 ``$1`` 、``$2`` 、…に格納される。xpressive では :cpp:struct:`sub_match\<>` 型のオブジェクトであり、:cpp:struct:`match_results\<>` 構造体に格納される。これらは :cpp:struct:`sub_match\<>` オブジェクトのベクタとして振舞う。


match_results
^^^^^^^^^^^^^

さて、正規表現アルゴリズムに :cpp:struct:`match_results\<>` オブジェクトを渡し、アルゴリズムが成功したとする。結果を調べたくなるところだ。:cpp:struct:`match_results\<>` オブジェクトを使ってすることといえば、その内部に格納されている :cpp:struct:`sub_match\<>` オブジェクトへ添字を介してアクセスすることがほとんどである。しかし :cpp:struct:`match_results\<>` オブジェクトには他にも少し使い道がある。

:cpp:var:`!what` という名前の :cpp:struct:`match_results\<>` オブジェクトに格納されている情報にアクセスする方法を以下の表に示す。

.. list-table:: match_results<> のアクセス子
   :header-rows: 1

   * - アクセス子
     - 効果
   * - :cpp:expr:`what.size()`
     - 部分マッチの総数を返す。マッチ全体は 0 番目の部分マッチとして格納されるため、アルゴリズムが成功した場合は結果は常に 0 より大きい。
   * - :cpp:expr:`what[n]`
     - n 番目の部分マッチを返す。
   * - :cpp:expr:`what.length(n)`
     - n 番目の部分マッチの長さを返す。:cpp:expr:`what[n].length()` と同じ。
   * - :cpp:expr:`what.str(n)`
     - n 番目の部分マッチから構築した :cpp:class:`!std::basic_string\<>` を返す。:cpp:expr:`what[n].str()` と同じ。
   * - :cpp:expr:`what.prefix`
     - 入力シーケンスの先頭から全体マッチ先頭までの部分シーケンスを表す :cpp:struct:`sub_match\<>` オブジェクトを返す。
   * - :cpp:expr:`what.suffix`
     - 全体マッチの終端から入力シーケンスの終端までの部分シーケンスを表す :cpp:struct:`sub_match\<>` オブジェクトを返す。
   * - :cpp:expr:`what.regex_id()`
     - この :cpp:class:`match_results\<>` オブジェクトで最後に使用した :cpp:struct:`basic_regex\<>` オブジェクトの :cpp:type:`regex_id` を返す。

:cpp:struct:`match_results\<>` オブジェクトには他にも使い道があるが、:doc:`grammars`\ の項であらためて述べることにする。


sub_match
^^^^^^^^^

:cpp:struct:`match_results\<>` オブジェクトに添字を介してアクセスすると :cpp:struct:`sub_match\<>` オブジェクトが得られる。:cpp:struct:`sub_match\<>` は基本的にはイテレータの組である。定義は以下のようになっている。 ::

   template< class BidirectionalIterator >
   struct sub_match
       : std::pair< BidirectionalIterator, BidirectionalIterator >
   {
       bool matched;
       // ...
   };

:cpp:class:`!std::pair\<>` を公開継承しているため、:cpp:struct:`sub_match\<>` は :cpp:type:`!BidirectionalIterator` 型の :cpp:member:`~sub_match::first` および :cpp:member:`~sub_match::second` データメンバをもつ。これらは、この :cpp:struct:`sub_match\<>` が表す部分シーケンスの先頭と終端である。また :cpp:struct:`sub_match\<>` は論理型の :cpp:member:`~sub_match::matched` データメンバをもち、この :cpp:struct:`sub_match\<>` が完全マッチに関与する場合に真となる。

名前を :cpp:var:`!sub` とした場合の、:cpp:struct:`sub_match\<>` オブジェクトに格納されている情報にアクセスする方法を以下の表に示す。

.. list-table:: sub_match<> アクセス子
   :header-rows: 1

   * - アクセス子
     - 効果
   * - :cpp:expr:`sub.length()`
     - 部分マッチの長さを返す。:cpp:expr:`std::distance(sub.first,sub.second)` と同じ。
   * - :cpp:expr:`sub.str()`
     - 部分マッチから構築した :cpp:class:`!std::basic_string\<>` を返す。:cpp:expr:`std::basic<char_type>(sub.first,sub.second)` と同じ。
   * - :cpp:expr:`sub.compare(str)`
     - 部分マッチと :cpp:var:`!str` の文字列比較を行う。:cpp:var:`!str` は :cpp:class:`!std::basic_string\<>` 、C 形式の null 終端文字列、別の部分マッチのいずれでもよい。:cpp:expr:`sub.str().compare(str)` と同じ。


効果の無効化
^^^^^^^^^^^^

結果は入力シーケンス内のイテレータとして格納される。入力シーケンスが無効になるとマッチ結果もまた無効となる。例えば :cpp:class:`!std::string` オブジェクトに対してマッチを行った場合、結果が有効なのは、次にその :cpp:class:`!std::string` オブジェクトの非 const メンバ関数を呼び出すまでの間だけである。それ以降は :cpp:struct:`match_results\<>` オブジェクトに格納されている結果は無効となるため、使用してはならない。
