push_back 構造体テンプレート
============================

.. cpp:struct:: op::push_back

   :cpp:struct:`push_back` は、コンテナに値を追加する PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::push_back


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::push_back` {
     // 型
     typedef void result_type;

     // :ref:`公開メンバ関数 <op.push_back.public-member-functions>`
     template<typename Sequence, typename Value>
       void :cpp:func:`operator()`\(Sequence &, Value const &) const;
   };


説明
----

.. _op.push_back.public-member-functions:

push_back 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Sequence, typename Value> \
		  void operator()(Sequence & seq, Value const & val) const

   :cpp:expr:`seq.push_back(val)` と等価。

   :param seq: 値を追加する対象のシーケンス。
   :param val: シーケンスに追加する値。
   :returns: :cpp:type:`!void`


.. cpp:namespace-pop::
