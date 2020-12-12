digit グローバル変数
====================

.. cpp:var:: unspecified digit

   数字にマッチする。


説明
----

文字が数字か決定する正規表現特性。数字以外にマッチさせる場合は :cpp:expr:`~digit` を使用する。

.. note:: :cpp:expr:`digit` は Perl の /:regexp:`[[:digit:]]`/ と等価である。:cpp:expr:`~digit` は Perl の /:regexp:`[[:^digit:]]`/ と等価である。
