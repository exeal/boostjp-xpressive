boost/python/return_value_policy.hpp
====================================

.. contents::
   :depth: 1
   :local:


.. _v2.return_value_policy.introduction:

はじめに
--------

:cpp:struct:`!return_value_policy` のインスタンスは、単純に :ref:`ResultConverterGenerator <concepts.resultconverter.resultconvertergenerator_concept>` と省略可能な :cpp:type:`!Base` :ref:`CallPolicies <concepts.callpolicies>` を合成した :ref:`CallPolicies <concepts.callpolicies>` モデルである。


.. _v2.return_value_policy.classes:

クラス
------

.. _v2.return_value_policy.return_value_policy-spec:

:cpp:struct:`!return_value_policy` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class ResultConverterGenerator, class Base = default_call_policies> \
                return_value_policy : Base

   :tparam ResultConverterGenerator:
      :要件: :ref:`ResultConverterGenerator <concepts.resultconverter.resultconvertergenerator_concept>` のモデル
   :tparam Base:
      :要件: :ref:`CallPolicies <concepts.callpolicies>` のモデル
      :既定: :cpp:struct:`default_call_policies`


.. _v2.return_value_policy.return_value_policy-spec-synopsis:

:cpp:struct:`!return_value_policy` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     template <class ResultConverterGenerator, class Base = default_call_policies>
     struct return_value_policy : Base
     {
         typedef ResultConverterGenerator result_converter;
     };
   }}


.. _v2.return_value_policy.examples:

例
--

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/copy_const_reference.hpp>
   #include <boost/python/return_value_policy.hpp>

   // ラップするクラス群
   struct Bar { int x; }

   struct Foo {
      Foo(int x) : { b.x = x; }
      Bar const& get_bar() const { return b; }
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
             , return_value_policy<copy_const_reference>())
         ;
   }

.. code-block:: python
   :caption: Python のコード

   >>> from my_module import *
   >>> f = Foo(3)         # Foo オブジェクトを作成
   >>> b = f.get_bar()    # 内部的な Bar オブジェクトのコピーを作成
