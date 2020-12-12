_s グローバル変数
=================

.. cpp:var:: unspecified _s

   空白類文字を表す表明。


説明
----

:cpp:var:`!_s` は空白類文字 1 文字にマッチする。この正規表現特性は空白類文字を規定するのに使用する。空白類文字以外にマッチさせる場合は :cpp:expr:`~_s` を使用する。

.. note:: :cpp:expr:`_s` は Perl の :regexp:`\\s` と同じである。:cpp:expr:`~_s` は Perl の :regexp:`\\S` と同じである。
