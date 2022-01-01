length 構造体テンプレート
=========================

.. cpp:struct:: op::length

   :cpp:struct:`length` は、:cpp:struct:`sub_match` の長さを取得する PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::length


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`length` {
     // メンバクラス、構造体、共用体
     template<typename Sig>
     struct :cpp:struct:`~length::result` {
     };
     template<typename This, typename Sub>
     struct :cpp:struct:`~length::result`\<This(Sub)> {
       // 型
       typedef remove_reference< Sub >::type::difference_type :cpp:type:`~length::result::type`;
     };

     // :ref:`公開メンバ関数 <op.length.public-member-functions>`
     template<typename Sub> Sub::difference_type :cpp:func:`~length::operator()`\(Sub const &) const;
   };


説明
----

.. _op.length.public-member-functions:

length 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Sub> \
		  Sub::difference_type operator()(Sub const & sub) const

   :param sub: :cpp:struct:`sub_match` オブジェクト。
   :returns: :cpp:expr:`sub.length()`


.. cpp:namespace-pop::
