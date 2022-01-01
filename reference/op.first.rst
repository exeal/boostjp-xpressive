first 構造体テンプレート
========================

.. cpp:struct:: op::first

   :cpp:struct:`first` は、組の第 1 要素にアクセスする PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::first


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::first` {
     // メンバクラス、構造体、共用体
     template<typename Sig>
     struct :cpp:struct:`~first::result` {
     };
     template<typename This, typename Pair>
     struct :cpp:struct:`~first::result`\<This(Pair)> {
       // 型
       typedef remove_reference< Pair >::type::first_type :cpp:type:`first::result::type`;
     };

     // :ref:`公開メンバ関数 <op.first.public-member-functions>`
     template<typename Pair> Pair::first_type :cpp:func:`~first::operator()`\(Pair const &) const;
   };


説明
----

.. _op.first.public-member-functions:

first 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Pair> \
		  Pair::first_type operator()(Pair const & p) const

   :param p: 第 1 要素にアクセスする対象の組。
   :returns: :cpp:expr:`p.first`


.. cpp:namespace-pop::
