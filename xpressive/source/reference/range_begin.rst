range_begin 関数
================

.. cpp:function::
   template<typename BidiIter> \
   BidiIter range_begin(sub_match< BidiIter > & sub)
   template<typename BidiIter> \
   BidiIter range_begin(sub_match< BidiIter > const & sub)

   :cpp:struct:`sub_match\<>` を有効な範囲にするための :cpp:func:`!range_begin`。

   :param sub: 範囲を表す :cpp:struct:`sub_match\<>` オブジェクト
   :要件: :cpp:expr:`sub.first` が単方向でない
   :returns: :cpp:expr:`sub.first`
