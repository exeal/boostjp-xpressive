regex_match 関数
================

正規表現がシーケンスの先頭から終端までにマッチするか調べる。

.. cpp:function::
   template<typename BidiIter> \
   bool regex_match(BidiIter begin, BidiIter end, match_results<BidiIter>& what, basic_regex<BidiIter> const& re, regex_constants::match_flag_type flags = regex_constants::match_default)
   template<typename BidiIter> \
   bool regex_match(BidiIter begin, BidiIter end, basic_regex<BidiIter> const& re, regex_constants::match_flag_type flags = regex_constants::match_default)
   template<typename Char> \
   bool regex_match(Char* begin, match_results<Char*>& what, basic_regex<Char*> const& re, regex_constants::match_flag_type flags = regex_constants::match_default)
   template<typename BidiRange, typename BidiIter> \
   bool regex_match(BidiRange& rng, match_results<BidiIter>& what, basic_regex<BidiIter> const& re, regex_constants::match_flag_type flags = regex_constants::match_default, unspecified = 0)
   template<typename BidiRange, typename BidiIter> \
   bool regex_match(BidiRange const& rng, match_results<BidiIter>& what, basic_regex<BidiIter> const& re, regex_constants::match_flag_type flags = regex_constants::match_default, unspecified = 0)
   template<typename Char> \
   bool regex_match(Char* begin, basic_regex<Char*> const& re, regex_constants::match_flag_type flags = regex_constants::match_default)
   template<typename BidiRange, typename BidiIter> \
   bool regex_match(BidiRange& rng, basic_regex<BidiIter> const& re, regex_constants::match_flag_type flags = regex_constants::match_default, unspecified = 0)
   template<typename BidiRange, typename BidiIter> \
   bool regex_match(BidiRange const& rng, basic_regex<BidiIter> const& re, regex_constants::match_flag_type flags = regex_constants::match_default, unspecified = 0)

   正規表現 :cpp:var:`!re` とシーケンス ``[begin, end)`` 全体の間に完全なマッチがあるか確定する。

   :param begin: シーケンスの先頭。
   :param end: シーケンスの終端。
   :param flags: 正規表現をシーケンスに対してどのようにマッチさせるか制御する、省略可能なマッチフラグ（:cpp:enum:`!match_flag_type` を見よ）。
   :param re: 使用する正規表現オブジェクト。
   :param what: :cpp:struct:`!sub_match` を書き込む :cpp:struct:`match_results` 構造体。
   :要件: 型 BidiIter が双方向イテレータ（24.1.4）の要件を満たす。
   :要件: ``[begin, end)`` が有効なイテレータ範囲を表す。
   :returns: マッチが見つかった場合は ``true`` 、それ以外の場合は ``false``。
   :throws regex_error: スタックが枯渇した場合
