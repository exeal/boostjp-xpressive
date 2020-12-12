unwrap_reference 構造体テンプレート
===================================

.. cpp:struct:: op::unwrap_reference

   :cpp:struct:`unwrap_reference` は、:cpp:class:`boost::reference_wrapper\<>` を逆ラップする PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::unwrap_reference


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::unwrap_reference` {
     // メンバクラス、構造体、共用体
     template<typename Sig>
     struct :cpp:struct:`!result` {
     };
     template<typename This, typename Ref>
     struct :cpp:struct:`!result`\<This(Ref &)> {
       // 型
       typedef boost::unwrap_reference< Ref >::type & :cpp:type:`!type`;
     };
     template<typename This, typename Ref>
     struct :cpp:struct:`!result`\<This(Ref)> {
       // 型
       typedef boost::unwrap_reference< Ref >::type & :cpp:type:`!type`;
     };

     // :ref:`公開メンバ関数 <op.unwrap_reference.public-member-functions>`
     template<typename T> T & :cpp:func:`operator()`\(boost::reference_wrapper< T >) const;
   };


説明
----

.. _op.unwrap_reference.public-member-functions:

unwrap_reference 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename T> \
		  T & operator()(boost::reference_wrapper< T > r) const

   :param r: 逆ラップする :cpp:class:`boost::reference_wrapper\<T>`。
   :returns: :cpp:expr:`static_cast<T &>(r)`


.. cpp:namespace-pop::
