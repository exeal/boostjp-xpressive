dynamic_cast\_ 構造体テンプレート
=================================

.. cpp:struct:: template<typename T> op::dynamic_cast_

   :cpp:struct:`dynamic_cast_\<>` は、引数を異なる型へ動的キャストする PolymorphicFunctionObject である。

   :tparam T: 引数の動的キャスト先の型。


.. cpp:namespace-push:: op::dynamic_cast_


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   template<typename T>
   struct :cpp:struct:`~op::dynamic_cast_` {
     // 型
     typedef T result_type;

     // :ref:`公開メンバ関数 <op.dynamic_cast_.public-member-functions>`
     template<typename Value> T :cpp:func:`~dynamic_cast_::operator()`\(Value const &) const;
   };


説明
----

.. _op.dynamic_cast_.public-member-functions:

dynamic_cast\_ 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Value> \
                  T operator()(Value const & val) const

   :param val: 動的キャストする値。
   :returns: :cpp:expr:`dynamic_cast<T>(val)`


.. cpp:namespace-pop::
