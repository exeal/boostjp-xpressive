地域化と正規表現特性
--------------------

概要
^^^^

文字列に対する正規表現マッチにおいて、ロカール依存の情報が必要になる場合がよくある。例えば、大文字小文字を区別しない比較はどのように行うのか？ ロカール依存の振る舞いは特性（traits）クラスが取り扱う。xpressive は :cpp:struct:`cpp_regex_traits\<>` 、 :cpp:struct:`c_regex_traits\<>` および :cpp:struct:`null_regex_traits\<>` の 3 つの特性クラステンプレートを提供する。1 番目のものは :cpp:class:`!std::locale` をラップし、2 番目のものはグローバルな C ロカールをラップする。3 番目は非文字データを検索するのに使用する控えの特性型である。すべての特性テンプレートは\ :ref:`正規表現特性のコンセプト <concepts.traits_requirements>`\に適合する。


既定の正規表現特性を設定する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

既定では xpressive はすべてにパターンに対して :cpp:struct:`cpp_regex_traits\<>` を使用する。これにより、すべての正規表現オブジェクトはグローバルな :class:`!std::locale` を使用する。:c:macro:`BOOST_XPRESSIVE_USE_C_TRAITS` を定義してコンパイルすると、xpressive の既定は :cpp:struct:`c_regex_traits\<>` になる。


動的正規表現でカスタムの特性を使用する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

カスタムの特性オブジェクトを使う動的正規表現を作成するには、:cpp:struct:`regex_compiler\<>` を使わなければならない。基本的な方法を以下の例に示す。 ::

   // グローバルな C ロカールを使う regex_compiler を宣言する
   regex_compiler<char const *, c_regex_traits<char> > crxcomp;
   cregex crx = crxcomp.compile( "\\w+" );

   // カスタムの std::locale を使う regex_compiler を宣言する
   std::locale loc = /* ... ここでロカールを作成する ... */;
   regex_compiler<char const *, cpp_regex_traits<char> > cpprxcomp(loc);
   cregex cpprx = cpprxcomp.compile( "\\w+" );

:cpp:struct:`regex_compiler` オブジェクトは正規表現のファクトリとして動作する。これらは一度ロカールを与えておくと、以降作成する正規表現はそのロカールを使用するようになる。


静的正規表現でカスタムの特性を使用する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

個々の静的正規表現に異なる特性群を使用したい場合は、:cpp:func:`imbue()` 特殊パターン修飾子を使用する。例えば、 ::

   // グローバルな C ロカールを使う正規表現を定義する
   c_regex_traits<char> ctraits;
   sregex crx = imbue(ctraits)( +_w );

   // カスタムの std::locale を使う正規表現を定義する
   std::locale loc = /* ... ここでロカールを作成する ... */;
   cpp_regex_traits<char> cpptraits(loc);
   sregex cpprx1 = imbue(cpptraits)( +_w );

   // 上記の短縮形
   sregex cpprx2 = imbue(loc)( +_w );

:cpp:func:`imbue()` パターン修飾子はパターン全体を囲まなければならない。静的正規表現の一部だけを :cpp:func:`imbue` するとエラーになる。例えば、 ::

   // エラー！ 正規表現の一部だけを imbue() することはできない
   sregex error = _w >> imbue(loc)( _w );


:cpp:struct:`null_regex_traits` で非文字データを検索する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

xpressive の静的正規表現では、パターンの検索は文字シーケンス内に限定されない。生のバイト、整数、その他\ :ref:`文字のコンセプト <concepts.chart_requirements>`\に適合するものであれば何でも検索できる。このような場合、:cpp:struct:`null_regex_traits\<>` を使うと簡単である。\ :ref:`正規表現特性のコンセプト <concepts.traits_requirements>`\の控えの実装であり、文字クラスを無視し、大文字小文字に関する変換を一切行わない。

例えば整数列からパターンを検索する静的正規表現は、:cpp:struct:`null_regex_traits\<>` を使って以下のように記述できる。 ::

   // 検索する整数データ
   int const data[] = {0, 1, 2, 3, 4, 5, 6};

   // 整数を検索する null_regex_traits<> オブジェクトを作成する...
   null_regex_traits<int> nul;

   // 正規表現オブジェクトに null_regex_traits を指示する...
   basic_regex<int const *> rex = imbue(nul)(1 >> +((set= 2,3) | 4) >> 5);
   match_results<int const *> what;

   // 整数の配列からパターンを検索する...
   regex_search(data, data + 7, what, rex);

   assert(what[0].matched);
   assert(*what[0].first == 1);
   assert(*what[0].second == 6);
