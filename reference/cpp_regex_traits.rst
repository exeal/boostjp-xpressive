cpp_regex_traits 構造体テンプレート
===================================

.. cpp:struct:: template<typename Char> cpp_regex_traits

   :cpp:struct:`basic_regex\<>` クラステンプレートで使用するために :cpp:class:`!std::locale` をカプセル化する。


.. cpp:namespace-push:: cpp_regex_traits


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/xpressive_fwd.hpp`>

   template<typename Char> 
   struct :cpp:struct:`~::boost::xpressive::cpp_regex_traits` {
     // :ref:`構築、コピー、解体 <cpp_regex_traits.construct-copy-destruct>`
     :cpp:func:`~cpp_regex_traits::cpp_regex_traits`\(locale_type const & = locale_type());

     // :ref:`公開メンバ関数 <cpp_regex_traits.public-member-functions>`
     bool :cpp:func:`operator==`\(:cpp:struct:`cpp_regex_traits`\< char_type > const &) const;
     bool :cpp:func:`operator!=`\(:cpp:struct:`cpp_regex_traits`\< char_type > const &) const;
     char_type :cpp:func:`widen`\(char) const;
     char_type :cpp:func:`translate_nocase`\(char_type) const;
     char_type :cpp:func:`tolower`\(char_type) const;
     char_type :cpp:func:`toupper`\(char_type) const;
     string_type :cpp:func:`fold_case`\(char_type) const;
     bool :cpp:func:`in_range_nocase`\(char_type, char_type, char_type) const;
     template<typename FwdIter> 
       string_type :cpp:func:`transform_primary`\(FwdIter, FwdIter) const;
     template<typename FwdIter> 
       string_type :cpp:func:`lookup_collatename`\(FwdIter, FwdIter) const;
     template<typename FwdIter> 
       char_class_type :cpp:func:`lookup_classname`\(FwdIter, FwdIter, bool) const;
     bool :cpp:func:`isctype`\(char_type, char_class_type) const;
     int :cpp:func:`value`\(char_type, int) const;
     locale_type :cpp:func:`imbue`\(locale_type);
     locale_type :cpp:func:`getloc`\() const;
     template<> unsigned char :cpp:func:`hash`\(unsigned char);
     template<> unsigned char :cpp:func:`hash`\(char);
     template<> unsigned char :cpp:func:`hash`\(signed char);
     template<> unsigned char :cpp:func:`hash`\(wchar_t);

     // :ref:`公開静的メンバ関数 <cpp_regex_traits.public-static-functions>`
     static unsigned char :cpp:func:`hash`\(char_type);
     static char_type :cpp:func:`translate`\(char_type);
     static bool :cpp:func:`in_range`\(char_type, char_type, char_type);
   };


説明
----

.. _cpp_regex_traits.construct-copy-destruct:

:cpp:struct:`!cpp_regex_traits` 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: cpp_regex_traits(locale_type const & loc = locale_type())

   指定した :cpp:class:`!std::locale` を使用する :cpp:struct:`!cpp_regex_traits` オブジェクトを初期化する。引数を省略した場合はグローバルな :cpp:class:`!std::locale` を使用する。


.. _cpp_regex_traits.public-member-functions:

:cpp:struct:`!cpp_regex_traits` 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: bool operator==(cpp_regex_traits< char_type > const & that) const

   2 つの :cpp:struct:`cpp_regex_traits` オブジェクトが等値か調べる。

   :returns: :cpp:expr:`this->getloc() == that.getloc()`。


.. cpp:function:: bool operator!=(cpp_regex_traits< char_type > const & that) const

   2 つの :cpp:struct:`cpp_regex_traits` オブジェクトが等値でないか調べる。

   :returns: :cpp:expr:`this->getloc() != that.getloc()`。


.. cpp:function:: char_type widen(char ch) const

   :cpp:type:`!char` 型の値を :cpp:type:`!Char` 型に変換する。

   :param ch: 元の文字。
   :returns: :cpp:expr:`std::use_facet<std::ctype<char_type> >(this->getloc()).widen(ch)`。


.. cpp:function:: char_type translate_nocase(char_type ch)

   内部保持した :cpp:class:`!std::locale` を使用して、文字を小文字に変換する。

   :param ch: 元の文字。
   :returns: :cpp:expr:`std::tolower(ch, this->getloc())`。


.. cpp:function:: char_type tolower(char_type ch)

   内部保持した :cpp:class:`!std::locale` を使用して、文字を小文字に変換する。

   :param ch: 元の文字。
   :returns: :cpp:expr:`std::tolower(ch, this->getloc())`。


.. cpp:function:: char_type toupper(char_type ch)

   内部保持した :cpp:class:`!std::locale` を使用して、文字を大文字に変換する。

   :param ch: 元の文字。
   :returns: :cpp:expr:`std::toupper(ch, this->getloc())`。


.. cpp:function:: string_type fold_case(char_type ch) const

   渡した文字と大文字小文字を区別せずに比較すると等値となる文字をすべて含む :cpp:type:`!string_type` を返す。この関数が呼び出されるのは :cpp:expr:`has_fold_case<cpp_regex_traits<Char> >` が真の場合のみである。

   :param ch: 元の文字。
   :returns: :cpp:var:`!ch` と大文字小文字を区別せずに比較すると等値となる文字をすべて含む :cpp:type:`!string_type`


.. cpp:function:: bool in_range_nocase(char_type first, char_type last, char_type ch)

   文字が文字範囲に含まれるか調べる。大文字小文字を区別しない。

   .. note:: 既定の実装は適正な Unicode ケースフォールディングを行わないが、標準の :cpp:class:`!ctype` ファセットではこれが最善である。

   :param ch: 元の文字。
   :param first: 範囲の下限。
   :param last: 範囲の上限。
   :returns: :cpp:expr:`in_range(first, last, ch) || in_range(first, last, tolower(ch, this->getloc())) || in_range(first, last, toupper(ch, this->getloc()))`


.. cpp:function:: template<typename FwdIter> string_type transform_primary(FwdIter, FwdIter)

   イテレータ範囲 ``[F1, F2)`` が示す文字シーケンスのソートキーを返す。大文字小文字を区別せずにソートして文字シーケンス ``[G1, G2)`` が文字シーケンス ``[H1, H2)`` の前に現れる場合に :cpp:expr:`v.transform(G1, G2) < v.transform(H1, H2)` とならなければならない。

   .. note:: 現在使用していない。


.. cpp:function:: template<typename FwdIter> string_type lookup_collatename(FwdIter begin, FwdIter end)

   イテレータ範囲 ``[F1, F2)`` が示す文字シーケンスが構成する照合要素を表す文字シーケンスを返す。文字シーケンスが正しい照合要素でなければ空文字列を返す。

   .. note:: 現在使用していない。


.. cpp:function:: template<typename FwdIter> char_class_type lookup_classname(FwdIter begin, FwdIter end, bool icase)

   指定した文字シーケンスが表す文字分類について、相当するビットマスクを返す。

   :param begin: 文字分類の名前を表す文字シーケンスの先頭を指す前進イテレータ。
   :param end: 文字シーケンスの終端。
   :param icase: 戻り値のビットマスクが大文字小文字を区別しない文字分類を表すかを指定する。
   :returns: 文字分類を表すビットマスク。


.. cpp:function:: bool isctype(char_type ch, char_class_type mask)

   文字分類ビットマスクに対して文字をテストする。

   :param ch: テストする文字。
   :param mask: テストする文字分類のビットマスク。
   :要件: :cpp:var:`!mask` は :cpp:func:`lookup_classname` が返したビットマスクか、それらのビット和。
   :returns: 文字が指定した文字分類に含まれれば真、それ以外は偽。


.. cpp:function:: int value(char_type ch, int radix) const

   数字を数値に変換する。

   :param ch: 数字。
   :param radix: 変換に使用する序数。
   :要件: :cpp:var:`!radix` は 8 、10 、16 のいずれか。
   :returns: :cpp:var:`!ch` が数字でなければ ``-1`` 、それ以外は文字が表す数値。変換は次の要領で行う：:cpp:class:`!std::stringstream` に :cpp:expr:`this->getloc()` を指示する。序数を 8 、16 、10 のいずれかに設定する。:cpp:var:`!ch` をストリームに挿入する。:cpp:type:`!int` を抽出する。


.. cpp:function:: locale_type imbue(locale_type loc)

   :cpp:expr:`*this` に :cpp:var:`!loc` を指示する。

   :param loc: :cpp:class:`!std::locale`。
   :returns: :cpp:expr:`*this` が直前まで使用していた :cpp:class:`!std::locale`。


.. cpp:function:: locale_type getloc() const

   :cpp:expr:`*this` が現在使用している :cpp:class:`!std::locale` を返す。


.. cpp:function:: template<> unsigned char hash(unsigned char ch)

.. cpp:function:: template<> unsigned char hash(char ch)

.. cpp:function:: template<> unsigned char hash(signed char ch)

.. cpp:function:: template<> unsigned char hash(wchar_t ch)


.. _cpp_regex_traits.public-static-functions:

:cpp:struct:`!cpp_regex_traits` 公開静的メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: static unsigned char hash(char_type ch)

   ``[0, UCHAR_MAX]`` の範囲で :cpp:type:`!Char` のハッシュ値を返す。

   :param ch: 元の文字。
   :returns: ``0`` 以上 :cpp:var:`!UCHAR_MAX` 以下の値。


.. cpp:function:: static char_type translate(char_type ch)

   何もしない。

   :param ch: 元の文字。
   :returns: :cpp:var:`!ch`


.. cpp:function:: static bool in_range(char_type first, char_type last, char_type ch)

   文字が文字範囲に含まれるか調べる。

   :param ch: 元の文字。
   :param first: 範囲の下限。
   :param last: 範囲の上限。
   :returns: :cpp:expr:`first <= ch && ch <= last`


.. cpp:namespace-pop::
