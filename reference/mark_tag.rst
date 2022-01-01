mark_tag 構造体
===============

.. cpp:struct:: mark_tag

   静的正規表現で名前付き捕捉を作成するのに使用する、部分マッチのプレースホルダ型。


.. cpp:namespace-push:: mark_tag


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_primitives.hpp`>


   struct :cpp:struct:`~::boost::xpressive::mark_tag` {
     // :ref:`構築、コピー、解体 <mark_tag.construct-copy-destruct>`
     :cpp:func:`~mark_tag::mark_tag`\(int);

     // :ref:`非公開静的メンバ関数 <mark_tag.private-static-functions>`
     static :samp:`{unspecified}` :cpp:func:`make_tag`\(int);
   };


説明
----

:cpp:struct:`mark_tag` は部分マッチのグローバルなプレースホルダ :cpp:var:`!s0` 、:cpp:var:`!s1` 、…の型である。:cpp:struct:`mark_tag` を使用すると、より意味のある名前で部分マッチプレースホルダを作成できる。動的正規表現における「名前付き捕捉」機能とおおよそ等価である。

名前付き部分マッチプレースホルダは、一意な整数で初期化して作成する。この整数はプレースホルダを使用する正規表現内で一意でなければならない。静的正規表現内でこれに部分式を代入して部分マッチを作成するか、すでに作成した部分マッチを後方参照できる。 ::

    mark_tag number(1); // number は s1 と等価
    // 数字、続いて空白、再び同じ数字にマッチ
    sregex rx = (number = +_d) >> ' ' >> number;

:cpp:func:`!regex_match()` か :cpp:func:`!regex_search()` が成功した後は、部分マッチのプレースホルダを :cpp:struct:`match_results\<>` オブジェクトの添字にして、対応する部分マッチを得る。


.. _mark_tag.construct-copy-destruct:

:cpp:struct:`!mark_tag` 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: mark_tag(int mark_nbr)

   :cpp:struct:`!mark_tag` プレースホルダを初期化する。

   :param mark_nbr: この :cpp:struct:`!mark_tag` を使用する静的正規表現内でこの :cpp:struct:`!mark_tag` を一意に識別する整数。
   :要件: :cpp:expr:`mark_nbr > 0`


.. _mark_tag.private-static-functions:

:cpp:struct:`!mark_tag` 非公開静的メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: static unspecified make_tag(int mark_nbr)

.. cpp:namespace-pop::
