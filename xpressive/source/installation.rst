xpressive のインストール
------------------------

xpressive の入手
^^^^^^^^^^^^^^^^

xpressive の入手方法は 2 つある。第 1 のより簡単な方法は Boost の最新版をダウンロードすることである。http://sf.net/projects/boost へ行き、“Download” リンクをたどるだけである。

2 番目の方法は Boost の Subversion リポジトリに直接アクセスすることである。http://svn.boost.org/trac/boost へ行き、そこにある匿名 Subversion アクセス方法に従うとよい。Boost Subversion にあるのは不安定版である。


xpressive を使ったビルド
^^^^^^^^^^^^^^^^^^^^^^^^

xpressive はヘッダのみのテンプレートライブラリであり、あなたのビルドスクリプトを書き直したり個別のライブラリファイルにリンクする必要はない。:code:`#include <boost/xpressive/xpressive.hpp>` とするだけでよい。使用するのが静的正規表現だけであれば、:file:`xpressive_static.hpp` だけをインクルードすることでコンパイル時間を短縮できる。同様に動的正規表現だけを使用するのであれば :file:`xpressive_dynamic.hpp` をインクルードするとよい。

静的正規表現とともに意味アクションやカスタム表明を使用したければ、\ :file:`regex_actions.hpp` も追加でインクルードする必要がある。


必要要件
^^^^^^^^

xpressive を使用するには Boost 1.34.1 以降が必要である。


サポートするコンパイラ
^^^^^^^^^^^^^^^^^^^^^^

* Visual C++ 7.1 以降
* GNU C++ 3.4 以降
* Intel for Linux 8.1 以降
* Intel for Windows 10 以降
* tru64cxx 71 以降
* MinGW 3.4 以降
* HP C/C++ A.06.14 以降

.. * QNX qcc 3.3 以降
.. * Metrowerks CodeWarrior 9.4 以降

Boost の\ `退行テスト結果のページ <http://beta.boost.org/development/tests/trunk/developer/xpressive.html>`_\にある最新テスト結果を参照するとよい。

.. note:: 質問、コメント、バグ報告は eric <at> boost-consulting <dot> com に送ってほしい。
