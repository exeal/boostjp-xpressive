.. cpp:namespace:: boost::python::numpy

unary_ufunc
===========

.. contents::
   :depth: 1
   :local:


.. cpp:struct:: template <typename TUnaryFunctor, typename TArgument=typename TUnaryFunctor::argument_type, typename TResult=typename TUnaryFunctor::result_type> \
	       unary_ufunc

   :cpp:struct:`unary_ufunc` は、単一引数をブロードキャストするための中間ステップとして使う構造体である。これにより C++ 関数が ufunc ライクな関数に変換可能となる。

      :file:`<boost/python/numpy/ufunc.hpp>` は :cpp:struct:`unary_ufunc` 構造体の定義をもつ。


.. cpp:namespace-push:: unary_ufunc


.. _numpy.reference.unary_ufunc.synopsis:

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
             typename TArgument=typename TUnaryFunctor::argument_type,
             typename TResult=typename TUnaryFunctor::result_type>
   struct unary_ufunc
   {

     static object call(TUnaryFunctor & self,
                        object const & input,
                        object const & output) ;

     static object make();

   };
   }
   }
   }


.. _numpy.reference.unary_ufunc.constructors:

コンストラクタ
--------------

.. cpp:struct:: example_unary_ufunc

   .. cpp:type:: any_valid_type argument_type
   .. cpp:type:: any_valid_type result_type

   :要件: 構造体のメソッドを正しく使用するために、:cpp:type:`!any_valid_type` は合法な C++ 型の typedef で定義しなければならない。
   :注意: この構造体は Python クラスとしてエクスポートしなければならない。またこのクラスのインスタンスは、Python オブジェクトの :py:meth:`!__call__` 属性に対応する :cpp:func:`~unary_ufunc::call` メソッドを使用するのに作成しなければならない。


.. _numpy.reference.unary_ufunc.accessors:

アクセッサ
----------

.. cpp:function:: template <typename TUnaryFunctor, typename TArgument=typename TUnaryFunctor::argument_type, typename TResult=typename TUnaryFunctor::result_type> \
		  static object call(TUnaryFunctor & self, object const & input, object const & output)

   :要件: :cpp:type:`TUnaryFunctor`。および引数の型を表す :cpp:type:`TArgument` と戻り値の型を表す :cpp:type:`TResult`\（いずれも省略可能）。
   :効果: Python オブジェクトを、引数をブロードキャストした後 C++ 関数子に渡す。


.. cpp:function:: template <typename TUnaryFunctor, typename TArgument=typename TUnaryFunctor::argument_type, typename TResult=typename TUnaryFunctor::result_type> \
		  static object make()

   :要件: :cpp:type:`TUnaryFunctor`。および引数の型を表す :cpp:type:`TArgument` と戻り値の型を表す :cpp:type:`TResult`\（いずれも省略可能）。
   :returns: （典型的な使い方として）構造体内で多重定義した :code:`()` 演算子を呼び出すための Python オブジェクト。


.. cpp:namespace-pop::


.. _numpy.reference.unary_ufunc.examples:

使用例
------

::

   namespace p = boost::python;
   namespace np = boost::python::numpy;

   struct UnarySquare
   {
     typedef double argument_type;
     typedef double result_type;
     double operator()(double r) const { return r * r;}
   };

   p::object ud = p::class_<UnarySquare, boost::shared_ptr<UnarySquare> >("UnarySquare").def("__call__", np::unary_ufunc<UnarySquare>::make());
   p::object inst = ud();
   std::cout << "単項スカラー 1.0 の正方行列は " << p::extract <char const * > (p::str(inst.attr("__call__")(1.0))) << std::endl ;
