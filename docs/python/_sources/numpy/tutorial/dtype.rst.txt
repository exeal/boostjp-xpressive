dtypes の使い方
===============

Python の組み込みのデータ型を用いた ndarray の作成、およびメンバ変数の型と値を抽出する方法について簡単なチュートリアルで説明する。

前回同様、numpy コンポーネントに必要なヘッダと名前空間を準備し、Python のランタイムと numpy モジュールを初期化する。 ::

   #include <boost/python/numpy.hpp>
   #include <iostream>

   namespace p = boost::python;
   namespace np = boost::python::numpy;

   int main(int argc, char **argv)
   {
     Py_Initialize();
     np::initialize();

次に形状と dtype を作成する。:cpp:func:`!get_builtin` メソッドを使って組み込みの C++ dtype に対応する numpy の dtype を取得する。以下はサイズとして (3,3) のタプルを、データ型として :cpp:type:`!double` を渡して 3×3 の配列を作成している。 ::

     p::tuple shape = p::make_tuple(3, 3);
     np::dtype dtype = np::dtype::get_builtin<double>();
     np::ndarray a = np::zeros(shape, dtype);

最後に :cpp:member:`!python` 名前空間の :cpp:func:`!extract` メソッドを使えば配列を印字できる。始めに変数を文字列に変換し、次に <char const * > テンプレートを使って Python の文字列から C++ の文字配列として抽出する。 ::

     std::cout << "元の配列：\n" << p::extract<char const *>(p::str(a)) << std::endl;

:cpp:class:`!ndarray` の :cpp:func:`!get_dtype` メソッドを使って ndarray のデータメンバの dtype を印字できる。 ::

     std::cout << "datatype は：\n" << p::extract<char const *>(p::str(a.get_dtype())) << std::endl ;

カスタムの dtype を作成して ndarray を構築することもできる。

カスタムの dtype を作成するには :cpp:class:`!dtype` のコンストラクタを使う。このコンストラクタはリストを引数にとる。

このリストは、形式（変数の名前と型）を表すタプルを 1 つ以上含まなければならない。

そこでカスタムの dtype を作成するのに、始めに変数の名前と型（ここでは :cpp:type:`!double`）でタプルを作成する。 ::

     p::tuple for_custom_dtype = p::make_tuple("ha",dtype) ;

次にリストを作成し、タプルをリストに追加する。そしてリストを使ってカスタムの dtype を作成する。 ::

     p::list list_for_dtype ;
     list_for_dtype.append(for_custom_dtype) ;
     np::dtype custom_dtype = np::dtype(list_for_dtype) ;

これで :cpp:var:`!shape` で指定した次元とカスタムの dtype をもつ ndarray を作成する準備が整った。 ::

     np::ndarray new_array = np::zeros(shape,custom_dtype);
   }
