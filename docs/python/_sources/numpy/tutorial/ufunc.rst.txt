ufunc
=====

ufunc またはユニバーサル関数は ndarray を要素ごとに操作する。またブロードキャスト\ [#]_\、型キャスト、その他機能をサポートする。

二項及び単項の ufunc メソッドについて使い方を見ていこう。

必要なファイルのインクルードを行った後、 ::

   #include <boost/python/numpy.hpp>
   #include <iostream>

   namespace p = boost::python;
   namespace np = boost::python::numpy;

ufunc の実装に必要な構造体を作成する。typedef は、ufunc 生成器がこれらの typedef を入力にとりそれ以外の場合にエラーを返すように\ **しなければならない**\。 ::

   struct UnarySquare
   {
     typedef double argument_type;
     typedef double result_type;

     double operator()(double r) const { return r * r;}
   };

   struct BinarySquare
   {
     typedef double first_argument_type;
     typedef double second_argument_type;
     typedef double result_type;

     double operator()(double a,double b) const { return (a*a + b*b) ; }
   };

Python ランタイムと numpy モジュールを初期化する。 ::

   int main(int argc, char **argv)
   {
     Py_Initialize();
     np::initialize();

:cpp:struct:`!UnarySquare` 構造体をクラスとして Python にエクスポートし、:cpp:var:`!ud` をクラスオブジェクトとする。 ::

     p::object ud = p::class_<UnarySquare, boost::shared_ptr<UnarySquare> >("UnarySquare");
     ud.def("__call__", np::unary_ufunc<UnarySquare>::make());

:cpp:var:`!inst` を :py:class:`!ud` クラスのインスタンスとする。 ::

     p::object inst = ud();

:py:func:`!__call__` メソッドを使って多重定義した :code:`()` 演算子を呼び出し、値を印字する。 ::

    std::cout << "単項スカラ 1.0 の正方行列は " << p::extract<char const *>(p::str(inst.attr("__call__")(1.0))) << std::endl;

C++ で配列を作成する。 ::

     int arr[] = {1,2,3,4} ;

この配列を使って、Python で ndarray を作成する。 ::

     np::ndarray demo_array = np::from_data(arr, np::dtype::get_builtin<int>(),
                                            p::make_tuple(4),
                                            p::make_tuple(4),
                                            p::object());

このデモ配列を印字する。 ::

     std::cout << "デモ配列は " << p::extract<char const *>(p::str(demo_array)) << std::endl;

:py:func:`!__call__` メソッドを呼び出して、演算と :cpp:var:`!result_array` に代入する。 ::

     p::object result_array = inst.attr("__call__")(demo_array);

結果の配列を印字する。 ::

     std::cout << "デモ配列の正方行列は " << p::extract<char const *>(p::str(result_array)) << std::endl;

リストで同じことをしてみよう。 ::

     p::list li;
     li.append(3);
     li.append(7);

デモリストを印字する。 ::

     std::cout << "デモリストは " << p::extract<char const *>(p::str(li)) << std::endl;

このリストに対して ufunc を呼び出す。 ::

     result_array = inst.attr("__call__")(li);

そしてリストを印字する。 ::

     std::cout << "デモリストの正方行列は " << p::extract<char const *>(p::str(result_array)) << std::endl;

今度は二項 ufunc を試してみよう。同様に :cpp:class:`!BinarySquare` 構造体をクラスとして Python へエクスポートし、:cpp:var:`!ud` をクラスオブジェクトとする。 ::

     ud = p::class_<BinarySquare, boost::shared_ptr<BinarySquare> >("BinarySquare");
     ud.def("__call__", np::binary_ufunc<BinarySquare>::make());

そして :cpp:var:`!ud` を初期化する。 ::

     inst = ud();

2 つの入力リストを印字する。 ::

     std::cout << "二項 ufunc に対する 2 つの入力リストは " << std::endl
               << p::extract<char const *>(p::str(demo_array)) << std::endl
               << p::extract<char const *>(p::str(demo_array)) << std::endl;

二項 ufunc を呼び出し、両方の入力として :cpp:var:`!demo_array` を与える。 ::

     result_array = inst.attr("__call__")(demo_array,demo_array);

最後に出力を印字する。 ::

     std::cout << "リストと二項 ufunc の正方行列は " << p::extract<char const *>(p::str(result_array)) << std::endl;
   }


.. [#] 訳注：型や次元の異なる ndarray 同士を計算する仕組み
