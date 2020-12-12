.. cpp:namespace:: boost::python::objects

boost/python/function_doc_signature.hpp
=======================================

.. contents::
   :depth: 1
   :local:

.. _v2.function_doc_signature.introduction:

はじめに
--------

Boost.Python は、Python と C++ シグニチャの自動的な連結を使ったドキュメンテーション文字列をサポートする。この機能は :cpp:class:`!function_doc_signature_generator` クラスが実装する。このクラスはユーザ定義のドキュメンテーション文字列の他に多重定義、与えられた引数の名前および既定値のすべてを使用して、与えられた関数のドキュメンテーション文字列を生成する。


.. _v2.function_doc_signature.classes:

クラス
------

.. _v2.function_doc_signature.function_doc_signature_generator-spec:

:cpp:class:`!function_doc_signature_generator` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:class:: function_doc_signature_generator

   このクラスは、1 つの関数の多重定義群に対するドキュメンテーション文字列のリストを返す公開関数を 1 つだけ持つ。


.. _v2.function_doc_signature.function_doc_signature_generator-spec-synopsis:

:cpp:class:`!function_doc_signature_generator` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace objects {

       class function_doc_signature_generator 
       {
         public:
             static list function_doc_signatures(function const *f);
       };

   }}}


.. _v2.function_doc_signature.examples:

例
--

.. code-block::
   :caption: :cpp:class:`!function_doc_signature_generator` で生成したドキュメンテーション文字列

   #include <boost/python/module.hpp>
   #include <boost/python/def.hpp>
   #include <boost/python/args.hpp>
   #include <boost/python/tuple.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/overloads.hpp>
   #include <boost/python/raw_function.hpp>

   using namespace boost::python;

   tuple f(int x = 1, double y = 4.25, char const* z = "wow")
   {
       return make_tuple(x, y, z);
   }

   BOOST_PYTHON_FUNCTION_OVERLOADS(f_overloads, f, 0, 3)


   struct X
   {
       tuple f(int x = 1, double y = 4.25, char const* z = "wow")
       {
           return make_tuple(x, y, z);
       }
   };

   BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS(X_f_overloads, X::f, 0, 3)

   tuple raw_func(tuple args, dict kw)
   {
       return make_tuple(args, kw);
   }

   BOOST_PYTHON_MODULE(args_ext)
   {
       def("f", f, (arg("x")=1, arg("y")=4.25, arg("z")="wow")
           , "これは f のドキュメンテーション文字列"
           );

       def("raw", raw_function(raw_func));

       def("f1", f, f_overloads("f1 のドキュメンテーション文字列", args("x", "y", "z")));


       class_<X>("X", "これは X のドキュメンテーション文字列", init<>(args("self")))
           .def("f", &X::f
                , "これは X.f のドキュメンテーション文字列"
                , args("self","x", "y", "z"))

           ;

   }

.. code-block:: python
   :caption: Python のコード

   >>> import args_ext
   >>> help(args_ext)
   Help on module args_ext:

   NAME
       args_ext

   FILE
       args_ext.pyd

   CLASSES
       Boost.Python.instance(__builtin__.object)
           X

       class X(Boost.Python.instance)
        |  これは X のドキュメンテーション文字列
        |
        |  Method resolution order:
        |      X
        |      Boost.Python.instance
        |      __builtin__.object
        |
        |  Methods defined here:
        |
        |  __init__(...)
        |      __init__( (object)self) -> None :
        |       C++ signature:
        |           void __init__(struct _object *)
        |
        |  f(...)
        |      f( (X)self, (int)x, (float)y, (str)z) -> tuple : これは X.f のドキュメンテーション文字列
        |      C++ signature:
        |          class boost::python::tuple f(struct X {lvalue},int,double,char const *)
        |
        |    .................
        |
   FUNCTIONS
       f(...)
           f([ (int)x=1 [, (float)y=4.25 [, (str)z='wow']]]) -> tuple : これは f のドキュメンテーション文字列
           C++ signature:
               class boost::python::tuple f([ int=1 [,double=4.25 [,char const *='wow']]])

       f1(...)
           f1([ (int)x [, (float)y [, (str)z]]]) -> tuple : f1 のドキュメンテーション文字列
           C++ signature:
               class boost::python::tuple f1([ int [,double [,char const *]]])

       raw(...)
           object raw(tuple args, dict kwds) :
           C++ signature:
               object raw(tuple args, dict kwds)
