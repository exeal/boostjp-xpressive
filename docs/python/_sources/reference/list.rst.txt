boost/python/list.hpp
=====================

.. contents::
   :depth: 1
   :local:


.. _v2.list.introduction:

はじめに
--------

Python の `list <http://docs.python.jp/2/c-api/list.html>`_ 型に対する :ref:`TypeWrapper <concepts.objectwrapper.typewrapper_concept_requirements>` をエクスポートする。


.. _v2.list.classes:

クラス
------

.. _v2.list.list-spec:

:cpp:class:`!list` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:class:: list : public object

   Python の組み込み :py:class:`!list` 型の\ `シーケンス型プロトコル <http://docs.python.jp/2/c-api/sequence.html>`_\をエクスポートする。以下に定義するコンストラクタとメンバ関数のセマンティクスを完全に理解するには、:ref:`concepts.objectwrapper.typewrapper_concept_requirements`\の定義を読むことである。:cpp:class:`!list` は :cpp:class:`object` から公開派生しているので、:cpp:class:`!object` の公開インターフェイスは :cpp:class:`!list` のインスタンスにも当てはまる。


.. _v2.list.list-spec-synopsis:

:cpp:class:`!list` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     class list : public object
     {
      public:
         list(); // list を新規作成する

         template <class T>
         explicit list(T const& sequence);

         template <class T>
         void append(T const& x);

         template <class T>
         long count(T const& value) const;

         template <class T>
         void extend(T const& x);

         template <class T>
         long index(T const& x) const;

         template <class T>
         void insert(object const& index, T const& x); // index の前にオブジェクトを挿入する

         object pop(); // index 位置（既定は末尾）の要素を削除して返す
         object pop(long index);
         object pop(object const& index);

         template <class T>
         void remove(T const& value);

         void reverse(); // 「その場で」逆順に入れ替える

         void sort(); // 「その場で」ソートする。比較関数を与える場合の形式は cmpfunc(x, y) -> -1, 0, 1

         template <class T>
         void sort(T const& value);
     };
   }}


.. _v2.list.examples:

例
--

::

   using namespace boost::python;

   // リスト内の 0 の数を返す
   long zeroes(list l)
   {
      return l.count(0);
   }
