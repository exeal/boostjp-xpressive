back 構造体テンプレート
=======================

.. cpp:struct:: op::back

   :cpp:struct:`!back\<>` は、コンテナの最後列の要素にアクセスする PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::back


概要
----

.. parsed-literal::

   // ヘッダ：:<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~::boost::xpressive::op::back` {
     // メンバクラス、構造体、共用体
     template<typename Sig>
     struct :cpp:struct:`~back::result` {
     };
     template<typename This, typename Sequence>
     struct :cpp:struct:`~back::result`\<This(Sequence)> {
       // 型
       typedef remove_reference< Sequence >::type                                                                                              :cpp:type:`~back::result::sequence_type`;
       typedef mpl::if_c< is_const< sequence_type >::value, typename sequence_type::const_reference, typename sequence_type::reference >::type :cpp:type:`~back::result::type`;         
     };

     // :ref:`公開メンバ関数 <op.back.public-member-functions>`
     template<typename Sequence>
       :cpp:class:`~back::result`\< back(Sequence &)>::type :cpp:func:`~back::operator()`\(Sequence &) const;
   };


説明
----

.. _op.back.public-member-functions:

back 公開メンバ関数
^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Sequence> \
		  result< back(Sequence &)>::type operator()(Sequence & seq) const

   :param seq: 最後列にアクセスするシーケンス
   :returns: :cpp:expr:`seq.back()`


.. cpp:namespace-pop::
