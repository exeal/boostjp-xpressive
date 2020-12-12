boost/python/return_internal_reference.hpp
==========================================

.. contents::
   :depth: 1
   :local:

.. _v2.return_internal_reference.introduction:

はじめに
--------

:cpp:struct:`!return_internal_reference` のインスタンスは、自由関数かメンバ関数の引数またはメンバ関数の対象が内部的に保持するオブジェクトへのポインタおよび参照を参照先のコピーを作成することなく安全に返すことを可能とする :ref:`CallPolicies <concepts.callpolicies>` モデルである。第 1 テンプレート引数の既定値は、内包するオブジェクトがラップするメンバ関数の対象（:cpp:expr:`*this`）となるよくある場合を処理する。


.. _v2.return_internal_reference.classes:

クラス
------

.. _v2.return_internal_reference.return_internal_reference-spec:

:cpp:struct:`!return_internal_reference` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <std::size_t owner_arg = 1, class Base = default_call_policies> \
                return_internal_reference : Base

   :tparam owner_arg:
      返す参照かポインタ先のオブジェクトを含む引数の添字。ラップするのがメンバ関数の場合、引数 1 は対象オブジェクト（:cpp:expr:`*this`）である。\ [#]_

      対象の Python オブジェクト型が弱い参照をサポートしない場合、ラップする関数を呼び出すと Python の :py:exc:`!TypeError` 例外を送出する。

      :要件: :cpp:type:`!std::size_t` 型の正のコンパイル時定数。
      :既定: 1

   :tparam Base:
      ポリシーの合成に使用。提供する :cpp:class:`!result_converter` は :cpp:struct:`!return_internal_reference` によりオーバーライドされるが、その :cpp:func:`!precall` および :cpp:func:`!postcall` ポリシーは :cpp:concept:`CallPolicies` の項に示すとおり合成される。

      :要件: :ref:`CallPolicies <concepts.callpolicies>` のモデルである
      :既定: :cpp:struct:`!default_call_policies`


.. cpp:namespace-push:: return_internal_reference


.. _v2.return_internal_reference.return_internal_reference-spec-synopsis:

:cpp:struct:`!return_internal_reference` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      template <std::size_t owner_arg = 1, class Base = default_call_policies>
      struct return_internal_reference : Base
      {
         static PyObject* postcall(PyObject*, PyObject* result);
         typedef reference_existing_object result_converter;
      };
   }}


.. _v2.return_internal_reference.return_internal_reference-spec-statics:

:cpp:struct:`!return_internal_reference` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: PyObject* postcall(PyObject* args, PyObject* result)

   :要件: `PyTuple_Check <http://docs.python.jp/2/c-api/tuple.html#PyTuple_Check>`_\ :cpp:expr:`(args) != 0`
   :returns: :cpp:expr:`with_custodian_and_ward_postcall::postcall(args, result)`


.. cpp:namespace-pop::


.. _v2.return_internal_reference.examples:

例
--

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/return_internal_reference.hpp>

   class Bar
   {
    public:
      Bar(int x) : x(x) {}
      int get_x() const { return x; }
      void set_x(int x) { this->x = x; }
    private:
      int x;
   };

   class Foo
   {
    public:
      Foo(int x) : b(x) {}

      // 内部的な参照を返す
      Bar const& get_bar() const { return b; }

    private:
      Bar b;
   };

   using namespace boost::python;
   BOOST_PYTHON_MODULE(internal_refs)
   {
      class_<Bar>("Bar", init<int>())
         .def("get_x", &Bar::get_x)
         .def("set_x", &Bar::set_x)
         ;

      class_<Foo>("Foo", init<int>())
         .def("get_bar", &Foo::get_bar
             , return_internal_reference<>())
         ;
   }

.. code-block:: python
   :caption: Python のコード

   >>> from internal_refs import *
   >>> f = Foo(3)
   >>> b1 = f.get_bar()
   >>> b2 = f.get_bar()
   >>> b1.get_x()
   3
   >>> b2.get_x()
   3
   >>> b1.set_x(42)
   >>> b2.get_x()
   42


.. [#] 訳注　:cpp:var:`!owner_arg` テンプレート引数に 0 や引数列の範囲を超える値を指定することはできません。
