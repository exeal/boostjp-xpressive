eos グローバル変数
==================

.. cpp:var:: unspecified eos

   シーケンスの終端を表す表明。


説明
----

文字シーケンス ``[begin, end)`` について、:cpp:var:`!eos` はゼロ幅の部分シーケンス ``[end, end)`` にマッチする。

.. note:: Perl のシーケンス終端表明 :regexp:`$` と異なり、:cpp:expr:`*(end-1)` が ``'\n'`` であれば :cpp:var:`!eos` は位置 ``[end-1, end)`` にはマッチしない。この振る舞いを得るには :cpp:expr:`(!_n >> eos)` を使用する。
