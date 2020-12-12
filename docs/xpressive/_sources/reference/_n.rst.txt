_n グローバル定数
=================

.. cpp:var:: proto::terminal<char>::type const _n

   リテラルの改行文字 :regex-input:`\\n` にマッチする。


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_primitives.hpp`>

   proto::terminal< char >::type const _n;


説明
----

:cpp:var:`!_n` は改行文字 :regexp:`\\n` 1 文字にマッチする。改行以外の文字にマッチさせる場合は :cpp:expr:`~_n` を使用する。

.. note:: :cpp:expr:`_n` は Perl で /s 修飾子を指定しなかった場合の :regexp:`.` と同じである。
