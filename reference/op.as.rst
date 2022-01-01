as 構造体テンプレート
=====================

.. cpp:struct:: template<typename T> op::as

   :cpp:struct:`!as\<>` は、引数を異なる型へ字句キャストする PolymorphicFunctionObject である。

   :tparam T: 引数の字句キャスト先の型。


.. cpp:namespace-push:: op::as


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   template<typename T>
   struct :cpp:struct:`~::boost::xpressive::op::as` {
     // 型
     typedef T result_type;

     // :ref:`公開メンバ関数 <op.as.public-member-functions>`
     template<typename Value> T :cpp:func:`operator\()`\(Value const &) const;
   };


説明
----

.. _op.as.public-member-functions:

as 公開メンバ関数
^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Value> \
                  T operator()(Value const & val) const

   :param val: 字句キャストする値。
   :returns: :cpp:expr:`boost::lexical_cast<T>(val)`


.. cpp:namespace-pop::
