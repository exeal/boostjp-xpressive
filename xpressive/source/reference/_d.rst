_d グローバル変数
=================

.. cpp:var:: unspecified _d

   数字を表す表明。


説明
----

:cpp:var:`!_d` は数字 1 文字にマッチする。この正規表現特性は数字を規定するのに使用する。数字以外にマッチさせる場合は :cpp:expr:`~_d` を使用する。

.. note:: :cpp:expr:`_d` は Perl の :regexp:`\\d` と同じである。:cpp:expr:`~_d` は Perl の :regexp:`\\D` と同じである。
