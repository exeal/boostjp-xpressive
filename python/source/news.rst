新着情報・変更履歴
==================

.. pull-quote::

   | **David Abrahams**
   | Copyright © 2006 David Abrahams
   | Distributed under the Boost Software License, Version 1.0. (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

現在の SVN
----------

* Python 3 のサポート

  * 現時点の Boost.Python テストはすべてパスした。Boost.Python を使用している拡張モジュールはスムースに Python 3 をサポートすると考えてよい。
  * :cpp:func:`!object.contains` を導入した（:cpp:expr:`!x.contains(y)` は Python の :code:`y in x` と等価である）。:cpp:func:`!dict.has_key` は :cpp:func:`!object.contains` のラッパに過ぎない。
  * Python 3 に対してビルドすると、:cpp:func:`!str.decode` は削除される。
  * Python 3 に対してビルドすると、:cpp:func:`!list.sort` の元のシグニチャが次のとおりだったのが ::

       void sort(object_cref cmpfunc);

    次のように変更となる。 ::

       void sort(args_proxy const &args, kwds_proxy const &kwds);

    これは Python 3 において :cpp:func:`!list.sort` がすべての引数がキーワード引数であることを要求するからである。よって呼び出しは次のようにしなければならない。 ::

       x.sort(*tuple(), **dict(make_tuple(make_tuple("reverse", true))));

    `PEP3123 <http://www.python.org/dev/peps/pep-3123/>`_ に従い、2.6 より前の Python に対して Boost.Python をビルドすると、Boost.Python のヘッダで以下のマクロが定義される。 ::

       # define Py_TYPE(o)    (((PyObject*)(o))->ob_type)
       # define Py_REFCNT(o)  (((PyObject*)(o))->ob_refcnt)
       # define Py_SIZE(o)    (((PyVarObject*)(o))->ob_size)

    よって拡張の作成者はこれらのマクロを直接使用して、コードを簡潔かつ Python 3 と互換にできる。


1.39.0 リリース
---------------

* Python のシグニチャが自動的にドキュメンテーション文字列に結合されるようになった。
* ドキュメンテーション文字列の内容を制御するには :doc:`reference/docstring_options` ヘッダを使用せよ。
* この新機能によりモジュールのサイズが約 14% 増加する。これが許容できない場合は、マクロ :c:macro:`!BOOST_PYTHON_NO_PY_SIGNATURES` を定義することで無効化できる。このマクロを定義してコンパイルしたモジュールとそうでないモジュールは互換性がある。
* :c:macro:`!BOOST_PYTHON_NO_PY_SIGNATURES` が定義されていない場合、現行のバージョンではマクロ :c:macro:`!BOOST_PYTHON_SUPPORTS_PY_SIGNATURES` が定義される。これにより以前のバージョンの Boost.Python でコンパイルする可能性のあるコードが記述できる（:ref:`ここ <v2.pytype_function.examples>`\を見よ）。
* :c:macro:`!BOOST_PYTHON_PY_SIGNATURES_PROPER_INIT_SELF_TYPE` を定義すると（サイズが 14% 増加するが）、:py:meth:`!__init__` メソッドの :py:obj:`!self` 引数に対して適切な Python 型が生成される。
* この新機能をサポートするために :doc:`reference/to_python_converter` 、:cpp:class:`default_call_policies` 、:ref:`concepts.resultconverter`\、:ref:`concepts.callpolicies`\等に変更が入った。これらはインターフェイスを破壊するような変更にならないようにした。


1.34.0 リリース（2007 年 5 月 12 日）
-------------------------------------

* C++ のシグニチャが自動的にドキュメンテーション文字列に結合されるようになった。
* ドキュメンテーション文字列の内容を制御する :doc:`reference/docstring_options` ヘッダを新規に追加した。
* 戻り値ポリシーである :doc:`opaque_pointer_converter <reference/opaque_pointer_converter>` による :cpp:type:`!void*` と Python の相互変換をサポートした。初期のパッチについて Niall Douglas に感謝する。


1.33.1 リリース（2005 年 10 月 19 日）
--------------------------------------

* :cpp:class:`!wrapper<T>` が :samp:`{some-smart-pointer}`\ :code:`<T>` の保持型とともに使用できるようになった。
* ビルドで想定する既定の Python のバージョンを 2.2 から 2.4 に変更した。
* Unicode サポートなしでビルドした Python をサポートした。
* アドレス（``&``）演算子を多重定義したクラスのラップをサポートした。


1.33 リリース（2005 年 8 月 14 日）
-----------------------------------

* 非静的プロパティのドキュメンテーション文字列をサポートした。
* :cpp:class:`!init<optional<> >` および :c:macro:`!XXX_FUNCTION_OVERLOADS()` の最後の多重定義に対してのみクライアントが提供したドキュメンテーション文字列をエクスポートするようにした。
* 組み込み :program:`VC++ 4` のサポートをいくつか修正した。
* :cpp:class:`!shared_ptr` の Python から rvalue への変換のサポートを強化した。所有する Python オブジェクトが正しい型の NULL の :cpp:class:`!shared_ptr` を持た\ **ない限り**\、常に Python オブジェクトを保持するポインタを返す。
* indexing suite を用いた :cpp:class:`!vector<T>` のエクスポートをサポートした。
* MacOS における :program:`GCC-3.3` をサポートした。
* :program:`Visual Studio` のプロジェクトビルドファイルを更新し、新しく 2 つのファイル（:file:`slice.cpp` および :file:`wrapper.cpp`）を追加した。
* 索引のページに検索機能を追加した。
* チュートリアルを大幅に修正した。
* :program:`MSVC` 6 および 7 、:program:`GCC` 2.96 、:program:`EDG` 2.45 のバグ回避コードを大量に追加した。


2005 年 3 月 11 日
------------------

間抜けな PyDoc が Boost.Python で動作するようハックを追加した。Nick Rasmussen に感謝する。


1.32 リリース（2004 年 11 月 19 日）
------------------------------------

* Boost Software Licese を使用するよう更新した。
* :ref:`仮想関数を持つクラスをラップするより優れた方法 <tutorial.exposing.class_virtual_functions>`\を新規に実装した。
* 次期 :program:`GCC` のシンボルエクスポート制御機能のサポートを取り込んだ。Niall Douglas に感謝する。
* :cpp:class:`!std::auto_ptr` ライクな型のサポートを改良した。
* 関数引数型のトップレベル CV 指定子が関数型の一部分となる :program:`Visual C++` のバグを回避した。
* 依存関係改善のため、他のライブラリが使用するコンポーネントを :file:`python/detail` 外部、:file:`boost/detail` へ移動した。
* その他のバグ修正とコンパイラバグの回避。


2004 年 9 月 8 日
-----------------

Python の :py:class:`!Bool` 型をサポートした。`Daniel Holth <mailto:dholth-at-fastmail.fm>`_ に感謝する。


2003 年 9 月 11 日
------------------

* 同じ型に対して複数の to-python 変換器を登録したときに出るエラーを警告に変えた。Boost.Python はメッセージ内に不愉快な型を報告するようになった。
* 組み込みの :cpp:type:`!std::wstring` 変換を追加した。
* :cpp:class:`!std::out_of_range` から Python の :py:exc:`!IndexError` 例外への変換を追加した。\ `Raoul Gough <mailto:RaoulGough-at-yahoo.co.uk>`_ に感謝する。


2003 年 9 月 9 日
-----------------

:cpp:class:`str` に文字の範囲をとる新しいコンストラクタを追加し、ヌル（``'\0'``）文字を含む文字列を受け付けるようになった。


2003 年 9 月 8 日
-----------------

（:cpp:expr:`operator()` を持つ）関数オブジェクトからメソッドを作成する機能を追加した。詳細は :cpp:func:`make_function` のドキュメントを見よ。


2003 年 8 月 10 日
------------------

`Roman Yakovenko <mailto:romany-at-actimize.com>`_ による新しい :cpp:member:`!properties` 単体テストを追加し、彼の依頼で :cpp:func:`!add_static_property` のドキュメントを追加した。


2003 年 8 月 1 日
-----------------

`Nikolay Mladenov`_ による新しい :cpp:class:`!arg` クラスを追加した。このクラスは、途中の引数を省略して呼び出せる関数をラップする機能を提供する。 ::

   void f(int x = 0, double y = 3.14, std::string z = std::string("foo"));

   BOOST_PYTHON_MODULE(test)
   {
      def("f", f
          , (arg("x", 0), arg("y", 3.14), arg("z", "foo")));
   }

Python 側は次のようにできる。

.. code-block:: python

   >>> import test
   >>> f(0, z = "bar")
   >>> f(z = "bar", y = 0.0)

Nikolay に感謝する。


2003 年 7 月 22 日
------------------

恐怖のエラー「bad argument type for builtin operation」が出ないようにした。引数エラーで実際の型と想定していた型を表示するようになった。


2003 年 7 月 19 日
------------------

`Nikolay Mladenov`_ による新しい :cpp:struct:`!return_arg` ポリシーを追加した。Nikolay に感謝する。


2003 年 3 月 18 日
------------------

* `Gottfried Ganßauge <mailto:Gottfried.Ganssauge-at-haufe.de>`_ が\ :doc:`不透明ポインタのサポート <reference/opaque_pointer_converter>`\を提供してくれた。
* `Bruno da Silva de Oliveira <mailto:nicodemus-at-globalite.com.br>`_ が素晴らしい `Pyste <http://www.boost.org/libs/python/pyste/>`_\（「Pie-steh」と発音する）パッケージを提供してくれた。


2003 年 2 月 24 日
------------------

:cpp:class:`!boost::shared_ptr` のサポート強化が完了した。C++ クラス :cpp:class:`!X` をラップしたオブジェクトが、ラップの方法に関わらず自動的に :cpp:class:`!shared_ptr<X>` に変換可能になった。:cpp:class:`!shared_ptr` は :cpp:class:`!X` オブジェクトだけではなく :cpp:class:`!X` を与える Python オブジェクトの寿命を管理し、また逆に :cpp:class:`!shared_ptr` を Python に変換するときは元の Python オブジェクトを返す。


2003 年 1 月 19 日
------------------

`Nikolay Mladenov`_ による :py:func:`!staticmethod` サポートを統合した。Nikolay に感謝する。


2002 年 12 月 29 日
-------------------

Brett Calcott による :program:`Visual Studio` のプロジェクトファイルと説明を追加した。Brett に感謝する。


2002 年 12 月 20 日
-------------------

Python への変換において、多態的なクラス型へのポインタ、参照、スマートポインタの自動的なダウンキャストを追加した。


2002 年 12 月 18 日
-------------------

各拡張モジュールの各クラスについて個別の変換器を登録する代わりに、共有ライブラリに変換ロジックを配置することにより、from_python 変換を最適化した。


2002 年 12 月 13 日
-------------------

* :cpp:class:`enum_` 値の :cpp:class:`scope` 内へのエクスポートが可能になった。
* :cpp:type:`!signed long` の範囲外の数値を正しく扱うよう、符号無し整数の変換を修正した。


2002 年 11 月 19 日
-------------------

基底クラスメンバ関数ポインタを :cpp:func:`class_::add_property` の引数として使用するときにキャストを不要にした。


2002 年 11 月 14 日
-------------------

:cpp:func:`make_getter` でラップしたクラスデータメンバの自動検出。


2002 年 11 月 13 日
-------------------

:cpp:class:`!std::auto_ptr<>` の完全なサポートを追加した。


2002 年 10 月
-------------

チュートリアルドキュメントの更新と改良。


2002 年 10 月 10 日
-------------------

Boost.Python バージョン 2 をリリース！


.. _Nikolay Mladenov: mailto:nickm-at-sitius.com
