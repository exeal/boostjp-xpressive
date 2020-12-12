boost/python/type_id.hpp
========================

.. contents::
   :depth: 1
   :local:


.. _v2.type_id.introduction:

はじめに
--------

:file:`<boost/python/type_id.hpp>` は、:file:`<typeinfo>` のような実行時型識別のための型および関数を提供する。主にコンパイラのバグやプラットフォーム固有の共有ライブラリとの相互作用に対する回避策のために存在する。

.. _v2.type_id.classes:

クラス
------

.. _v2.type_id.type_info-spec:

:cpp:class:`!type_info` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:class:: type_info : totally_ordered<type_info>

   :cpp:class:`!type_info` インスタンスは型を識別する。:cpp:class:`!std::type_info` が規定しているとおり（ただしコンパイラによっては異なる実装をしている場合もある）、:cpp:class:`!boost::python::type_info` はトップレベルの参照や CV 指定子を表現しない（C++ 標準の 5.2.8 節を見よ）。:cpp:class:`!std::type_info` と異なり :cpp:class:`!boost::python::type_info` インスタンスはコピー可能であり、共有ライブラリ境界をまたいで確実に動作する。

.. cpp:namespace-push:: type_info


.. _v2.type_id.type_info-spec-synopsis:

:cpp:class:`!type_info` クラスの概要\ [#]_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     class type_info : totally_ordered<type_info>
     {
      public:
         // コンストラクタ
         type_info(std::type_info const& = typeid(void));

         // 比較
         bool operator<(type_info const& rhs) const;
         bool operator==(type_info const& rhs) const;

         // オブザーバ
         char const* name() const;
     };
   }}


.. _v2.type_id.type_info-spec-ctors:

:cpp:class:`!type_info` クラスのコンストラクタ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: type_info(std::type_info const& = typeid(void))

   :効果: 引数と同じ型を識別する :cpp:class:`!type_info` オブジェクトを構築する。
   :根拠: :cpp:class:`!type_info` オブジェクトの配列の作成が必要になることがあるため、親切にも既定の引数が与えられている。

   .. note:: このコンストラクタはコンパイラの :code:`typeid()` 実装の非準拠を修正し\ **ない**\。以下の :cpp:func:`~type_id::type_id` を見よ。

   .. Sphinx can't recognize :cpp:expr:`typeid()` above.


.. _v2.type_id.type_info-spec-comparisons:

:cpp:class:`!type_info` クラスの比較関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: bool operator<(type_info const& rhs) const

   :効果: :cpp:class:`!type_info` オブジェクト間の全順序を与える。


.. cpp:function:: bool operator==(type_info const& rhs) const

   :returns: 2 つの値が同じ型を示す場合は ``true``。

   .. note:: `totally_ordered\<type_info> <http://www.boost.org/libs/utility/operators.htm#totally_ordered1>`_ を非公開基底クラスとして使用すると、:code:`<=` 、:code:`>=` 、:code:`>` および :code:`!=` が提供される。


.. _v2.type_id.type_info-spec-observers:

:cpp:class:`!type_info` クラスのオブザーバ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: char const* name() const

   :returns: オブジェクトの構築に使用した引数に対して :cpp:func:`~std::type_info::name()` を呼び出した結果。


.. cpp:namespace-pop::


.. _v2.type_id.functions:

関数
----

.. _v2.type_id.lshift-spec:

operator<<
^^^^^^^^^^

.. cpp:function:: std::ostream& operator<<(std::ostream& s, type_info const& x)

   :効果: :cpp:var:`!x` が指定する型の説明を :cpp:var:`!s` に書き込む。
   :根拠: すべての C++ 実装が真に可読可能な :cpp:func:`!type_info::name()` 文字列を提供するわけではないが、文字列を復号化して手ごろな表現を生成できる場合がある。


.. _v2.type_id.type_id-spec:

type_id
^^^^^^^

.. cpp:function:: template <class T> type_info type_id()

   :returns: :cpp:expr:`type_info(typeid(T))`

   .. note:: 標準に非準拠ないくつかの C++ 実装において、コードは実際には上記のように単純ではない。その C++ 実装が標準に準拠している\ **かのように**\動作するようセマンティクスを調整する。


.. _v2.type_id.examples:

例
--

以下の例は、多少醜いが :cpp:func:`!type_id` 機能の使用方法を示している。 ::

   #include <boost/python/type_id.hpp>

   // ユーザが int の引数を渡した場合にtrueを返す
   template <class T>
   bool is_int(T x)
   {
      using boost::python::type_id;
      return type_id<T>() == type_id<int>();
   }


.. [#] `boost::totally_ordered <http://www.boost.org/libs/utility/operators.htm#totally_ordered1>`_
