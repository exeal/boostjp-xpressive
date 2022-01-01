repeat 関数
===========

.. cpp:function:: template<unsigned int, typename Expr> \
		  unspecified repeat(Expr const& expr)

   部分式を複数回繰り返す。

   :param expr: 繰り返す部分式。


説明
----

:cpp:func:`!repeat\<>()` 関数テンプレートは 2 形式ある。部分式に :samp:`{N}` 回マッチさせる場合は :cpp:expr:`repeat\<N>(expr)` を使用する。部分式を :samp:`{M}` から :samp:`{N}` 回マッチさせるには :cpp:expr:`repeat<M,N>(expr)` を使用する。

:cpp:func:`!repeat\<>()` 関数は貪欲な数量子を作成する。貪欲でない数量子にするには :cpp:expr:`-repeat<M,N>(expr)` のように単項マイナス演算子を適用する。
