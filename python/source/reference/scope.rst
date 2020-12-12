boost/python/scope.hpp
======================

.. contents::
   :depth: 1
   :local:


.. _v2.scope.introduction:

はじめに
--------

Python のスコープ（名前空間）を問い合わせたり制御する機能を定義する。このスコープには新しくラップするクラスや関数を追加できる。


.. _v2.scope.classes:

クラス
------

.. _v2.scope.scope-spec:

:cpp:class:`!scope` クラス
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:class:: scope : public object

   :cpp:class:`!scope` クラスは、新しい拡張クラスおよびラップした関数がその属性として定義される Python の名前空間を制御する（自分自身に対応した）グローバルな Python オブジェクトを持つ。新しい :cpp:class:`!scope` オブジェクトをデフォルトコンストラクタで構築すると、そのオブジェクトは対応するグローバルな Python のオブジェクトに束縛される。:cpp:class:`!scope` オブジェクトを引数付きで構築すると、対応するグローバルな Python のオブジェクトを引数が保持するオブジェクトへ変更する。これはこの :cpp:class:`!scope` オブジェクトの寿命が終わるまで続き、その時点で対応するグローバルな Python オブジェクトは :cpp:class:`!scope` オブジェクトを構築する前の状態に復元する。


.. cpp:namespace-push:: scope


.. _v2.scope.scope-spec-synopsis:

:cpp:class:`!scope` クラスの概要
""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python
   {
     class scope : public object
     {
      public:
         scope(scope const&);
         scope(object const&);
         scope();
         ~scope()
      private:
         void operator=(scope const&);
     };
   }}


.. _v2.scope.scope-spec-ctors:

:cpp:class:`!scope` クラスのコンストラクタおよびデストラクタ
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: explicit scope(scope const& x)
                  explicit scope(object const& x)

   現在のスコープ相当オブジェクトへの参照を格納し、スコープ相当オブジェクトに :cpp:expr:`x.ptr()` が参照するオブジェクトを設定する。:cpp:class:`!object` 基底クラスを :cpp:var:`!x` で初期化する。


.. cpp:function:: scope()

   現在のスコープ相当オブジェクトへの参照を格納する。:cpp:class:`!object` 基底クラスを現在のスコープ相当オブジェクトで初期化する。モジュール初期化関数の外部では、現在の相当 Python オブジェクトは :py:const:`!None` である。


.. cpp:function:: ~scope()

   現在の相当 Python オブジェクトを格納したオブジェクトに設定する。


.. cpp:namespace-pop::


.. _v2.scope.examples:

例
--

以下の例は、スコープの設定を使用して入れ子クラスを定義する方法を示している。

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/scope.hpp>
   using namespace boost::python;

   struct X
   {
     void f() {}

     struct Y { int g() { return 42; } };
   };

   BOOST_PYTHON_MODULE(nested)
   {
      // 現在の（モジュールの）スコープにいくつか定数を追加する
      scope().attr("yes") = 1;
      scope().attr("no") = 0;

      // 現在のスコープを変更する
      scope outer
          = class_<X>("X")
               .def("f", &X::f)
               ;

      // 現在のスコープ X でクラス Y を定義する
      class_<X::Y>("Y")
         .def("g", &X::Y::g)
         ;
   }

.. code-block:: python
   :caption: Python の対話例

   >>> import nested
   >>> nested.yes
   1
   >>> y = nested.X.Y()
   >>> y.g()
   42
