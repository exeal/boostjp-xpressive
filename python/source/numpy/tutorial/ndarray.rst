.. cpp:namespace:: boost::python::numpy

ndarray の作成
==============

Boost.Numpy ライブラリは、ndarray を作成するかなりの数のメソッドを提供している。ndarray は空の配列やゼロ埋めされた配列を含む様々な方法で作成できる。また ndarray はデータと dtype から作成する場合と同様に、任意の Python シーケンスから作成することもできる。

このチュートリアルでは ndarray の作成方法をいくつか紹介する。単位飛び幅（unit stride）、非単位飛び幅（non-unit stride）を使った、任意の Python シーケンスからの作成方法、C++ コンテナからの作成方法を扱う。

まず、これまでと同様に必要な名前空間とランタイムを初期化する。 ::

   #include <boost/python/numpy.hpp>
   #include <iostream>

   namespace p = boost::python;
   namespace np = boost::python::numpy;

   int main(int argc, char **argv)
   {
     Py_Initialize();
     np::initialize();

単純なタプルから ndarray を作成するとしよう。始めに :cpp:class:`tuple` オブジェクトを作成し、これを :cpp:func:`array` メソッドに渡して必要なタプルを生成する。 ::

     p::object tu = p::make_tuple('a','b','c');
     np::ndarray example_tuple = np::array(tu);

リストで同じことをやってみよう。空の :cpp:class:`list` を作成し、:cpp:func:`~list::append` メソッドで要素を 1 つ追加する。同様に :cpp:func:`array` メソッドを呼び出す。 ::

     p::list l;
     l.append('a');
     np::ndarray example_list = np::array (l);

配列に対して dtype を指定することもできる。 ::

     np::dtype dt = np::dtype::get_builtin<int>();
     np::ndarray example_list1 = np::array (l,dt);

データ配列と数個の引数を与えて ndarray を作成することもできる。

始めに整数の配列を作成する。 ::

     int data[] = {1,2,3,4,5};

関数に必要な形状、飛び幅を作成する。 ::

     p::tuple shape = p::make_tuple(5);
     p::tuple stride = p::make_tuple(sizeof(int));

形状を (4,) 、飛び幅を :cpp:expr:`sizeof(int)` とした。飛び幅は、ndarray の構築中に次の要素へ移動するときのバイト数である。

渡した配列へのトラッキングを保持するための所有者も必要である。:cpp:var:`none` を渡すのは危険である。 ::

     p::object own;

:cpp:func:`from_data` 関数はデータ配列、データ型、形状、飛び幅、所有者を引数にとり、:cpp:class:`ndarray` を返す。 ::

     np::ndarray data_ex1 = np::from_data(data,dt, shape,stride,own);

作成した ndarray を印字してみよう。 ::

     std::cout << "単一次元の配列 ::" << std::endl
     << p::extract<char const *>(p::str(data_ex)) << std::endl;

もう少し面白いパターンにしてみよう。non-unit 飛び幅を使って多次元配列から 3×2 の ndarray を作成しよう。

始めに 8 ビット整数の 3×4 配列を作成しよう。 ::

     uint8_t mul_data[][4] = {{1,2,3,4},{5,6,7,8},{1,3,5,7}};

各行の 1 番目と 3 番目の要素を取り出して 3×2 の配列を作成しよう。形状は 3×2 となる。飛び幅は 4×2 、つまり行方向が 4 バイトずつで列方向が 2 バイトずつである。 ::

     shape = p::make_tuple(3,2);
     stride = p::make_tuple(sizeof(uint8_t)*2,sizeof(uint8_t));

組み込みの 8 ビット整数データ型に対する numpy dtype を取得する。 ::

     np::dtype dt1 = np::dtype::get_builtin<uint8_t>();

それではまず ndarray を作成し、そのまま印字してみよう。所有者と同様に、形状と飛び幅も直接渡していることに注意していただきたい。所有者については「所有者」オブジェクトを操作する必要がないため、このような書き方ができる。 ::

     np::ndarray mul_data_ex = np::from_data(mul_data, dt1,
                                             p::make_tuple(3,4),
                                             p::make_tuple(4,1),
                                             p::object());
     std::cout << "元の多次元配列 :: " << std::endl
               << p::extract<char const *>(p::str(mul_data_ex)) << std::endl;

最後に形状と飛び幅を使って新しい ndarray を作成し、非単位飛び幅を使って作成した配列を印字する。 ::

     mul_data_ex = np::from_data(mul_data, dt1, shape, stride, p::object());
     std::cout << "選択的な多次元配列 :: "<<std::endl
               << p::extract<char const *>(p::str(mul_data_ex)) << std::endl ;
   }

.. note:: 形状と飛び幅が指定する要素数が一致しない場合、:cpp:func:`from_data` メソッドは :cpp:class:`error_already_set` を投げる。
