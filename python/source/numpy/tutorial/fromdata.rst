.. cpp:namespace:: boost::python::numpy

生のポインタを使ってデータにアクセスする方法
============================================

ndarray ラッパの利点の 1 つは、同じデータを Python と C++ の両方で使え、変更が両方に反映されることである。:cpp:func:`from_data` メソッドがこれを可能にする。

これまで同様、まず必要なヘッダファイルのインクルードと名前空間の準備を行い、Python ランタイムと numpy モジュールを初期化する。 ::

   #include <boost/python/numpy.hpp>
   #include <iostream>

   namespace p = boost::python;
   namespace np = boost::python::numpy;

   int main(int argc, char **argv)
   {
     Py_Initialize();
     np::initialize();

C++ で配列を作成し、そのポインタを :cpp:func:`from_data` メソッドに渡して ndarray を作成する。 ::

     int arr[] = {1,2,3,4,5};
     np::ndarray py_array = np::from_data(arr, np::dtype::get_builtin<int>(),
                                          p::make_tuple(5),
                                          p::make_tuple(sizeof(int)),
                                          p::object());

元の C++ 配列と ndarray を印字し、同じであるかチェックする。 ::

     std::cout << "C++ array :" << std::endl;
     for (int j=0;j<4;j++)
     {
       std::cout << arr[j] << ' ';
     }
     std::cout << std::endl
               << "Python の ndarray :" << p::extract<char const *>(p::str(py_array)) << std::endl;

ここで Python の ndarray で要素 1 つを変更し、元の C++ 配列で値が変更されたかチェックする。 ::

     py_array[1] = 5 ;
     std::cout << "ndarray の作成に使用した C++ 配列に変更が反映されたか？" << std::endl;
     for (int j = 0; j < 5; j++)
     {
       std::cout << arr[j] << ' ';
     }

次に元の C++ 配列で要素 1 つを変更し、Python の ndarray に反映されたか見る。 ::

     arr[2] = 8;
     std::cout << std::endl
               << "Python の ndarray に変更が反映されたか？" << std::endl
               << p::extract<char const *>(p::str(py_array)) << std::endl;
   }

以上のように、変更はフロントエンド間で反映される。:cpp:func:`from_data` メソッドが C++ 配列を参照で渡して ndarray を作成し、データを格納するのに同じ場所を使っているため、このような結果になる。
