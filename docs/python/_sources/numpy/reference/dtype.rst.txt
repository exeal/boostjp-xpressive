.. cpp:namespace:: boost::python::numpy

dtype
=====

.. contents:: 目次
   :depth: 1
   :local:


.. cpp:class:: dtype : public boost::object

   `dtype`_ は ndarray の要素の型を記述するオブジェクトである。

   .. _dtype: http://docs.scipy.org/doc/numpy/reference/arrays.dtypes.html#data-type-objects-dtype

      :file:`<boost/python/numpy/dtype.hpp>` は、組み込みの C++ オブジェクトから等価な numpy.dtype Python オブジェクトを生成する、ユーザ定義型からカスタムの dtype を作成するのに必要なメソッド呼び出しを含む。


.. cpp:namespace-push:: dtype


.. _numpy.reference.dtype.synopsis:

概要
----

::

   namespace boost
   {
   namespace python
   {
   namespace numpy
   {

   class dtype : public object
   {
     static python::detail::new_reference convert(object::object_cref arg, bool align);
   public:

     // 任意の Python オブジェクトをデータ型記述子オブジェクトへ変換する。
     template <typename T>
     explicit dtype(T arg, bool align=false);

     // 与えられたスカラーテンプレート型に相当する組み込みの numpy dtype を得る。
     template <typename T> static dtype get_builtin();

     // データ型のバイトサイズを返す。
     int get_itemsize() const;
   };

   }
   }
   }


.. _numpy.reference.dtype.constructors:

コンストラクタ
--------------

.. cpp:function:: template <typename T> \
		  explicit dtype(T arg, bool align = false)

   :要件: :cpp:type:`T` が下記いずれかでなければならない。

          * オブジェクトへ変換可能な組み込みの C++ typename
          * オブジェクトへ変換可能な合法な Python オブジェクト
   :効果: 与えられた Python オブジェクト、オブジェクトへ変換可能なオブジェクト、組み込み C++ データ型からオブジェクトを構築する。
   :例外: なし


.. cpp:function:: template <typename T> \
		  static dtype get_builtin()

   :要件: typename で与えられた :cpp:type:`T` が、numpy がサポートする組み込み C++ 型でなければならない。
   :returns: 組み込み C++ 型に対応する numpy の dtype。


.. _numpy.reference.dtype.accessors:

アクセッサ
----------

.. cpp:function:: int get_itemsize() const

   :returns: データ型のバイト数。


.. cpp:namespace-pop::


.. _numpy.reference.dtype.examples:

使用例
------

::

   namespace p = boost::python;
   namespace np = boost::python::numpy;

   np::dtype dtype = np::dtype::get_builtin<double>();
   p::tuple for_custom_dtype = p::make_tuple("ha",dtype);
   np::dtype custom_dtype = np::dtype(list_for_dtype);
