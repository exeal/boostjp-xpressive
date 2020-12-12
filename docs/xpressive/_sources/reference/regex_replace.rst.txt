regex_replace 関数
==================

与えられた入力シーケンス、正規表現、および書式化文字列、書式化オブジェクト、関数、式に対して出力シーケンスを構築する。

.. cpp:function::
   template<typename OutIter, typename BidiIter, typename Formatter> \
     OutIter regex_replace(OutIter out, BidiIter begin, BidiIter end, \
                           basic_regex< BidiIter > const & re, \
                           Formatter const & format, \
                           regex_constants::match_flag_type flags = regex_constants::match_default, \
                           unspecified = 0)
   template<typename OutIter, typename BidiIter> \
     OutIter regex_replace(OutIter out, BidiIter begin, BidiIter end, \
                           basic_regex< BidiIter > const & re, \
                           typename iterator_value< BidiIter >::type const * format, \
                           regex_constants::match_flag_type flags = regex_constants::match_default)
   template<typename BidiContainer, typename BidiIter, typename Formatter> \
     BidiContainer \
     regex_replace(BidiContainer & str, basic_regex< BidiIter > const & re, \
                   Formatter const & format, \
                   regex_constants::match_flag_type flags = regex_constants::match_default, \
                   unspecified = 0)
   template<typename BidiContainer, typename BidiIter, typename Formatter> \
     BidiContainer \
     regex_replace(BidiContainer const & str, basic_regex< BidiIter > const & re, \
                   Formatter const & format, \
                   regex_constants::match_flag_type flags = regex_constants::match_default, \
                   unspecified = 0)
   template<typename Char, typename Formatter> \
     std::basic_string< typename remove_const< Char >::type > \
     regex_replace(Char * str, basic_regex< Char * > const & re, \
                   Formatter const & format, \
                   regex_constants::match_flag_type flags = regex_constants::match_default, \
                   unspecified = 0)
   template<typename BidiContainer, typename BidiIter> \
     BidiContainer \
     regex_replace(BidiContainer & str, basic_regex< BidiIter > const & re, \
                   typename iterator_value< BidiIter >::type const * format, \
                   regex_constants::match_flag_type flags = regex_constants::match_default, \
                   unspecified = 0)
   template<typename BidiContainer, typename BidiIter> \
     BidiContainer \
     regex_replace(BidiContainer const & str, basic_regex< BidiIter > const & re, \
                   typename iterator_value< BidiIter >::type const * format, \
                   regex_constants::match_flag_type flags = regex_constants::match_default, \
                   unspecified = 0)
   template<typename Char> \
     std::basic_string< typename remove_const< Char >::type > \
     regex_replace(Char * str, basic_regex< Char * > const & re, \
                   typename add_const< Char >::type * format, \
                   regex_constants::match_flag_type flags = regex_constants::match_default)

   :code:`regex_iterator< BidiIter > i`\ :cpp:expr:`(begin, end, re, flags)` で :cpp:struct:`regex_iterator` オブジェクトを構築し、シーケンス ``[begin, end)`` に現れる :cpp:type:`!match_results< BidiIter >` 型のマッチ :cpp:var:`!m` すべてを :cpp:var:`!i` を使って列挙する。マッチが見つからず、かつ :cpp:expr:`\!(flags & format_no_copy)` であれば :cpp:expr:`std::copy(begin, end, out)` を呼び出す。それ以外の場合は、見つかった各マッチについて :cpp:expr:`\!(flags & format_no_copy)` であれば :cpp:expr:`std::copy(m.prefix().first, m.prefix().second, out)` を呼び出し、次に :cpp:expr:`m.format(out, format, flags)` を呼び出す。最後に :cpp:expr:`\!(flags & format_no_copy)` であれば :cpp:expr:`std::copy(last_m.suffix().first, last_m.suffix().second, out)` を呼び出す（:cpp:var:`!last_m` は最後に見つかったマッチのコピー）。

   :cpp:expr:`flags & format_first_only` が非ゼロの場合は、最初に見つかったマッチのみを置換する。

   :param begin: 入力シーケンスの先頭。
   :param end: 入力シーケンスの終端。
   :param flags: 正規表現をシーケンスに対してどのようにマッチさせるか制御する、省略可能なマッチフラグ（:cpp:enum:`match_flag_type` を見よ）。
   :param format: 置換シーケンスを整形する書式化文字列。または書式化関数、オブジェクト、式。
   :param out: 出力シーケンスを書き込む出力イテレータ。
   :param re: 使用する正規表現オブジェクト。
   :要件: :cpp:type:`!BidiIter` が双方向イテレータ（24.1.4）の要件を満たす。
   :要件: :cpp:type:`!OutIter` が出力イテレータ（24.1.2）の要件を満たす。
   :要件: :cpp:type:`!Formatter` 型が :cpp:type:`!ForwardRange` 、:cpp:type:`!Callable<match_results<BidiIter> >, Callable<match_results<BidiIter>, OutIter>` あるいは :cpp:type:`!Callable<match_results<BidiIter>, OutIter, regex_constants::match_flag_type>` のいずれか。または null 終端書式化文字列か書式化ラムダ式を表す式テンプレート。
   :要件: ``[begin, end)`` が有効なイテレータ範囲を表す。
   :returns: 出力シーケンスを書き込んだ後の出力イテレータ。
   :throws regex_error: スタックが枯渇した、または書式化文字列が不正な場合
