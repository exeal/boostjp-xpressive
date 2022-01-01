swap 関数テンプレート
=====================

2 つの :cpp:struct:`basic_regex` オブジェクトの内容を交換する。

.. cpp:function::
   template<typename BidiIter> \
   void swap(basic_regex< BidiIter > & left, basic_regex< BidiIter > & right)

   .. note::
      参照まで追跡しない浅い交換である。:cpp:struct:`basic_regex` オブジェクトを参照により別の正規表現に組み込み、他の :cpp:struct:`basic_regex` オブジェクトと内容を交換すると、外側の正規表現からはこの変更を検出できない。これは :cpp:func:`swap()` が例外を送出できないためである。

   :param left: 第 1 の :cpp:struct:`basic_regex` オブジェクト。
   :param right: 第 2 の :cpp:struct:`basic_regex` オブジェクト。
   :例外: 送出しない。
