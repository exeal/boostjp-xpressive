punct グローバル変数
====================

.. cpp:var:: unspecified punct

   区切り文字にマッチする。


説明
----

文字が区切り文字か決定する正規表現特性。区切り文字以外にマッチさせる場合は :cpp:expr:`~punct` を使用する。

.. note:: :cpp:expr:`punct` は Perl の /:regexp:`[[:punct:]]`/ と等価である。:cpp:expr:`~punct` は Perl の /:regexp:`[[:^punct:]]`/ と等価である。
