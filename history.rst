付録 1：履歴 [#]_
-----------------

Boost 1.55.0（2013 年 11 月 11 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* 不完全な文字集合について assert ではなく例外を投げるようにした（チケット `#8843 <https://svn.boost.org/trac/boost/ticket/8843>`_\）。
* 未使用のローカルな typedef を削除した（チケット `#8880 <https://svn.boost.org/trac/boost/ticket/8880>`_\）。
* :file:`sequence_stack.hpp` で try/catch の代わりに RAII を使用するようにした（チケット `#8882 <https://svn.boost.org/trac/boost/ticket/8882>`_\）。
* clang の :option:`!-Wimplicit-fallthrough` 診断が正しく動作するようにした（チケット `#8474 <https://svn.boost.org/trac/boost/ticket/8474>`_\）。


Boost 1.54.0（2013 年 7 月 1 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* 未使用の変数を削除した。チケット `#8039 <https://svn.boost.org/trac/boost/ticket/8039>`_ を修正した。
* glx.h のマクロ None と名前が衝突していたのを回避した。チケット `#8204 <https://svn.boost.org/trac/boost/ticket/8204>`_ を修正した。
* gcc で出ていた警告に対応した。チケット `#8138 <https://svn.boost.org/trac/boost/ticket/8138>`_ を修正した。


Boost 1.53.0（2013 年 2 月 4 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* 最近の Boost 版スマートポイントの変更に対応した。チケット `#7809 <https://svn.boost.org/trac/boost/ticket/7809>`_ を修正した。


Boost 1.52.0（2012 年 11 月 5 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* sub_match で Boost.Range が使えるようにした。チケット `#7237 <https://svn.boost.org/trac/boost/ticket/7237>`_ を修正した。


Boost 1.50.0（2012 年 6 月 28 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* たちの悪い lexical_cast ハックを幾分マシなものにした。
* C++11 で問題になる MPL の assert を static assert に置き換えた。チケット `#6864 <https://svn.boost.org/trac/boost/ticket/6846>`_ を修正した。


Boost 1.49.0（2012 年 2 月 24 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* gcc で未使用として警告が出ていた変数を削除した。


Boost 1.45.0（2010 年 11 月 19 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* :cpp:func:`xpressive::as` がワイド文字版の :cpp:struct:`sub_match` オブジェクトを処理できなかったバグを修正（チケット `#4496 <https://svn.boost.org/trac/boost/ticket/4496>`_\）。


Boost 1.44.0（2010 年 8 月 13 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* :cpp:func:`nested_results` における、:code:`typedef` を使った移植性のない :code:`using` ディレクティブを置き換えた。
* 非ローカル変数に対するプレースホルダを使ったユーザー定義表明をサポートした。


Boost 1.43.0（2010 年 5 月 6 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* :file:`<boost/xpressive/regex_error.hpp>` へのインクルードが欠けていたのを修正。


Boost 1.42.0（2010 年 2 月 2 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* :cpp:struct:`match_results` を :cpp:class:`!std::list` の未定義の動作に依存しないようにした（チケット `#3278 <https://svn.boost.org/trac/boost/ticket/3278>`_\）。
* 「既定コンストラクタで構築したイテレータをコピーしてはならない。」（チケット `#3538 <https://svn.boost.org/trac/boost/ticket/3538>`_\）
* GCC および Darwin で警告が出ないようにした（チケット `#3734 <https://svn.boost.org/trac/boost/ticket/3734>`_\）。


Boost 1.41.0（2009 年 11 月 17 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* :regexp:`\\Q` ～ :regexp:`\\E` 引用メタを使用した場合に無限ループする場合があるバグを修正（チケット `#3586 <https://svn.boost.org/trac/boost/ticket/3586>`_\）。
* MSVC で到達不能コードの警告を出ないようにした。
* MSVC で :option:`!/Za`\（「言語拡張を無効にする」）モードにした場合に発生する警告とエラーを解決した。
* 様々なコンパイラの C++0x モードに関するバグを修正した。


Boost 1.40.0（2009 年 8 月 27 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Visual C++ 10.0 で動作するようになった（チケット `#3124 <https://svn.boost.org/trac/boost/ticket/3124>`_\）。


Boost 1.39.0（2009 年 5 月 2 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* GCC の最適化で純粋仮想関数呼び出しによる実行時エラーが発生する問題（チケット `#2655 <https://svn.boost.org/trac/boost/ticket/2655>`_\）の回避策を追加。


Boost 1.38.0（2009 年 2 月 8 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* :cpp:struct:`std::basic_regex` との互換性のために、:cpp:struct:`basic_regex` に入れ子の :cpp:type:`syntax_option_flags` と :cpp:type:`value_type` 型定義を追加。
* Proto v4 への移植。:file:`boost/xpressive/proto` にあった Proto v2 は削除した。
* :cpp:struct:`regex_error` を :cpp:class:`!boost::exception` から継承するようにした。


バージョン 2.1.0（2008 年 6 月 12 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

新機能
~~~~~~

* 静的正規表現に :cpp:func:`skip()` プリミティブを追加。入力文字列内の、正規表現マッチ中に無視する部分を指定できる。
* :cpp:func:`regex_replace()` アルゴリズムの範囲ベースのインターフェイス。
* :cpp:func:`regex_replace()` が書式化文字列に加えて、書式化オブジェクトと書式化ラムダ式を受け付けるようになった。


バグ修正
~~~~~~~~

* 前方先読み、後方先読み、独立部分式における意味アクションがクラッシュせず、積極実行されるようになった。


バージョン 2.0.1（2007 年 10 月 23 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

バグ修正
~~~~~~~~

* :cpp:struct:`sub_match\<>` コンストラクタが、既定コンストラクタで構築したイテレータをコピーするとデバッグ表明にヒットする。


バージョン 2.0.0（2007 年 10 月 12 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

新機能
~~~~~~

* 意味アクション。
* カスタムの表明。
* 名前付き捕捉
* 動的正規表現文法。
* :regexp:`(?R)` 構造による動的再帰正規表現。
* 非文字データ検索のサポート。
* 不正な静的正規表現に対するエラーを改善した。
* 正規表現アルゴリズムの範囲ベースのインターフェイス。
* :cpp:enumerator:`regex_constants::match_flag_type::format_perl` 、:cpp:enumerator:`regex_constants::match_flag_type::format_sed` および :cpp:enumerator:`regex_constants::match_flag_type::format_all`\。
* :cpp:func:`!operator+(std::string, sub_match\<>)` とその変種。
* バージョン 2。このバージョンの正規表現特性は :cpp:func:`~cpp_regex_traits::tolower()` と :cpp:func:`~cpp_regex_traits::toupper()` をもつ。


バグ修正
~~~~~~~~

:regexp:`~(set='a')` のような 1 文字の否定が動作するようになった。


バージョン 1.0.2（2007 年 4 月 27 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

バグ修正
~~~~~~~~

* 事前の予告どおり、10 番目以降の後方参照が動作するようになった。

このバージョンは Boost 1.34 とともにリリースされた。


バージョン 1.0.1（2006 年 10 月 2 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

バグ修正
~~~~~~~~

* :cpp:func:`match_results::position()` が入れ子の結果に対して動作するようになった。


バージョン 1.0.0（2006 年 3 月 16 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

バージョン 1.0！


バージョン 0.9.6（2005 年 6 月 19 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Boost の受理に向けてレビューされたバージョン。レビューが始まったのは 2005 年 11 月 8 日。2005 年 11 月 28 日、xpressive は Boost に受理された。


バージョン 0.9.3（2005 年 6 月 30 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

新機能
~~~~~~

* TR1 形式の :cpp:struct:`regex_traits` インターフェイス。
* 高速化。
* :cpp:enumerator:`regex_constants::syntax_option_type::ignore_white_space`\。


バージョン 0.9.0（2004 年 9 月 2 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

新機能
~~~~~~

* いろいろ。


バージョン 0.0.1（2003 年 11 月 16 日）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

xpressive のアナウンス：http://lists.boost.org/Archives/boost/2003/11/56312.php


.. [#] 訳注　原文ではバージョン 2.1.0 までしか記述がありませんが、翻訳版では Boost のリリースノートから以降の履歴を抜粋しました。2.1.0 が Boost 1.36（2008 年 8 月 14 日）に相当します。

