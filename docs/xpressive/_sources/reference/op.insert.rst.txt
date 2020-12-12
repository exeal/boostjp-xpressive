insert 構造体テンプレート
=========================

.. cpp:struct:: op::insert

   :cpp:struct:`insert` は、値か値のシーケンスを連続コンテナ、連想コンテナ、または文字列に挿入する PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::insert


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`insert` {
     // メンバクラス、構造体、共用体
     template<typename Sig>
     struct :cpp:struct:`~insert::result` {
       // 型
       typedef unspecified :cpp:type:`~insert::result::type`;
     };

     // :ref:`公開メンバ関数 <op.insert.public-member-functions>`
     template<typename Cont, typename A0>
       :cpp:struct:`~insert::result`\< insert(Cont &, A0 const &)>::type 
       :cpp:func:`~insert::operator()`\(Cont &, A0 const &) const;
     template<typename Cont, typename A0, typename A1>
       :cpp:struct:`~insert::result`\< insert(Cont &, A0 const &, A1 const &)>::type 
       :cpp:func:`~insert::operator()`\(Cont &, A0 const &, A1 const &) const;
     template<typename Cont, typename A0, typename A1, typename A2>
       :cpp:struct:`~insert::result`\< insert(Cont &, A0 const &, A1 const &, A2 const &)>::type 
       :cpp:func:`~insert::operator()`\(Cont &, A0 const &, A1 const &, A2 const &) const;
     template<typename Cont, typename A0, typename A1, typename A2, typename A3>
       :cpp:struct:`~insert::result`\< insert(Cont &, A0 const &, A1 const &, A2 const &, A3 const &)>::type 
       :cpp:func:`~insert::operator()`\(Cont &, A0 const &, A1 const &, A2 const &, A3 const &) const;
   };


説明
----

.. _op.insert.public-member-functions:

insert 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Cont, typename A0> \
		  result< insert(Cont &, A0 const &)>::type operator()() const

   .. include:: -overload-description.rst


.. cpp:function:: template<typename Cont, typename A0, typename A1> \
		  result< insert(Cont &, A0 const &, A1 const &)>::type operator()(Cont & cont, A0 const & a0, A1 const & a1) const

   .. include:: -overload-description.rst


.. cpp:function:: template<typename Cont, typename A0, typename A1, typename A2> \
		  result< insert(Cont &, A0 const &, A1 const &, A2 const &)>::type operator()(Cont & cont, A0 const & a0, A1 const & a1, A2 const & a2) const

   .. include:: -overload-description.rst


.. cpp:function:: template<typename Cont, typename A0, typename A1, typename A2, typename A3> \
		  result< insert(Cont &, A0 const &, A1 const &, A2 const &, A3 const &)>::type operator()(Cont & cont, A0 const & a0, A1 const & a1, A2 const & a2, A3 const & a3) const

   :param a0: 値、イテレータ、または個数
   :param a1: 値、イテレータ、文字列、個数、または文字
   :param a2: 値、イテレータ、または個数
   :param a3: 個数
   :param cont: 要素を挿入する対象のコンテナ
   :returns:
      * :cpp:expr:`insert()(cont, a0)` の場合、:cpp:expr:`cont.insert(a0)` を返す。
      * :cpp:expr:`insert()(cont, a0, a1)` の場合、:cpp:expr:`cont.insert(a0, a1)` を返す。
      * :cpp:expr:`insert()(cont, a0, a1, a2)` の場合、:cpp:expr:`cont.insert(a0, a1, a2)` を返す。
      * :cpp:expr:`insert()(cont, a0, a1, a2, a3)` の場合、:cpp:expr:`cont.insert(a0, a1, a2, a3)` を返す。


.. cpp:namespace-pop::
