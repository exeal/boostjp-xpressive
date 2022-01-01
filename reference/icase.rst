icase 関数テンプレート
======================

.. cpp:function:: template<typename Expr> \
		  unspecified icase(Expr const& expr)

   部分式を大文字小文字を区別しないようにする。


説明
----

部分式を大文字小文字を区別しないようにするには :cpp:func:`!icase()` を使用する。例えば :cpp:expr:`"foo" >> icase(set['b'] >> "ar")` は :regex-input:`foo` の後に :regex-input:`bar` が続くシーケンスにマッチするが、後半は大文字小文字を区別しない。
