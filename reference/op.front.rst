front 構造体テンプレート
========================

.. cpp:struct:: op::front

   :cpp:struct:`front` は、コンテナの最前列の要素にアクセスする PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::front


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::front` {
     // メンバクラス、構造体、共用体
     template<typename Sig>
     struct :cpp:struct:`~front::result` {
     };
     template<typename This, typename Sequence>
     struct :cpp:struct:`~front::result`\<This(Sequence)> {
       // 型
       typedef remove_reference< Sequence >::type                                                                                              sequence_type;
       typedef mpl::if_c< is_const< sequence_type >::value, typename sequence_type::const_reference, typename sequence_type::reference >::type type;         
     };

     // :ref:`公開メンバ関数 <op.front.public-member-functions>`
     template<typename Sequence>
     :cpp:struct:`~front::result`\< front(Sequence &)>::type :cpp:func:`~front::operator()`\(Sequence &) const;
   };


説明
----

.. _op.front.public-member-functions:

front 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Sequence> \
		  result< front(Sequence &)>::type operator()(Sequence & seq) const

   :param seq: 最前列の要素にアクセスするシーケンス。
   :returns: :cpp:expr:`seq.front()`


.. cpp:namespace-pop::
