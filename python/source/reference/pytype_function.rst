.. cpp:namespace:: boost::python::converter

boost/python/pytype_function.hpp
================================

.. contents::
   :depth: 1
   :local:

.. _v2.pytype_function.introduction:

はじめに
--------

Python のシグニチャをサポートするには、変換器は関連する :c:type:`!PyTypeObject` へのポインタを返す :cpp:func:`!get_pytype` 関数を提供しなければならない。例として :cpp:concept:`ResultConverter` か :cpp:class:`to_python_converter` を見るとよい。このヘッダファイルのクラスは :cpp:func:`!get_pytype` の実装に使用することを想定している。修飾無しの引数型とともに使用する :cpp:type:`!T` に対するテンプレートの ``_direct`` 版\ [#]_\もある（これらはモジュールを読み込んだときに変換レジストリ内にあると考えてしかるべきものである）。


.. _v2.pytype_function.classes:

クラス
------

.. _v2.pytype_function.wrap_pytype-spec:

:cpp:class:`!wrap_pytype` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:class:: template < PyTypeObject const *pytype > wrap_pytype

   このテンプレートは、テンプレート引数を返す静的メンバ :cpp:func:`!get_pytype` を生成する。


.. _v2.pytype_function.wrap_pytype-spec-synopsis:

:cpp:class:`!wrap_pytype` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace converter{

       template < PyTypeObject const *pytype >
       class wrap_pytype 
       {
         public:
             static PyTypeObject const *get_pytype(){return pytype; }
       };

   }}}


.. _v2.pytype_function.registered_pytype-spec:

:cpp:class:`!registered_pytype` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:class:: template < class T > registered_pytype

   このテンプレートは、:cpp:class:`class_` で Python へエクスポートする型（修飾子があってもよい）のテンプレート引数とともに使用すべきである。生成された静的メンバ :cpp:func:`!get_pytype` は対応する Python の型を返す。


.. _v2.pytype_function.registered_pytype-spec-synopsis:

:cpp:class:`!registered_pytype` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace converter{

       template < class T >
       class registered_pytype 
       {
         public:
             static PyTypeObject const *get_pytype();
       };

   }}}


.. _v2.pytype_function.expected_from_python_type-spec:

:cpp:class:`!expected_from_python_type` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:class:: template < class T > expected_from_python_type

   このテンプレートは、型 :cpp:type:`!T` について登録済みの ``from_python`` 変換器を問い合わせし合致した Python 型を返す静的メンバ :cpp:func:`!get_pytype` を生成する。


.. _v2.pytype_function.expected_from_python_type-spec-synopsis:

:cpp:class:`!expected_from_python_type` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace converter{

       template < class T >
       class expected_from_python_type 
       {
         public:
             static PyTypeObject const *get_pytype();
       };

   }}}


.. _v2.pytype_function.to_python_target_type-spec:

:cpp:class:`!to_python_target_type` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:class:: template < class T > to_python_target_type

   このテンプレートは、:cpp:type:`!T` から変換可能な Python の型を返す静的メンバ :cpp:func:`!get_pytype` を生成する。


.. _v2.pytype_function.to_python_target_type-spec-synopsis:

:cpp:class:`!to_python_target_type` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace converter{

       template < class T >
       class to_python_target_type 
       {
         public:
             static PyTypeObject const *get_pytype();
       };

   }}}


.. _v2.pytype_function.examples:

例
--

以下の例では、Python のドキュメントにある標準的な `noddy モジュール例 <http://docs.python.jp/2/extending/newtypes.html#dnt-basics>`_\を実装したとして、関連する宣言を :file:`noddy.h` に置いたものと仮定する。:c:type:`!noddy_NoddyObject` は極限なまでに単純な拡張型であるので、この例は少しばかりわざとらしい。すべての情報がその戻り値の型に含まれる関数をラップしている。

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/reference.hpp>
   #include <boost/python/module.hpp>
   #include "noddy.h"

   struct tag {};
   tag make_tag() { return tag(); }

   using namespace boost::python;

   struct tag_to_noddy 
   #if defined BOOST_PYTHON_SUPPORTS_PY_SIGNATURES // Python のシグニチャがサポートされない場合は不要なオーバーヘッドが発生
   : wrap_pytype<&noddy_NoddyType> // wrap_pytype から get_pytype を継承する
   #endif
   {
       static PyObject* convert(tag const& x)
       {
           return PyObject_New(noddy_NoddyObject, &noddy_NoddyType);
       }
   };

   BOOST_PYTHON_MODULE(to_python_converter)
   {
       def("make_tag", make_tag);
       to_python_converter<tag, tag_to_noddy
   #if defined BOOST_PYTHON_SUPPORTS_PY_SIGNATURES // Python のシグニチャがサポートされない場合は不正
             , true
   #endif
             >(); // tag_to_noddy がメンバ get_pytype を持つので「真」
   }

以下の例は、テンプレート :cpp:class:`!expected_from_python_type` および :cpp:class:`!to_python_target_type` を使用して Python との双方向変換器を登録している。 ::

   #include <boost/python/module.hpp>
   #include <boost/python/def.hpp>
   #include <boost/python/extract.hpp>
   #include <boost/python/to_python_converter.hpp>
   #include <boost/python/class.hpp>

   using namespace boost::python;

   struct A
   {
   };

   struct B
   {
     A a;
     B(const A& a_):a(a_){}
   };

   // A から Python の整数への変換器
   struct BToPython 
   #if defined BOOST_PYTHON_SUPPORTS_PY_SIGNATURES // Python のシグニチャがサポートされていない場合は不要なオーバーヘッドが発生
      : converter::to_python_target_type<A>  // get_pytype を継承する
   #endif
   {
     static PyObject* convert(const B& b)
     {
       return incref(object(b.a).ptr());
     }
   };

   // Python の整数から A への変換
   struct BFromPython
   {
     BFromPython()
     {
       boost::python::converter::registry::push_back
           ( &convertible
           , &construct
           , type_id< B >()
   #if defined BOOST_PYTHON_SUPPORTS_PY_SIGNATURES // Python のシグニチャがサポートされていない場合は不正
           , &converter::expected_from_python_type<A>::get_pytype// A へ変換可能なものは B へ変換可能
   #endif
           );
     }

     static void* convertible(PyObject* obj_ptr)
     {
         extract<const A&> ex(obj_ptr);
         if (!ex.check()) return 0;
         return obj_ptr;
     }

     static void construct(
         PyObject* obj_ptr,
         converter::rvalue_from_python_stage1_data* data)
     {
       void* storage = (
           (converter::rvalue_from_python_storage< B >*)data)-> storage.bytes;

       extract<const A&> ex(obj_ptr);
       new (storage) B(ex());
       data->convertible = storage;
     }
   };


   B func(const B& b) { return b ; }

   BOOST_PYTHON_MODULE(pytype_function_ext)
   {
     to_python_converter< B , BtoPython
   #if defined BOOST_PYTHON_SUPPORTS_PY_SIGNATURES // Python のシグニチャがサポートされていない場合は不正
                ,true 
   #endif
                >(); // get_pytype を持つ
     BFromPython();

     class_<A>("A") ;

     def("func", &func);

   }

   >>> from pytype_function_ext import *
   >>> print func.__doc__
   func( (A)arg1) -> A :
       C++ signature:
            struct B func(struct B)


.. [#] 訳注　:cpp:class:`!expected_from_python_type_direct` 、:cpp:class:`!registered_pytype_direct` 、:cpp:class:`!to_python_target_type_direct` の 3 つ。
