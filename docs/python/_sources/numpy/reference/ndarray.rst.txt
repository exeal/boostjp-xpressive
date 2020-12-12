.. cpp:namespace:: boost::python::numpy

ndarray
=======

.. contents:: 目次
   :depth: 1
   :local:


.. cpp:class:: ndarray : public boost::python::object

   `ndarray`_ は同一の型とサイズをもつ要素の N 次元配列である。N は次元数であり、タプル :cpp:var:`!shape` の形式で指定する。内容のオブジェクトについて numpy の dtype を指定することもできる。

   .. _ndarray: http://docs.scipy.org/doc/numpy/reference/arrays.ndarray.html

      :file:`<boost/python/numpy/ndarray.hpp>` は、生のポインタを C++ と Python 間で移動し、データから ndarray を作成するのに必要な構造体とメソッドを含む。


.. cpp:namespace-push:: ndarray


.. _numpy.reference.ndarray.synopsis:

概要
----

::

   namespace boost
   {
   namespace python
   {
   namespace numpy
   {

   class ndarray : public object
   {

   public:

     enum bitflag
     {
       NONE=0x0, C_CONTIGUOUS=0x1, F_CONTIGUOUS=0x2, V_CONTIGUOUS=0x1|0x2,
       ALIGNED=0x4, WRITEABLE=0x8, BEHAVED=0x4|0x8,
       CARRAY_RO=0x1|0x4, CARRAY=0x1|0x4|0x8, CARRAY_MIS=0x1|0x8,
       FARRAY_RO=0x2|0x4, FARRAY=0x2|0x4|0x8, FARRAY_MIS=0x2|0x8,
       UPDATE_ALL=0x1|0x2|0x4, VARRAY=0x1|0x2|0x8, ALL=0x1|0x2|0x4|0x8
     };

     ndarray view(dtype const & dt) const;
     ndarray astype(dtype const & dt) const;
     ndarray copy() const;
     int const shape(int n) const;
     int const strides(int n) const;
     char * get_data() const;
     dtype get_dtype() const;
     python::object get_base() const;
     void set_base(object const & base);
     Py_intptr_t const * get_shape() const;
     Py_intptr_t const * get_strides() const;
     int const get_nd() const;

     bitflag const get_flags() const;

     ndarray transpose() const;
     ndarray squeeze() const;
     ndarray reshape(tuple const & shape) const;
     object scalarize() const;
   };

   ndarray zeros(tuple const & shape, dtype const & dt);
   ndarray zeros(int nd, Py_intptr_t const * shape, dtype const & dt);

   ndarray empty(tuple const & shape, dtype const & dt);
   ndarray empty(int nd, Py_intptr_t const * shape, dtype const & dt);

   ndarray array(object const & obj);
   ndarray array(object const & obj, dtype const & dt);

   template <typename Container>
   ndarray from_data(void * data,dtype const & dt,Container shape,Container strides,python::object const & owner);
   template <typename Container>
   ndarray from_data(void const * data, dtype const & dt, Container shape, Container strides, object const & owner);

   ndarray from_object(object const & obj, dtype const & dt,int nd_min, int nd_max, ndarray::bitflag flags=ndarray::NONE);
   ndarray from_object(object const & obj, dtype const & dt,int nd, ndarray::bitflag flags=ndarray::NONE);
   ndarray from_object(object const & obj, dtype const & dt, ndarray::bitflag flags=ndarray::NONE);
   ndarray from_object(object const & obj, int nd_min, int nd_max,ndarray::bitflag flags=ndarray::NONE);
   ndarray from_object(object const & obj, int nd, ndarray::bitflag flags=ndarray::NONE);
   ndarray from_object(object const & obj, ndarray::bitflag flags=ndarray::NONE)

   ndarray::bitflag operator|(ndarray::bitflag a, ndarray::bitflag b) ;
   ndarray::bitflag operator&(ndarray::bitflag a, ndarray::bitflag b);

   }}}


.. _numpy.reference.ndarray.constructors:

コンストラクタ
--------------

.. cpp:function:: ndarray view(dtype const & dt) const

   :returns: 古い ndarray を与えられたデータ型でキャストした新しい ndarray。


.. cpp:function:: ndarray astype(dtype const & dt) const

   :returns: 古い ndarray を与えられたデータ型へ変換した新しい ndarray。


.. cpp:function:: ndarray copy() const

   :returns: 呼び出した :cpp:class:`ndarray` のコピー。


.. cpp:function:: ndarray transpose() const

   :returns: 行と列を入れ替えた :cpp:class:`ndarray`。


.. cpp:function:: ndarray squeeze() const

   :returns: 大きさが 1 の次元を全て削除した :cpp:class:`ndarray`。


