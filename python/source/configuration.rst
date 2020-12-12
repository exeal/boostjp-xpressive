設定に関する情報
================

.. pull-quote::

   | **David Abrahams**
   | Copyright © 2002-2015 David Abrahams, Stefan Seefeld


.. _configuration.configuration:

設定
----

.. _configuration.configuraion.introduction:

はじめに
^^^^^^^^

**Boost.Python** は :file:`<boost/config.hpp>` にある数個の設定マクロのほか、アプリケーションが与える設定マクロを使用する。これらのマクロについて記載する。

.. http://www.boost.org/libs/config/config.htm


.. _configuration.configuration.application_defined_macros:

アプリケーション定義のマクロ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

これらは Boost.Python を使用するアプリケーションが定義可能なマクロである。動的ライブラリをカバーするのに C++ 標準の厳密な解釈を拡大するのであれば、異なるライブラリ（拡張モジュールや Boost.Python 自身も含む）をコンパイルするときにこれらのマクロの異なる値を使用することは :term:`ODR` 違反であることに注意していただきたい。しかしながら、この種の違反を検出可能か問題となる C++ 実装は無いようである。

.. list-table::
   :header-rows: 1

   * - マクロ
     - 既定
     - 意味
   * - :c:macro:`!BOOST_PYTHON_MAX_ARITY`
     - 15
     - 引数 :code:`x1, x2, ...xn` をとるよう指定した Boost.Python 関数の起動における、ラップする関数、メンバ関数、コンストラクタの最大\ :term:`引数長 <arity>`\。これには特に :cpp:expr:`object::operator()(...)` や :cpp:expr:`call_method<R>(...)` のようなコールバック機構も含まれる。
   * - :c:macro:`BOOST_PYTHON_MAX_BASES`
     - 10
     - ラップした C++ クラスの基底型を指定する :cpp:class:`!bases<...>` クラステンプレートのテンプレート引数の最大数。
   * - :c:macro:`BOOST_PYTHON_STATIC_MODULE`
     - （未定義）
     - 定義すると、モジュール初期化関数がエクスポート対象シンボルとして扱われないようになる（コード内での区別をサポートするプラットフォームの場合）。
   * - :c:macro:`BOOST_PYTHON_ENABLE_CDECL`
     - （未定義）
     - 定義すると、:cpp:expr:`__cdecl` 呼び出し規約を使用する関数のラップが可能となる。
   * - :c:macro:`BOOST_PYTHON_ENABLE_STDCALL`
     - （未定義）
     - 定義すると、:cpp:expr:`__stdcall` 呼び出し規約を使用する関数のラップが可能となる。
   * - :c:macro:`BOOST_PYTHON_ENABLE_FASTCALL`
     - （未定義）
     - 定義すると、:cpp:expr:`__fastcall` 呼び出し規約を使用する関数のラップが可能となる。


.. _configuration.configuration.lib-defined-impl:

ライブラリ定義の実装マクロ
^^^^^^^^^^^^^^^^^^^^^^^^^^

これらのマクロは Boost.Python が定義するものであり、新しいプラットフォームへ移植する実装者のみが取り扱う実装の詳細である。

.. list-table::
   :header-rows: 1

   * - マクロ
     - 既定
     - 意味
   * - :c:macro:`BOOST_PYTHON_TYPE_ID_NAME`
     - （未定義）
     - 定義すると、共有ライブラリ境界をまたいだ :cpp:class:`!type_info` の比較がこのプラットフォームでは動作しないことを指定する。言い換えると、shared-lib-2 内の :cpp:expr:`typeid(T)` を比較する関数に shared-lib-1 が :cpp:expr:`typeid(T)` を渡すと、比較結果は ``false`` になるということである。このマクロを定義しておくと、Boost.Python は :cpp:class:`!std::type_info` オブジェクトの比較を直接使用する代わりに :cpp:expr:`typeid(T).name()` の比較を使用する。
   * - :c:macro:`BOOST_PYTHON_NO_PY_SIGNATURES`
     - （未定義）
     - 定義すると、モジュール関数のドキュメンテーション文字列に対して Python のシグニチャが生成されなくなり、モジュールが登録した変換器に Python 型が紐付かなくなる。また、モジュールのバイナリサイズが約 14%（gcc でコンパイルした場合）削減する。boost_python 実行時ライブラリで定義すると、:cpp:expr:`docstring_options.enable_py_signatures()` の既定は ``false`` に設定される。
   * - :c:macro:`BOOST_PYTHON_SUPPORTS_PY_SIGNATURES`
     - :c:macro:`BOOST_PYTHON_NO_PY_SIGNATURES` を定義していないと定義される
     - このマクロを定義すると、Python のシグニチャをサポートしない古いバージョンの Boost.Python からのスムースな移行が有効になる。使用例は\ :ref:`ここ <v2.pytype_function.examples>`\を見よ。
   * - :c:macro:`BOOST_PYTHON_PY_SIGNATURES_PROPER_INIT_SELF_TYPE`
     - （未定義）
     - 定義すると、:py:meth:`__init__` メソッドの :py:obj:`!self` 引数の Python 型を適切に生成する。それ以外の場合、:py:class:`!object` を使用する。モジュールのバイナリサイズが約 14%（gcc でコンパイルした場合）増加するため、既定では定義されない。
