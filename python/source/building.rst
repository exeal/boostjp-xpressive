ビルドとテスト
==============

.. pull-quote::

   | **David Abrahams**
   | Copyright © 2002-2015 David Abrahams, Stefan Seefeld

.. _building.requirements:

必要事項
--------

Boost.Python は Python の\ `バージョン 2.2 <http://www.python.org/2.2>`_\ [#]_\ か\ `それ以降 <http://www.python.jp/>`_\を要求する。


.. _building.background:

背景
----

C++ と Python を組み合わせるための基本的なモデルは 2 つある。

* `拡張 <http://www.python.org/doc/current/ext/intro.html>`_\。エンドユーザは Python のインタープリタ（実行可能ファイル）を起動し、C++ で書かれた Python の「拡張モジュール」をインポートする。ライブラリを C++ で書き Python のインターフェイスを与えることで、Python のプログラマが使用できるようにするという考え。Python からはこれらのライブラリは通常の Python モジュールと同じにしか見えない。
* `組み込み <http://www.python.org/doc/current/ext/embedding.html>`_\。エンドユーザは、Python をライブラリのサブルーチンとして呼び出す C++ で書かれたプログラムを起動する。既存のアプリケーションにスクリプト機能を追加するという考え。

拡張と組み込みの重要な違いは C++ の :cpp:func:`!main()` 関数の場所である（それぞれ Python のインタープリタと他のプログラムである）。Python を他のプログラムへ組み込む場合であっても、\ `拡張モジュールは C/C++ から Python のコードへアクセス可能にする最も優れた方法 <http://docs.python.jp/2/extending/embedding.html#extending-with-embedding>`_\であり、拡張モジュールの使用が両方のモデルの核心であることに注意していただきたい。

わずかな例外を除いて、拡張モジュールは単一のエントリポイントを持ち動的に読み込まれるライブラリとしてビルドする。つまり変更時に他の拡張モジュールや :cpp:func:`!main()` を持つ実行可能ファイルを再ビルドする必要がない。


.. _building.no-install-quickstart:

インストールなしのクイックスタート
----------------------------------

Boost.Python を使い始めるのに「Boost をインストール」する必要はない。この説明では、バイナリを必要に応じてビルドする `Boost.Build <http://www.boost.org/build>`_ プロジェクトを利用する。最初のテストは Boost.Python のビルドより少し長くかかるかもしれないが、この方法であれば特定のコンパイラ設定に対してどのライブラリバイナリを使用すべきかといった厄介ごとに悩むことなく、正しいコンパイラオプションをあなた自身が理解できることだろう。

.. note::
   他のビルドシステムを使用して Boost.Python やその拡張をビルドすることは当然可能であるが、Boost では公式にはサポートしない。\ **「Boost.Python がビルドできないよ」問題の 99% 以上は、**\以下の説明を無視して\ **他のビルドシステムを使用したことが原因である。**

   それでも他のビルドシステムを使用したい場合は、以下の説明に従って :program:`bjam` にオプション :option:`!-a -o`\ :samp:`{filename}` を付けて起動し実行するビルドコマンドをファイルにダンプすれば、あなたのビルドシステムで必要なことが分かる。


.. _building.no_install_quickstart.basic_procedure:

基本的な手順
^^^^^^^^^^^^

#. Boost を入手する。Boost `導入ガイド <http://www.boost.org/more/getting_started/>`_\の第 1 節、第 2 節を見よ。
#. :program:`bjam` ビルドドライバを入手する。Boost `導入ガイド <http://www.boost.org/more/getting_started/>`_\の第 5 節を見よ。
#. Boost をインストールした :file:`example/quickstart/` ディレクトリに :command:`cd` で移動する。小さなプロジェクト例がある。
#. :program:`bjam` を起動する。すべてのテストターゲットをビルドするため、\ `導入ガイド <http://www.boost.org/more/getting_started/>`_\第 5 節の起動例にある「:option:`!stage`」引数を「:option:`!test`」に置き換える。またテストが生成した出力を見るため、引数に「:option:`!--verbose-test`」を追加する。

   Windows の場合、:program:`bjam` の起動は以下のようになる。

   .. code-block:: console

      C:\\…\quickstart> bjam toolset=msvc --verbose-test test

   Unix 系の場合はおそらく、

   .. code-block:: console

      …/quickstart$ bjam toolset=gcc --verbose-test test

.. note::
   簡単のために、このガイドの残りの部分ではパス名に Windows ユーザになじみのあるバックスラッシュではなく、Unix スタイルのスラッシュを使用する。スラッシュは\ `コマンドプロンプト <http://www.boost.org/more/getting_started/windows.html#command-prompt>`_\ウィンドウ以外のあらゆる場所で機能するはずである（コマンドプロンプトだけはバックスラッシュを使用しなければならない）。

ここまでの手順がうまくいったら、:py:mod:`!extending` という名前の拡張モジュールのビルドが終わり、:file:`test_extending.py` という Python スクリプトが走ってテストも完了しているはずである。また、Python を組み込む :program:`embedding` という簡単なアプリケーションもビルド、起動する。


.. _building.no_install_quickstart.in_case_of_trouble:

問題が起きた場合
^^^^^^^^^^^^^^^^

コンパイラやリンカのエラーメッセージが大量に表示された場合、Boost.Build が Python のインストール情報を見つけられていない可能性が高い。:program:`bjam` を起動する最初の数回、:option:`!--debug-configuration` オプションを :program:`bjam` に渡して Boost.Build が Python のインストール情報をすべて正しく見つけられているか確認することだ。失敗している場合は、以下の :ref:`Boost.Build を設定する <building.configuring-boost-build>`\の節を試すとよい。

それでもなお問題が解決しない場合は、以下のメーリングリストに手助けしてくれる人がいるかもしれない。

* Boost.Build に関する話題は `Boost.Build のメーリングリスト <http://www.boost.org/more/mailing_lists.htm#jamboost>`_
* Boost.Python に固有の話題は Python の `C++ Sig <http://www.boost.org/more/mailing_lists.htm#cplussig>`_


.. _building.no_install_quickstart.in_case_everything_seemed_to_wor:

すべて問題無い場合
^^^^^^^^^^^^^^^^^^

おめでとう！ Boost.Python に慣れていなければ、この時点でしばらくビルドに関することを忘れ、\ :doc:`チュートリアル <tutorial>`\や\ :doc:`リファレンス <reference>`\を通じてライブラリの学習に集中するとよいかもしれない。quickstart プロジェクトに変更を加えて、API について学んだことを十分に試してみるのもよい。


.. _building.no_install_quickstart.modifying_the_example_project:

サンプルプロジェクトを変更する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

拡張モジュールを（Boost ディストリビューション内の 1 つのソースファイルである）\ :file:`extending.cpp` 内に限定し、これを :py:mod:`!extending` としてインポートすることに満足しているのであれば、ここでやめてしまってもよい。しかしながら少しぐらいは変更したいと思うことだろう。\ `Boost.Build <http://www.boost.org/build>`_ について詳しく学ぶことなく先に進む方法はある。

.. http://www.boost.org/doc/libs/python/example/quickstart/extending.cpp

今ビルドしたプロジェクトは現在のディレクトリにある 2 つのファイルで規定されている。:file:`boost-build.jam` は Boost ビルドシステムのコードの場所を :program:`bjam` に指定する。:file:`Jamroot` はビルドしたターゲットを記述する。これらのファイルにはコメントを大量に書いてあるので、変更は容易なはずである。ただし空白の保持には注意していただきたい。:code:`;` のような区切り文字は前後に空白がなければ :program:`bjam` は認識しない。

.. http://www.boost.org/doc/libs/python/example/quickstart/boost-build.jam
.. http://www.boost.org/doc/libs/python/example/quickstart/Jamroot


.. _building.no_install_quickstart.modifying_the_example_project.relocate_the_project:

プロジェクトの場所を変更する
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Boost ディストリビューションに変更が生じないよう、このプロジェクトをどこか他の場所にコピーしたいと思うことだろう。単純に次のようにする。

#. :file:`example/quickstart/` ディレクトリ全体を新しいディレクトリにコピーする。
#. :file:`boost-build.jam` および :file:`Jamroot` の新コピーにおいて、ファイルの先頭付近で相対パスを探し（コメントで分かりやすくマークしてある）、ファイルが :file:`example/quickstart` ディレクトリ内の元の場所にあったときと同様に Boost ディストリビューションを指すように編集する。

http://www.boost.org/doc/libs/python/example/quickstart/boost-build.jam
http://www.boost.org/doc/libs/python/example/quickstart/Jamroot

例えばプロジェクトを :file:`/home/dave/boost_1_34_0/libs/python/example/quickstart` から :file:`/home/dave/my-project` へ移動したとすると、:file:`boost-build.jam` の最初のパスは

.. http://www.boost.org/doc/libs/python/example/quickstart/boost-build.jam

.. code-block:: none

   ../../../../tools/build/src

次のように変更する。

.. code-block:: none

   /home/dave/boost_1_34_0/tools/build/src

また :file:`Jamroot` の最初のパスは

.. http://www.boost.org/doc/libs/python/example/quickstart/Jamroot

.. code-block:: none

   ../../../..

次のように変更する。

.. code-block:: none

   /home/dave/boost_1_34_0


.. _building.no_install_quickstart.modifying_the_example_project.add_new_or_change_names_of_exist:

新しいソースファイルを追加するか既存ファイルの名前を変更する
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

拡張モジュールや組み込みアプリケーションのビルドに必要なファイルの名前は、:file:`Jamroot` 内にそれぞれ :file:`extending.cpp` 、:file:`embedding.cpp` の右に並べて書く。各ファイル名の前後に空白を入れるのを忘れてはならない。

.. http://www.boost.org/doc/libs/python/example/quickstart/Jamroot

.. code-block:: none

   … file1.cpp file2.cpp file3.cpp …

当然ながら、ソースファイルの名前を変更したければ :file:`Jamroot` 内の名前を編集して Boost.Build に通知する。

.. http://www.boost.org/doc/libs/python/example/quickstart/Jamroot


.. _building.no_install_quickstart.modifying_the_example_project.change_the_name_of_your_extensio:

拡張モジュールの名前を変更する
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

拡張モジュールの名前は以下の 2 つで決まる。

#. :file:`Jamroot` 内の :code:`python-extension` 直後の名前

   .. http://www.boost.org/doc/libs/python/example/quickstart/Jamroot

#. :file:`extending.cpp` 内で :c:macro:`!BOOST_PYTHON_MODULE` に渡した名前

   .. http://www.boost.org/doc/libs/python/example/quickstart/extending.cpp

拡張モジュールの名前を :py:mod:`!extending` から :py:mod:`!hello` に変更するには、:file:`Jamroot` を編集して次の行を

.. http://www.boost.org/doc/libs/python/example/quickstart/Jamroot

.. code-block:: none

   python-extension extending : extending.cpp ;

以下のように変更する。

.. code-block:: none

   python-extension hello : extending.cpp ;

また :file:`extending.cpp` を編集して次の行を

.. code-block:: none

   BOOST_PYTHON_MODULE(extending)

以下のように変更する。

.. code-block:: none

   BOOST_PYTHON_MODULE(hello)


.. _building.installing-boost-python-on-your-system:

システムに Boost.Python をインストールする
------------------------------------------

Boost.Python は（ヘッダオンリーライブラリとは逆に）個別にコンパイルが必要なライブラリであるため、ユーザは Boost.Python ライブラリバイナリのサービスに依存する。

.. http://www.boost.org/more/getting_started/windows.html#header-only-libraries

Boost.Python ライブラリのバイナリを普通にインストールする必要がある場合、Boost の\ `導入ガイド <http://www.boost.org/more/getting_started/index.html>`_\を見ればその作成手順が一通り分かるだろう。ソースからバイナリをビルドする場合、Boost の全バイナリではなく Boost.Python のバイナリだけがビルドされるよう、:program:`bjam` に :option:`!--with-python` 引数を（あるいは :file:`configure` に :option:`!--with-libraries=python` 引数を）渡すとよい。


.. _building.configuring-boost-build:

Boost.Build を設定する
----------------------

`Boost.Build のリファレンスマニュアル <http://www.boost.org/build/doc/html/bbv2/overview/configuration.html>`_\にあるとおり、ビルドシステムで利用可能なツールとライブラリの指定はホームディレクトリの :file:`user-config.jam` で行う。:file:`user-config.jam` を作成・編集して Python の起動、ヘッダのインクルード、ライブラリのリンクについての方法を Boost.Build に指定する必要があるかもしれない。

.. note::
   .. rubric:: Unix 系 OS のユーザ

   Unix 系 OS を使用しており Boost の :file:`configure` スクリプトを走らせた場合、:file:`user-config.jam` が生成されている可能性がある。\ [#]_ :program:`configure`/:program:`make` シーケンスが成功して Boost.Python のバイナリがビルドされていれば、:file:`user-config.jam` はおそらく既に正しい状態になっている。

Python を「標準的な」形でインストールしたのであれば、特に行うことはない。:file:`user-config.jam` で python を設定していない（かつ Boost.Build コマンドラインで :option:`!--without-python` を指定していない）のであれば、Boost.Build は自動的に以下と等価なことを行い、最も適切な場所から Python を自動的に探し出す。

.. code-block:: none

   import toolset : using ;
   using python ;

ただしこれが行われるのは Boost.Python のプロジェクトファイルを使用した場合だけである（例えば :py:mod:`!quickstart` の方法のように別のプロジェクトから参照される場合）。個別にコンパイルした Boost.Python バイナリにリンクする場合は、上に挙げた最小限のおまじないで :file:`user-config.jam` をセットアップしなければならない。

.. building.no-install-quickstart


.. _building.configuring_boost_build.python_configuration_parameters:

Python の設定引数
^^^^^^^^^^^^^^^^^

Python を複数バージョンインストールしている場合や Python を通常でない方法でインストールした場合は、以下の省略可能な引数のいずれか、またはすべてを :code:`using python` に与えなければならない可能性がある。

.. option:: version

   使用する Python のバージョン。（メジャー）.（マイナー）の形式でなければらない（例：:code:`2.3`）。サブマイナーバージョンは含めてはならない（:code:`2.5.1` は\ **不可**\）。複数のバージョンの Python をインストールした場合、大抵は version が省略不可能な唯一の引数となる。

.. option:: cmd-or-prefix

   Python インタープリタを起動するコマンド。または Python のライブラリやヘッダファイルのインストール接頭辞。このパラメータの使用は、適切な Python 実行可能ファイルがない場合に限定すること。

.. option:: includes

   Python ヘッダの :code:`#include` パス。通常、:option:`version` と :option:`cmd-or-prefix` から適切なパスが推測される。

.. option:: libraries

   Python ライブラリのバイナリへのパス。MacOS/Darwin では Python フレームワークのパスを渡してもよい。通常、:option:`version` と :option:`cmd-or-prefix` から適切なパスが推測される。

.. option:: condition

   指定する場合は、Boost.Build が使用する Python の設定を選択するときのビルド設定にマッチした Boost.Build パラメータの集合でなければならない。詳細は以下の例を見よ。

.. option:: extension-suffix

   拡張モジュール名の真のファイル拡張子の前に追加する文字列。ほとんどの場合、この引数を使用する必要はない。大抵の場合、この接尾辞を使用するのは Windows において Python のデバッグビルドをターゲットにする場合だけであり、:ref:`\<python-debugging\> <building.python_debugging_builds>` 機能の値に基づいて自動的に設定される。しかしながら少なくとも 1 つの Linux のディストリビューション（Ubuntu Feisty Fawn）では `python-dbg <https://wiki.ubuntu.com/PyDbgBuilds>`_ は特殊な設定がなされており、この種の接頭辞を使用しなければならない。


.. _building.configuring_boost_build.examples:

例
^^

以下の例では大文字小文字の区別や、\ **特に空白**\が重要である。

* Python 2.5 と Python 2.4 の両方をインストールしている場合、:file:`user-config.jam` を次のようにしておく。

  .. code-block:: none

     using python : 2.5 ;  # 両方のバージョンの Python を有効にする

     using python : 2.4 ;  # python 2.4 でビルドする場合は、python=2.4 を
                           # コマンドラインに追加する。

  最初のバージョン設定（2.5）が既定となる。Python 2.4 についてビルドする場合は :program:`bjam` コマンドラインに :option:`!python=2.4` を追加する。

* Python を通常でない場所にインストールしている場合、:option:`cmd-or-prefix` 引数にインタープリタへのパスを与えるとよい。

  .. code-block:: none

     using python : : /usr/local/python-2.6-beta/bin/python ;

* 特定のツールセットに対して個別の Python ビルドを置いている場合、:option:`condition` 引数にそのツールセットを与えるとよい。

  .. code-block:: none

     using python ;  # 通常のツールセットで使用

     # Intel C++ ツールセットで使用
         using python
          : # version
          : c:\\Devel\\Python-2.5-IntelBuild\\PCBuild\\python # cmd-or-prefix
          : # includes
          : # libraries
          : <toolset>intel # condition
          ;

* Python のソースをダウンロードし、Windows 上でソースから通常版と「:ref:`Python デバッグ <building.python_debugging_builds>`\」ビルド版の両方をビルドした場合、次のようにするとよい。

  .. code-block:: none

     using python : 2.5 : C:\\src\\Python-2.5\\PCBuild\\python ;
     using python : 2.5 : C:\\src\\Python-2.5\\PCBuild\\python_d
       : # includes
       : # libs
       : <python-debugging>on ;

* Windows でビルドした bjam では、Windows と `Cygwin <http://cygwin.com/>`_ の両方の Python 拡張をビルド・テストできるよう :file:`user-config.jam` をセットアップできる。Cygwin の Python インストールに対して :option:`condition` 引数に :code:`<target-os>cygwin` を渡すだけでよい。

  .. code-block:: none

     # Windows の場合
     using python ;

     # Cygwin の場合
     using python : : c:\\cygwin\\bin\\python2.5 : : : <target-os>cygwin ;

  ビルドリクエストに :option:`!target-os=cygwin` と書くと、Cygwin 版の Python でビルドが行われる。\ [#]_

  .. boostorg.github.io 版だとこの footnote が消えてる

  .. code-block:: console

     bjam target-os=cygwin toolset=gcc

  他の方法でも同様に動作すると思う（Windows 版の Python をターゲットにして `Cygwin <http://cygwin.com/>`_ 版の bjam を使用する場合）が、本稿執筆時点ではそのような組み合わせのビルドに対する Boost.Build ツールセットのサポートにはバグがあるようだ。

* `Boost.Build がターゲットを選択する方法 <http://zigzag.cs.msu.su/boost.build/wiki/AlternativeSelection>`_\が原因で、ビルドリクエストは完全に明確にしなければならないということに注意していただきたい。例えば、次のようであるとすると、

  .. code-block:: none

     using python : 2.5 ; # 通常の Windows ビルドの場合
     using python : 2.4 : : : : <target-os>cygwin ;

  以下の方法でビルドするとエラーになる。

  .. code-block:: console

     bjam target-os=cygwin

  代わりに、こう書く必要がある。

  .. code-block:: console

     bjam target-os=cygwin/python=2.4


.. _building.choosing_a_boost_python_library_:

Boost.Python ライブラリのバイナリを選択する
-------------------------------------------

（Boost.Build に自動的に正しいライブラリを構築、リンクさせる代わりに）ビルド済みの Boost.Python ライブラリを使用する場合、どれをリンクするか考える必要がある。Boost.Python バイナリには動的版と静的版がある。アプリケーションに応じて注意して選択しなければならない。\ [#]_


.. _building.choosing_a_boost_python_library_.the_dynamic_binary:

動的バイナリ
^^^^^^^^^^^^

動的ライブラリは最も安全で最も汎用性の高い選択である。

* 与えられたツールセットでビルドしたすべての拡張モジュールが、ライブラリコードの単一のコピーを使用する。\ [#]_
* ライブラリには型変換レジストリが含まれる。すべての拡張モジュールが単一のレジストリを共有するので、ある動的に読み込んだ拡張モジュールで Python へエクスポートしたクラスのインスタンスを、別のモジュールでエクスポートした関数へ渡すことができる。


.. _building.choosing_a_boost_python_library_.the_static_binary:

静的バイナリ
^^^^^^^^^^^^

以下のいずれかの場合は Boost.Python の静的ライブラリを使用するのが適切である。

* Python を\ `拡張 <http://docs.python.jp/2/extending/extending.html>`_\していて、動的に読み込んだ拡張モジュールで他の Boost.Python 拡張モジュールから使用する必要のない型をエクスポートしており、かつそれらの間でコアライブラリコードが複製されても問題ない場合。
* Python をアプリケーションに\ `組み込んで <http://docs.python.jp/2/extending/embedding.html>`_\おり、かつ以下のいずれかの場合。

  * MacOS か AIX 以外の Unix 系 OS をターゲットにしていて、動的に読み込んだ拡張モジュールから実行可能ファイルの一部である Boost.Python ライブラリシンボルが「見える」場合。
  * またはアプリケーションに何らかの Boost.Python 拡張モジュールを静的にリンクしており、かつ動的に読み込んだ Boost.Python 拡張モジュールが静的にリンクした拡張モジュールでエクスポートした型を使用可能でも問題ない場合（あるいはその逆）。


.. _building.include_issues:

:code:`#include` に関すること
-----------------------------

#. Boost.Python を使用するプログラムの翻訳単位で直接 :code:`#include "python.h"` と書きたくなったら、代わりに :code:`#include "boost/python/detail/wrap_python.hpp"` を使用せよ。こうすることで Boost.Python を使用するのに必要ないくつかの事柄が適当に処理される（その中の 1 つを次節で見る）。
#. :file:`wrap_python.hpp` の前にシステムヘッダをインクルードしないよう注意せよ。この制限は実際には Python によるものであり、より正確には Python とオペレーティングシステムの相互作用によるものである。詳細は http://docs.python.org/ext/simpleExample.html [#]_ を見よ。


.. _building.python_debugging_builds:

Python のデバッグビルド
-----------------------

Python は特殊な「python debugging」設定でビルドすることで、拡張モジュールの開発者にとって非常に有用なチェックとインストゥルメント（instrumentation）を追加できる。デバッグ設定が使用するデータ構造は追加のメンバを含んでいるため、\ **python debugging を有効にした Python 実行可能ビルドを、有効にせずにコンパイルしたライブラリや拡張モジュールとともに使用することはできない（その逆も同様である）。**

Python のビルド済み実行可能の「python debugging」版はほとんどの Python ディストリビューションでは提供されておらず\ [#]_\ 、それらのビルドをユーザに強制したくないので、:option:`!debug` ビルド（既定）において python debugging を自動的に有効化することはない。代わりに :option:`!python-debugging` という特殊なビルドプロパティを用意しており、これを使用すると適切なプリプロセッサシンボルが定義され正しいライブラリがリンク先として選択される。

Unix 系プラットフォームでは、デバッグ版 Python のデータ構造は :c:macro:`!Py_DEBUG` シンボルを定義したときのみ使用される。多くの Windows コンパイラでは、プリプロセッサシンボル :c:macro:`!_DEBUG` を付けてビルドすると、Python は既定では Python DLL の特殊デバッグ版へのリンクを強制する。このシンボルは Python の有無とは別にごくありふれたものであるので、Boost.Python は :file:`boost/python/detail/wrap_python.hpp` で :file:`Python.h` をインクルードするときから :c:macro:`!BOOST_DEBUG_PYTHON` が定義されるまでの間、一時的に :c:macro:`!_DEBUG` を未定義にする。結論としては「python debugging」が必要で Boost.Build を使用しない場合は、:c:macro:`!BOOST_DEBUG_PYTHON` が定義されているのを確認することである。そうでなければ python debugging は無効になる。


.. _building.testing_boost_python:

Boost.Python をテストする
-------------------------

Boost.Build の完全なテストスイートを走らせるには、Boost ディストリビューションの :file:`test` サブディレクトリで :program:`bjam` を起動する。


.. _building.notes_for_mingw_and_cygwin_with_:

MinGW（および Cygwin の -mno-cygwin）の GCC ユーザに対する注意
--------------------------------------------------------------

Python の 2.4.1 より前のバージョンを MinGW の 3.0.0（binutils-2.13.90-20030111-1）より前のバージョンで使用する場合は、MinGW 互換バージョンの Python ライブラリを作成する必要がある（Python に付属のものは Microsoft 互換のリンカでしか動作しない）。『`Python モジュールのインストール <http://docs.python.jp/2/install/>`_\』の「拡張モジュールのビルド: 小技と豆知識」―「Windows で非 Microsoft コンパイラを使ってビルドするには」の節に従い、:file:`libpython{XX}.a` を作成する。:samp:`{XX}` はインストールした Python のメジャーバージョンとマイナーバージョン番号である。


.. [#] Boost.Python の以前のバージョンと Python 2.2 の組み合わせでテストを行っており互換性を損なうようなことはしていないと\ **考えて**\いる。しかしながら Boost.Python の最新版では Python の 2.4 より前のバージョンに対してテストを行っていない可能性があり、Python 2.2 および 2.3 をサポートしているとは 100% 言い切れない。

.. [#] :program:`configure` はホームディレクトリにある既存の :file:`user-config.jam` について、（あれば）バックアップを作成した後で上書きする。

.. [#] :code:`<target-os>cygwin` 機能は :program:`gcc` ツール群の :code:`<flavor>cygwin` サブ機能とは別物であることに注意していただきたい。MinGW GCC もインストールしている場合は、両者を明示的に扱わなければならない。

.. [#] Boost.Python の静的ビルドと動的ビルドを区別する方法：

       * `Windows の場合 <http://www.boost.org/more/getting_started/windows.html#library-naming>`_
       * `Unix 系の場合 <http://www.boost.org/more/getting_started/unix-variants.html#library-naming>`_

.. [#] ほとんどの Unix/Linux 系プラットフォームでは動的に読み込んだオブジェクトを共有するため、異なるコンパイラツールセットでビルドした拡張モジュールを同一の Python インスタンスに読み込んだとき常に異なる Boost.Python ライブラリのコピーを使用するか定かではない。それらのコンパイラが互換性のある ABI を有しているのであれば、2 つのライブラリでビルドした拡張モジュールは相互運用可能なので、別のライブラリを使用しないほうが望ましい。そうでなければ拡張モジュールと Boost.Python はクラスレイアウト等が異なるため、大惨事となるかもしれない。何が起こるか確認する実験を行ってくれる人がいれば幸いである。

.. [#] 訳注　日本語訳は http://docs.python.jp/2/extending/extending.html#extending-simpleexample （Python 2.x の場合）。

.. [#] Unix 系列のプラットフォームでは、debugging python と関連ライブラリは Python のビルド設定で :option:`!--with-pydebug` を追加するとビルドされる。Windows では Python のデバッグ版は、Python の完全なソースコードディストリビューションの :file:`PCBuild` サブディレクトリにある Visual Studio プロジェクトの「Win32 Debug」ターゲットから生成される。
