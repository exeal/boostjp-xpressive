boost/python/reference_existing_object.hpp
==========================================

.. contents::
   :depth: 1
   :local:


.. _v2.reference_existing_object.classes:

クラス
------

.. _v2.reference_existing_object-spec:

:cpp:struct:`!reference_existing_object` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: reference_existing_object

   :cpp:struct:`!reference_existing_object` は、C++ オブジェクトへの参照かポインタを返すC++関数をラップするのに使用する :ref:`ResultConverterGenerator <concepts.resultconverter.resultconvertergenerator_concept>` のモデルである。ラップした関数を呼び出すとき、戻り値が参照する値はコピーされない。新しい Python オブジェクトは参照先へのポインタを持ち、対応する Python オブジェクトと少なくとも同じ長さの寿命となるような処置はなされない。よって、:cpp:struct:`with_custodian_and_ward` 等の :ref:`CallPolicies <concepts.callpolicies>` モデルを利用した他の寿命管理無しで :cpp:struct:`!reference_existing_object` を使用すると\ **非常に危険**\となる可能性がある。このクラスは :cpp:struct:`return_internal_reference` の実装に使用されている。


.. cpp:namespace-push:: reference_existing_object


.. _v2.reference_existing_object.reference_existing_object-spec-synopsis:

:cpp:struct:`!reference_existing_object` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       struct reference_existing_object
       {
           template <class T> struct apply;
       };
   }}


.. _v2.reference_existing_object.reference_existing_object-spec-metafunctions:

:cpp:struct:`!reference_existing_object` クラスのメタ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:struct:: template <class T> apply

   :要件: ある :cpp:type:`!U` に対して :cpp:type:`!T` が :cpp:type:`!U&` か :cpp:type:`!U*`。

   .. cpp:type:: to_python_indirect<T,V> type

      :cpp:type:`!V` は、ラップする関数の戻り値が参照する先への所有権のない :cpp:type:`!U*` ポインタを持つインスタンスホルダを構築する :cpp:func:`!execute` 静的関数を持つクラス。


.. cpp:namespace-pop::


.. _v2.reference_existing_object.examples:

例
--

.. code-block::
   :caption: C++ 側

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/reference_existing_object.hpp>
   #include <boost/python/return_value_policy.hpp>
   #include <utility>

   // ラップするクラス群
   struct Singleton
   {
      Singleton() : x(0) {}

      int exchange(int n)  // x を設定し、古い値を返す
      {
           std::swap(n, x);
           return n;
      }

      int x;
   };

   Singleton& get_it()
   {
      static Singleton just_one;
      return just_one;
   }

   // ラッパコード
   using namespace boost::python;
   BOOST_PYTHON_MODULE(singleton)
   {
       def("get_it", get_it,
           return_value_policy<reference_existing_object>());

       class_<Singleton>("Singleton")
          .def("exchange", &Singleton::exchange)
          ;
   }

.. code-block:: python
   :caption: Python 側

   >>> import singleton
   >>> s1 = singleton.get_it()
   >>> s2 = singleton.get_it()
   >>> id(s1) == id(s2)  # s1 と s2 は同じオブジェクトではないが
   0
   >>> s1.exchange(42)   # 同じ C++ の Singleton を参照する
   0
   >>> s2.exchange(99)
   42
