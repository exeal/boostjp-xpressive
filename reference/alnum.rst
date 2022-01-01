alnum グローバル変数
====================

.. cpp:var:: unspecified alnum

   英数字にマッチする。


説明
----

文字が英数字か決定する正規表現特性。英数字以外にマッチさせる場合は :cpp:expr:`~alnum` を使用する。

.. note:: :cpp:expr:`alnum` は Perl の /:regexp:`[[:alnum:]]`/ と等価である。:cpp:expr:`~alnum` は Perl の /:regexp:`[[:^alnum:]]`/ と等価である。
