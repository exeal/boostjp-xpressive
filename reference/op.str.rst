str 構造体テンプレート
======================

.. cpp:struct:: op::str

   :cpp:struct:`str` は、:cpp:struct:`sub_match` を等価な :cpp:class:`!std::string` に変換する PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::str


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::str` {
     // メンバクラス、構造体、共用体
     template<typename Sig>
     struct :cpp:struct:`!result` {
     };
     template<typename This, typename Sub>
     struct :cpp:struct:`!result`\<This(Sub)> {
       // 型
       typedef remove_reference< Sub >::type::string_type :cpp:type:`!type`;
     };

     // :ref:`公開メンバ関数 <op.str.public-member-functions>`
     template<typename Sub> Sub::string_type :cpp:func:`operator()`\(Sub const &) const;
   };


説明
----

.. _op.str.public-member-functions:

str 公開メンバ関数
^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Sub> \
		  Sub::string_type operator()(Sub const & sub) const

   :param sub: :cpp:struct:`sub_match` オブジェクト。
   :returns: :cpp:expr:`sub.str()`


.. cpp:namespace-pop::
