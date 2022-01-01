top 構造体テンプレート
======================

.. cpp:struct:: op::top

   :cpp:struct:`top` は、スタックの一番上の要素にアクセスする PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::top


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::top` {
     // メンバクラス、構造体、共用体
     template<typename Sig>
     struct :cpp:struct:`!result` {
     };
     template<typename This, typename Sequence>
     struct :cpp:struct:`!result`\<This(Sequence)> {
       // 型
       typedef remove_reference< Sequence >::type                                                                                                        :cpp:type:`!sequence_type`;
       typedef mpl::if_c< is_const< sequence_type >::value, typename sequence_type::value_type const &, typename sequence_type::value_type & >::type :cpp:type:`!type`;
     };

     // :ref:`公開メンバ関数 <op.top.public-member-functions>`
     template<typename Sequence>
       :cpp:struct:`!result`\< top(Sequence &)>::type :cpp:func:`operator()`\(Sequence &) const;
   };


説明
----

.. _op.top.public-member-functions:

top 公開メンバ関数
^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Sequence> \
		  result< top(Sequence &)>::type operator()(Sequence & seq) const

   :param seq: 一番上の要素にアクセスするシーケンス。
   :returns: :cpp:expr:`seq.top()`


.. cpp:namespace-pop::
