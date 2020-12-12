Boost.Python（日本語訳）
========================

.. pull-quote::

   | **David Abrahams**
   | **Stefan Seefeld**
   | Copyright © 2002-2015 David Abrahams, Stefan Seefeld
   | Distributed under the Boost Software License, Version 1.0. (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

.. note::

   .. rubric:: 翻訳にあたって

   * 本書は `Boost.Python ドキュメント <http://www.boost.org/libs/python/doc/>`_\の日本語訳です。原文書のバージョンは翻訳時の最新である 1.70.0 です。
   * 原文の誤りは修正したうえで翻訳しました。
   * 外部文書の表題等は英語のままにしてあります。
   * Python のサイトへのリンクは可能な限り日本語サイトへ変更しました。
   * 原文に含まれているローカルファイルへのハイパーリンクは削除したか、Boost のサイトへのリンクに変更しました。
   * ファイル名、ディレクトリ名は :file:`pathname` のように記します。
   * その他、読みやすくするためにいくつか書式の変更があります。
   * 翻訳の誤り等は `exeal <http://twitter.com/exeal>`_ に連絡ください。


.. _synopsis:

概要
----

Boost.Python へようこそ。Boost.Python は、C++ と `Python <http://www.python.jp/>`_ プログラミング言語間のシームレスな相互運用を可能にする C++ ライブラリである。以下の項目をサポートする：

* 参照とポインタ
* 大域に登録した型変換
* モジュール間の自動的な型変換
* 効率的な関数多重定義
* C++ 例外の Python への変換
* 既定の引数
* キーワード引数
* C++ における Python オブジェクトの操作
* C++ のイテレータを Python のイテレータとしてエクスポート
* ドキュメンテーション文字列

これらの機能の開発は、``Boost Consulting`` に対する `Lawrence Livemore National Laboratories <http://www.llnl.gov/>`_ の一部助成と、Lawrence Berkeley National Laboratories の `Computational Crystallography Initiative <http://cci.lbl.gov/>`_ に提供を受けた。

.. toctree::
   :caption: 目次
   :titlesonly:

   release_notes
   tutorial
   building
   reference
   configuration
   glossary
   support
   faq
   numpy/index

.. note::

   .. rubric:: 訳注

   本日本語訳は http://www.boost.org/libs/python/ を原文としていますが、現在の原文は http://boostorg.github.io/python/doc/html/ へ管理が移行しています。以下はこの過程で削除された記事の日本語訳です。

   .. toctree::
      :maxdepth: 1

      platforms
      projects

   * `Py++ Boost.Python コード生成器 <http://www.language-binding.net/pyplusplus/pyplusplus.html>`_
   * `Pyste Boost.Python コード生成器 <http://www.boost.org/libs/python/pyste/>`_

   .. toctree::
      :maxdepth: 1

      internals
      news
      todo
      progress_reports
      acknowledgements


.. _articles:

記事
----

Dave Abrahams と Ralf W. Grosse-Kunstleve による『`Building Hybrid Systems With Boost Python <http://boostorg.github.io/python/doc/html/article.html>`_\』。

.. 未訳
