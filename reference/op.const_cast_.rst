const_cast\_ 構造体テンプレート
===============================

.. cpp:struct:: template<typename T> op::const_cast_

   :cpp:struct:`const_cast_\<>` は、引数を CV 修飾へ const キャストする PolymorphicFunctionObject である。

   :tparam T: const キャスト先の型。


.. cpp:namespace-push:: op::const_cast_


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   template<typename T>
   struct :cpp:struct:`~::boost::xpressive::op::const_cast_` {
     // 型
     typedef T result_type;

     // :ref:`公開メンバ関数 <op.const_cast_.public-member-functions>`
     template<typename Value> T :cpp:func:`~const_cast_::operator`\()(Value const &) const;
   };


説明
----

.. _op.const_cast_.public-member-functions:

const_cast\_ 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Value> \
		  T operator()(Value const & val) const

   :param val: const キャストする値。
   :要件: 型 :cpp:type:`!T` と :cpp:type:`!Value` の違いが CV 修飾子のみである。
   :returns: :cpp:expr:`const_cast<T>\(val)`


.. cpp:namespace-pop::
