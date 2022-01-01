value 構造体テンプレート
========================

.. cpp:struct:: template<typename T> value

   :cpp:struct:`!value\<>` は、xpressive の意味アクションで使用できる値の遅延ラッパである。

   :tparam T: 格納する値の型。

.. cpp:namespace-push:: value


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   template<typename T>
   struct :cpp:struct:`~::boost::xpressive::value` :
     public proto::extends< proto::terminal< T >::type, value< T > >
   {
     // :ref:`構築、コピー、解体 <value.construct-copy-destruct>`
     :cpp:func:`~value::value`\();
     explicit :cpp:func:`~value::value`\(T const &);

     // :ref:`公開メンバ関数 <value.public-member-functions>`
     T & :cpp:func:`get`\();
     T const & :cpp:func:`get`\() const;
   };


説明
----

以下は :cpp:struct:`!value\<>` を使用すると便利な例である。 ::

   sregex good_voodoo(boost::shared_ptr<int> pi)
   {
       using namespace boost::xpressive;
       // val() を使用して shared_ptr を値で保持する：
       sregex rex = +( _d [ ++*val(pi) ] >> '!' );
       // OK 、rex は整数に対する参照カウントを保持する。
       return rex;
   }

上のコードにおいて、:cpp:func:`!xpressive::val()` は :cpp:struct:`!value\<>` オブジェクトを返す関数である。:cpp:func:`!val()` を使用しないと :cpp:expr:`++*pi` の演算は正規表現がマッチしたときに遅延評価されるのではなく、一度だけ積極評価される。


.. _value.construct-copy-destruct:

value 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: value()

   デフォルト構築した :cpp:type:`T` を格納する。


.. cpp:function:: explicit value(T const & t)

   :cpp:var:`t` のコピーを格納する。

   :param t: 初期値。


.. _value.public-member-functions:

value の公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: T & get()

   .. include:: -overload-description.rst


.. cpp:function:: T const & get() const

   格納した値にアクセスする。


.. cpp:namespace-pop::
