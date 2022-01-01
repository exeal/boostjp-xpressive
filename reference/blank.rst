blank グローバル変数
====================

.. cpp:var:: unspecified blank

   空白（水平空白）にマッチする。


説明
----

文字が空白か決定する正規表現特性。空白以外にマッチさせる場合は :cpp:expr:`~blank` を使用する。

.. note:: :cpp:expr:`blank` は Perl の /:regexp:`[[:blank:]]`/ と等価である。:cpp:expr:`~blank` は Perl の /:regexp:`[[:^blank:]]`/ と等価である。
