boost/python/tuple.hpp
======================

.. _v2.tuple.introduction:

はじめに
--------

Python の `tuple <http://docs.python.jp/2/tutorial/datastructures.html#tuples-and-sequences>`_ 型に対する :ref:`TypeWrapper <concepts.objectwrapper.typewrapper_concept_requirements>` をエクスポートする。


.. _v2.tuple.classes:

クラス
------

.. _v2.tuple.tuple-spec:

:cpp:class:`!tuple` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:class:: tuple : public object

   Python の組み込み :py:class:`!tuple` インターフェイスをエクスポートする。以下に定義するコンストラクタとメンバ関数のセマンティクスを完全に理解するには、:ref:`concepts.objectwrapper.typewrapper_concept_requirements`\の定義を読むことである。:cpp:class:`!tuple` は :cpp:class:`object` から公開派生しているので、:cpp:class:`!object` の公開インターフェイスは :cpp:class:`!tuple` のインスタンスにも当てはまる。


.. _v2.tuple.tuple-spec-synopsis:

:cpp:class:`!tuple` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      class tuple : public object
      {
         // tuple() は空の tuple を作成
         tuple();

         // tuple(sequence) はシーケンスの要素で初期化した tuple を作成
         template <class T>
         explicit tuple(T const& sequence)
     };
   }}


.. _v2.tuple.functions:

関数
----

.. _v2.tuple.make_tuple-spec:

:cpp:func:`!make_tuple`
^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template <class ...Args> \
                  tuple make_tuple(Args const& ...args)

   :cpp:expr:`object(a0)`\ :code:`,...`\ :cpp:expr:`object(an)` [#]_ を組み合わせて新しいタプルオブジェクトを構築する。


.. _v2.tuple.examples:

例
--

::

   using namespace boost::python;
   tuple head_and_tail(object sequence)
   {
       return make_tuple(sequence[0],sequence[-1]);
   }


.. [#] 訳注　:cpp:var:`!a0` … :cpp:var:`!an` は :cpp:var:`!args` の全要素。
