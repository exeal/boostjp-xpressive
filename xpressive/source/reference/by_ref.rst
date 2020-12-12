by_ref 関数テンプレート
=======================

.. cpp:function:: template<typename BidiIter> \
		  proto::terminal<reference_wrapper<basic_regex<BidiIter> const>>::type const by_ref(basic_regex<BidiIter> const& rex)

   正規表現オブジェクトを参照により組み込む。

   :param rex: 参照により組み込む :cpp:struct:`basic_regex` オブジェクト。
