boost/python/dict.hpp
=====================

.. contents::
   :depth: 1
   :local:

.. _v2.dict.introduction:

はじめに
--------

Python の `dict <http://docs.python.jp/2/c-api/dict.html>`_ 型に対する :ref:`TypeWrapper <concepts.objectwrapper.typewrapper_concept_requirements>` をエクスポートする。


.. _v2.dict.classes:

クラス
------

.. _v2.dict.dict-spec:

:cpp:class:`!dict` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:class:: dict : public object

   Python の組み込み :py:class:`!dict` 型の\ `マップ型プロトコル <http://docs.python.jp/2/c-api/mapping.html>`_\をエクスポートする。以下に定義するコンストラクタとメンバ関数のセマンティクスを完全に理解するには、:ref:`concepts.objectwrapper.typewrapper_concept_requirements`\の定義を読むことである。:cpp:class:`!dict` は :cpp:class:`object` から公開派生しているので、:cpp:class:`!object` の公開インターフェイスは :cpp:class:`!dict` のインスタンスにも当てはまる。


.. _v2.dict.dict-spec-synopsis:

:cpp:class:`!dict` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      class dict : public object
      {
         dict();

         template< class T >
         dict(T const & data);

         // 変更
         void clear();
         dict copy();

         template <class T1, class T2>
         tuple popitem();

         template <class T>
         object setdefault(T const &k);

         template <class T1, class T2>
         object setdefault(T1 const & k, T2 const & d);

         void update(object_cref E);
 
         template< class T >
         void update(T const & E);

         // オブザーバ
         list values() const;

         object get(object_cref k) const;

         template<class T>
         object get(T const & k) const;

         object get(object_cref k, object_cref d) const;
         object get(T1 const & k, T2 const & d) const;

         bool has_key(object_cref k) const;

         template< class T >
         bool has_key(T const & k) const;

         list items() const;
         object iteritems() const;
         object iterkeys() const;
         object itervalues() const;
         list keys() const;
     };
   }}


.. _v2.dict.examples:

例
--

::

   using namespace boost::python;
   dict swap_object_dict(object target, dict d)
   {
       dict result = extract<dict>(target.attr("__dict__"));
       target.attr("__dict__") = d;
       return result;
   }
