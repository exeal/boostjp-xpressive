boost/python/has_back_reference.hpp
===================================

.. contents::
   :depth: 1
   :local:


.. _v2.has_back_reference.introduction:

はじめに
--------

:file:`<boost/python/has_back_reference.hpp>` は、述語メタ関数 :cpp:class:`!has_back_reference<>` を定義する。ユーザはこれを特殊化して、ラップするクラスのインスタンスが Python オブジェクトに対応する :c:type:`!PyObject*` を保持することを指定できる。


.. _v2.has_back_reference.classes:

クラス
------

.. _v2.has_back_reference.has_back_reference-spec:

:cpp:class:`!has_back_reference` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:class:: template<class WrappedClass> has_back_reference

   引数が :cpp:class:`!pointer_wrapper<>` である場合に :cpp:member:`!value` が真である単項メタ関数である。


.. _v2.has_back_reference.has_back_reference-spec-synopsis:

:cpp:class:`!has_back_reference` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       template<class WrappedClass> class has_back_reference
       { 
           typedef mpl::false_ type;
       };
   }}

ラップするクラスをどうように構築するか決定するため、Boost.Pythonがアクセスする「\ `メタ関数 <http://www.boost.org/libs/mpl/doc/refmanual/metafunction.html>`_\」。

:cpp:member:`!type::value` は未規定型の論理値へ変換可能な整数定数である。:cpp:expr:`class_<WrappedClass>::def(init<type_sequence...>())` および暗黙のラップされたコピーコンストラクタ（\ :ref:`noncopyable <v2.class.class_-spec>` でない限り）の各呼び出しについて、対応するコンストラクタ :cpp:expr:`WrappedClass::WrappedClass(PyObject*, type_sequence...)` が存在する場合、``true`` の値を持つ :cpp:type:`!type` の整数定数が特殊化により置換される可能性がある。そのような特殊化が存在する場合、:cpp:type:`!WrappedClass` のコンストラクタが Python から呼び出されるときは常に対応する Python オブジェクトへの「逆参照」ポインタが使用される。:cpp:class:`!mpl::true_` から特殊化を導出するのが、この入れ子の :cpp:type:`!type` を提供する最も簡単な方法である。


.. _v2.has_back_reference.examples:

例
--

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/class.hpp>
   #include <boost/python/module.hpp>
   #include <boost/python/has_back_reference.hpp>
   #include <boost/python/handle.hpp>
   #include <boost/shared_ptr.hpp>

   using namespace boost::python;
   using boost::shared_ptr;

   struct X
   {
       X(PyObject* self) : m_self(self), m_x(0) {}
       X(PyObject* self, int x) : m_self(self), m_x(x) {}
       X(PyObject* self, X const& other) : m_self(self), m_x(other.m_x) {}
    
       handle<> self() { return handle<>(borrowed(m_self)); }
       int get() { return m_x; }
       void set(int x) { m_x = x; }

       PyObject* m_self;
       int m_x;
   };

   // X について has_back_reference を特殊化
   namespace boost { namespace python
   {
     template <>
     struct has_back_reference<X>
       : mpl::true_
     {};
   }}

   struct Y
   {
       Y() : m_x(0) {}
       Y(int x) : m_x(x) {}
       int get() { return m_x; }
       void set(int x) { m_x = x; }

       int m_x;
   };

   shared_ptr<Y> 
   Y_self(shared_ptr<Y> self) { return self; }

   BOOST_PYTHON_MODULE(back_references)
   {
       class_<X>("X")
          .def(init<int>())
          .def("self", &X::self)
          .def("get", &X::get)
          .def("set", &X::set)
          ;

       class_<Y, shared_ptr<Y> >("Y")
          .def(init<int>())
          .def("get", &Y::get)
          .def("set", &Y::set)
          .def("self", Y_self)
          ;
   }

以下の Python セッションでは、:code:`x.self()` が何度呼び出しても毎回同じ Python オブジェクトを返すいっぽうで、:code:`y.self()` は同じ :cpp:struct:`!Y` インスタンスを参照する新しい Python オブジェクトを作成する。

.. code-block:: python
   :caption: Python のコード

   >>> from back_references import *
   >>> x = X(1)
   >>> x2 = x.self()
   >>> x2 is x
   1
   >>> (x.get(), x2.get())
   (1, 1)
   >>> x.set(10)
   >>> (x.get(), x2.get())
   (10, 10)
   >>> 
   >>> 
   >>> y = Y(2)
   >>> y2 = y.self()
   >>> y2 is y
   0
   >>> (y.get(), y2.get())
   (2, 2)
   >>> y.set(20)
   >>> (y.get(), y2.get())
   (20, 20)
