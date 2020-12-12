local 構造体テンプレート
========================

.. cpp:struct:: template<typename T> boost::xpressive::local

   :cpp:struct:`!local\<>` は、:cpp:struct:`!local` 自身に格納されている値への参照に対する遅延ラッパである。

   :tparam T: 変数の型。


.. cpp:namespace-push:: local


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   template<typename T>
   struct :cpp:struct:`local` : public proto::terminal::type< reference_wrapper< T > > {
     // :ref:`構築、コピー、解体 <local.construct-copy-destruct>`
     :cpp:func:`~local::local`\();
     explicit :cpp:func:`~local::local`\(T const &);

     // :ref:`公開メンバ関数 <local.public-member-functions>`
     T & :cpp:func:`get`\();
     T const & :cpp:func:`get`\() const;
   };


説明
----

以下は意味アクション内における :cpp:struct:`!local\<>` の使用例である。 ::

   using namespace boost::xpressive;
   local<int> i(0);
   std::string str("1!2!3?");
   // 感嘆符付きの数字を数える。
   // 疑問符付きのものは数えない。
   sregex rex = +( _d [ ++i ] >> '!' );
   regex_search(str, rex);
   assert( i.get() == 2 );

.. note::
   local という名前が示すとおり、:cpp:struct:`!local\<>` オブジェクトとそれらを参照する正規表現がローカルスコープを離脱することはない。:cpp:struct:`!local` オブジェクトが格納する値は :cpp:struct:`!local\<>` の寿命が終わった時点で破壊され、:cpp:struct:`!local\<>` を保持する正規表現オブジェクトは懸垂参照とともに取り残される。


.. _local.construct-copy-destruct:

local 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: local()

   型 :cpp:type:`T` をデフォルト構築した値を格納する。


.. cpp:function:: explicit local(T const & t)

   型 :cpp:type:`T` をデフォルト構築した値を格納する。

   :param t: 初期値。


.. _local.public-member-functions:

公開メンバ関数
^^^^^^^^^^^^^^

.. cpp:function:: T & get()

   ラップしている値にアクセスする。


.. cpp:function:: T const & get() const

   .. include:: -overload-description.rst


.. cpp:namespace-pop::
