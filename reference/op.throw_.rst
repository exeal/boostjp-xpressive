throw\_ 構造体テンプレート
==========================

.. cpp:struct:: template<Except> op::throw_

   :cpp:struct:`throw_\<>` は、例外を投げる PolymorphicFunctionObject である。

   :tparam Except: 例外オブジェクトの型。


.. cpp:namespace-push:: op::throw_


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   template<typename Except>
   struct :cpp:struct:`~op::throw_` {
   // 型
   typedef void result_type;

   // :ref:`公開メンバ関数 <op.throw_.public-member-functions>`
   void :cpp:func:`operator()`\() const;
   template<typename A0> void :cpp:func:`operator()`\(A0 const &) const;
   template<typename A0, typename A1>
   void :cpp:func:`operator()`\(A0 const &, A1 const &) const;
   template<typename A0, typename A1, typename A2>
   void :cpp:func:`operator()`\(A0 const &, A1 const &, A2 const &) const;
   };


説明
----

.. _op.throw_.public-member-functions:

throw\_ 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: void operator()() const

   .. include:: -overload-description.rst


.. cpp:function:: template<typename A0> \
		  void operator()(A0 const & a0) const

   .. include:: -overload-description.rst


.. cpp:function:: template<typename A0, typename A1> \
		  void operator()(A0 const & a0, A1 const & a1) const

   .. include:: -overload-description.rst


.. cpp:function:: template<typename A0, typename A1, typename A2> \
		  void operator()(A0 const & a0, A1 const & a1, A2 const & a2) const

   .. note:: この関数は実際に例外を投げるのに :c:macro:`!BOOST_THROW_EXCEPTION` を使用する。Boost.Exception ライブラリの説明を見よ。

   :param a0: コンストラクタの第 1 引数。
   :param a1: コンストラクタの第 2 引数。
   :param a2: コンストラクタの第 3 引数。
   :throws Except(a0,a1,...):


.. cpp:namespace-pop::
