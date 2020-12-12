.. cpp:namespace:: boost::python::numpy

binary_ufunc
============

.. contents::
   :depth: 1
   :local:


.. cpp:struct:: template <typename TUnaryFunctor, typename TArgument1=typename TBinaryFunctor::first_argument_type, typename TArgument2=typename TBinaryFunctor::second_argument_type, typename TResult=typename TUnaryFunctor::result_type> \
		binary_ufunc

   :cpp:struct:`binary_ufunc` は、2 つの引数をブロードキャストするための中間ステップとして使う構造体である。これにより C++ 関数が ufunc ライクな関数に変換可能となる。

      :file:`<boost/python/numpy/ufunc.hpp>` は :cpp:struct:`binary_ufunc` 構造体の定義をもつ。


.. cpp:namespace-push:: binary_ufunc


.. _numpy.reference.binary_ufunc.synopsis:

概要
----

::

   namespace boost
   {
   namespace python
   {
   namespace numpy
   {

   template <typename TUnaryFunctor,
             typename TArgument1=typename TBinaryFunctor::first_argument_type,
             typename TArgument2=typename TBinaryFunctor::second_argument_type,
             typename TResult=typename TUnaryFunctor::result_type>
   struct binary_ufunc
   {

     static object call(TUnaryFunctor & self,
                        object const & input1,
                        object const & input2,
                        object const & output) ;

     static object make();

   };
   }
   }
   }


.. _numpy.reference.binary_ufunc.constructors:

コンストラクタ
--------------

.. cpp:struct:: example_binary_ufunc

   .. cpp:type:: any_valid first_argument_type
   .. cpp:type:: any_valid second_argument_type
   .. cpp:type:: any_valid result_type

   :要件: 構造体のメソッドを正しく使用するために、:cpp:type:`!any_valid_type` は合法な C++ 型の typedef で定義しなければならない。
   :注意: この構造体は Python クラスとしてエクスポートしなければならない。またこのクラスのインスタンスは、Python オブジェクトの :py:mod:`!__call__` 属性に対応する :cpp:func:`call` メソッドを使用するのに作成しなければならない。


.. _numpy.reference.binary_ufunc.accessors:

アクセッサ
----------

.. cpp:function:: template <typename TUnaryFunctor, typename TArgument1=typename TBinaryFunctor::first_argument_type, typename TArgument2=typename TBinaryFunctor::second_argument_type, typename TResult=typename TUnaryFunctor::result_type> \
                  static object call(TUnaryFunctor & self, object const & input1, object const & input2, object const & output)

   :要件: :cpp:type:`TUnaryFunctor`。および引数の型を表す :cpp:type:`TArgument1` 、:cpp:type:`TArgument2` と戻り値の型を表す :cpp:type:`TResult`\（いずれも省略可能）。
   :効果: Python オブジェクトを、引数をブロードキャストした後 C++ 関数子に渡す。


.. cpp:function:: template <typename TUnaryFunctor, typename TArgument1=typename TBinaryFunctor::first_argument_type, typename TArgument2=typename TBinaryFunctor::second_argument_type, typename TResult=typename TUnaryFunctor::result_type> \
                  static object make()

   :要件: :cpp:type:`TUnaryFunctor`。および引数の型を表す :cpp:type:`TArgument1` 、:cpp:type:`TArgument2` と戻り値の型を表す :cpp:type:`TResult`\（いずれも省略可能）。
   :returns: （典型的な使い方として）構造体内で多重定義した :code:`()` 演算子を呼び出すための Python オブジェクト。


.. cpp:namespace-pop::


.. _numpy.reference.binary_ufunc.examples:

使用例
------

::

   namespace p = boost::python;
   namespace np = boost::python::numpy;

   struct BinarySquare
   {
     typedef double first_argument_type;
     typedef double second_argument_type;
     typedef double result_type;

     double operator()(double a,double b) const { return (a*a + b*b) ; }
   };

   p::object ud = p::class_<BinarySquare, boost::shared_ptr<BinarySquare> >("BinarySquare").def("__call__", np::binary_ufunc<BinarySquare>::make());
   p::object inst = ud();
   result_array = inst.attr("__call__")(demo_array,demo_array) ;
   std::cout << "リストに二項 ufunc を適用した正方行列は " << p::extract <char const * > (p::str(result_array)) << std::endl ;
