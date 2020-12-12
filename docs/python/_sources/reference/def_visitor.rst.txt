boost/python/def_visitor.hpp
============================

.. contents::
   :depth: 1
   :local:


.. _v2.def_visitor.introduction:

はじめに
--------

:file:`<boost/python/def_visitor.hpp>` は、:cpp:class:`class_` インターフェイスを分散させないよう :cpp:class:`class_` の :cpp:func:`~class_::def` メンバの機能を非侵入的に拡張する汎用的な訪問インターフェイスを提供する。:cpp:class:`!def_visitor<>` クラステンプレートを宣言する。テンプレート引数は、その :cpp:func:`~def_visitor::visit` メンバ関数を介して実際の :cpp:func:`!def` 機能を提供する派生型 :cpp:type:`!DerivedVisitor` である。


.. _v2.def_visitor.classes:

クラス
------

.. _v2.def_visitor.def_visitor-spec:

:cpp:class:`!def_visitor<DerivedVisitor>` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:class:: template<class DerivedVisitor> def_visitor

   :cpp:class:`!def_visitor` クラスは、その派生クラスを引数にとる（基底）クラスである。:cpp:class:`!def_visitor` はプロトコルクラスであり、派生クラスである :cpp:type:`!DerivedVisitor` はメンバ関数 :cpp:func:`!visit` を持たなければならない。:cpp:class:`!def_visitor` クラスが直接インスタンス化されることはなく、代わりに派生クラス :cpp:type:`!DerivedVisitor` のインスタンスが :cpp:class:`class_` の :cpp:func:`~class_::def` メンバ関数の引数として渡される。


.. _v2.def_visitor.def_visitor-synopsis:

:cpp:class:`!def_visitor` クラスの概要
""""""""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python {

       template <class DerivedVisitor>
       class def_visitor {};
   }


.. _v2.def_visitor.def_visitor-requirements:

:cpp:class:`!def_visitor` の要件
""""""""""""""""""""""""""""""""

クライアントが与える :cpp:type:`!DerivedVisitor` テンプレート引数は、

* :cpp:class:`!def_visitor` から非公開派生していなければならない
* :cpp:class:`!def_visitor_access` クラスへのフレンドアクセスを認めなければらない
* 下表に挙げる :cpp:func:`!visit` メンバ関数のいずれかあるいは両方を定義しなければらない

  .. list-table::
     :header-rows: 1

     * - 式
       - 戻り値の型
       - 要件
       - 効果
     * - :cpp:expr:`visitor.visit(cls)`
       - :cpp:type:`!void`
       - :cpp:var:`!cls` は Python へラップする :cpp:class:`class_` のインスタンス。:cpp:var:`!visitor` は :cpp:class:`!def_visitor` の派生クラス。
       - :cpp:expr:`cls.def(visitor)` の呼び出しがこのメンバ関数へ転送される。
     * - :cpp:expr:`visitor.visit(cls, name, options)`
       - :cpp:type:`!void`
       - :cpp:var:`!cls` は :cpp:class:`!class_` のインスタンス、:cpp:var:`!name` は C 文字列。:cpp:var:`!visitor` は :cpp:class:`!def_visitor` の派生クラス。:cpp:var:`!options` は文脈固有のオプション引数。
       - :cpp:expr:`cls.def(name, visitor)` または :cpp:expr:`cls.def(name, visitor, options)` の呼び出しがこのメンバ関数へ転送される。


.. _v2.def_visitor.examples:

例
--

::

   class X {/*...*/};

   class my_def_visitor : boost::python::def_visitor<my_def_visitor>
   {
       friend class def_visitor_access;

       template <class classT>
       void visit(classT& c) const
       {
           c
               .def("foo", &my_def_visitor::foo)
               .def("bar", &my_def_visitor::bar)
           ;
       }

       static void foo(X& self);
       static void bar(X& self);
   };

   BOOST_PYTHON_MODULE(my_ext)
   { 
       class_<X>("X")
           .def(my_def_visitor())
       ;
   }
