as_xpr 関数テンプレート
=======================

.. cpp:function:: template<typename Literal> \
		  unspecified as_xpr(Literal const& literal)

   リテラルを正規表現にする。


説明
----

リテラルを正規表現にするには :cpp:func:`!as_xpr()` を使用する。例えば :cpp:expr:`"foo" >> "bar"` は右シフト演算子の両方のオペランドが :cpp:type:`!const char*` であり、そのような演算子は存在しないためコンパイルできない。:cpp:expr:`as_xpr("foo") >> "bar"` を代わりに使用する。

文字列リテラルだけでなく、文字リテラルに対しても :cpp:func:`!as_xpr()` を使用できる。例えば :cpp:expr:`as_xpr('a')` は :regex-input:`a` にマッチする。また :cpp:expr:`~as_xpr('a')` とすることで文字リテラルの否定が得られる。これは :regex-input:`a` 以外の文字にマッチする。
