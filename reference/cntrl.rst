cntrl グローバル変数
====================

.. cpp:var:: unspecified cntrl

   制御文字にマッチする。


説明
----

文字が制御文字か決定する正規表現特性。制御文字以外にマッチさせる場合は :cpp:expr:`~cntrl` を使用する。

.. note:: :cpp:expr:`cntrl` は Perl の /:regexp:`[[:cntrl:]]`/ と等価である。:cpp:expr:`~cntrl` は Perl の /:regexp:`[[:^cntrl:]]`/ と等価である。
