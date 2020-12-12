xdigit グローバル変数
=====================

.. cpp:var:: unspecified xdigit

   区切り文字にマッチする。


説明
----

文字が 16 進数字か決定する正規表現特性。16 進数字以外にマッチさせる場合は :cpp:expr:`~xdigit` を使用する。

.. note:: :cpp:expr:`xdigit` は Perl の /:regexp:`[[:xdigit:]]`/ と等価である。:cpp:expr:`~xdigit` は Perl の /regexp:`[[:^xdigit:]]`/ と等価である。
