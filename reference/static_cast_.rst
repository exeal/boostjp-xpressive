static_cast\_ 関数テンプレート
==============================

.. cpp:function:: template<typename T, typename A> \
		  unspecified static_cast_(A const& a)

   :cpp:func:`!static_cast_` は、引数を異なる型へ静的キャストする遅延関数である。

   :parama: 静的キャストする遅延値。
   :tparam T: 引数の静的キャスト先の型。
   :returns: 評価時に引数を所望の型へ静的キャストする遅延オブジェクト。
