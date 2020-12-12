const_cast\_ 関数テンプレート
=============================

.. cpp:function:: template<typename T, typename A> \
		  unspecified const_cast_(A const& a)

   :cpp:func:`!const_cast_` は、引数を異なる型へ const キャストする遅延関数である。

   :param a: const キャストする遅延値。
   :tparam T: 引数の const キャスト先の型。
   :returns: 評価時に引数を所望の型へ const キャストする遅延オブジェクト。
