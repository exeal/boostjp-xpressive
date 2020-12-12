matched 構造体テンプレート
==========================

.. cpp:struct:: op::matched

   :cpp:struct:`matched` は、:cpp:struct:`sub_match` オブジェクトがマッチしたかどうか判断する PolymorphicFunctionObject である。


.. cpp:namespace-push:: op::matched


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   struct :cpp:struct:`~op::matched` {
     // 型
     typedef bool result_type;

     // :ref:`公開メンバ関数 <op.matched.public-member-functions>`
     template<typename Sub> bool :cpp:func:`operator()`\(Sub const &) const;
   };


説明
----

.. _op.matched.public-member-functions:

matched 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename Sub> \
		  bool operator()(Sub const & sub) const

   :param sub: :cpp:class:`sub_match` オブジェクト。
   :returns: :cpp:expr:`sub.matched`


.. cpp:namespace-pop::
