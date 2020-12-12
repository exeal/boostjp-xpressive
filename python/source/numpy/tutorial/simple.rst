配列における単純なチュートリアル
================================

配列を作成、変更する単純なチュートリアルから始めよう。

numpy コンポーネントに必要なヘッダと名前空間を準備する。 ::

   #include <boost/python/numpy.hpp>
   #include <iostream>

   namespace p = boost::python;
   namespace np = boost::python::numpy;

Python のランタイムと numpy モジュールを初期化する。これらの呼び出しに失敗すると、セグメントエラーとなる。 ::

   int main(int argc, char **argv)
   {
     Py_Initialize();
     np::initialize();

配列の形状、データ型を引数として使用して、n 次元のゼロ埋めされた配列を作成できる。以下は、形状が 3×3 でデータ型が組み込みの浮動小数点数型である。 ::

     p::tuple shape = p::make_tuple(3, 3);
     np::dtype dtype = np::dtype::get_builtin<float>();
     np::ndarray a = np::zeros(shape, dtype);

また、次のようにして空の配列を作成できる。 ::

     np::ndarray b = np::empty(shape,dtype);

元の配列と変形した配列を印字する。リストである配列 :cpp:var:`!a` をまず文字列に変換し、リストの各値を :cpp:struct:`extract\<>` を使って抽出する。 ::

     std::cout << "元の配列：\n" << p::extract<char const *>(p::str(a)) << std::endl;

     // 配列を 1 次元に変形する
     a = a.reshape(p::make_tuple(9));
     // 再度印字する
     std::cout << "変形後の配列：\n" << p::extract<char const *>(p::str(a)) << std::endl;
   }
