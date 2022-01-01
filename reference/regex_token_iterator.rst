regex_token_iterator 構造体テンプレート
=======================================

.. cpp:struct:: template<typename BidiIter> regex_token_iterator


.. cpp:namespace-push:: regex_token_iterator


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_token_iterator.hpp`>

   template<typename BidiIter> 
   struct :cpp:struct:`~::boost::xpressive::regex_token_iterator` {
     // 型
     typedef basic_regex< BidiIter >          regex_type;       
     typedef iterator_value< BidiIter >::type char_type;        
     typedef sub_match< BidiIter >            value_type;       
     typedef std::ptrdiff_t                   difference_type;  
     typedef value_type const \*               pointer;          
     typedef value_type const &               reference;        
     typedef std::forward_iterator_tag        iterator_category;

     // :ref:`構築、コピー、解体 <regex_token_iterator.construct-copy-destruct>`
     :cpp:func:`~regex_token_iterator::regex_token_iterator`\();
     :cpp:func:`~regex_token_iterator::regex_token_iterator`\(BidiIter, BidiIter, :cpp:struct:`basic_regex`\< BidiIter > const &);
     template<typename LetExpr> 
       :cpp:func:`~regex_token_iterator::regex_token_iterator`\(BidiIter, BidiIter, :cpp:struct:`basic_regex`\< BidiIter > const &, 
                            :samp:`{unspecified}`);
     template<typename Subs> 
       :cpp:func:`~regex_token_iterator::regex_token_iterator`\(BidiIter, BidiIter, :cpp:struct:`basic_regex`\< BidiIter > const &, 
                            Subs const &, 
                            regex_constants::match_flag_type = regex_constants::match_default);
     template<typename Subs, typename LetExpr> 
       :cpp:func:`~regex_token_iterator::regex_token_iterator`\(BidiIter, BidiIter, :cpp:struct:`basic_regex`\< BidiIter > const &, 
                            Subs const &, :samp:`{unspecified}`, 
                            regex_constants::match_flag_type = regex_constants::match_default);
     :cpp:func:`~regex_token_iterator::regex_token_iterator`\(:cpp:struct:`regex_token_iterator`\< BidiIter > const &);
     :cpp:struct:`regex_token_iterator`\< BidiIter >& :cpp:func:`operator=`\(:cpp:struct:`regex_token_iterator`\< BidiIter > const &);

     // :ref:`公開メンバ関数 <regex_token_iterator.public-member-functions>`
     value_type const & :cpp:func:`operator*`\() const;
     value_type const \* :cpp:func:`operator->`\() const;
     :cpp:struct:`regex_token_iterator` BidiIter > & :cpp:func:`operator++`\();
     :cpp:struct:`regex_token_iterator` BidiIter > :cpp:func:`operator++`\(int);
   };


説明
----

.. _regex_token_iterator.construct-copy-destruct:

:cpp:struct:`!regex_token_iterator` 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: regex_token_iterator()

   :事後条件: :cpp:expr:`*this` がシーケンスイテレータの終端。


.. cpp:function:: regex_token_iterator(BidiIter begin, BidiIter end, basic_regex< BidiIter > const & rex)

   :param begin: 検索する文字範囲の先頭。
   :param end: 検索する文字範囲の終端。
   :param rex: 検索する正規表現パターン。
   :要件: ``[begin,end)`` が有効な範囲。


.. cpp:function:: template<typename LetExpr> \
		  regex_token_iterator(BidiIter begin, BidiIter end, basic_regex< BidiIter > const & rex, unspecified args)

   :param begin: 検索する文字範囲の先頭。
   :param end: 検索する文字範囲の終端。
   :param rex: 検索する正規表現パターン。
   :param args: 意味アクションに対して引数束縛した :cpp:func:`!let()` 式。
   :要件: ``[begin,end)`` が有効な範囲。


.. cpp:function:: template<typename Subs> \
		  regex_token_iterator(BidiIter begin, BidiIter end, basic_regex< BidiIter > const & rex, Subs const & subs, regex_constants::match_flag_type flags = regex_constants::match_default)

   :param begin: 検索する文字範囲の先頭。
   :param end: 検索する文字範囲の終端。
   :param rex: 検索する正規表現パターン。
   :param subs: トークンとして扱う部分マッチを表す整数範囲。
   :param flags: シーケンスに対して正規表現がどのようにマッチするかを制御する省略可能なマッチフラグ（:cpp:enum:`!match_flag_type` を見よ）。
   :要件: ``[begin,end)`` が有効な範囲。
   :要件: :cpp:var:`!subs` が ``-1`` 以上の整数、あるいは全要素が ``-1`` 以上の整数である配列か空でない :cpp:class:`!std::vector\<>` のいずれか。


.. cpp:function:: template<typename Subs, typename LetExpr> \
		  regex_token_iterator(BidiIter begin, BidiIter end, basic_regex< BidiIter > const & rex, Subs const & subs, unspecified args, regex_constants::match_flag_type flags = regex_constants::match_default)

   :param begin: 検索する文字範囲の先頭。
   :param end: 検索する文字範囲の終端。
   :param rex: 検索する正規表現パターン。
   :param subs: トークンとして扱う部分マッチを表す整数範囲。
   :param flags: シーケンスに対して正規表現がどのようにマッチするかを制御する省略可能なマッチフラグ（:cpp:enum:`!match_flag_type` を見よ）。
   :要件: ``[begin,end)`` が有効な範囲。
   :要件: :cpp:var:`!subs` が ``-1`` 以上の整数、あるいは全要素が ``-1`` 以上の整数である配列か空でない :cpp:class:`!std::vector\<>` のいずれか。


.. cpp:function:: regex_token_iterator(regex_token_iterator< BidiIter > const & that)

   :事後条件: :cpp:expr:`*this == that`


.. cpp:function:: regex_token_iterator< BidiIter >& operator=(regex_token_iterator< BidiIter > const & that)

   :事後条件: :cpp:expr:`*this == that`


.. _regex_token_iterator.public-member-functions:

:cpp:struct:`!regex_token_iterator` 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: value_type const & operator*() const

.. cpp:function:: value_type const * operator->() const

.. cpp:function:: regex_token_iterator< BidiIter > & operator++()

   :cpp:expr:`N == -1` であれば :cpp:expr:`*this` をシーケンスイテレータの終端と同値に設定する。\ [#]_ :cpp:expr:`N+1 < subs.size()` であれば :cpp:var:`!N` を ``1`` 増やし、結果を :code:`((subs[N] == -1) ? value_type(what.prefix().str()) : value_type(what[subs[N]].str()))` と同値に設定する。それ以外の場合は、:cpp:expr:`what.prefix().first != what[0].second` かつ :cpp:var:`!match_prev_avail` 要素がフラグに設定されていなければ設定する。次に :cpp:expr:`regex_search(what[0].second, end, what, *pre, flags)` を呼び出したのと同様の振る舞いをする。ただし以下の点については振る舞いが異なる。前回見つかったマッチがゼロ幅（:cpp:expr:`what[0].length() == 0`）の場合、:cpp:expr:`what[0].second` を先頭とする非ゼロ幅マッチを探索する。これが失敗し、かつ :cpp:expr:`what[0].second != suffix().second` である場合に限り :cpp:expr:`what[0].second + 1` を先頭とするマッチ（これもゼロ幅かもしれない）を探索する。そのようなマッチが見つかった場合は :cpp:var:`!N` を ``0`` に設定し、結果を :code:`((subs[N] == -1) ? value_type(what.prefix().str()) : value_type(what[subs[N]].str()))` と同値に設定する。マッチが見つからなかった場合は :cpp:var:`!last_end` を最後に見つかったマッチの終端に設定し、:cpp:expr:`last_end != end` かつ :cpp:expr:`subs[0] == -1` であれば :cpp:var:`!N` を ``-1`` に、結果を :cpp:expr:`value_type(last_end, end)` と同値に設定する。それ以外の場合は :cpp:expr:`*this` をシーケンスの終端イテレータと等値に設定する。


.. cpp:function:: regex_token_iterator< BidiIter > operator++(int)

.. cpp:namespace-pop::


.. [#] 訳注　:cpp:var:`!N` の説明は原文にもありませんが、構築直後は 0 である内部変数です。
