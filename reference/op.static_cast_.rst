static_cast\_ 構造体テンプレート
================================

.. cpp:struct:: template<typename T> op::static_cast_

   :cpp:struct:`static_cast_\<>` は、引数を異なる型へ静的キャストする PolymorphicFunctionObject である。

   :tparam T: 静的キャスト先の型。


.. cpp:namespace-push:: op::static_cast_


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   template<typename T>
   struct :cpp:struct:`~op::static_cast_` {
   // 型
   typedef T result_type;

   // :ref:`公開メンバ関数 <op.static_cast_.public-member-functions>`
   template<typename Value> T :cpp:func:`operator()`\(Value const &) const;
   };


説明
----

.. _op.static_cast_.public-member-functions:

static_cast\_ 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Value> \
		  T operator()(Value const & val) const

   :param val: 静的キャストする値。
   :returns: :cpp:expr:`static_cast<T>(val)`


.. cpp:namespace-pop::
