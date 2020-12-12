alpha グローバル変数
====================

.. cpp:var:: unspecified alpha

   アルファベットにマッチする。


説明
----

文字がアルファベットか決定する正規表現特性。アルファベット以外にマッチさせる場合は :cpp:expr:`~alpha` を使用する。

.. note:: :cpp:expr:`alpha` は Perl の /:regexp:`[[:alpha:]]`/ と等価である。:cpp:expr:`~alpha` は Perl の /:regexp:`[[:^alpha:]]`/ と等価である。
