付録 3：Boost.Regexとの違い
---------------------------
  
xpressive のユーザーの多くは `Boost.Regex`_ ライブラリになじんでいると思うので、xpressive と `Boost.Regex`_ の重大な違いについて見落としているとしたら私の怠慢である。特に以下の点を挙げる。
  
* :cpp:struct:`xpressive::basic_regex\<>` は、文字型ではなくイテレータ型に対するテンプレートである。
* :cpp:struct:`xpressive::basic_regex\<>` は、文字列から直接構築できない。文字列から正規表現オブジェクトを構築するには、代わりに :cpp:func:`basic_regex::compile()` か :cpp:struct:`regex_compiler\<>` を使用しなければならない。
* :cpp:struct:`xpressive::basic_regex\<>` は :cpp:func:`~::boost::basic_regex::imbue()` メンバ関数を持たない。代わりに :cpp:struct:`xpressive::regex_compiler\<>` ファクトリに :cpp:func:`~regex_compiler::imbue()` メンバ関数がある。
* :cpp:struct:`boost::basic_regex\<>` は :cpp:struct:`std::basic_string\<>` メンバのサブセットをもつが、:cpp:struct:`xpressive::basic_regex\<>` にはない。欠けているメンバは、:cpp:func:`~std::basic_regex::assign()` 、:cpp:func:`~std::basic_regex::operator[]()` 、:cpp:func:`~std::basic_regex::max_size()` 、:cpp:func:`~std::basic_regex::begin()` 、:cpp:func:`~std::basic_regex::end()` 、:cpp:func:`~std::basic_regex::size()` 、:cpp:func:`~std::basic_regex::compare()` および :cpp:expr:`operator=(std::basic_string<>)` である。
* :cpp:struct:`boost::basic_regex\<>` にあって :cpp:struct:`xpressive::basic_regex\<>` にないメンバ関数は、:cpp:func:`~::boost::basic_regex::set_expression()` 、:cpp:func:`~::boost::basic_regex::get_allocator()` 、:cpp:func:`~::boost::basic_regex::imbue()` 、:cpp:func:`~::boost::basic_regex::getloc()` 、:cpp:func:`~::boost::basic_regex::getflags()` および :cpp:func:`~::boost::basic_regex::str()` である。
* :cpp:struct:`xpressive::basic_regex\<>` は RegexTraits テンプレート引数をもたない。正規表現構文と地域化に関する振る舞いをカスタマイズするには、:cpp:struct:`regex_compiler\<>` およびカスタムの :cpp:class:`!std::locale` 正規表現ファセットを使用する。
* :cpp:struct:`xpressive::basic_regex\<>` および :cpp:struct:`xpressive::match_results\<>` は Allocator テンプレート引数を持たない。これはこういう設計である。
* :cpp:enumerator:`match_not_dot_null` および :cpp:enumerator:`match_not_dot_newline` は :cpp:enum:`~regex_constants::match_flag_type` 列挙から :cpp:enum:`~regex_constants::syntax_option_type` 列挙に移動しており、名前も :cpp:enumerator:`~regex_constants::syntax_option_type::not_dot_null` および :cpp:enumerator:`~regex_constants::syntax_option_type::not_dot_newline` に変更している。
* :cpp:enum:`~regex_constants::syntax_option_type` 列挙値はサポートしない：:cpp:enumerator:`escape_in_lists` 、:cpp:enumerator:`char_classes` 、:cpp:enumerator:`intervals` 、:cpp:enumerator:`limited_ops` 、:cpp:enumerator:`newline_alt` 、:cpp:enumerator:`bk_plus_qm` 、:cpp:enumerator:`bk_braces` 、:cpp:enumerator:`bk_parens` 、:cpp:enumerator:`bk_refs` 、:cpp:enumerator:`bk_vbar` 、:cpp:enumerator:`use_except` 、:cpp:var:`failbit` 、:cpp:enumerator:`literal` 、:cpp:enumerator:`perlex` 、:cpp:enumerator:`basic` 、:cpp:enumerator:`extended` 、:cpp:enumerator:`emacs` 、:cpp:enumerator:`awk` 、:cpp:enumerator:`grep` 、:cpp:enumerator:`egrep` 、:cpp:enumerator:`sed` 、:cpp:enumerator:`JavaScript` 、:cpp:enumerator:`JScript`\。
* :cpp:enum:`~regex_constants::match_flag_type` 列挙値はサポートしない：:cpp:enumerator:`match_not_bob` 、:cpp:enumerator:`match_not_eob` 、:cpp:enumerator:`match_perl` 、:cpp:enumerator:`match_posix` および :cpp:enumerator:`match_extra`\。

また、現在の実装では xpressive の正規表現アルゴリズムは病的な振る舞いや例外によるアボートを検出しない。病的な振る舞いをせず効率のよいパターンを書くのはあなたの責任である。


.. _Boost.Regex: http://www.boost.org/libs/regex/
