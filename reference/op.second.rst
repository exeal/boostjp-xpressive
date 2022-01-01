second 構造体テンプレート
=========================

.. cpp:struct:: op::second

   :cpp:struct:`second` は、組の第 2 要素にアクセスする PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::second


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::second` {
     // メンバクラス、構造体、共用体
     template<typename Sig>
     struct :cpp:struct:`!result` {
     };
     template<typename This, typename Pair>
     struct :cpp:struct:`!result`\<This(Pair)> {
     // 型
     typedef remove_reference< Pair >::type::second_type :cpp:type:`!result`;
     };

     // :ref:`公開メンバ関数 <op.second.public-member-functions>`
     template<typename Pair> Pair::second_type :cpp:func:`operator()`\(Pair const &) const;
   };


説明
----

.. _op.second.public-member-functions:

second 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Pair> \
		  Pair::second_type operator()(Pair const & p) const

   :param p: 第 2 要素にアクセスする対象の組。
   :returns: :cpp:expr:`p.second`


.. cpp:namespace-pop::
