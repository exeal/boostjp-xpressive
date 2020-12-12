regex_compiler 構造体テンプレート
=================================

.. cpp:struct:: template<typename BidiIter, typename RegexTraits, typename CompilerTraits> regex_compiler

   :cpp:struct:`regex_compiler` クラステンプレートは文字列から :cpp:struct:`basic_regex` オブジェクトを構築するファクトリである。


.. cpp:namespace-push:: regex_compiler


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_compiler.hpp`>

   template<typename BidiIter, typename RegexTraits, typename CompilerTraits> 
   struct :cpp:struct:`regex_compiler` {
     // 型
     typedef BidiIter                            iterator_type;  
     typedef iterator_value< BidiIter >::type    char_type;      
     typedef regex_constants::syntax_option_type flag_type;      
     typedef RegexTraits                         traits_type;    
     typedef traits_type::string_type            string_type;    
     typedef traits_type::locale_type            locale_type;    
     typedef traits_type::char_class_type        char_class_type;

     // :ref:`構築、コピー、解体 <regex_compiler.construct-copy-destruct>`
     explicit :cpp:func:`~regex_compiler::regex_compiler`\(RegexTraits const & = RegexTraits());

     // :ref:`公開メンバ関数 <regex_compiler.public-member-functions>`
     locale_type :cpp:func:`imbue`\(locale_type);
     locale_type :cpp:func:`getloc`\() const;
     template<typename InputIter> 
       :cpp:struct:`basic_regex`\< BidiIter > 
     :cpp:func:`compile`\(InputIter, InputIter, flag_type = regex_constants::ECMAScript);
     template<typename InputRange> 
       disable_if< is_pointer< InputRange >, :cpp:struct:`basic_regex`\< BidiIter > >::type 
     :cpp:func:`compile`\(InputRange const &, flag_type = regex_constants::ECMAScript);
     :cpp:struct:`basic_regex`\< BidiIter > 
     :cpp:func:`compile`\(char_type const \*, flag_type = regex_constants::ECMAScript);
     :cpp:struct:`basic_regex`\< BidiIter > :cpp:func:`compile`\(char_type const \*, std::size_t, flag_type);
     :cpp:struct:`basic_regex`\< BidiIter > & :cpp:func:`operator[]`\(string_type const &);
     :cpp:struct:`basic_regex`\< BidiIter > const & :cpp:func:`operator[]`\(string_type const &) const;

     // :ref:`非公開メンバ関数 <regex_compiler.private-member-functions>`
     bool :cpp:func:`is_upper_`\(char_type) const;
   };


説明
----

:cpp:struct:`regex_compiler` クラステンプレートは、文字列から :cpp:struct:`basic_regex` オブジェクトを構築するのに使用する。文字列は正しい正規表現でなければならない。:cpp:struct:`regex_compiler` オブジェクトにロカールを指示すると、以降その :cpp:struct:`regex_compiler` オブジェクトが作成する :cpp:struct:`basic_regex` オブジェクトはすべてそのロカールを使用する。:cpp:struct:`regex_compiler` オブジェクト作成後、（必要であればロカールを与え、）正規表現を表す文字列を使って :cpp:func:`!compile()` メソッドを呼び出すことで :cpp:struct:`basic_regex` オブジェクトを構築する。同じ :cpp:struct:`regex_compiler` オブジェクトに対して :cpp:func:`!compile()` は複数回呼び出すことができる。同じ文字列からコンパイルした 2 つの :cpp:struct:`basic_regex` オブジェクトは異なる :cpp:type:`!regex_id` をもつ。


.. _regex_compiler.construct-copy-destruct:

regex_compiler 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: regex_compiler(RegexTraits const & traits = RegexTraits())


.. _regex_compiler.public-member-functions:

regex_compiler 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: locale_type imbue(locale_type loc)

   :cpp:struct:`regex_compiler` が使用するロカールを指定する。

   :param loc: この :cpp:struct:`regex_compiler` が使用するロカール。
   :returns: 直前のロカール。


.. cpp:function:: locale_type getloc() const

   :cpp:struct:`regex_compiler` が使用しているロカールを返す。

   :returns: この :cpp:struct:`regex_compiler` が使用しているロカール。


.. cpp:function:: template<typename InputIter> basic_regex< BidiIter > compile(InputIter begin, InputIter end, flag_type flags = regex_constants::ECMAScript)

   文字の範囲から :cpp:struct:`basic_regex` オブジェクトを構築する。

   :param begin: コンパイルする正規表現を表す文字範囲の先頭。
   :param end: コンパイルする正規表現を表す文字範囲の終端。
   :param flags: パターン文字列をどのように解釈するか決める省略可能なビットマスク（:cpp:type:`!syntax_option_type` を見よ）。
   :要件: :cpp:type:`InputIter` が入力イテレータの要件を満たす。
   :要件: ``[begin, end)`` が有効な範囲である。
   :要件: ``[begin, end)`` で指定した文字範囲が正しい正規表現の文字列表現である。
   :returns: 文字範囲が表す正規表現に相当する :cpp:struct:`basic_regex` オブジェクト。
   :throws regex_error: 文字範囲に不正な正規表現構文がある場合。


.. cpp:function:: template<typename InputRange> disable_if< is_pointer< InputRange >, basic_regex< BidiIter > >::type compile(InputRange const & pat, flag_type flags = regex_constants::ECMAScript)

   .. include:: -overload-description.rst


.. cpp:function:: basic_regex< BidiIter > compile(char_type const * begin, flag_type flags = regex_constants::ECMAScript)

   .. include:: -overload-description.rst


.. cpp:function:: basic_regex< BidiIter > compile(char_type const * begin, std::size_t size, flag_type flags)

   .. include:: -overload-description.rst


.. cpp:function:: basic_regex< BidiIter > & operator[](string_type const & name)

   名前付き正規表現への参照を返す。指定した名前をもつ正規表現が存在しない場合は、新しい正規表現を作成し参照を返す。

   :param name: 正規表現の名前を表す :cpp:class:`!std::string`。
   :要件: 文字列が空でない。
   :throws bad_alloc: メモリ確保に失敗した場合。


.. cpp:function:: basic_regex< BidiIter > const & operator[](string_type const & name) const

   .. include:: -overload-description.rst


.. _regex_compiler.private-member-functions:

:cpp:struct:`!regex_compiler` 非公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: bool is_upper_(char_type ch)

.. cpp:namespace-pop::
