null_regex_traits 構造体テンプレート
====================================

.. cpp:struct:: template<typename Char> null_regex_traits

   非文字データのための控えの :cpp:struct:`regex_traits`。


.. cpp:namespace-push:: null_regex_traits


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/xpressive_fwd.hpp`>

   template<typename Char> 
   struct :cpp:struct:`~::boost::xpressive::null_regex_traits` {
     // :ref:`構築、コピー、解体 <null_regex_traits.construct-copy-destruct>`
     :cpp:func:`~null_regex_traits::null_regex_traits`\(locale_type const & = locale_type());

     // :ref:`公開メンバ関数 <null_regex_traits.public-member-functions>`
     bool :cpp:func:`operator==`\(:cpp:struct:`null_regex_traits`\< char_type > const &) const;
     bool :cpp:func:`operator!=`\(:cpp:struct:`null_regex_traits`\< char_type > const &) const;
     char_type :cpp:func:`widen`\(char) const;

     // :ref:`公開静的メンバ関数 <null_regex_traits.public-static-functions>`
     static unsigned char :cpp:func:`hash`\(char_type);
     static char_type :cpp:func:`translate`\(char_type);
     static char_type :cpp:func:`translate_nocase`\(char_type);
     static bool :cpp:func:`in_range`\(char_type, char_type, char_type);
     static bool :cpp:func:`in_range_nocase`\(char_type, char_type, char_type);
     template<typename FwdIter> static string_type :cpp:func:`transform`\(FwdIter, FwdIter);
     template<typename FwdIter> 
       static string_type :cpp:func:`transform_primary`\(FwdIter, FwdIter);
     template<typename FwdIter> 
       static string_type :cpp:func:`lookup_collatename`\(FwdIter, FwdIter);
     template<typename FwdIter> 
       static char_class_type :cpp:func:`lookup_classname`\(FwdIter, FwdIter, bool);
     static bool :cpp:func:`isctype`\(char_type, char_class_type);
     static int :cpp:func:`value`\(char_type, int);
     static locale_type :cpp:func:`imbue`\(locale_type);
     static locale_type :cpp:func:`getloc`\();
   };


説明
----

.. _null_regex_traits.construct-copy-destruct:

:cpp:class:`!null_regex_traits` 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: null_regex_traits(locale_type const & loc = locale_type())

   :cpp:struct:`!null_regex_traits` オブジェクトを初期化する。


.. _null_regex_traits.public-member-functions:

:cpp:class:`!null_regex_traits` 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: bool operator==(null_regex_traits< char_type > const & that) const

   2 つの :cpp:struct:`null_regex_traits` オブジェクトが等値か調べる。

   :returns: 真。


.. cpp:function:: bool operator!=(null_regex_traits< char_type > const & that) const

   2 つの :cpp:struct:`null_regex_traits` オブジェクトが等値でないか調べる。

   :returns: 偽。


.. cpp:function:: char_type widen(char ch) const

   :cpp:type:`!char` 型の値を :cpp:type:`!Char` 型に変換する。

   :param ch: 元の文字。
   :returns: :cpp:expr:`Elem(ch)`。


.. _null_regex_traits.public-static-functions:

:cpp:struct:`!null_regex_traits` 公開静的メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: static unsigned char hash(char_type ch)

   ``[0, UCHAR_MAX]`` の範囲で :cpp:type:`!Elem` のハッシュ値を返す。

   :param ch: 元の文字。
   :returns: ``0`` 以上 :cpp:var:`!UCHAR_MAX` 以下の値。


.. cpp:function:: static char_type translate(char_type ch)

   何もしない。

   :param ch: 元の文字。
   :returns: :cpp:var:`!ch`


.. cpp:function:: static char_type translate_nocase(char_type ch)

   何もしない。

   :param ch: 元の文字。
   :param first: 範囲の下限。
   :param last: 範囲の上限。
   :returns: :cpp:expr:`first <= ch && ch <= last`


.. cpp:function:: static bool in_range(char_type first, char_type last, char_type ch)

   文字が文字範囲に含まれるか調べる。

   :param ch: 元の文字。
   :param first: 範囲の下限。
   :param last: 範囲の上限。
   :returns: :cpp:expr:`first <= ch && ch <= last`


.. cpp:function:: static bool in_range_nocase(char_type first, char_type last, char_type ch)

   文字が文字範囲に含まれるか調べる。

   .. note:: :cpp:struct:`null_regex_traits` はケースフォールディングを行わないので、この関数は :cpp:func:`!in_range()` と等価である。

   :param ch: 元の文字。
   :param first: 範囲の下限。
   :param last: 範囲の上限。
   :returns: :cpp:expr:`first <= ch && ch <= last`


.. cpp:function:: template<typename FwdIter> static string_type transform(FwdIter begin, FwdIter end)

   イテレータ範囲 ``[F1, F2)`` が示す文字シーケンスのソートキーを返す。文字シーケンス ``[G1, G2)`` が文字シーケンス ``[H1, H2)`` の前にソートされる場合に :cpp:expr:`v.transform(G1, G2) < v.transform(H1, H2)` とならなければならない。

   .. note:: 現在使用していない。


.. cpp:function:: template<typename FwdIter> static string_type transform_primary(FwdIter begin, FwdIter end)

   イテレータ範囲 ``[F1, F2)`` が示す文字シーケンスのソートキーを返す。大文字小文字を区別せずにソートして文字シーケンス ``[G1, G2)`` が文字シーケンス ``[H1, H2)`` の前に現れる場合に :cpp:expr:`v.transform(G1, G2) < v.transform(H1, H2)` とならなければならない。

   .. note:: 現在使用していない。


.. cpp:function:: template<typename FwdIter> static string_type lookup_collatename(FwdIter begin, FwdIter end)

   イテレータ範囲 ``[F1, F2)`` が示す文字シーケンスが構成する照合要素を表す文字シーケンスを返す。文字シーケンスが正しい照合要素でなければ空文字列を返す。

   .. note:: 現在使用していない。


.. cpp:function:: template<typename FwdIter> static char_class_type lookup_classname(FwdIter begin, FwdIter end, bool icase)

   :cpp:struct:`null_regex_traits` は文字分類をもたないので、:cpp:func:`!lookup_classname()` は使用しない。

   :param begin: 使用しない。
   :param end: 使用しない。
   :param icase: 使用しない。
   :returns: :cpp:expr:`static_cast<char_class_type>(0)`


.. cpp:function:: static bool isctype(char_type ch, char_class_type mask)

   :cpp:struct:`null_regex_traits` は文字分類をもたないので、:cpp:func:`!isctype()` は使用しない。

   :param ch: 使用しない。
   :param mask: 使用しない。
   :returns: 偽


.. cpp:function:: static int value(char_type ch, int radix)

   :cpp:struct:`null_regex_traits` は数字を解釈しないので、:cpp:func:`!value()` は使用しない。

   :param ch: 使用しない。
   :param radix: 使用しない。
   :returns: ``-1``


.. cpp:function:: static locale_type imbue(locale_type loc)

   何もしない。

   :param loc: 使用しない。
   :returns: :cpp:var:`!loc`


.. cpp:function:: static locale_type getloc()

   何もしない。

   :returns: :cpp:expr:`locale_type()` を返す。


.. cpp:namespace-pop::
