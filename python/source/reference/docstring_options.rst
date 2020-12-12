boost/python/docstring_options.hpp
==================================

.. contents::
   :depth: 1
   :local:


.. _v2.docstring_options.introduction:

はじめに
--------

Boost.Python はユーザ定義ドキュメンテーション文字列をサポートし、自動的に C++ シグニチャを追加する。これらの機能は既定で有効である。:cpp:class:`!docstring_options` クラスはユーザ定義ドキュメンテーション文字列とシグニチャを選択的にまたは両方を抑止できる。


.. _v2.docstring_options.classes:

クラス
------

.. _v2.docstring_options.docstring_options-spec:

:cpp:class:`!docstring_options` クラス
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:class:: docstring_options : boost::noncopyable

   ラップした関数およびメンバ関数のドキュメンテーション文字列の可視性をインスタンスの寿命に対して制御する。予期しない副作用を防ぐため、インスタンスはコピー不可能である。


.. cpp:namespace-push:: docstring_options


.. _v2.docstring_options.docstring_options-spec-synopsis:

:cpp:class:`!docstring_options` クラスの概要
""""""""""""""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python {

       class docstring_options : boost::noncopyable
       {
         public:
             docstring_options(bool show_all=true);

             docstring_options(bool show_user_defined, bool show_signatures);

             docstring_options(bool show_user_defined, bool show_py_signatures, bool show_cpp_signatures);

             ~docstring_options();

             void
             disable_user_defined();

             void
             enable_user_defined();

             void
             disable_signatures();

             void
             enable_signatures();

             void
             disable_py_signatures();

             void
             enable_py_signatures();

             void
             disable_cpp_signatures();

             void
             enable_cpp_signatures();

             void
             disable_all();

             void
             enable_all();
       };

   }}


.. _v2.docstring_options.docstring_options-spec-ctors:

:cpp:class:`!docstring_options` クラスのコンストラクタ
""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: docstring_options(bool show_all = true)

   :効果: 後続のコードで定義する関数およびメンバ関数のドキュメンテーション文字列の可視性を制御する :cpp:class:`!docstring_options` オブジェクトを構築する。:cpp:var:`!show_all` が ``true`` の場合、ユーザ定義のドキュメンテーション文字列と自動的に生成された Python および C++ シグニチャの両方が表示される。:cpp:var:`!show_all` が ``false`` の場合、:py:attr:`!__doc__` 属性は :py:const:`!None` である。


.. cpp:function:: docstring_options(bool show_user_defined, bool show_signatures)

   :効果: 後続のコードで定義する関数およびメンバ関数のドキュメンテーション文字列の可視性を制御する :cpp:class:`!docstring_options` オブジェクトを構築する。:cpp:var:`!show_user_defined` が ``true`` の場合、ユーザ定義ドキュメンテーション文字列が表示される。:cpp:var:`!show_signatures` が ``true`` の場合、Python および C++ のシグニチャが自動的に追加される。:cpp:var:`!show_user_defined` および :cpp:var:`!show_signatures` の両方が ``false`` の場合、:py:attr:`!__doc__` 属性は :py:const:`!None` である。


.. cpp:function:: docstring_options(bool show_user_defined, bool show_py_signatures, bool show_cpp_signatures)

   :効果: 後続のコードで定義する関数およびメンバ関数のドキュメンテーション文字列の可視性を制御する :cpp:class:`!docstring_options` オブジェクトを構築する。:cpp:var:`!show_user_defined` が ``true`` の場合、ユーザ定義ドキュメンテーション文字列が表示される。:cpp:var:`!show_py_signatures` が ``true`` の場合、Python のシグニチャが自動的に追加される。:cpp:var:`!show_cpp_signatures` が ``true`` の場合、C++ のシグニチャが自動的に追加される。すべての引数が ``false`` の場合、:py:attr:`!__doc__` 属性は :py:const:`!None` である。


.. _v2.docstring_options.docstring_options-spec-dtors:

:cpp:class:`!docstring_options` デストラクタ
""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: ~docstring_options()

   :効果: ドキュメンテーション文字列のオプションを前の状態に復元する。特に :cpp:class:`!docstring_options` インスタンスが入れ子の C++ スコープ内にある場合は、そのスコープ内の設定が復元される。最後の :cpp:class:`!docstring_options` インスタンスがスコープから外れると、既定の「すべて ON」の設定が復元される。


.. _v2.docstring_options.docstring_options-spec-modifiers:

:cpp:class:`!docstring_options` クラスの変更関数
""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: void disable_user_defined()
                  void enable_user_defined()
                  void disable_signatures()
                  void enable_signatures()
                  void disable_py_signatures()
                  void enable_py_signatures()
                  void disable_cpp_signatures()
                  void enable_cpp_signatures()
                  void disable_all()
                  void enable_all()

   これらのメンバ関数は、後続のコードのドキュメンテーション文字列の可視性を動的に変更する。:cpp:func:`!*_user_defined()` および :cpp:func:`!*_signatures()` メンバ関数は細かい制御目的で提供されている。:cpp:func:`!*_all()` メンバ関数はすべての設定を同時に操作するための便利なショートカットである。


