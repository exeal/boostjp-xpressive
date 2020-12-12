boost/python/raw_function.hpp
=============================

.. contents::
   :depth: 1
   :local:


.. _v2.raw_function.introduction:

はじめに
--------

:cpp:func:`raw_function()` は、:cpp:class:`tuple` および :cpp:class:`dict` を引数にとる関数を可変長の引数と任意のキーワード引数を受け取る Python の呼び出し可能オブジェクトに変換するのに使用する。


.. _v2.raw_function.functions:

関数
----

.. _v2.raw_function.raw_function-spec:

raw_function
^^^^^^^^^^^^

.. cpp:function:: template <class F> \
                  object raw_function(F f, std::size_t min_args = 0)

   :要件: :cpp:expr:`f(tuple(), dict())` が合法な形式。
   :returns: 少なくとも :cpp:var:`!min_args` 個の引数を要求する\ `呼び出し可能 <http://docs.python.jp/2/library/functions.html#callable>`_\オブジェクト。呼び出されると実際の非キーワード引数列が :cpp:class:`tuple` の第 1 引数として、キーワード引数列が :cpp:class:`dict` の第 2 引数として :cpp:var:`!f` に渡される。


.. _v2.raw_function.examples:

例
--

.. code-block::
   :caption: C++

   #include <boost/python/def.hpp>
   #include <boost/python/tuple.hpp>
   #include <boost/python/dict.hpp>
   #include <boost/python/module.hpp>
   #include <boost/python/raw_function.hpp>
   using namespace boost::python;

   tuple raw(tuple args, dict kw)
   {
       return make_tuple(args, kw);
   }

   BOOST_PYTHON_MODULE(raw_test)
   {
       def("raw", raw_function(raw));
   }

.. code-block:: python
   :caption: Python

   >>> from raw_test import *

   >>> raw(3, 4, foo = 'bar', baz = 42)
   ((3, 4), {'foo': 'bar', 'baz': 42})
