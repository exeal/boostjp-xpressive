optional 関数テンプレート
=========================

.. cpp:function:: template<typename Expr> \
		  proto::result_of::make_expr<proto::tag::logical_not, proto::default_domain, Expr const&>::type const optional(Expr const& expr)

   部分式を省略可能にする。:cpp:expr:`!as_xpr(expr)` と等価である。

   :param expr: 省略可能にする部分式。
