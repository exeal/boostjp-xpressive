construct 構造体テンプレート
============================

.. cpp:struct:: template<typename T> op::construct

   :cpp:struct:`construct\<>` は、新しいオブジェクトを構築する PolymorphicFunctionObject である。

   :tparam T: 構築するオブジェクトの型。


.. cpp:namespace-push:: op::construct


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   template<typename T>
   struct :cpp:struct:`~::boost::xpressive::op::construct` {
     // 型
     typedef T result_type;

     // :ref:`公開メンバ関数 <op.construct.public-member-functions>`
     T :cpp:func:`~construct::operator()`\() const;
     template<typename A0> T :cpp:func:`~construct::operator()`\(A0 const &) const;
     template<typename A0, typename A1>
       T :cpp:func:`~construct::operator()`\(A0 const &, A1 const &) const;
     template<typename A0, typename A1, typename A2>
       T :cpp:func:`~construct::operator()`\(A0 const &, A1 const &, A2 const &) const;
   };


説明
----

.. _op.construct.public-member-functions:

construct 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: T operator()() const

   .. include:: -overload-description.rst


.. cpp:function:: template<typename A0> \
		  T operator()(A0 const & a0) const

   .. include:: -overload-description.rst


.. cpp:function:: template<typename A0, typename A1> \
		  T operator()(A0 const & a0, A1 const & a1) const

   .. include:: -overload-description.rst


.. cpp:function:: template<typename A0, typename A1, typename A2> \
		  T operator()(A0 const & a0, A1 const & a1, A2 const & a2) const

   :param a0: コンストラクタの第 1 引数
   :param a1: コンストラクタの第 2 引数
   :param a2: コンストラクタの第 3 引数
   :returns: :cpp:expr:`T(a0,a1,...)`


.. cpp:namespace-pop::
