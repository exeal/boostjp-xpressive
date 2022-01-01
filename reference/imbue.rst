imbue 関数テンプレート
======================

.. cpp:function:: template<typename Locale> \
		  imbue(Locale const& loc)

   正規表現特性か :cpp:class:`!std::locale` を指定する。

   :param loc: :cpp:class:`!std::locale` か正規表現特性オブジェクト。


説明
----

:cpp:func:`!imbue()` は正規表現マッチ時に使用する特性かロカールを正規表現エンジンに対して指示する。特性・ロカールは、正規表現全体で同じものを使用しなければならない。例えば次のコードは正規表現で使用するロカールを指定する：:code:`std::locale loc; sregex rx = imbue(loc)(+digit);`
