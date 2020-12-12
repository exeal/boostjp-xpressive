pop 構造体テンプレート
======================

.. cpp:struct:: op::pop

   :cpp:struct:`pop` は、コンテナから要素を 1 つ削除する PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::pop


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::pop` {
     // 型
     typedef void result_type; 

     // :ref:`公開メンバ関数 <op.pop.public-member-functions>`
     template<typename Sequence> void :cpp:func:`operator()`\(Sequence &) const;
   };


説明
----

.. _op.pop.public-member-functions:

pop 公開メンバ関数
^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Sequence> \
		  void operator()(Sequence & seq) const

   :cpp:expr:`seq.pop()` と等価。

   :param seq: 削除対象のシーケンス。
   :returns: :cpp:type:`!void`


.. cpp:namespace-pop::
