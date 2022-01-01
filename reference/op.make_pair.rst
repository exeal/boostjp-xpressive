make_pair 構造体テンプレート
============================

.. cpp:struct:: op::make_pair

   :cpp:struct:`make_pair` は、2 つの引数から :cpp:struct:`!std::pair` を構築する PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::make_pair


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::make_pair` {
     // メンバクラス、構造体、共用体
     template<typename Sig>
     struct :cpp:struct:`!result` {
     };
     template<typename This, typename First, typename Second>
     struct :cpp:struct:`!result`\<This(First, Second)> {
       // 型
       typedef decay< First >::type                 :cpp:type:`!first_type`;   // 説明のためにのみ記載。 
       typedef decay< Second >::type                :cpp:type:`!second_type`;  // 説明のためにのみ記載。 
       typedef std::pair< first_type, second_type > :cpp:type:`!type`;       
     };

     // :ref:`公開メンバ関数 <op.make_pair.public-member-functions>`
     template<typename First, typename Second>
       std::pair< First, Second > :cpp:func:`operator()`\(First const &, Second const &) const;
   };


説明
----

.. _op.make_pair.public-member-functions:

make_pair 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename First, typename Second> \
		  std::pair< Pair, Second > operator()(First const & first, Second const & second) const

   :param first: 組の第 1 要素。
   :param second: 組の第 2 要素。
   :returns: :cpp:expr:`std::make_pair(first, second)`


.. cpp:namespace-pop::
