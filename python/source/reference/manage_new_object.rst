boost/python/manage_new_object.hpp
==================================

.. contents::
   :depth: 1
   :local:

.. _v2.manage_new_object.classes:

クラス
------

.. _v2.manage_new_object-spec:

:cpp:struct:`!manage_new_object` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: manage_new_object

   :cpp:struct:`!copy_non_const_reference` は、``new`` 式で確保したオブジェクトへのポインタを返し、呼び出し側がそのオブジェクトを削除する責任をもつことを想定する C++ 関数をラップするのに使用する :ref:`ResultConverterGenerator <concepts.resultconverter.resultconvertergenerator_concept>` のモデルである。


.. cpp:namespace-push:: manage_new_object


.. _v2.manage_new_object.manage_new_object-spec-synopsis:

:cpp:struct:`!manage_new_object` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       struct manage_new_object
       {
           template <class T> struct apply;
       };
   }}


.. _v2.manage_new_object.manage_new_object-spec-metafunctions:

:cpp:struct:`!manage_new_object` クラスのメタ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:struct:: template <class T> apply

   :要件: ある :cpp:type:`!U` に対して :cpp:type:`!T` が :cpp:type:`!U*`。

   .. cpp:type:: to_python_indirect<T> type


.. cpp:namespace-pop::


.. _v2.manage_new_object.examples:

例
--

.. code-block::
   :caption: C++ 側

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/manage_new_object.hpp>
   #include <boost/python/return_value_policy.hpp>


   struct Foo {
      Foo(int x) : x(x){}
      int get_x() { return x; }
      int x;
   };

   Foo* make_foo(int x) { return new Foo(x); }

   // ラッパコード
   using namespace boost::python;
   BOOST_PYTHON_MODULE(my_module)
   {
       def("make_foo", make_foo, return_value_policy<manage_new_object>())
       class_<Foo>("Foo")
           .def("get_x", &Foo::get_x)
           ;
   }

.. code-block:: python
   :caption: Python 側

   >>> from my_module import *
   >>> f = make_foo(3)     # Foo オブジェクトを作成
   >>> f.get_x()
   3
