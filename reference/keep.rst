keep 関数テンプレート
=====================

.. cpp:function:: template<typename Expr> \
		  unspecified keep(Expr const& expr)

   独立部分式を作成する。

   :param expr: 変更する部分式。


説明
----

部分式のバックトラックを抑止する。部分式内の選択と繰り返しは 1 つの経路だけマッチし、他の選択肢は試行しない。

.. note:: :cpp:expr:`keep(expr)` は Perl の :regexp:`(?>...)` 拡張と等価である。
