space グローバル変数
====================

.. cpp:var:: unspecified space

   区切り文字にマッチする。


説明
----

文字が空白類文字か決定する正規表現特性。空白類文字以外にマッチさせる場合は :cpp:expr:`~space` を使用する。

.. note:: :cpp:expr:`space` は Perl の /:regexp:`[[:space:]]`/ と等価である。:cpp:expr:`~space` は Perl の /:regexp:`[[:^space:]]`/ と等価である。
