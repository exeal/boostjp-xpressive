after 関数テンプレート
======================

.. cpp:function:: template<typename Expr> \
		  unspecified after(Expr const& expr)

   肯定後読み表明。

   :param expr: 肯定後読み表明に使用する部分式。
   :要件: :cpp:var:`!expr` の文字数は可変にできない。


説明
----

:cpp:expr:`after(expr)` は部分式 :cpp:var:`!expr` がシーケンス内の現在位置から :cpp:var:`!expr` の長さ戻ったところでマッチすれば成功する。:cpp:var:`!expr` はマッチに含まれない。例えば :cpp:expr:`after("foo")` は現在位置が :regex-input:`foo` の直後であれば成功する。肯定後読み表明はビット否定演算子で否定できる。

.. note:: :cpp:expr:`after(expr)` は Perl の :regexp:`(?<=...)` 拡張と等価である。:cpp:expr:`~after(expr)` は否定後読みであり、Perl の :regexp:`(?<!...)` 拡張と等価である。
