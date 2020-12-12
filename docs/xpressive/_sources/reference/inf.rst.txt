inf グローバル定数
==================

.. cpp:var:: unsigned int const inf

   部分式の無限回の繰り返し。


説明
----

制限なしの繰り返しを指定する :cpp:func:`!repeat\<>()` 関数テンプレートとともに使用する魔法数。:cpp:expr:`repeat<17, inf>('a')` のように使用する。これは Perl の /:regexp:`a{17,}`/ と等価である。
