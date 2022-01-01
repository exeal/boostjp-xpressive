range_end 関数
==============

.. cpp:function:: 
   template<typename BidiIter> \
   BidiIter range_end(sub_match< BidiIter > & sub)
   template<typename BidiIter> \
   BidiIter range_end(sub_match< BidiIter > const & sub)

   :cpp:struct:`sub_match\<>` を有効な範囲にするための :cpp:func:`!range_end`。

   :param sub: 範囲を表す :cpp:struct:`sub_match\<>` オブジェクト
   :要件: :cpp:expr:`sub.second` が単方向でない
   :returns: :cpp:expr:`sub.second`