.. cpp:function:: ndarray reshape(tuple const & shape) const

   :要件: :cpp:class:`ndarray` の新しい :cpp:var:`shape` はタプルとして与えなければならない
   :returns: データが同じで、与えられた :cpp:var:`shape` に変形した :cpp:class:`ndarray`。


.. cpp:function:: object scalarize() const

   :returns: :cpp:class:`ndarray` の要素がただ 1 つの場合はそのスカラー。それ以外の場合は配列全体。


.. _numpy.reference.ndarray.accessors:

アクセッサ
----------

.. cpp:function:: int const shape(int n) const

   :returns: ndarray の :cpp:var:`n` 次元目のサイズ。


.. cpp:function:: int const strides(int n) const

   :returns: :cpp:var:`n` 次元目の飛び幅。


.. cpp:function:: char* get_data() const

   :returns: 配列の生データ（:cpp:type:`!char` 型）のポインタ。
   :注意: :cpp:type:`!char` を返すため、飛び幅の算出が有効である。ユーザは reinterpret_cast を使わなければならない。


.. cpp:function:: object get_base() const

   :returns: 配列のデータを所有するオブジェクト、または配列が自身のデータを所有する場合は :py:const:`None`。


.. cpp:function:: void set_base(object const & base)

   :returns: 配列のデータを所有するオブジェクトを設定する。このメソッドの使用には注意を要する。


.. cpp:function:: Py_intptr_t const * get_shape() const

   :returns: 配列の形状を表す整数配列。


.. cpp:function:: Py_intptr_t const * get_strides() const

   :returns: 配列の飛び幅を表す整数配列。


.. cpp:function:: int const get_nd() const

   :returns: 配列の次元数。


.. cpp:function:: bitflag const get_flags() const

   :returns: 配列のフラグ。


.. cpp:function:: inline ndarray::bitflag operator|(ndarray::bitflag a, ndarray::bitflag b)

   :returns: ビットフラグの論理和（:cpp:expr:`a | b`）。


.. cpp:function:: inline ndarray::bitflag operator&(ndarray::bitflag a, ndarray::bitflag b)

   :returns: ビットフラグの論理積（:cpp:expr:`a & b`）。


.. cpp:namespace-pop::


.. cpp:function:: ndarray zeros(tuple const & shape, dtype const & dt)
                  ndarray zeros(int nd, Py_intptr_t const * shape, dtype const & dt)

   :要件: 以下の引数を必ず与えなければならない。

          * :cpp:var:`shape` か全次元の数（タプル）
          * データの :cpp:class:`dtype`
          * 正方行列に対する :cpp:var:`nd` サイズ
          * Py_intptr_t 型の :cpp:var:`shape`

   :returns: 与えた形状、データ型の :cpp:class:`ndarray`。データは 0 で初期化される。


.. cpp:function:: ndarray empty(tuple const & shape, dtype const & dt)
		  ndarray empty(int nd, Py_intptr_t const * shape, dtype const & dt)

   :要件: 以下の引数を与えなければならない。

          * :cpp:var:`shape` か全次元の数（タプル）
          * データの :cpp:class:`dtype`
	  * Py_intptr_t 型の :cpp:var:`shape`

   :returns: 与えた形状、データ型の新しい :cpp:class:`ndarray`。データは未初期化のままとなる。


.. cpp:function:: ndarray array(object const & obj)
		  ndarray array(object const & obj, dtype const & dt)

   :returns: 任意の Python シーケンスから得た新しい :cpp:class:`ndarray`。各要素の型はオプション引数で指定した dtype となる。


.. cpp:function:: template <typename Container> \
		  inline ndarray from_data(void * data, dtype const & dt, Container shape, Container strides, python::object const & owner)

   :要件: 以下の引数を与えなければならない。

	  * 汎用的な C++ データコンテナ :cpp:var:`data`。
	  * データの dtype を表す :cpp:var:`dt`。
	  * ndarray の :cpp:var:`shape`\（形状）を表す Python オブジェクト。
	  * 各次元の飛び幅を表す Python オブジェクト :cpp:var:`strides`。
	  * （所有者が ndarray 自身でない場合）データの所有者 :cpp:var:`owner`。

   :returns: 与えられた属性とデータをもつ :cpp:class:`ndarray`。
   :注意: typename :cpp:type:`Container` は :cpp:class:`std::vector` か Python のオブジェクト型のいずれかに変換可能でなければならない。


