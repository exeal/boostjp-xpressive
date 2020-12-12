graph グローバル変数
====================

.. cpp:var:: unspecified graph

   グラフィカルな文字にマッチする。


説明
----

文字がグラフィカルな文字か決定する正規表現特性。グラフィカルな文字以外にマッチさせる場合は :cpp:expr:`~digit` を使用する。

.. note:: :cpp:expr:`graph` は Perl の /:regexp:`[[:graph:]]`/ と等価である。:cpp:expr:`~graph` は Perl の /:regexp:`[[:^graph:]]`/ と等価である。