.. cpp:namespace-pop::


.. _v2.docstring_options.examples:

例
--

コンパイル時に定義したドキュメンテーション文字列のオプション
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   #include <boost/python/module.hpp>
   #include <boost/python/def.hpp>
   #include <boost/python/docstring_options.hpp>

   void foo() {}

   BOOST_PYTHON_MODULE(demo)
   {
       using namespace boost::python;
       docstring_options doc_options(DEMO_DOCSTRING_SHOW_ALL);
       def("foo", foo, "foo のドキュメント");
   }

:option:`!-DDEMO_DOCSTRING_SHOW_ALL=true` としてコンパイルすると次のようになる。

.. code-block:: python

   >>> import demo
   >>> print demo.foo.__doc__
   foo() -> None : foo のドキュメント
   C++ signature:
       foo(void) -> void

:option:`!-DDEMO_DOCSTRING_SHOW_ALL=false` としてコンパイルすると次のようになる。

.. code-block:: python

   >>> import demo
   >>> print demo.foo.__doc__
   None


選択的な抑止
~~~~~~~~~~~~

::

   #include <boost/python/module.hpp>
   #include <boost/python/def.hpp>
   #include <boost/python/args.hpp>
   #include <boost/python/docstring_options.hpp>

   int foo1(int i) { return i; }
   int foo2(long l) { return static_cast<int>(l); }
   int foo3(float f) { return static_cast<int>(f); }
   int foo4(double d) { return static_cast<int>(d); }

   BOOST_PYTHON_MODULE(demo)
   {
       using namespace boost::python;
       docstring_options doc_options;
       def("foo1", foo1, arg("i"), "foo1 のドキュメント");
       doc_options.disable_user_defined();
       def("foo2", foo2, arg("l"), "foo2 のドキュメント");
       doc_options.disable_signatures();
       def("foo3", foo3, arg("f"), "foo3 のドキュメント");
       doc_options.enable_user_defined();
       def("foo4", foo4, arg("d"), "foo4 のドキュメント");
       doc_options.enable_py_signatures();
       def("foo5", foo4, arg("d"), "foo5 のドキュメント");
       doc_options.disable_py_signatures();
       doc_options.enable_cpp_signatures();
       def("foo6", foo4, arg("d"), "foo6 のドキュメント");
   }

.. code-block:: python
   :caption: Python のコード

   >>> import demo
   >>> print demo.foo1.__doc__
   foo1( (int)i) -> int : foo1 のドキュメント
   C++ signature:
       foo1(int i) -> int
   >>> print demo.foo2.__doc__
   foo2( (int)l) -> int : 
   C++ signature:
       foo2(long l) -> int
   >>> print demo.foo3.__doc__
   None</computeroutput>
   >>> print demo.foo4.__doc__
   foo4 のドキュメント
   >>> print demo.foo5.__doc__
   foo5( (float)d) -> int : foo5 のドキュメント
   >>> print demo.foo6.__doc__
   foo6 のドキュメント
   C++ signature:
       foo6(double d) -> int


複数の C++ スコープからのラッピング
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   #include <boost/python/module.hpp>
   #include <boost/python/def.hpp>
   #include <boost/python/args.hpp>
   #include <boost/python/docstring_options.hpp>

   int foo1(int i) { return i; }
   int foo2(long l) { return static_cast<int>(l); }

   int bar1(int i) { return i; }
   int bar2(long l) { return static_cast<int>(l); }

   namespace {

       void wrap_foos()
       {
           using namespace boost::python;
           // docstring_options を使用していない
           //   -> 外側の C++ スコープの設定が適用される
           def("foo1", foo1, arg("i"), "foo1 のドキュメント");
           def("foo2", foo2, arg("l"), "foo2 のドキュメント");
       }

       void wrap_bars()
       {
           using namespace boost::python;
           bool show_user_defined = true;
           bool show_signatures = false;
           docstring_options doc_options(show_user_defined, show_signatures);
           def("bar1", bar1, arg("i"), "bar1 のドキュメント");
           def("bar2", bar2, arg("l"), "bar2 のドキュメント");
       }
   }

   BOOST_PYTHON_MODULE(demo)
   {
       boost::python::docstring_options doc_options(false);
       wrap_foos();
       wrap_bars();
   }

.. code-block:: python
   :caption: Python のコード

   >>> import demo
   >>> print demo.foo1.__doc__
   None
   >>> print demo.foo2.__doc__
   None
   >>> print demo.bar1.__doc__
   bar1 のドキュメント
   >>> print demo.bar2.__doc__
   bar2 のドキュメント

:file:`boost/libs/python/test/docstring.cpp` および :file:`docstring.py` も見よ。
