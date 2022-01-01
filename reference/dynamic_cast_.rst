dynamic_cast\_ 関数テンプレート
===============================

.. cpp:function:: template<typename T, typename A> \
		  unspecified dynamic_cast_(A const & a)

   :cpp:func:`!dynamic_cast_` は、引数を異なる型へ動的キャストする遅延関数である。

   :param a: 動的キャストする遅延値。
   :tparam T: 引数の動的キャスト先の型。
   :returns: 評価時に引数を所望の型へ動的キャストする遅延オブジェクト。
