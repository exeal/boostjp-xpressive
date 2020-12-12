boost/python/module.hpp
=======================

.. contents::
   :depth: 1
   :local:


.. _v2.module.introduction:

はじめに
--------

このヘッダは、Boost.Python 拡張モジュールを作成するのに必要な基本的な機能を提供する。


.. _v2.module.macros:

マクロ
------

.. c:macro:: BOOST_PYTHON_MODULE(name)

   :c:macro:`!BOOST_PYTHON_MODULE(name)` は Python の\ `モジュール初期化関数 <http://www.python.org/doc/2.2/ext/methodTable.html#SECTION003400000000000000000>`_\を宣言するのに使用する。引数 :c:var:`!name` は初期化するモジュールの名前に完全に一致していなければならず、Python の\ `識別子の名前付け規約 <http://docs.python.jp/2/reference/lexical_analysis.html#identifiers>`_\に従っていなければならない。通常、次のように書くところを、 ::

      extern "C" void initname()
      {
         ...
      }

   Boost.Python モジュールでは次のように初期化する。 ::

      BOOST_PYTHON_MODULE(name)
      {
         ...
      }

   このマクロは、使用したスコープ内で 2 つの関数 :code:`extern "C" void init`\ :samp:`{name}`\ :code:`()` および :code:`void init_module_`\ :samp:`{name}`\ :code:`()` を生成する。関数の本体はマクロ呼び出しの直後でなければならない。生成された C++ 例外を安全に処理するため、:code:`init_`\ :samp:`{name}` は :code:`init_module_`\ :samp:`{name}` を :cpp:func:`handle_exception()` に渡す。:code:`init_`\ :samp:`{name}` の本体内では現在の :cpp:class:`scope` は初期化するモジュールを指す。


.. _v2.module.examples:

例
--

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/module.hpp>

   BOOST_PYTHON_MODULE(xxx)
   {
       throw "何かまずいことが起きた"
   }

.. code-block:: python
   :caption: Python の対話例

   >>> import xxx
   Traceback (most recent call last):
     File "", line 1, in ?
   RuntimeError: Unidentifiable C++ Exception
