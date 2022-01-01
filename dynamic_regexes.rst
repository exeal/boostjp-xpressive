.. cpp:namespace:: boost::xpressive


動的正規表現
^^^^^^^^^^^^

概要
~~~~

静的正規表現は一級品だが、ときにはもっと別の…、つまり動的正規表現が必要な場合もある。正規表現検索・置換機能を備えたテキストエディタを開発中だとしよう。正規表現は、実行時にエンドユーザーからの入力として受け付けなければならない。文字列を正規表現に解析する方法が必要であり、xpressive の動的正規表現がそれに相当する。これらは静的正規表現と同じコアコンポーネントから構築するが、遅延束縛のため実行時にパターンを指定できる。


構築と代入
~~~~~~~~~~

動的正規表現を作成する方法は2つある。:cpp:func:`basic_regex::compile` 関数によるものと :cpp:struct:`regex_compiler\<>` クラステンプレートによるものである。既定のロカールでよければ :cpp:func:`basic_regex::compile()` を使うとよい。別のロカールを指定する必要がある場合は、:cpp:struct:`regex_compiler\<>` を使用する。:doc:`正規表現文法 <grammars>`\の節で、:cpp:struct:`regex_compiler\<>` の他の使用について述べる。

以下は :cpp:func:`basic_regex::compile()` の使用例である。 ::

   sregex re = sregex::compile( "this|that", regex_constants::icase );

以下は :cpp:struct:`regex_compiler\<>` を使った同じ例である。 ::

   sregex_compiler compiler;
   sregex re = compiler.compile( "this|that", regex_constants::icase );

:cpp:func:`basic_regex::compile()` は :cpp:struct:`regex_compiler` を使って実装している。


動的 xpressive の構文
~~~~~~~~~~~~~~~~~~~~~

動的構文は合法な C++ の式規則による制約を受けないので、動的正規表現については慣れ親しんだ構文が使える。そういうわけで動的正規表現については xpressive は、正規表現を標準ライブラリに追加することになった John Maddock の\ `草案 <http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2003/n1429.htm>`_\に従った。本質的には `ECMAScript <http://www.ecma-international.org/publications/files/ECMA-ST/Ecma-262.pdf>`_ により標準化された構文であり、国際化のための細かい変更を加えてある。

構文の網羅的な文書は他にあるので、ここでは仕様の複製はせず、既存の標準を参照するにとどめる。


国際化
~~~~~~

静的正規表現と同様、動的正規表現の国際化サポートは別の :cpp:class:`!std::locale` を指定することによる。これを行うには :cpp:struct:`regex_compiler\<>` を使用しなければならない。:cpp:struct:`regex_compiler\<>` クラスは :cpp:func:`imbue()` 関数をもつ。:cpp:struct:`regex_compiler\<>` オブジェクトに対してカスタムの :cpp:class:`!std::locale` を使って :cpp:func:`~regex_compiler::imbue()` を呼び出すと、それ以降に :cpp:struct:`regex_compiler\<>` でコンパイルした正規表現オブジェクトはそのロカールを使用するようになる。例えば、 ::

   std::locale my_locale = /* ここでロカールオブジェクトを初期化する */;
   sregex_compiler compiler;
   compiler.imbue( my_locale );
   sregex re = compiler.compile( "\\w+|\\d+" );

この正規表現は、組み込みの文字集合 :regexp:`\\w` および :regexp:`\\d` を処理するのに :cpp:var:`!my_locale` を使用する。
