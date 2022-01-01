as 関数テンプレート
===================

.. cpp:function:: template<typename T, typename A> \
		  unspecified as(A const& a)

   :cpp:func:`!as()` は、xpressive の意味アクションにおいて引数を異なる型へ字句キャストする遅延関数である。

   :param a: 字句キャストする遅延値。
   :tparam T: 引数の字句キャスト先の型。
   :returns: 評価時に引数を所望の型へ字句キャストする遅延オブジェクト。
