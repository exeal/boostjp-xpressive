at 構造体テンプレート
=====================

.. cpp:struct:: op::at

   :cpp:struct:`!at\<>` は、シーケンスに添字アクセスする PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::at


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~::boost::xpressive::op::at` {
     // メンバクラス、構造体、共用体
     template<typename Sig>
     struct :cpp:struct:`~at::result` {
     };
     template<typename This, typename Cont, typename Idx>
     struct :cpp:struct:`~at::result`\<This(Cont &, Idx)> {
       // 型
       typedef Cont::reference :cpp:type:`~at::result::type`;
     };
     template<typename This, typename Cont, typename Idx>
     struct :cpp:struct:`~at::result`\<This(Cont const &, Idx)> {
       // 型
       typedef Cont::const_reference :cpp:type:`~at::result::type`;
     };
     template<typename This, typename Cont, typename Idx>
     struct :cpp:struct:`~at::result`\<This(Cont, Idx)> {
       // 型
       typedef Cont::const_reference :cpp:type:`~at::result::type`;
     };

     // :ref:`公開メンバ関数 <op.at.public-member-functions>`
     template<typename Cont, typename Idx>
       Cont::reference :cpp:func:`~at::operator()`\(Cont &, Idx) const;
     template<typename Cont, typename Idx>
       Cont::const_reference :cpp:func:`~at::operator()`\(Cont const &, Idx) const;
   };


説明
----

.. _op.at.public-member-functions:

at 公開メンバ関数
^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Cont, typename Idx> \
		  Cont::reference operator()(Cont & c, Idx idx) const

   :param c: 添字アクセスする RandomAccessSequence
   :param idx: 添字
   :要件: :cpp:type:`!Cont` が RandomAccessSequence のモデルである
   :returns: :cpp:expr:`c[idx]`


.. cpp:function:: template<typename Cont, typename Idx> \
		  Cont::const_reference operator()(Cont const & c, Idx idx) const

   .. include:: -overload-description.rst


.. cpp:namespace-pop::
