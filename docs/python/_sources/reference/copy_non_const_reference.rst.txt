boost/python/copy_non_const_reference.hpp
=========================================

.. contents::
   :depth: 1
   :local:

.. _v2.copy_non_const_reference.classes:

クラス
------

.. _v2.copy_non_const_reference-spec:

:cpp:struct:`!copy_non_const_reference` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: copy_non_const_reference

   :cpp:struct:`!copy_non_const_reference` は、参照先の値を新しい Python オブジェクトにコピーする型への非 ``const`` 参照を返す C++ 関数をラップするのに使用する :ref:`ResultConverterGenerator <concepts.resultconverter.resultconvertergenerator_concept>` のモデルである。

   .. わかりにくい


.. cpp:namespace-push:: copy_non_const_reference


.. _v2.copy_non_const_reference.copy_non_const_reference-spec-synopsis:

:cpp:struct:`!copy_non_const_reference` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       struct copy_non_const_reference
       {
           template <class T> struct apply;
       };
   }}


.. _v2.copy_non_const_reference.copy_const_reference-spec-metafunctions:

:cpp:struct:`!copy_non_const_reference` クラスのメタ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:struct:: template <class T> apply

   :要件: 非 const な :cpp:type:`!U` に対して :cpp:type:`!T` が :cpp:type:`!U&`。

   .. cpp:type:: to_python_value<T> type


.. cpp:namespace-pop::


.. _v2.copy_non_const_reference.examples:

例
--

.. code-block::
   :caption: C++ のコード

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/copy_non_const_reference.hpp>
   #include <boost/python/return_value_policy.hpp>

   // ラップするクラス群
   struct Bar { int x; }

   struct Foo {
      Foo(int x) : { b.x = x; }
      Bar& get_bar() { return b; }
    private:
      Bar b;
   };

   // ラッパコード
   using namespace boost::python;
   BOOST_PYTHON_MODULE(my_module)
   {
       class_<Bar>("Bar");

       class_<Foo>("Foo", init<int>())
           .def("get_bar", &Foo::get_bar
               , return_value_policy<copy_non_const_reference>())
          ;
   }

.. code-block:: python
   :caption: Python のコード

   >>> from my_module import *
   >>> f = Foo(3)         # Foo オブジェクトを作成
   >>> b = f.get_bar()    # 内部的な Bar オブジェクトのコピーを作成