.. cpp:function:: ndarray from_object(object const & obj, dtype const & dt, int nd_min, int nd_max, ndarray::bitflag flags = ndarray::NONE)

   :要件: 以下の引数を与えなければならない。

	  * :cpp:class:`ndarray` に変換する Python オブジェクト :cpp:var:`obj`。
	  * データの dtype を表す :cpp:var:`dt`。
	  * :cpp:class:`ndarray` の最小次元数を表す Python オブジェクト :cpp:var:`nd_min`。
	  * :cpp:class:`ndarray` の最大次元数を表す Python オブジェクト :cpp:var:`nd_max`。
	  * 省略可能なビットフラグ :cpp:var:`flags`。

   :returns: 引数で与えられた次元とデータで構築した :cpp:class:`ndarray`。
   :注意: typename :cpp:type:`Container` は :cpp:class:`std::vector` か Python のオブジェクト型のいずれかに変換可能でなければならない。


.. cpp:function:: inline ndarray from_object(object const & obj, dtype const & dt, int nd, ndarray::bitflag flags = ndarray::NONE)

   :要件: 以下の引数を与えなければならない。

	  * :cpp:class:`ndarray` に変換する Python オブジェクト :cpp:var:`obj`。
	  * データの dtype を表す :cpp:var:`dt`。
	  * :cpp:class:`ndarray` の次元数を表す Python オブジェクト :cpp:var:`nd`。
	  * 省略可能なビットフラグ :cpp:var:`flags`。

   :returns: 引数で与えた属性をもつ :cpp:var:`nd` × :cpp:var:`nd` 次元の :cpp:class:`ndarray`。


.. cpp:function:: inline ndarray from_object(object const & obj, dtype const & dt, ndarray::bitflag flags = ndarray::NONE)

   :要件: 以下の引数を与えなければならない。

	  * :cpp:class:`ndarray` に変換する Python オブジェクト :cpp:var:`obj`。
	  * データの dtype を表す :cpp:var:`dt`。
	  * 省略可能なビットフラグ :cpp:var:`flags`。

   :returns: 与えた Python オブジェクトの :cpp:class:`ndarray`。


.. cpp:function:: ndarray from_object(object const & obj, int nd_min, int nd_max, ndarray::bitflag flags = ndarray::NONE)

   :要件: 以下の引数を与えなければならない。

	  * :cpp:class:`ndarray` に変換する Python オブジェクト :cpp:var:`obj`。
	  * :cpp:class:`ndarray` の最小次元数を表す Python オブジェクト :cpp:var:`nd_min`。
	  * :cpp:class:`ndarray` の最大次元数を表す Python オブジェクト :cpp:var:`nd_max`。
	  * 省略可能なビットフラグ :cpp:var:`flags`。

   :returns: 引数で与えられた次元数制限と属性をもつ :cpp:class:`ndarray`。


.. cpp:function:: inline ndarray from_object(object const & obj, int nd, ndarray::bitflag flags = ndarray::NONE)

   :要件: 以下の引数を与えなければならない。

	  * :cpp:class:`ndarray` に変換する Python オブジェクト :cpp:var:`obj`。

	  .. 原文には dtype の説明があるが、引数には無いので削除した

	  * :cpp:class:`ndarray` の次元数を表す Python オブジェクト :cpp:var:`nd`。
	  * 省略可能なビットフラグ :cpp:var:`flags`。

   :returns: 与えたオブジェクトから構築した :cpp:var:`nd` × :cpp:var:`nd` 次元の :cpp:class:`ndarray`。


.. cpp:function:: inline ndarray from_object(object const & obj, ndarray::bitflag flags = ndarray::NONE)

   :要件: 以下の引数を与えなければならない。

	  * :cpp:class:`ndarray` に変換する Python オブジェクト :cpp:var:`obj`。
	  * 省略可能なビットフラグ :cpp:var:`flags`。

   :returns: 与えた Python オブジェクトと同じ次元と dtype の :cpp:class:`ndarray`。


.. _numpy.reference.ndarray.examples:

使用例
------

::

   namespace p = boost::python;
   namespace np = boost::python::numpy;

   p::object tu = p::make_tuple('a','b','c') ;
   np::ndarray example_tuple = np::array (tu) ;

   p::list l ;
   np::ndarray example_list = np::array (l) ;

   np::dtype dt = np::dtype::get_builtin<int>();
   np::ndarray example_list1 = np::array (l,dt);

   int data[] = {1,2,3,4} ;
   p::tuple shape = p::make_tuple(4) ;
   p::tuple stride = p::make_tuple(4) ;
   p::object own ;
   np::ndarray data_ex = np::from_data(data,dt,shape,stride,own);

   uint8_t mul_data[][4] = {{1,2,3,4},{5,6,7,8},{1,3,5,7}};
   shape = p::make_tuple(3,2) ;
   stride = p::make_tuple(4,2) ;
   np::dtype dt1 = np::dtype::get_builtin<uint8_t>();

   np::ndarray mul_data_ex = np::from_data(mul_data,dt1, p::make_tuple(3,4),p::make_tuple(4,1),p::object());
   mul_data_ex = np::from_data(mul_data,dt1, shape,stride,p::object());
