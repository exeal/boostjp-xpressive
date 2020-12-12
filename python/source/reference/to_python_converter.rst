boost/python/to_python_converter.hpp
====================================

.. contents::
   :depth: 1
   :local:


.. _v2.to_python_converter.introduction:

はじめに
--------

:cpp:struct:`!to_python_converter` は与えられた C++ 型のオブジェクトから Python オブジェクトへの変換を登録する。

.. _v2.to_python_converter.classes:

クラス
------

.. _v2.to_python_converter.to_python_converter-spec:

:cpp:struct:`!to_python_converter` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class T, class Conversion, bool convertion_has_get_pytype_member=false> \
                to_python_converter

   :cpp:struct:`!to_python_converter` は、第 2 テンプレート引数の静的メンバ関数に対するラッパを追加し、変換器のレジストリへの挿入といった低水準の詳細を処理する。

   以下の説明において :cpp:var:`!x` は :cpp:type:`!T` 型のオブジェクト。

   :tparam T:
      変換元オブジェクトの C++ 型。

   :tparam Conversion:
      実際の変換を行う :cpp:func:`!convert` 静的メンバ関数を持つクラス型。

      :要件: :cpp:expr:`p == 0` かつ `PyErr_Occurred <http://docs.python.jp/2/c-api/exceptions.html#PyErr_Occurred>`_\ :code:`() != 0` の場合、:cpp:expr:`PyObject* p = Conversion::convert(x)`

   :tparam bool has_get_pytype = false:
      **省略可能なメンバ。**\ :cpp:type:`!Conversion` が :cpp:func:`!get_pytype` を持つ場合、この引数に対して ``true`` を与えなければならない。この引数が与えられた場合、:cpp:func:`!get_pytype` はこの変換を使用する関数の戻り値の型に対してドキュメントを生成するために使用される。:cpp:func:`!get_pytype` は :doc:`pytype_function.hpp <pytype_function>` のクラスと関数を使用して実装してもよい。

      .. note::
         後方互換性のため、この引数を渡す前に :c:macro:`BOOST_PYTHON_SUPPORTS_PY_SIGNATURES` が定義されているチェックするとよい（:ref:`ここ <v2.pytype_function.examples>`\を見よ）。

      :要件: :code:`PyTypeObject const * p = Conversion::get_pytype()`


.. cpp:namespace-push:: to_python_converter


.. _v2.to_python_converter.to_python_converter-spec-synopsis:

:cpp:struct:`!to_python_converter` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     template <class T, class Conversion, bool convertion_has_get_pytype_member=false>
     struct to_python_converter
     {
         to_python_converter();
     };
   }}


.. _v2.to_python_converter.to_python_converter-spec-ctors:

:cpp:struct:`!to_python_converter` クラステンプレートのコンストラクタ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: to_python_converter()

   :効果: :cpp:func:`!Conversion::convert()` を実際の動作として使用する ``to_python`` 変換器を登録する。


.. cpp:namespace-pop::


.. _v2.to_python_converter.examples:

例
--

以下の例では、Python のドキュメントにある標準的な `noddy モジュール例 <http://docs.python.jp/2/extending/newtypes.html#dnt-basics>`_\を実装したとして、関連する宣言を :file:`noddy.h` に置いたものと仮定する。:cpp:type:`!noddy_NoddyObject` は極限なまでに単純な拡張型であるので、この例は少しばかりわざとらしい。すべての情報がその戻り値の型に含まれる関数をラップしている。

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/reference.hpp>
   #include <boost/python/module.hpp>
   #include "noddy.h"

   struct tag {};
   tag make_tag() { return tag(); }

   using namespace boost::python;

   struct tag_to_noddy
   {
       static PyObject* convert(tag const& x)
       {
           return PyObject_New(noddy_NoddyObject, &noddy_NoddyType);
       }
       static PyTypeObject const* get_pytype()
       {
           return &noddy_NoddyType;
       }
   };

   BOOST_PYTHON_MODULE(to_python_converter)
   {
       def("make_tag", make_tag);
       to_python_converter<tag, tag_to_noddy, true>(); // tag_to_noddy がメンバ get_pytype を持つので「true」
   }

.. code-block:: python
   :caption: Python のコード

   >>> import to_python_converter
   >>> def always_none():
   ...     return None
   ...
   >>> def choose_function(x):
   ...     if (x % 2 != 0):
   ...         return to_python_converter.make_tag
   ...     else:
   ...         return always_none
   ...
   >>> a = [ choose_function(x) for x in range(5) ]
   >>> b = [ f() for f in a ]
   >>> type(b[0])
   <type 'NoneType'>
   >>> type(b[1])
   <type 'Noddy'>
   >>> type(b[2])
   <type 'NoneType'>
   >>> type(b[3])
   <type 'Noddy'>
