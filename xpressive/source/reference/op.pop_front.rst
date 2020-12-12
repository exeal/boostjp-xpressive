pop_front 構造体テンプレート
============================

.. cpp:struct:: op::pop_front

   :cpp:struct:`pop_front` は、コンテナから要素を 1 つ削除する PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::pop_front


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::pop_front` {
     // 型
     typedef void result_type; 

     // :ref:`公開メンバ関数 <op.pop_front.public-member-functions>`
     template<typename Sequence> void :cpp:func:`operator()`\(Sequence &) const;
   };


説明
----

.. _op.pop_front.public-member-functions:

pop_front 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Sequence> \
		  void operator()(Sequence & seq) const

   :cpp:expr:`seq.pop_front()` と等価。

   :param seq: 削除対象のシーケンス。
   :returns: :cpp:type:`!void`


.. cpp:namespace-pop::
