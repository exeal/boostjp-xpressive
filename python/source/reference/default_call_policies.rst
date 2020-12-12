boost/python/default_call_policies.hpp
======================================

.. contents::
   :depth: 1
   :local:


.. _v2.default_call_policies.classes:

クラス
------

.. _v2.default_call_policies.default_call_policies-spec:

:cpp:struct:`!default_call_policies` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: default_call_policies

   :cpp:struct:`!default_call_policies` は :cpp:func:`!precall` および :cpp:func:`!postcall` の振る舞いを持たない :cpp:concept:`CallPolicies` のモデルであり、値返しを行う :cpp:class:`!result_converter` である。ラップする C++ の関数およびメンバ関数は、特に指定しなければ :cpp:struct:`!default_call_policies` を使用する。新規の :cpp:concept:`CallPolicies` は :cpp:struct:`!default_call_policies` から派生すると便利である。


.. cpp:namespace-push:: default_call_policies


.. _v2.default_call_policies.default_call_policies-spec-synopsis:

:cpp:struct:`!default_call_policies` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       struct default_call_policies
       {
           static bool precall(PyObject*);
           static PyObject* postcall(PyObject*, PyObject* result);
           typedef default_result_converter result_converter;
           template <class Sig> struct extract_return_type : mpl::front<Sig>{};
       };
   }}


.. _v2.default_call_policies.default_call_policies-spec-statics:

:cpp:struct:`!default_call_policies` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: bool precall(PyObject*)

   :returns: ``true``
   :例外: なし

.. cpp:function:: PyObject* postcall(PyObject*, PyObject* result)

   :returns: :cpp:var:`!result`
   :例外: なし


.. cpp:namespace-pop::


.. _v2.default_call_policies.default_result_converter-spec:

:cpp:struct:`!default_result_converter` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: default_result_converter

   .. cpp:struct:`!default_result_converter` は、非ポインタ型、:cpp:type:`!char const*` または :c:type:`!PyObject*` を値で返す C++ 関数をラップするのに使用する :cpp:concept:`!ResultConverterGenerator` モデルである。


.. cpp:namespace-push:: default_result_converter


.. _v2.default_call_policies.default_result_converter-spec-synopsis:

:cpp:struct:`!default_result_converter` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       struct default_result_converter
       {
           template <class T> struct apply;
       };
   }}


.. _v2.default_call_policies.default_result_converter-spec-metafunctions:

:cpp:struct:`!default_result_converter` クラスのメタ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:struct:: template <class T> apply

   :要件: :cpp:type:`!T` が参照型でない。:cpp:type:`!T` がポインタ型の場合、:cpp:type:`!T` は :cpp:type:`!const char*` か :c:type:`!PyObject*`。

   .. cpp:type:: to_python_value<T const&> type


.. cpp:namespace-pop::


.. _v2.default_call_policies.examples:

例
--

この例は Boost.Python の実装そのものからとった。:cpp:class:`return_value_policy` クラステンプレートは :cpp:func:`!precall` および :cpp:func:`!postcall` に対する振る舞いの実装を持たないので、その基底クラスは :cpp:struct:`!default_call_policies` となっている。 ::

   template <class Handler, class Base = default_call_policies>
   struct return_value_policy : Base
   {
      typedef Handler result_converter;
   };
