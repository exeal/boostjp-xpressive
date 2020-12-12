print グローバル変数
====================

.. cpp:var:: unspecified print

   印字可能文字にマッチする。


説明
----

文字が印字可能文字か決定する正規表現特性。印字可能文字以外にマッチさせる場合は :cpp:expr:`~print` を使用する。

.. note:: :cpp:expr:`print` は Perl の /:regexp:`[[:print:]]`/ と等価である。:cpp:expr:`~print` は Perl の /:regexp:`[[:^print:]]`/ と等価である。
