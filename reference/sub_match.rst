sub_match 構造体テンプレート
============================

.. cpp:struct:: template<typename BidiIter> sub_match : public std::pair<BidiIter, BidiIter>

   :cpp:struct:`sub_match` クラステンプレートは、個々のマーク済み部分式にマッチした文字シーケンスを表す。


.. cpp:namespace-push:: sub_match


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/sub_match.hpp`>

   template<typename BidiIter>
   struct :cpp:struct:`~::boost::xpressive::sub_match` : public std::pair< BidiIter, BidiIter > {
     // 型
     typedef iterator_value< BidiIter >::type      value_type;     
     typedef iterator_difference< BidiIter >::type difference_type;
     typedef :samp:`{unspecified}`                           string_type;    
     typedef BidiIter                              iterator;       

     // :ref:`構築、コピー、解体 <sub_match.construct-copy-destruct>`
     :cpp:func:`~sub_match::sub_match`\();
     :cpp:func:`~sub_match::sub_match`\(BidiIter, BidiIter, bool = false);

     // :ref:`公開メンバ関数 <sub_match.public-member-functions>`
     string_type :cpp:func:`str`\() const;
     :cpp:func:`operator string_type`\() const;
     difference_type :cpp:func:`length`\() const;
     :cpp:func:`operator bool_type`\() const;
     bool :cpp:func:`operator!`\() const;
     int :cpp:func:`compare`\(string_type const &) const;
     int :cpp:func:`compare`\(:cpp:struct:`sub_match` const &) const;
     int :cpp:func:`compare`\(value_type const \*) const;

     // 公開データメンバ
     bool matched;  // この部分マッチが全体マッチに関与していれば真。
   };


説明
----

:cpp:struct:`sub_match\<>` 型のオブジェクトが表すマーク済み部分式が正規表現マッチに関与している場合、メンバ :cpp:member:`!matched` は真と評価されメンバ :cpp:member:`!first` および :cpp:member:`!second` はマッチを形成する文字範囲 ``[first,second)`` を表す。それ以外の場合、:cpp:member:`!matched` は偽でありメンバ :cpp:member:`!first` および :cpp:member:`!second` に未定義の値が入る。

:cpp:struct:`sub_match\<>` 型のオブジェクトが 0 番目の部分式、つまりマッチ全体を表す場合、メンバ :cpp:member:`!matched` は常に真である。ただし、フラグ :cpp:var:`!match_partial` を正規表現アルゴリズムを渡して部分マッチが得られた場合は例外である。この場合メンバ :cpp:member:`!matched` は偽であり、メンバ :cpp:member:`!first` および :cpp:member:`!second` は部分マッチを形成する文字範囲を表す。


.. _sub_match.construct-copy-destruct:

:cpp:struct:`!sub_match` 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: sub_match()

.. cpp:function:: sub_match(BidiIter first, BidiIter second, bool matched_ = false)


.. _sub_match.public-member-functions:

:cpp:struct:`!sub_match` 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: string_type str() const

.. cpp:function:: operator string_type() const

.. cpp:function:: difference_type length() const

.. cpp:function:: operator bool_type() const

.. cpp:function:: bool operator!() const

.. cpp:function:: int compare(string_type const & str) const

   字句的な文字列比較を行う。

   :param str: 比較する文字列
   :returns: :cpp:expr:`(*this).str().compare(str)` の結果


.. cpp:function:: int compare(sub_match const & sub) const

   .. include:: -overload-description.rst


.. cpp:function:: int compare(value_type const * ptr) const

   .. :include:: -overload-description.rst


.. cpp:namespace-pop::
