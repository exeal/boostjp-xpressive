set グローバル変数
==================

.. cpp:var:: unspecified set

   文字集合（文字セット）を作成するのに使用する。


説明
----

識別子 :cpp:var:`!set` を使って文字集合を作成する方法は 2 つある。より簡単なのは :cpp:expr:`(set= 'a','b','c')` のように集合内の文字をカンマで区切って並べる方法である。この集合は :regex-input:`a` 、:regex-input:`b` 、:regex-input:`c` にマッチする。もう 1 つは set の添字演算子の引数として集合を定義する方法である。例えば :cpp:expr:`set[ 'a' | range('b','c') | digit ]` は :regex-input:`a` 、:regex-input:`b` 、:regex-input:`c` 、数字にマッチする。

:cpp:var:`!set` の補集合を得るには ~ 演算子を適用する。例えば :cpp:expr:`~(set= 'a','b','c')` は :regex-input:`a` 、:regex-input:`b` 、:regex-input:`c` 以外の文字にマッチする。

:cpp:var:`!set` は他の集合や補集合と和をとることもできる。例えば :cpp:expr:`set[ ~digit | ~(set= 'a','b','c') ]` のようにする。
