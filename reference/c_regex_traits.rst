c_regex_traits 構造体テンプレート
=================================

.. cpp:struct:: template<typename Char> c_regex_traits

   :cpp:struct:`basic_regex\<>` クラステンプレートで使用するために標準の C ロカール関数をカプセル化する。


.. cpp:namespace-push:: c_regex_traits


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/xpressive_fwd.hpp`>

   template<typename Char> 
   struct :cpp:struct:`~::boost::xpressive::c_regex_traits` {
     // :ref:`構築、コピー、解体 <c_regex_traits.construct-copy-destruct>`
     :cpp:func:`~c_regex_traits::c_regex_traits`\(locale_type const & = locale_type());

     // :ref:`公開メンバ関数 <c_regex_traits.public-member-functions>`
     bool :cpp:func:`operator==`\(:cpp:struct:`c_regex_traits`\< char_type > const &) const;
     bool :cpp:func:`operator!=`\(:cpp:struct:`c_regex_traits`\< char_type > const &) const;
     string_type :cpp:func:`fold_case`\(char_type) const;
     locale_type :cpp:func:`imbue`\(locale_type);
     template<> char :cpp:func:`widen`\(char);
     template<> wchar_t :cpp:func:`widen`\(char);
     template<> unsigned char :cpp:func:`hash`\(char);
     template<> unsigned char :cpp:func:`hash`\(wchar_t);
     template<> int :cpp:func:`value`\(char, int);
     template<> int :cpp:func:`value`\(wchar_t, int);

     // :ref:`公開静的メンバ関数 <c_regex_traits.public-static-functions>`
     static char_type :cpp:func:`widen`\(char);
     static unsigned char :cpp:func:`hash`\(char_type);
     static char_type :cpp:func:`translate`\(char_type);
     static char_type :cpp:func:`translate_nocase`\(char_type);
     static char_type :cpp:func:`tolower`\(char_type);
     static char_type :cpp:func:`toupper`\(char_type);
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
     static locale_type :cpp:func:`getloc`\();
   };


説明
----

.. _c_regex_traits.construct-copy-destruct:

:cpp:struct:`!c_regex_traits` 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: c_regex_traits(locale_type const & loc = locale_type())

   グローバルな C ロカールを使用する :cpp:struct:`!c_regex_traits` オブジェクトを初期化する。


.. _c_regex_traits.public-member-functions:

:cpp:struct:`!c_regex_traits` 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: bool operator==(c_regex_traits< char_type > const &) const

   2 つの :cpp:struct:`c_regex_traits` オブジェクトが等値か調べる。

   :returns: 真。


.. cpp:function:: bool operator!=(c_regex_traits< char_type > const &) const

   2 つの :cpp:struct:`c_regex_traits` オブジェクトが等値でないか調べる。

   :returns: 偽。


.. cpp:function:: string_type fold_case(char_type ch) const

   渡した文字と大文字小文字を区別せずに比較すると等値となる文字をすべて含む :cpp:type:`!string_type` を返す。この関数が呼び出されるのは :cpp:expr:`has_fold_case<c_regex_traits<Char> >` が真の場合のみである。

   :param ch: 元の文字。
   :returns: :cpp:var:`!ch` と大文字小文字を区別せずに比較すると等値となる文字をすべて含む :cpp:type:`!string_type`


.. cpp:function:: locale_type imbue(locale_type loc)

   何もしない。


.. cpp:function:: template<> char widen(char ch)

.. cpp:function:: template<> wchar_t widen(char ch)

.. cpp:function:: template<> unsigned char hash(char ch)

.. cpp:function:: template<> unsigned char hash(wchar_t ch)

.. cpp:function:: template<> int value(char ch, int radix)

.. cpp:function:: template<> int value(wchar_t ch, int radix)


.. _c_regex_traits.public-static-functions:

:cpp:struct:`!c_regex_traits` 公開静的メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: static char_type widen(char ch)

   :cpp:type:`!char` 型の値を :cpp:type:`Char` 型に変換する。

   :param ch: 元の文字。
   :returns: :cpp:type:`!Char` が :cpp:type:`!char` であれば :cpp:var:`!ch` 、:cpp:type:`!Char` が :cpp:type:`!wchar_t` であれば :cpp:expr:`std::btowc(ch)`。


.. cpp:function:: static unsigned char hash(char_type ch)

   ``[0, UCHAR_MAX]`` の範囲で :cpp:type:`!Char` のハッシュ値を返す。

   :param ch: 元の文字
   :returns: ``0`` 以上 :cpp:var:`!UCHAR_MAX` 以下の値。


.. cpp:function:: static char_type translate(char_type ch)

   何もしない。

   :param ch: 元の文字。
   :returns: :cpp:var:`!ch`


.. cpp:function:: static char_type translate_nocase(char_type ch)

   現在のグローバルな C ロカールを使用して、文字を小文字に変換する。

   :param ch: 元の文字。
   :returns: :cpp:type:`!Char` が :cpp:type:`!char` であれば :cpp:expr:`std::tolower(ch)` 、:cpp:type:`!Char` が :cpp:type:`!wchar_t` であれば :cpp:expr:`std::towlower(ch)`。


.. cpp:function:: static char_type tolower(char_type ch)

   現在のグローバルな C ロカールを使用して、文字を小文字に変換する。

   :param ch: 元の文字。
   :returns: :cpp:type:`!Char` が :cpp:type:`!char` であれば :cpp:expr:`std::tolower(ch)` 、:cpp:type:`!Char` が :cpp:type:`!wchar_t` であれば :cpp:expr:`std::towlower(ch)`。


.. cpp:function:: static char_type toupper(char_type ch)

   現在のグローバルな C ロカールを使用して、文字を大文字に変換する。

   :param ch: 元の文字。
   :returns: :cpp:type:`!Char` が :cpp:type:`!char` であれば :cpp:expr:`std::toupper(ch)` 、:cpp:type:`!Char` が :cpp:type:`!wchar_t` であれば :cpp:expr:`std::towupper(ch)`。


.. cpp:function:: static bool in_range(char_type first, char_type last, char_type ch)

   文字が文字範囲に含まれるか調べる。

   :param ch: 元の文字。
   :param first: 範囲の下限。
   :param last: 範囲の上限。
   :returns: :cpp:expr:`first <= ch && ch <= last`


.. cpp:function:: static bool in_range_nocase(char_type first, char_type last, char_type ch)

   文字が文字範囲に含まれるか調べる。大文字小文字を区別しない。

   .. note:: 既定の実装は適正な Unicode ケースフォールディングを行わないが、標準 C ロカールではこれが最善である。

   :param ch: 元の文字。
   :param first: 範囲の下限。
   :param last: 範囲の上限。
   :returns: :cpp:expr:`in_range(first, last, ch) || in_range(first, last, tolower(ch)) || in_range(first, last, toupper(ch))`


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

   指定した文字シーケンスが表す文字分類について、相当するビットマスクを返す。

   :param begin: 文字分類の名前を表す文字シーケンスの先頭を指す前進イテレータ。
   :param end: 文字シーケンスの終端。
   :param icase: 戻り値のビットマスクが大文字小文字を区別しない文字分類を表すかを指定する。
   :returns: 文字分類を表すビットマスク。


.. cpp:function:: static bool isctype(char_type ch, char_class_type mask)

   文字分類ビットマスクに対して文字をテストする。

   :param ch: テストする文字。
   :param mask: テストする文字分類のビットマスク。
   :要件: :cpp:var:`!mask` は :cpp:func:`!lookup_classname` が返したビットマスクか、それらのビット和。
   :returns:	文字が指定した文字分類に含まれれば真、それ以外は偽。


.. cpp:function:: static int value(char_type ch, int radix)

   数字を数値に変換する。

   :param ch: 数字。
   :param radix: 変換に使用する序数。
   :要件: :cpp:var:`!radix` は 8 、10 、16 のいずれか。
   :returns: :cpp:var:`!ch` が数字でなければ ``-1`` 、それ以外は文字が表す数値。:cpp:type:`!char_type` が :cpp:type:`!char` であれば :cpp:func:`!std::strtol` を、:cpp:type:`!char_type` が :cpp:type:`!wchar_t` であれば :cpp:func:`!std::wcstol` を使用する。

.. cpp:function:: static locale_type getloc()

   何もしない。


.. cpp:namespace-pop::
