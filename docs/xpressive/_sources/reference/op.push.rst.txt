push 構造体テンプレート
=======================

.. cpp:struct:: op::push

   :cpp:struct:`push` は、コンテナに値を追加する PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::push


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::push` {
     // 型
     typedef void result_type;

     // :ref:`公開メンバ関数 <op.push.public-member-functions>`
     template<typename Sequence, typename Value>
       void :cpp:func:`operator()`\(Sequence &, Value const &) const;
   };


説明
----

.. _op.push.public-member-functions:

push 公開メンバ関数
^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Sequence, typename Value> \
		  void operator()(Sequence & seq, Value const & val) const

   :cpp:expr:`seq.push(val)` と等価。

   :param seq: 値を追加する対象のシーケンス。
   :param val: シーケンスに追加する値。
   :returns: :cpp:type:`!void`


.. cpp:namespace-pop::
