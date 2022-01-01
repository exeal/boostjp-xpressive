regex_iterator 構造体テンプレート
=================================

.. cpp:struct:: template<typename BidiIter> regex_iterator

.. cpp:namespace-push:: regex_iterator


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_iterator.hpp`>

   template<typename BidiIter> 
   struct :cpp:struct:`~::boost::xpressive::regex_iterator` {
     // 型
     typedef :cpp:struct:`basic_regex`\< BidiIter >               regex_type;       
     typedef :cpp:struct:`match_results`\< BidiIter >             value_type;       
     typedef iterator_difference< BidiIter >::type difference_type;  
     typedef value_type const \*                    pointer;          
     typedef value_type const &                    reference;        
     typedef std::forward_iterator_tag             iterator_category;

     // :ref:`構築、コピー、解体 <regex_iterator.construct-copy-destruct>`
     :cpp:func:`~regex_iterator::regex_iterator`\();
     :cpp:func:`~regex_iterator::regex_iterator`\(BidiIter, BidiIter, :cpp:struct:`basic_regex`\< BidiIter > const &, 
                    regex_constants::match_flag_type = regex_constants::match_default);
     template<typename LetExpr> 
       :cpp:func:`~regex_iterator::regex_iterator`\(BidiIter, BidiIter, :cpp:struct:`basic_regex`\< BidiIter > const &, 
                      :samp:`{unspecified}`, 
                      regex_constants::match_flag_type = regex_constants::match_default);
     :cpp:func:`~regex_iterator::regex_iterator`\(:cpp:struct:`regex_iterator`\< BidiIter > const &);
     :cpp:struct:`regex_iterator`\< BidiIter >& :cpp:func:`operator=`\(:cpp:struct:`regex_iterator`\< BidiIter > const &);

     // :ref:`公開メンバ関数 <regex_iterator.public-member-functions>`
     value_type const & :cpp:func:`operator*`\() const;
     value_type const \* :cpp:func:`operator->`\() const;
     :cpp:struct:`regex_iterator`\< BidiIter > & :cpp:func:`operator++`\();
     :cpp:struct:`regex_iterator`\< BidiIter > :cpp:func:`operator++`\(int);


説明
----

.. _regex_iterator.construct-copy-destruct:

:cpp:struct:`!regex_iterator` 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: regex_iterator()

.. cpp:function:: regex_iterator(BidiIter begin, BidiIter end, basic_regex< BidiIter > const & rex, regex_constants::match_flag_type flags = regex_constants::match_default)

.. cpp:function:: template<typename LetExpr> regex_iterator(BidiIter begin, BidiIter end, basic_regex< BidiIter > const & rex, unspecified args, regex_constants::match_flag_type flags = regex_constants::match_default)

.. cpp:function:: regex_iterator(regex_iterator< BidiIter > const & that)

.. cpp:function:: regex_iterator< BidiIter > & operator=(regex_iterator< BidiIter > const & that)


.. _regex_iterator.public-member-functions:

:cpp:struct:`regex_iterator` 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: value_type const & operator*() const

.. cpp:function:: value_type const * operator->() const

.. cpp:function:: regex_iterator< BidiIter > & operator++()

   :cpp:expr:`what.prefix().first != what[0].second` かつ :cpp:var:`!match_prev_avail` 要素がフラグに設定されていなければ設定する。その上で :cpp:expr:`regex_search(what[0].second, end, what, *pre, flags)` を呼び出したのと同様に振る舞う。ただし以下の点については振る舞いが異なる：前回見つかったマッチがゼロ幅だった（:cpp:expr:`what[0].length() == 0`）場合は開始位置が :cpp:expr:`what[0].second` である非ゼロ幅のマッチを探索し、それが失敗かつ :cpp:expr:`what[0].second != suffix().second` である場合に限り開始位置が :cpp:expr:`what[0].second + 1` であるマッチ（これもゼロ幅である可能性がある）を探索する。それ以上マッチが見つからなければ、:cpp:expr:`*this` をシーケンスの終端を指すイテレータと等値に設定する。

   :事後条件:
      :cpp:expr:`(*this)->size() == pre->mark_count() + 1`
   :事後条件:
      :cpp:expr:`(*this)->empty() == false`
   :事後条件:
      :cpp:expr:`(*this)->prefix().first == i`。:samp:`{i}` は（前回見つかったマッチの終端位置を指すイテレータ）
   :事後条件:
      :cpp:expr:`(*this)->prefix().last == (**this)[0].first`
   :事後条件:
      :cpp:expr:`(*this)->prefix().matched == (*this)->prefix().first != (*this)->prefix().second`
   :事後条件:
      :cpp:expr:`(*this)->suffix().first == (**this)[0].second`
   :事後条件:
      :cpp:expr:`(*this)->suffix().last == end`
   :事後条件:
      :cpp:expr:`(*this)->suffix().matched == (*this)->suffix().first != (*this)->suffix().second`
   :事後条件:
      :cpp:expr:`(**this)[0].first == i`。:samp:`{i}` はこのマッチの開始イテレータ
   :事後条件:
      :cpp:expr:`(**this)[0].second == i`。:samp:`{i}` はこのマッチの終端イテレータ
   :事後条件:
      完全マッチが見つかった場合は :cpp:expr:`(**this)[0].matched == true` 、（:cpp:var:`!match_partial` フラグを設定して見つかった）部分マッチの場合は :cpp:expr:`(**this)[0].matched == true`。
   :事後条件:
      :cpp:expr:`n < (*this)->size()` である全ての整数 :samp:`{n}` について :cpp:expr:`(**this)[n].first == v`。:cpp:var:`!v` は :samp:`{n}` 番目の部分式にマッチしたシーケンスの先頭。:samp:`{n}` 番目の部分式がマッチに関与しなかった場合は :cpp:var:`!end`。
   :事後条件:
      :cpp:expr:`n < (*this)->size()` である全ての整数 :samp:`{n}` について :cpp:expr:`(**this)[n].second == v`。:cpp:var:`!v` は :samp:`{n}` 番目の部分式にマッチしたシーケンスの終端。:samp:`{n}` 番目の部分式がマッチに関与しなかった場合は :cpp:var:`!end`。
   :事後条件:
      :cpp:expr:`n < (*this)->size()` である全ての整数 :samp:`{n}` について :cpp:expr:`(**this)[n].matched == b`。:cpp:var:`!b` は :samp:`{n}` 番目の部分式がマッチに関与した場合は ``true`` 、それ以外の場合は ``false``。
   :事後条件:
      :cpp:expr:`(*this)->position() == d`。:cpp:var:`!d` は走査対象シーケンスの先頭からこのマッチの先頭までの距離


.. cpp:function:: regex_iterator< BidiIter > operator++(int)

.. cpp:namespace-pop::
