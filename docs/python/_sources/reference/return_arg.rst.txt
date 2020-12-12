boost/python/return_arg.hpp
===========================

.. contents::
   :depth: 1
   :local:


.. _v2.return_arg.introduction:

はじめに
--------

:cpp:struct:`!return_arg` および :cpp:struct:`!return_self` のインスタンスは、ラップする（メンバ）関数の指定した引数（大抵は :cpp:expr:`*this`）を返す :ref:`CallPolicies <concepts.callpolicies>` モデルである。


.. _v2.return_arg.classes:

クラス
------

.. _v2.return_arg.return_arg-spec:

:cpp:struct:`!return_arg` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <size_t arg_pos=1, class Base = default_call_policies> \
                return_arg : Base

   :tparam arg_pos:
      返す引数の位置。\ [#]_

      :要件: :cpp:type:`!std::size_t` 型の正のコンパイル時定数。

   :tparam Base:
      ポリシーの合成に使用。提供する :cpp:class:`!result_converter` は :cpp:struct:`!return_arg` によりオーバーライドされるが、その :cpp:func:`!precall` および :cpp:func:`!postcall` ポリシーは :ref:`CallPolicies <concepts.callpolicies>` の項に示すとおり合成される。

      :要件: :ref:`CallPolicies <concepts.callpolicies>` のモデル
      :既定: :cpp:struct:`default_call_policies`


.. cpp:namespace-push:: return_arg


.. _v2.return_arg.return_arg-spec-synopsis:

:cpp:struct:`!return_arg` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      template <size_t arg_pos=1, class Base = default_call_policies>
      struct return_arg : Base
      {
         static PyObject* postcall(PyObject*, PyObject* result);
         struct result_converter{ template <class T> struct apply; };
         template <class Sig> struct extract_return_type : mpl::at_c<Sig, arg_pos>{};

      };
   }}


.. _v2.return_arg.return_arg-spec-statics:

:cpp:struct:`!return_arg` クラステンプレートの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: PyObject* postcall(PyObject* args, PyObject* result)

   :要件: `PyTuple_Check <http://docs.python.jp/2/c-api/tuple.html#PyTuple_Check>`_\ :cpp:expr:`(args) != 0` かつ :cpp:expr:`PyTuple_Size(args) != 0`
   :returns: :cpp:expr:`PyTuple_GetItem(args,arg_pos-1)`


.. cpp:namespace-pop::


.. _v2.return_arg.return_self-spec:

:cpp:struct:`!return_self` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class Base = default_call_policies> \
                return_self : return_arg<1,Base>


.. _v2.return_arg.return_self-spec-synopsis:

:cpp:struct:`!return_self` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      template <class Base = default_call_policies>
      struct return_self 
        : return_arg<1,Base>
      {};
   }}


.. _v2.return_arg.examples:

例
--

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/return_arg.hpp>

   struct Widget
   {
      Widget() :sensitive_(true){}
      bool get_sensitive() const { return sensitive_; }
      void set_sensitive(bool s) { this->sensitive_ = s; }
    private:
      bool sensitive_;
   };

   struct Label : Widget
   {
      Label() {}

      std::string  get_label() const { return label_; }
      void set_label(const std::string &l){ label_ = l; }

    private:
      std::string label_;
   };

   using namespace boost::python;
   BOOST_PYTHON_MODULE(return_self_ext)
   {
      class_<widget>("Widget")
         .def("sensitive", &Widget::get_sensitive)
         .def("sensitive", &Widget::set_sensitive, return_self<>())
         ;

      class_<Label, bases<Widget> >("Label")
         .def("label", &Label::get_label)
         .def("label", &Label::set_label, return_self<>())
         ;
   }

.. code-block:: python
   :caption: Python のコード

   >>> from return_self_ext import *
   >>> l1 = Label().label("foo").sensitive(false)
   >>> l2 = Label().sensitive(false).label("foo")


.. [#] 訳注　:cpp:var:`!arg_pos` テンプレート引数に 0 を指定することはできません。
