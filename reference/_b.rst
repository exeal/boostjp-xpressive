_b グローバル変数
=================

.. cpp:var:: unspecified _b

   単語境界を表す表明。


説明
----

:cpp:var:`!_b` は語頭か語末のゼロ幅部分シーケンスにマッチする。:cpp:expr:`(bow|eow)` と等価である。この正規表現特性は単語の構成を規定するのに使用する。単語境界以外にマッチさせる場合は :cpp:expr:`~_b` を使用する。

.. note:: :cpp:expr:`_b` は Perl の :regexp:`\\b` と同じである。:cpp:expr:`~_b` は Perl の :regexp:`\\B` と同じである。
