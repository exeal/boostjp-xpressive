lower グローバル変数
====================

.. cpp:var:: unspecified lower

   小文字にマッチする。


説明
----

文字が小文字か決定する正規表現特性。小文字以外にマッチさせる場合は :cpp:expr:`~lower` を使用する。

.. note:: :cpp:expr:`lower` は Perl の /:regexp:`[[:lower:]]`/ と等価である。:cpp:expr:`~lower` は Perl の /:regexp:`[[:^lower:]]`/ と等価である。
