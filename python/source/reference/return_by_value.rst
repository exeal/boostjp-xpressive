boost/python/return_by_value.hpp
================================

.. contents::
   :depth: 1
   :local:


.. _v2.return_by_value.classes:

クラス
------

.. _v2.return_by_value-spec:

:cpp:struct:`!return_by_value` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: return_by_value

   :cpp:struct:`!return_by_value` は、戻り値が新しいPythonオブジェクトへコピーされる参照型か値型を返すC++関数をラップするのに使用する :ref:`ResultConverterGenerator <concepts.resultconverter.resultconvertergenerator_concept>` のモデルである。


.. cpp:namespace-push:: return_by_value


.. _v2.return_by_value.return_by_value-spec-synopsis:

:cpp:struct:`!return_by_value` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       struct return_by_value
       {
           template <class T> struct apply;
       };
   }}


.. _v2.return_by_value.return_by_value-spec-metafunctions:

:cpp:struct:`!return_by_value` クラスのメタ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:struct:: template <class T> apply

   .. cpp:type:: to_python_value<T> type


.. cpp:namespace-pop::


.. _v2.return_by_value.examples:

例
--

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/return_by_value.hpp>
   #include <boost/python/return_value_policy.hpp>

   // ラップするクラス群
   struct Bar { };

   Bar global_bar;

   // ラップする関数群：
   Bar b1();
   Bar& b2();
   Bar const& b3();

   // ラッパコード
   using namespace boost::python;
   template <class R>
   void def_void_function(char const* name, R (*f)())
   {
      def(name, f, return_value_policy<return_by_value>());
   }

   BOOST_PYTHON_MODULE(my_module)
   {
       class_<Bar>("Bar");
       def_void_function("b1", b1);
       def_void_function("b2", b2);
       def_void_function("b3", b3);
   }

.. code-block:: python
   :caption: Python 側

   >>> from my_module import *
   >>> b = b1() # これらの呼び出しは
   >>> b = b2() # それぞれ新しい Bar オブジェクトを
   >>> b = b3() # 個別に作成する
