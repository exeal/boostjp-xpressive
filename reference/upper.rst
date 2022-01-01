upper グローバル変数
====================

.. cpp:var:: unspecified upper

   区切り文字にマッチする。


説明
----

文字が大文字か決定する正規表現特性。大文字以外にマッチさせる場合は :cpp:expr:`~upper` を使用する。

.. note:: :cpp:expr:`upper` は Perl の /:regexp:`[[:upper:]]`/ と等価である。:cpp:expr:`~upper` は Perl の /:regexp:`[[:^upper:]]`/ と等価である。
