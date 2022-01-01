cref 関数テンプレート
=====================

.. cpp:function:: template<typename T> \
		  reference<T const> const cref(T const& t)

   const への参照を格納する :cpp:class:`reference\<>` オブジェクトを構築するヘルパ。

   :returns: :cpp:expr:`reference<T const>(t)`
