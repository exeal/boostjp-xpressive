.. cpp:namespace:: boost::python::numpy

multi_iter
==========

.. contents::
   :depth: 1
   :local:


.. cpp:class:: multi_iter : public boost::python::object

   :cpp:class:`multi_iter` はイテレータとして使う Python オブジェクトである。通常、ループ内でのみ使用する。

      :file:`<boost/python/numpy/ufunc.hpp>` は :cpp:class:`multi_iter` のクラス定義をもつ。


.. cpp:namespace-push:: multi_iter


.. _numpy.reference.multi_iter.synopsis:

概要
----

::

   namespace boost
   {
   namespace python
   {
   namespace numpy
   {

   class multi_iter : public object
   {
   public:
     void next();
     bool not_done() const;
     char * get_data(int n) const;
     int const get_nd() const;
     Py_intptr_t const * get_shape() const;
     Py_intptr_t const shape(int n) const;
   };


   multi_iter make_multi_iter(object const & a1);
   multi_iter make_multi_iter(object const & a1, object const & a2);
   multi_iter make_multi_iter(object const & a1, object const & a2, object const & a3);

   }
   }
   }


.. _numpy.reference.multi_iter.constructors:

コンストラクタ
--------------

.. cpp:function:: multi_iter make_multi_iter(object const & a1)
		  multi_iter make_multi_iter(object const & a1, object const & a2)
		  multi_iter make_multi_iter(object const & a1, object const & a2, object const & a3)

   :returns: 与えた 1 つから 3 つのシーケンスをブロードキャストする Python イテレータオブジェクト。


.. _numpy.reference.multi_iter.accessors:

アクセッサ
----------

.. cpp:function:: void next()

   :効果: イテレータを進める。


.. cpp:function:: bool not_done()

   :returns: イテレータが終端に到達したかを表す論理値。


.. cpp:function:: char * get_data(int n) const

   :returns: ブロードキャストした :cpp:var:`n` 番目の配列の要素へのポインタ。


.. cpp:function:: int const get_nd() const

   :returns: ブロードキャストした配列式の次元数。


.. cpp:function:: Py_intptr_t const * get_shape() const

   :returns: ブロードキャストした配列式の形状を表す整数配列。


.. cpp:function:: Py_intptr_t const shape(int n) const

   :returns: ブロードキャストした配列式の第 :cpp:var:`n` 次元の形状。


.. cpp:namespace-pop::
