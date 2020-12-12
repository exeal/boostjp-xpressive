Boost.Python を使用しているプロジェクト
=======================================

.. pull-quote::

   | **David Abrahams**
   | Copyright © 2006 David Abrahams
   | Distributed under the Boost Software License, Version 1.0. (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

はじめに
--------

これは Boost.Python を使用しているプロジェクトの部分的なリストである。あなたが Python/C++ バインディングに Boost.Python を使用しているのであれば、このページにあなたのプロジェクトを追加をさせていただきたい。プロジェクトの短い説明と Boost.Python を使用して解決した問題について\ `投稿して <mailto:c++-sig@python.org>`_\もらえれば、このページに追加しよう。


データ解析
----------

`NeuraLab <http://www.neuralynx.com/>`_
   NeuraLab は、`Neuralynx <http://www.neuralynx.com/>`_ acquisition systems による神経データに特化したデータ解析環境である。Neuralab はプレゼンテーション水準のグラフィクス、数値解析ライブラリおよび `Python <http://www.python.jp/>`_ スクリプトエンジンを 1 つのアプリケーションにまとめたものである。Neuralab を使用すると、Neuralynx のユーザはマウスを数回クリックするだけで一般的な解析ができる。上級ユーザはカスタムの Python スクリプトを作成でき、必要があればメニューに割り当てられる。

TSLib – `Fortress Investment Group LLC <http://www.fortressinv.com/>`_
   Fortress Investment Group は、C++ による内部財務解析ツールの開発と Boost.Python によるそれらの Python バインディングの整備のために `Boost Consulting <http://www.boost-consulting.com/>`_ と契約した。

   Fortress の Tom Barket はこう書いている：

      私たちには財務と経済の調査に特化した巨大な C++ の解析ライブラリがある。速度と業務上枢要な安定性を主眼に構築した。一方で Python は、新しいアイデアをすばやく試してみたり、C++ の場合より生産性を向上させる柔軟性を与えてくれる。Python を際立たせる重要な機能がいくつもある。その優雅さ、安定性、Web における資源の幅広さはすべて貴重なものであるが、最も重要なものはオープンソースの透明性がもたらす拡張性である。Boost.Python は Python の多大なパワーと制御を維持しながら、同時にその拡張性を極限まで単純で直感的にする。


教育
----

`Kig <http://edu.kde.org/kig>`_
   KDE Interactive Geometry は、KDE デスクトップ向けに構築されたハイスクールレベルの教育ツールである。学生が幾何学的な構造を扱うのによいツールである。この種のアプリケーションで最も直感的かつ機能が豊富なものといえる。

   0.6.x 以降のバージョンではユーザが Python 言語内で構築したオブジェクトをサポートする（予定である）。関連する内部 API のエクスポートに Boost.Python を使用することで、それらの処理が非常に簡単になっている。


エンタープライズ
   `OpenWBEM <http://openwbem.sourceforge.net/>`_
      OpenWBEM プロジェクトは商用・非商用アプリケーション向けの Web Based Enterprise Management のオープンソース実装を開発している。

      `Dan Nuffer <mailto:dnuffer@sco.com>`_ はこう書いている：

         OpenWBEM のクライアント API をラップするのに Boost.Python を使っている。WBEMを使用する管理ソリューションを開発するときに、高速なプロトタイピング、テスト、スクリプティングが可能になった。

   `Metafaq <http://www.transversal.com/>`_
      `Transversal, Inc. <http://www.transversal.com/>`_ による Metafaq は、企業レベルのオンラインナレッジベース管理システムである。

      `Ben Young <mailto:ben.young-at-transversal.com>`_ はこう書いている：

         複数のバックエンドとフロントエンドを介してエクスポートする API に対して、Python バインディングを生成する自動処理に Boost.Python を使用している。おかげで完全なコンパイルサイクルに入ることなく、簡単なテストや一度限りのスクリプトを書けるようになった。


ゲーム
------

Civilization IV
   「Sid Meier の Civilization IV は売り上げ 5 百万部以上の PC 戦略シリーズの 4 作目です。壮観な新規 3D グラフィクスと完全に新しい 1 人・多人数コンテンツを備え、フランチャイズに向け大きく前進しました。また Civilization IV ではプレイヤー自身が Python や XML でアドオンを作成でき、ユーザ変更の新基準を打ち立てます。

   Sid Meier の Civilization IV は 2005 年の暮れ、PC 向けにリリース予定です。http://www.firaxis.com にお越しいただくか、mailto:kgilmore@firaxis.com までお問い合わせください。」

      C++ のゲームコードと Python 間のインターフェイス層で Boost.Python を使用している。マップの生成、インターフェイススクリーン、ゲームのイベント、ツール、チュートリアル等の多くの目的で Python を使用している。ゲームをカスタマイズする必要のある MOD 製作者に対して、最高水準のゲーム操作をエクスポートしている。

      -- Mustafa Thamer（Civ4 メインプログラマ）

   Vega Strike
      Vega Strike は、広大な宇宙空間でトレードや賞金稼ぎをする3次元空間シミュレータである。プレイヤーは海賊や異星人に遭遇し、危険に直面しながら様々な決定を下していく。

      Vega Strike ではスクリプト機能に Python を使うことに決め、Python のクラス階層と C++ のクラス階層の橋渡しに Boost を使用した。その結果、ミッションの設計と AI の記述時に、ユニットをネイティブな Python のクラスとして扱う非常に柔軟なスクリプトシステムが完成した。

      現在、巨大な経済・惑星シミュレーションが現在 Python 内のバックグランドで走り、その結果はプレイヤーが近くにいる場合に Python 内で接近してシミュレートされた世界の近くで現れる様々なグループの宇宙船の形で C++ に戻される。

      .. イミフ。原文は：“A large economic and planetary simulation is currently being run in the background in python and the results are returned back into C++ in the form of various factions' spaceships appearing near worlds that they are simulated to be near in python if the player is in the general neighborhood.”


グラフィックス
   `OpenSceneGraph Bindings <http://sourceforge.net/projects/pyosg>`_
      `Gideon May <mailto:gideon@computer.org>`_ は、クロスプラットフォームの C++/OpenGL リアルタイム可視化ライブラリである `OpenSceneGraph <http://www.openscenegraph.org/>`_ に対するバインディングを作成した。

   `HippoDraw <http://www.slac.stanford.edu/grp/ek/hippodraw/index.html>`_
      HippoDraw は、ヒストグラムや散布図等を描画するキャンバスで構成されたデータ解析環境である。高度に対話的な GUI を有するが、場合によってはスクリプトを用意しなければならない。HippoDraw は Python の拡張モジュールとして動作させることで、あらゆる操作を Python と GUI の両方から実行できる。

      Web ページがオンラインになる以前、`Paul F. Kunz <mailto:Paul_Kunz@SLAC.Stanford.EDU>`_ はこう書いている：

         プロジェクトのために Web ページを用意すべきではないが、組織のページは http://www.slac.stanford.edu\（アメリカ最初の Web サーバサイト）である。

         .. “the first web server site in America, I installed it”

      とても面白い雑学だったので載せることにした。

   `IPLT <http://www.iplt.org/>`_
      `Ansgar Philippsen <mailto:ansgar.philippsen-at-unibas.ch>`_ はこう書いている：

         IPLT はイメージ処理ライブラリであり、構造生物学・電子顕微鏡コミュニティのツールボックスである。今のところ製品化の段階ではないが活発に開発が進んでおり、私の中では新進気鋭のプロジェクトである。Python はメインのスクリプティング・対話水準で使用しているが、背後の C++ クラスライブラリが Boost.Python により（少なくとも高水準インターフェイスは）完全にエクスポートされているため、高速なプロトタイピングにも使用している。このプロジェクトにおける C++ と Python の組み合わせは素晴らしいとしか言いようがない。

   `PythonMagick <http://www.procoders.net/pythonmagick>`_
      PythonMagick は、`GraphicsMagick <http://www.graphicsmagick.org/>`_ イメージ操作ライブラリの Python に対するバインディングである。

   `VPython <http://www.vpython.org/>`_
       `Bruce Sherwood <mailto:Bruce_Sherwood-at-ncsu.edu>`_ はこう書いている：

          VPython は操縦可能な 3D アニメーションを簡単に作成できる Python 拡張である。計算コードの副作用として生成される。VPython は物理やプログラミングの授業といった教育目的に使用されているが、博士研究員がシステムやデータを 3D で可視化するのに使用されたこともある。


科学計算
--------

`CAMFR <http://camfr.sourceforge.net/>`_
   CAMFR は光通信学、電磁気学のモデリングツールである。計算操作に Python を使用している。

   `Peter Bienstman <mailto:Peter.Bienstman@rug.ac.be>`_ はこう書いている：

      素晴らしいツールを提供してくれてありがとう！

   `cctbx – Computational Crystallography Toolbox <http://cctbx.sourceforge.net/>`_

      Computational Crystallography は、X 線回折の実験データからの結晶構造の原子モデルの導出を扱う。cctbx は結晶学の計算を行う基本的なアルゴリズムのオープンソースライブラリである。コアアルゴリズムは C++ で実装されており、高水準な Python インターフェイスを介してアクセスする。

      cctbx は Boost.Python とともに開発が進められ、Python/C++ ハイブリッドシステムとしての基盤にもとづいて設計された。1 つの些細な例外を除き、実行時の多態性は Python により完全に処理される。C++ のコンパイル時多態性はパフォーマンス重視のアルゴリズムを実装するのに使用されている。Python と C++ の両方の層は Boost.Python を使用して統合されている。

      SourceForge の cctbx プロジェクトは非結晶学的なアプリケーションでの使用を容易にするモジュール群で構成される。scitbx モジュールは科学アプリケーションのための汎用配列ファミリ、および FFTPACK\ [#]_ と L-BFGS\ [#]_ 準ニュートンミニマイザを実装する。

   `EMSolve <http://www.llnl.gov/CASC/emsolve>`_
      EMSolve は、電荷保存・エネルギー保存のマクスウェルの方程式のための安定したソルバである。

   `Gaudi <http://cern.ch/gaudi>`_ および `RootPython <http://cern.ch/Gaudi/RootPython/>`_
      Gaudi は、CERN における LHCb および ATLAS 実験\ [#]_\の過程で開発された粒子物理衝突データ処理アプリケーションである。

      `Pere Mato Vila <mailto:Pere.Mato@cern.ch>`_ はこう書いている：

         当フレームワークにスクリプト可能かつ対話的な機能を与えるために Boost.Python を使用している。Python からあらゆるフレームワークサービスおよびアルゴリズムに対話的にアクセスできるよう、「GaudiPython」というモジュールを Boost.Python を使用して実装した。RootPython もまた、\ `ROOT <http://root.cern.ch/>`_ フレームワークと Python 間の汎用的な「ゲートウェイ」を提供するのに Boost.Python を使用する。

         Boost.Python は素晴らしい。当フレームワークの Python に対するインターフェイスすばやく構築できた。私たちは物理学者（エンドユーザ）に Python ベースの高速な解析アプリケーション開発環境を容易にするよう試みているところであり、Boost.Python は本質的な役割を果たしている。

   `ESSS <http://www.esss.com.br/>`_
      ESSS（Engineering Simulation and Scientific Software）は、ブラジルおよび南アメリカのマーケットにおいて工学ソリューションの提供、および計算流体力学と画像解析に関する製品とサービスを提供する活動を行う企業である。

      `Bruno da Silva de Oliveria <mailto:bruno@esss.com.br>`_ はこう書いている：

         私たちの仕事は、最近 C++ による排他的なものから Python と C++ を使ったハイブリッド言語のアプローチへ移行した。二者の間の層を与えてくれたのは Boost.Python であり、非常に素晴らしい結果となった。

      このテクノロジーを用いてこれまでに 2 つのプロジェクトを開発してきた。

      `Simba <http://www.esss.com.br/index.php?pg=dev_projetos>`_ は、滑油システムの発展のシミュレーションから収集した地層の3次元可視化を提供する。これにより、ユーザはシミュレーションの時間に沿った変形、圧力および流体といったシミュレーションにおける様々な側面からの解析が可能である。

      .. “the simulation of the evolution of oil systems”

      `Aero <http://www.esss.com.br/index.php?pg=dev_projetos>`_ の狙いはブラジルの様々な企業や大学の技術を用いた CFD\ [#]_ の構築である。ESSS は GUI や結果のポストプロセスといった種々のアプリケーションモジュール群を扱う。

   `PolyBoRi <http://polybori.sourceforge.net/>`_
      `Michael Brickenstein <mailto:brickenstein@mfo.de>`_ はこう書いている：

         PolyBoRi のコアは C++ ライブラリであり、多項環や論理変数のべき集合の部分集合のみならず、論理多項・単項式、指数ベクトルのための高水準データ型を提供する。ユニークなアプローチとして、多項式構造の内部記憶型として二分決定図を使用している。この C++ ライブラリの最上部で Python のインターフェイスを提供している。これによりグレブナー基底計算における複雑かつ拡張可能な戦略のみならず、複雑な多項式系の解析も可能になる。Boost.Python のおかげでこのインターフェイスの作成は鮮やかなものとなった。

   `Pyrap <http://pyrap.googlecode.com/>`_
      `Ger van Diepen <mailto:diepen@astron.nl>`_ はこう書いている：

         Pyrap は電波天文学パッケージ casacore（`casacore.googlecode.com <http://casacore.googlecode.com/>`_）に対する Python インターフェイスである。（LOFAR\ [#]_\、ASKAP\ [#]_\、eVLA\ [#]_ のような電波天体望遠鏡で取得した）データを簡単に numpy 配列で得られ、利用可能な多数の Python パッケージを使って基本的な検査と操作が容易になることが、pyrap が天文学者に親しまれている理由である。

         Boost.Python を使用することで、様々なデータ型（numpy 配列および numpy 配列の個々の要素も含む）の変換器を非常に簡単に作成できるようになった。完全に再帰的に動作する点も優れている。C++ 関数から Python へのマッピングは直感的に行うことができた。

   `RDKit: Cheminformatics and Machine Learning Software <http://www.rdkit.org/>`_
      C++ と Python で書かれた化学情報工学と機械学習ソフトウェアのコレクションである。


システムライブラリ
------------------

`Fusion <http://itamarst.org/software>`_
   Fusion は、C++ におけるプロトコルの実装をサポートするライブラリである。Twisted\ [#]_ とともに使用し、メモリ確保戦略や高速なメソッド内部呼び出し等の制御を提供する。Fusion は TCP 、UDP およびマルチキャストをサポートし、Python バインディングに Boost.Python を使用している。

   Fusion は MIT ライセンスのもとで http://itamarst.org/software からダウンロードできる。


ツール
------

`Jayacard <http://www.jayacard.org/>`_
   Jayacard は、非接触スマートカードのための安全でポータブルなオープンソースオペレーティングシステム、およびスマートカード OS とアプリケーション開発を容易にする高品質な開発ツール群の完全なセットの開発を主眼に置いている。

   スマートカードリーダ管理のコア部分は C++ で書かれているが、開発ツールはすべて友好的な Python 言語で書かれている。Boost.Python は、スマートカードリーダのコアライブラリに対するツールのバインディングにおいて根本的な役割を果たしている。


.. [#] 訳注　FFTPACK（http://ja.wikipedia.org/wiki/FFTPACK）

.. [#] 訳注　Limited-memory Broyden-Fletcher-Goldfarb-Shanno 法（http://en.wikipedia.org/wiki/L-BFGS）

.. [#] 訳注　LHC アトラス実験（http://atlas.kek.jp/）

.. [#] 訳注　Computational Fluid Dynamics。計算流体力学

.. [#] 訳注　LOw Frequency ARray（http://ja.wikipedia.org/wiki/LOFAR）

.. [#] 訳注　Australian Square Kilometre Array Pathfinder（http://en.wikipedia.org/wiki/Australian_Square_Kilometre_Array_Pathfinder）

.. [#] 訳注　expanded Very Large Array。拡大超大型干渉電波望遠鏡群（\ `http://ja.wikipedia.org/wiki/拡大超大型干渉電波望遠鏡群 <http://ja.wikipedia.org/wiki/%E8%B6%85%E5%A4%A7%E5%9E%8B%E5%B9%B2%E6%B8%89%E9%9B%BB%E6%B3%A2%E6%9C%9B%E9%81%A0%E9%8F%A1%E7%BE%A4>`_）

.. [#] 訳注　Twisted は Python で書かれたイベント駆動型のネットワーキングエンジン（http://twistedmatrix.com/）
