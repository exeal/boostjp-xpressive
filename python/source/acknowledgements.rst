謝辞
====

.. pull-quote::

   | **David Abrahams**
   | Copyright © 2006 David Abrahams
   | Distributed under the Boost Software License, Version 1.0. (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

`Dave Abrahams <http://www.boost.org/people/dave_abrahams.htm>`_ は Boost.Python のアーキテクト、設計者、実装者である。

`Brett Calcott <mailto:brett.calcott@paradise.net.nz>`_ は :program:`Visual Studio` プロジェクトファイルとドキュメントに寄与し維持している。

`Gottfried Ganßauge <mailto:Gottfried.Ganssauge-at-haufe.de>`_ は不透明なポインタの変換サポートを提供し、（私が特に依頼しなかったにもかかわらず）ドキュメントと退行テストも付けてくれた！

Joel de Guzman は\ :doc:`既定の引数サポート <reference/overloads>`\ を実装し、素晴らしい\ :doc:`tutorial`\を書いてくれた。

`Ralf W. Grosse-Kunstleve <http://www.boost.org/people/ralf_w_grosse_kunstleve.htm>`_ は :doc:`pickle サポート <reference/pickle>`\を実装し、ライブラリをその誕生から熱狂的にサポートし、設計の決定とユーザの要求に対する非常に貴重な現実世界の見識を提供してくれた。Ralf は、私がすぐにでもライブラリに取り入れたい C++ コンテナの変換を行う\ :ref:`拡張 <faq.how_can_i_wrap_functions_which_t>`\を書いた。彼はまた、Boost.Python の最初のバージョンでクロスモジュールサポートを実装した。さらに重要なのは、Ralf は大規模ソフトウェアの構築における問題を解決するための C++ と Python のほぼ完全な相乗効果が無視できないものであると確かめたことである。

`Aleksey Gurtovoy <http://www.boost.org/people/aleksey_gurtovoy.htm>`_ は驚嘆すべき C++ `テンプレートメタプログラミングライブラリ <http://www.mywikinet.com/mpl>`_\を書いた。これにより Boost.Python の大部分のコンパイル時のマジックが可能になった。加えて Aleksey はバグだらけの複数のコンパイラの癖に対する知識が深く、重大な局面で問題を回避できるよう気前よく時間をかけて助けてくれた。

`Paul Mensonides <http://www.boost.org/people/paul_mensonides.htm>`_ と `Vesa Karvonen <http://www.boost.org/people/vesa_karvonen.htm>`_ は、同様に驚くべき\ `プリプロセッサメタプログラミングライブラリ <http://www.boost.org/libs/preprocessor/>`_\を書き、それが Boost.Python で動作するよう時間と知識を使ってくれた。また Boost.Python の大部分を新しいプリプロセッサメタプログラミングツールを使うように書き直し、バグだらけで低速な C++ プリプロセッサで対応が取れるよう助けてくれた。

`Bruno da Silva de Oliveria <mailto:nicodemus-at-globalite.com.br>`_ は巧妙な `Pyste <http://www.boost.org/libs/python/pyste/>`_\（「Pie-Steh」と発音する）コード生成器を寄贈してくれた。

`Nikolay Mladenov <mailto:nickm@sitius.com>`_ は :py:meth:`!staticmethod` サポートを寄贈してくれた。

Martin Casado は、AIX の狂った動的リンクモデルに対して Boost.Python の共有ライブラリをビルド可能にするよう、厄介な問題を解決してくれた。

`Achim Domma <mailto:achim@procoders.net>`_ は\ :ref:`オブジェクトラッパ <object_wrappers>`\と、このドキュメントの HTML テンプレートを提供してくれた。Dave Hawkes は、:cpp:class:`scope` クラスを使ってモジュール定義構文を簡単にするアイデアを提供してくれた。Pearu Pearson は現在のテストスートにあるテストケースをいくつか書いてくれた。

現バージョンの Boost.Python の開発の一部は、`Lawrence Livermore National Laboratories <http://www.llnl.gov/>`_ と Lawrence Berkeley National Laboratories の `Computational Crystallography Initiative <http://cci.lbl.gov/>`_ の投資による。

`Ullrich Koethe <http://kogs-www.informatik.uni-hamburg.de/~koethe/>`_ は類似のシステムを別に開発していた。Boost.Python v1 を見つけたとき、彼は深い見識・洞察で以って Boost.Python の強化に熱心に数え切れない時間を費やしてくれた。彼は関数の多重定義サポートの初期のバージョンについて責任を果たし、C++ 継承関係のリフレクションについてのサポートを書いた。彼は C++ と Python の両方からのエラー報告強化を手伝ってくれ（v2 でも再度そうなればと思う）、多数の演算子のエクスポートに関数のオリジナルのサポートと多重定義による明示的な型変換を回避する方法を設計した。

Boost のメーリングリストと Python コミュニティのメンバーからは、早い段階から非常に貴重なフィードバックを得た。特に Ron Clarke 、Mark Evans 、Anton Gluck 、Chuck Ingold 、Prabhu Ramachandran 、Barry Scott はまだ開発の初期段階であったにもかかわらず、勇敢にも足を踏み出して Boost.Python を使ってくれた。

Boost.Python の最初のバージョンは、開発と Boost ライブラリとしてのリリースをサポートしてくれた Dragon Systems のサポートなくしてはありえなかった。
