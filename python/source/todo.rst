TODO リスト
===========

.. pull-quote::

   | **David Abrahams**
   | Copyright ©2003, 2006 David Abrahams
   | Distributed under the Boost Software License, Version 1.0. (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

.. _todo.class-support:

クラスのサポート
----------------

.. _todo.base-class-for-virtual-function-callback-wrappers:

仮想関数コールバックラッパの基底クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* http://aspn.activestate.com/ASPN/Mail/Message/c++-sig/1456023\（メッセージの最後を見よ）
* http://mail.python.org/pipermail/c++-sig/2003-August/005297.html\（:cpp:class:`!VirtualDispatcher` で検索するとよい）に、コールバッククラスがその Python ラッパとの関係について所有権を交換する方法が述べられている。
* http://aspn.activestate.com/ASPN/Mail/Message/c++-sig/1860301 に、基底クラスを使ってコールバッククラスを非常に単純化し、「懸垂参照」問題を解決し、オーバーライドされていない仮想関数の呼び出すを最適化する方法が述べられている。


.. _todo.miscellaneous:

その他
------

.. _todo.support-for-enums-with-duplicate-values:

値が重複した enum のサポート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Scott Snyder がパッチを提供している。Dave はある理由から不満だったが、これ以上のアクションが無ければおそらく適用されるだろう（http://aspn.activestate.com/ASPN/Mail/Message/1824616）。


.. _todo.functions:

関数
----

.. _todo.wrapping-function-objects:

関数オブジェクトのラップ
^^^^^^^^^^^^^^^^^^^^^^^^

:cpp:expr:`operator()` をサポートするクラスは Python のメソッドとしてラップ可能となるだろう（http://mail.python.org/pipermail/c++-sig/2003-August/005184.html）。


.. _todo.best-match-overload-resolution:

多重定義解決の「最良マッチ」
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

現時点では多重定義の解決はdefの呼び出し順に依存する（後の多重定義を優先する）。これは常に最良マッチの多重定義を選択するよう変更すべきである。このテクニックはすでに `Luabind <http://luabind.sf.net/>`_ で培われているので、\ :ref:`Langbinding <todo.langbinding>` の合流待ちとなっている。


.. _todo.type-converters:

型変換器
--------

.. _todo.lvalue-conversions-from-non-const-pytypeobject-s:

非 const な :c:type:`!PyTypeObject*` から lvalue への変換
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

http://aspn.activestate.com/ASPN/Mail/Message/C++-sig/1662717


.. _todo.converter-scoping:

変換器のスコープ制御
^^^^^^^^^^^^^^^^^^^^

* http://article.gmane.org/gmane.comp.python.c++/2044
* 上記が完了すれば :ref:`Luabind の統合 <todo.langbinding>`\と合流することになるだろう。


.. _todo.boost-tuple:

:cpp:class:`!boost::tuple`
^^^^^^^^^^^^^^^^^^^^^^^^^^

Python との相互変換は問題なさそうである。http://news.gmane.org/find-root.php?message_id=%3cuvewak97m.fsf%40boost%2dconsulting.com%3e を見よ。


.. _todo.file-conversions:

:c:type:`!FILE*` の変換
^^^^^^^^^^^^^^^^^^^^^^^

http://aspn.activestate.com/ASPN/Mail/Message/1411366


.. _todo.void-conversions:

:cpp:type:`!void*` の変換
^^^^^^^^^^^^^^^^^^^^^^^^^

:samp:`{CV}` :cpp:type:`!void` へのポインタは、不透明な値として関数へ渡したり関数から返したりできるべきである。


.. _todo.post-call-actions:

呼び出し後（Post-Call）のアクション
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Policies オブジェクト内の post-call アクションチェインに from-python 変換器を渡さなければならない（追加のアクションが登録可能な場合）。http://aspn.activestate.com/ASPN/Mail/Message/C++-sig/1755435 の最後を見よ。


.. _todo.pyunicode-support:

:c:type:`!PyUnicode` のサポート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Lijun Qin <mailto:qinlj-at-solidshare.com>`_ によるレビューが http://aspn.activestate.com/ASPN/Mail/Message/C++-sig/1771145 にある。この変更は組み入れる可能性が高い。


.. _todo.ownership-metadata:

所有権のメタデータ
^^^^^^^^^^^^^^^^^^

http://aspn.activestate.com/ASPN/Mail/Message/c++-sig/1860301 のスレッドにおいて、Niall Douglas は「偽の」懸垂ポインタ・参照がオブジェクトに関するデータをアタッチすることでエラーを返すという解法のアイデアについて述べた。そのデータの寿命について伝えてこないオブジェクトの参照カウントをフレームワークが決められる。


.. _todo.documentation:

ドキュメンテーション
--------------------

.. _todo.builtin-converters:

組み込みの変換器
^^^^^^^^^^^^^^^^

組み込みの Python 型と C++ 型間の組み込みの対応関係についてドキュメントが必要である。


.. _todo.internals:

内部的な話
^^^^^^^^^^

フレームワークの構造についてドキュメントしておく必要がある。\ `Brett Calcott <mailto:brett.calcott-at-paradise.net.nz>`_ が\ :doc:`このドキュメント <internals>`\をユーザ向けに書き直すと約束してくれた。


.. _todo.large-scale:

大規模
------

.. _todo.full-threading-support:

スレッドの完全なサポート
^^^^^^^^^^^^^^^^^^^^^^^^

Boost.Python におけるスレッドサポートの強化について、多くの人々からパッチが寄せられている（例えば http://aspn.activestate.com/ASPN/Mail/Message/1826544 や http://aspn.activestate.com/ASPN/Mail/Message/1865842 のスレッドを見よ）。唯一の問題はこれらが不完全な解法であることで、完全な解法があるのか検証するには時間と注意が必要である。


.. _todo.langbinding:

Langbinding
^^^^^^^^^^^

このプロジェクトは Boost.Python を一般化して他の言語で動作するもので、一番手は Lua である。http://lists.sourceforge.net/lists/listinfo/boost-langbinding の議論を見よ。


.. _todo.refactoring-and-reorganization:

リファクタリングと再構成
^^^^^^^^^^^^^^^^^^^^^^^^

http://aspn.activestate.com/ASPN/Mail/Message/c++-sig/1673338


.. _todo.numarray-support-enhancements:

NumArray サポートの強化
^^^^^^^^^^^^^^^^^^^^^^^

http://aspn.activestate.com/ASPN/Mail/Message/C++-sig/1757092 で述べられている強化について統合を検討する。


.. _todo.pyfinalize-safety:

:c:func:`!PyFinalize` の安全性
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

現在のところ、Boost.Python にはグローバル（および関数内静的）オブジェクトが複数あり、それらは Boost.Python 共有オブジェクトがアンロードされるまで参照カウントがゼロにならない。インタープリタが存在しない状態で参照カウントがゼロになるので、クラッシュを引き起こす。:c:func:`!PyFinalize()` の呼び出しを安全にするには、これらのオブジェクトを破壊し Python の参照カウントを解放する :cpp:func:`!atexit` ルーチンを登録して、Python がインタープリタが存在している間にそれらを始末できるようにしなければならない。\ `Dick Gerrits <mailto:dirk-at-gerrits.homeip.net>`_ が何とかすると約束してくれた。
