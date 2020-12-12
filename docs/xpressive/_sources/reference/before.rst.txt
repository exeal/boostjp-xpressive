before 関数テンプレート
=======================

.. cpp:function:: template<typename Expr> \
		  unspecified before(Expr const& expr)

   肯定先読み表明。

   :param expr: 肯定先読み表明に使用する部分式。


説明
----

:cpp:expr:`before(expr)` は部分式 :cpp:var:`!expr` がシーケンス内の現在位置でマッチすれば成功するが、:cpp:var:`!expr` はマッチに含まれない。例えば :cpp:expr:`before("foo")` は現在位置が :regex-input:`foo` の直前であれば成功する。肯定先読み表明はビット否定演算子で否定できる。

.. note:: :cpp:expr:`before(expr)` は Perl の :regexp:`(?=...)` 拡張と等価である。:cpp:expr:`~before(expr)` は否定先読みであり、Perl の :regexp:`(?!...)` 拡張と等価である。
