boost/python/overloads.hpp
==========================

.. contents::
   :depth: 1
   :local:


.. _v2.overloads.introduction:

はじめに
--------

C++ の関数、メンバ関数および多重定義群から既定の引数とともに Python の関数および拡張クラスのメソッドの多重定義群を生成する機能を定義する。


.. _v2.overloads.overload-dispatch-expression:

:token:`!overload-dispatch-expression`
--------------------------------------

.. productionlist::
   overload-dispatch-expression: 'see-other-document'

:token:`!overload-dispatch-expression` は、拡張クラスのために生成するメソッドの多重定義群を記述するのに使用する。以下のプロパティを持つ。

docstring
   メソッドの :py:attr:`!__doc__` 属性に束縛される値を持つ :term:`ntbs`
keywords
   生成するメソッドの引数（の最後列）に名前を付ける :token:`keyword-expression`。
call policies
   :ref:`CallPolicies <concepts.callpolicies>` モデルの何らかの型。
minimum :term:`arity`
   生成するメソッド多重定義が受け付ける引数の最小数。
maximum :term:`arity`
   生成するメソッド多重定義が受け付ける引数の最大数。


.. _v2.overloads.OverloadDispatcher-concept:

OverloadDispatcher コンセプト
-----------------------------

OverloadDispatcher の :cpp:class:`!X` とは、minimum arity と maximum arity を持つクラスであり、以下がそれぞれ OverloadDispatcher と同じ最大・最小引数長を持つ合法な :token:`overload-dispatch-expression` である。 ::

   X()
   X(docstring)
   X(docstring, keywords)
   X(keywords, docstring)
   X()[policies]
   X(docstring)[policies]
   X(docstring, keywords)[policies]
   X(keywords, docstring)[policies]</programlisting>

* :cpp:var:`!policies` が与えられた場合、:ref:`CallPolicies <concepts.callpolicies>` モデルの型でなければならず、結果の呼び出しポリシーとなる。それ以外の場合、結果の呼び出しポリシーは :cpp:class:`default_call_policies` のインスタンスである。
* :cpp:var:`!docstring` が与えられた場合、:term:`ntbs` でなければならず、結果のドキュメンテーション文字列となる。それ以外の場合、結果のドキュメンテーション文字列は空である。
* keywords が与えられた場合、長さが :cpp:class:`!X` の最大引数長以下である :token:`keyword-expression` の結果でなければならず、結果のキーワード引数列となる。それ以外の場合、結果のキーワード引数列は空である。


.. _v2.overloads.macros:

マクロ
------

.. _v2.overloads.BOOST_PYTHON_FUNCTION_OVERLOADS-spec:

:c:macro:`!BOOST_PYTHON_FUNCTION_OVERLOADS(name, func_id, min_args, max_args)`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. c:macro:: BOOST_PYTHON_FUNCTION_OVERLOADS(name, func_id, min_args, max_args)

   現在のスコープで名前 :cpp:var:`!name` の OverloadDispatcher の定義へ展開する。これは以下の関数呼び出し生成に使用できる（``min_args <= i <= max_args``）。 ::

      func_id(a1, a2,...ai);


.. _v2.overloads.BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS-spec:

:c:macro:`!BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS(name, member_name, min_args, max_args)`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. c:macro:: BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS(name, member_name, min_args, max_args)

   現在のスコープで名前 :cpp:var:`!name` の OverloadDispatcher の定義へ展開する。これは以下の関数呼び出し生成に使用できる（``min_args <= i <= max_args``、:cpp:var:`!x` はクラス型オブジェクトへの参照）。 ::

      x.member_name(a1, a2,...ai);


.. _v2.overloads.examples:

例
--

::

   #include <boost/python/module.hpp>
   #include <boost/python/def.hpp>
   #include <boost/python/args.hpp>
   #include <boost/python/tuple.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/overloads.hpp>
   #include <boost/python/return_internal_reference.hpp>

   using namespace boost::python;

   tuple f(int x = 1, double y = 4.25, char const* z = "wow")
   {
       return make_tuple(x, y, z);
   }

   BOOST_PYTHON_FUNCTION_OVERLOADS(f_overloads, f, 0, 3)

   struct Y {};
   struct X
   {
       Y& f(int x, double y = 4.25, char const* z = "wow")
       {
           return inner;
       }
       Y inner;
   };

   BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS(f_member_overloads, f, 1, 3)

   BOOST_PYTHON_MODULE(args_ext)
   {
       def("f", f, 
           f_overloads(
               args("x", "y", "z"), "これは f のドキュメンテーション文字列"
           ));

    
       class_<Y>("Y")
           ;

       class_<X>("X", "これは X のドキュメンテーション文字列")
           .def("f1", &X::f, 
                   f_member_overloads(
                       args("x", "y", "z"), "f のドキュメンテーション文字列"
                   )[return_internal_reference<>()]
           )
           ;
   }
