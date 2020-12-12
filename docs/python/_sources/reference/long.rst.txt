boost/python/long.hpp
=====================

.. contents::
   :depth: 1
   :local:


.. _v2.long.introduction:

はじめに
--------

Python の `long <http://docs.python.jp/2/c-api/long.html>`_ 整数型に対する :ref:`TypeWrapper <concepts.objectwrapper.typewrapper_concept_requirements>` をエクスポートする。


.. _v2.long.classes:

クラス
------

.. _v2.long.long_-spec:

:cpp:class:`!long_` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:class:: long_ : public object

   Python の組み込み :py:class:`!long` 型の\ `整数型プロトコル <http://docs.python.jp/2/c-api/number.html>`_\をエクスポートする。以下に定義するコンストラクタとメンバ関数のセマンティクスを完全に理解するには、:ref:`concepts.objectwrapper.typewrapper_concept_requirements`\の定義を読むことである。:cpp:class:`long_` は :cpp:class:`object` から公開派生しているので、:cpp:class:`!object` の公開インターフェイスは :cpp:class:`!long_` のインスタンスにも当てはまる。


.. _v2.long.long_-spec-synopsis:

:cpp:class:`!long_` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     class long_ : public object
     {
      public:
         long_(); // long_ を新規に作成する

         template <class T>
         explicit long_(T const& rhs);

         template <class T, class U>
         long_(T const& rhs, U const& base);
     };
   }}


.. _v2.long.examples:

例
--

::

   namespace python = boost::python;

   // オーバーフローすることなく階乗を計算する
   python::long_ fact(long n)
   {
      if (n == 0)
         return python::long_(1);
      else
         return n * fact(n - 1);
   }
