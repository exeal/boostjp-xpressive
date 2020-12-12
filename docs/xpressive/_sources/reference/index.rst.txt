リファレンス
============

.. contents::
   :depth: 1
   :local:


.. toctree::
   :hidden:

   -externals


<boost/xpressive/basic_regex.hpp> ヘッダ
----------------------------------------

.. toctree::
   :hidden:

   basic_regex
   swap

:cpp:struct:`basic_regex\<>` クラステンプレートの定義と、関連するヘルパ関数がある。

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       template<typename BidiIter> struct :cpp:struct:`basic_regex`;
       template<typename BidiIter> void :cpp:func:`swap`\(:cpp:struct:`basic_regex`\< BidiIter > &, :cpp:struct:`basic_regex`\< BidiIter > &);
     }
   }


<boost/xpressive/match_results.hpp> ヘッダ
------------------------------------------

.. toctree::
   :hidden:

   match_results
   regex_id_filter_predicate

:cpp:struct:`match_results` 型の定義と、関連するヘルパがある。:cpp:struct:`match_results` 型は :cpp:func:`regex_match()` および :cpp:func:`regex_search()` 操作の結果を保持する。

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       template<typename BidiIter> struct :cpp:struct:`match_results`;
       template<typename BidiIter> struct :cpp:struct:`regex_id_filter_predicate`;
     }
   }


<boost/xpressive/regex_actions.hpp> ヘッダ
------------------------------------------

xpressive におけるアクション式の構文要素がある。

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       template<typename :cpp:concept:`~template<> ::boost::PolymorphicFunctionObject`> struct :cpp:struct:`function`;
       template<typename T> struct :cpp:struct:`local`;
       template<typename T, int I, typename Dummy> struct :cpp:struct:`placeholder`;
       template<typename T> struct :cpp:struct:`reference`;
       template<typename T> struct :cpp:struct:`value`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::at` >::type const :cpp:var:`at`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::push` >::type const :cpp:var:`push`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::push_back` >::type const :cpp:var:`push_back`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::push_front` >::type const :cpp:var:`push_front`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::pop` >::type const :cpp:var:`pop`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::pop_back` >::type const :cpp:var:`pop_back`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::pop_front` >::type const :cpp:var:`pop_front`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::top` >::type const :cpp:var:`top`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::back` >::type const :cpp:var:`back`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::front` >::type const :cpp:var:`front`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::first` >::type const :cpp:var:`first`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::second` >::type const :cpp:var:`second`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::matched` >::type const :cpp:var:`matched`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::length` >::type const :cpp:var:`length`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::str` >::type const :cpp:var:`str`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::insert` >::type const :cpp:var:`insert`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::make_pair` >::type const :cpp:var:`make_pair`;
       :cpp:class:`~::boost::function`\< :cpp:struct:`op::unwrap_reference` >::type const :cpp:var:`unwrap_reference`;
       template<typename T, typename A> :samp:`{unspecified}` :cpp:func:`as`\(A const &);
       template<typename T, typename A> :samp:`{unspecified}` :cpp:func:`static_cast_`\(A const &);
       template<typename T, typename A> :samp:`{unspecified}` :cpp:func:`dynamic_cast_`\(A const &);
       template<typename T, typename A> :samp:`{unspecified}` :cpp:func:`const_cast_`\(A const &);
       template<typename T> value< T > const :cpp:func:`val`\(T const &);
       template<typename T> reference< T > const :cpp:func:`ref`\(T &);
       template<typename T> reference< T const  > const :cpp:func:`cref`\(T const &);
       template<typename T> :samp:`{unspecified}` :cpp:func:`check`\(T const &);
       template<typename... ArgBindings> :samp:`{unspecified}` :cpp:func:`let`\(ArgBindings const &...);
       template<typename T, typename... Args> :samp:`{unspecified}` :cpp:func:`construct`\(Args const &...);
       namespace op {
         template<typename T> struct :cpp:struct:`~op::as`;
	 struct :cpp:struct:`~op::at`;
	 struct :cpp:struct:`~op::back`;
	 template<typename T> struct :cpp:struct:`~op::const_cast_`;
	 template<typename T> struct :cpp:struct:`~op::construct`;
	 template<typename T> struct :cpp:struct:`~op::dynamic_cast_`;
	 struct :cpp:struct:`~op::first`;
	 struct :cpp:struct:`~op::front`;
	 struct :cpp:struct:`~op::insert`;
	 struct :cpp:struct:`~op::length`;
	 struct :cpp:struct:`~op::make_pair`;
	 struct :cpp:struct:`~op::matched`;
	 struct :cpp:struct:`~op::pop`;
	 struct :cpp:struct:`~op::pop_back`;
	 struct :cpp:struct:`~op::pop_front`;
	 struct :cpp:struct:`~op::push`;
	 struct :cpp:struct:`~op::push_back`;
	 struct :cpp:struct:`~op::push_front`;
	 struct :cpp:struct:`~op::second`;
	 template<typename T> struct :cpp:struct:`~op::static_cast_`;
	 struct :cpp:struct:`~op::str`;
	 template<typename Except> struct :cpp:struct:`~op::throw_`;
	 struct :cpp:struct:`~op::top`;
	 struct :cpp:struct:`~op::unwrap_reference`;
       }
     }
   }

.. toctree::
   :hidden:

   function
   local
   placeholder
   reference
   value
   at
   push
   push_back
   push_front
   pop
   pop_back
   pop_front
   top
   back
   front
   first
   second
   matched
   length
   str
   insert
   make_pair
   unwrap_reference
   as
   static_cast_
   dynamic_cast_
   const_cast_
   val
   ref
   cref
   check
   let
   construct

   op.as
   op.at
   op.back
   op.const_cast_
   op.construct
   op.dynamic_cast_
   op.first
   op.front
   op.insert
   op.length
   op.make_pair
   op.matched
   op.pop
   op.pop_back
   op.pop_front
   op.push
   op.push_back
   op.push_front
   op.second
   op.static_cast_
   op.str
   op.throw_
   op.top
   op.unwrap_reference


<boost/xpressive/regex_algorithms.hpp> ヘッダ
---------------------------------------------

:cpp:func:`regex_match()` 、:cpp:func:`regex_search()` および :cpp:func:`regex_replace()` アルゴリズムがある。

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       template<typename BidiIter>
         bool :cpp:func:`regex_match`\(BidiIter, BidiIter, :cpp:struct:`match_results`\< BidiIter > &,
                           :cpp:struct:`basic_regex`\< BidiIter > const &,
                           regex_constants::match_flag_type = regex_constants::match_default);
       template<typename BidiIter>
         bool :cpp:func:`regex_match`\(BidiIter, BidiIter, :cpp:struct:`basic_regex`\< BidiIter > const &,
                           regex_constants::match_flag_type = regex_constants::match_default);
       template<typename Char> bool :cpp:func:`regex_match`\(Char \*, :cpp:struct:`match_results`\< Char \* > &,
                           :cpp:struct:`basic_regex`\< Char \* > const &,
                           regex_constants::match_flag_type = regex_constants::match_default);
       template<typename BidiRange, typename BidiIter>
         bool :cpp:func:`regex_match`\(BidiRange &, :cpp:struct:`match_results`\< BidiIter > &,
                           :cpp:struct:`basic_regex`\< BidiIter > const &,
                           regex_constants::match_flag_type = regex_constants::match_default,
                           :samp:`{unspecified}` = 0);
       template<typename BidiRange, typename BidiIter>
         bool :cpp:func:`regex_match`\(BidiRange const &, :cpp:struct:`match_results`\< BidiIter > &,
                           :cpp:struct:`basic_regex`\< BidiIter > const &,
                           regex_constants::match_flag_type = regex_constants::match_default,
                           :samp:`{unspecified}` = 0);
       template<typename Char>
         bool :cpp:func:`regex_match`\(Char \*, :cpp:struct:`basic_regex`\< Char \* > const &,
                           regex_constants::match_flag_type = regex_constants::match_default);
       template<typename BidiRange, typename BidiIter>
         bool :cpp:func:`regex_match`\(BidiRange &, :cpp:struct:`basic_regex`\< BidiIter > const &,
                           regex_constants::match_flag_type = regex_constants::match_default,
                           :samp:`{unspecified}` = 0);
       template<typename BidiRange, typename BidiIter>
         bool :cpp:func:`regex_match`\(BidiRange const &, :cpp:struct:`basic_regex`\< BidiIter > const &,
                           regex_constants::match_flag_type = regex_constants::match_default,
                           :samp:`{unspecified}` = 0);
       template<typename BidiIter>
         bool :cpp:func:`regex_search`\(BidiIter, BidiIter, :cpp:struct:`match_results`\< BidiIter > &,
                           :cpp:struct:`basic_regex`\< BidiIter > const &,
                           regex_constants::match_flag_type = regex_constants::match_default);
       template<typename BidiIter>
         bool :cpp:func:`regex_search`\(BidiIter, BidiIter, :cpp:struct:`basic_regex`\< BidiIter > const &,
                           regex_constants::match_flag_type = regex_constants::match_default);
       template<typename Char>
         bool :cpp:func:`regex_search`\(Char \*, :cpp:struct:`match_results`\< Char \* > &,
                           :cpp:struct:`basic_regex`\< Char \* > const &,
                           regex_constants::match_flag_type = regex_constants::match_default);
       template<typename BidiRange, typename BidiIter> 
         bool :cpp:func:`regex_search`\(BidiRange &, :cpp:struct:`match_results`\< BidiIter > &, 
                           :cpp:struct:`basic_regex`\< BidiIter > const &, 
                           regex_constants::match_flag_type = regex_constants::match_default, 
                           :samp:`{unspecified}` = 0);
       template<typename BidiRange, typename BidiIter> 
         bool :cpp:func:`regex_search`\(BidiRange const &, :cpp:struct:`match_results`\< BidiIter > &, 
                           :cpp:struct:`basic_regex`\< BidiIter > const &, 
                           regex_constants::match_flag_type = regex_constants::match_default, 
                           :samp:`{unspecified}` = 0);
       template<typename Char> 
         bool :cpp:func:`regex_search`\(Char \*, :cpp:struct:`basic_regex`\< Char \* > const &, 
                           regex_constants::match_flag_type = regex_constants::match_default);
       template<typename BidiRange, typename BidiIter> 
         bool :cpp:func:`regex_search`\(BidiRange &, :cpp:struct:`basic_regex`\< BidiIter > const &, 
                           regex_constants::match_flag_type = regex_constants::match_default, 
                           :samp:`{unspecified}` = 0);
       template<typename BidiRange, typename BidiIter> 
         bool :cpp:func:`regex_search`\(BidiRange const &, :cpp:struct:`basic_regex`\< BidiIter > const &, 
                           regex_constants::match_flag_type = regex_constants::match_default, 
                           :samp:`{unspecified}` = 0);
       template<typename OutIter, typename BidiIter, typename Formatter> 
         OutIter :cpp:func:`regex_replace`\(OutIter, BidiIter, BidiIter, 
                               :cpp:struct:`basic_regex`\< BidiIter > const &, 
                               Formatter const &, 
                               regex_constants::match_flag_type = regex_constants::match_default, 
                               :samp:`{unspecified}` = 0);
       template<typename OutIter, typename BidiIter> 
         OutIter :cpp:func:`regex_replace`\(OutIter, BidiIter, BidiIter, 
                               :cpp:struct:`basic_regex`\< BidiIter > const &, 
                               typename iterator_value< BidiIter >::type const \*, 
                               regex_constants::match_flag_type = regex_constants::match_default);
       template<typename BidiContainer, typename BidiIter, typename Formatter> 
         BidiContainer 
         :cpp:func:`regex_replace`\(BidiContainer &, :cpp:struct:`basic_regex`\< BidiIter > const &, 
                       Formatter const &, 
                       regex_constants::match_flag_type = regex_constants::match_default, 
                       :samp:`{unspecified}` = 0);
       template<typename BidiContainer, typename BidiIter, typename Formatter> 
         BidiContainer 
         :cpp:func:`regex_replace`\(BidiContainer const &, :cpp:struct:`basic_regex`\< BidiIter > const &, 
                       Formatter const &, 
                       regex_constants::match_flag_type = regex_constants::match_default, 
                       :samp:`{unspecified}` = 0);
       template<typename Char, typename Formatter> 
         std::basic_string< typename remove_const< Char >::type > 
         :cpp:func:`regex_replace`\(Char \*, :cpp:struct:`basic_regex`\< Char \* > const &, Formatter const &, 
                       regex_constants::match_flag_type = regex_constants::match_default, 
                       :samp:`{unspecified}` = 0);
       template<typename BidiContainer, typename BidiIter> 
         BidiContainer 
         :cpp:func:`regex_replace`\(BidiContainer &, :cpp:struct:`basic_regex`\< BidiIter > const &, 
                       typename iterator_value< BidiIter >::type const \*, 
                       regex_constants::match_flag_type = regex_constants::match_default, 
                       :samp:`{unspecified}` = 0);
       template<typename BidiContainer, typename BidiIter> 
         BidiContainer 
         :cpp:func:`regex_replace`\(BidiContainer const &, :cpp:struct:`basic_regex`\< BidiIter > const &, 
                       typename iterator_value< BidiIter >::type const \*, 
                       regex_constants::match_flag_type = regex_constants::match_default, 
                       :samp:`{unspecified}` = 0);
       template<typename Char> 
         std::basic_string< typename remove_const< Char >::type > 
         :cpp:func:`regex_replace`\(Char \*, :cpp:struct:`basic_regex`\< Char \* > const &, 
                       typename add_const< Char >::type \*, 
                       regex_constants::match_flag_type = regex_constants::match_default);
     }
   }

.. toctree::
   :hidden:

   regex_match
   regex_search
   regex_replace


<boost/xpressive/regex_compiler.hpp> ヘッダ
-------------------------------------------

正規表現を文字列から構築するファクトリである :cpp:struct:`!regex_compiler` の定義がある。

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       template<typename BidiIter, typename RegexTraits, typename CompilerTraits>
         struct :cpp:struct:`regex_compiler`;
     }
   }

.. toctree::
   :hidden:

   regex_compiler


<boost/xpressive/regex_constants.hpp> ヘッダ
--------------------------------------------

:cpp:enum:`!syntax_option_type` 、:cpp:enum:`!match_flag_type` および :cpp:enum:`!error_type` 列挙の定義がある。

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       namespace regex_constants {
         enum :cpp:enum:`~regex_constants::syntax_option_type`;
         enum :cpp:enum:`~regex_constants::match_flag_type`;
         enum :cpp:enum:`~regex_constants::error_type`;
       }
     }
   }

.. toctree::
   :hidden:

   regex_constants.syntax_option_type
   regex_constants.match_flag_type
   regex_constants.error_type


<boost/xpressive/regex_error.hpp> ヘッダ
----------------------------------------

:cpp:struct:`!regex_error` 例外クラスの定義がある。

.. parsed-literal::

   :c:macro:`BOOST_XPR_ENSURE_`\(pred, code, msg)

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       struct :cpp:struct:`regex_error`;
     }
   }

.. toctree::
   :hidden:

   regex_error


<boost/xpressive/regex_iterator.hpp> ヘッダ
-------------------------------------------

シーケンス内のすべてのマッチを辿る STL 互換のイテレータである :cpp:struct:`!regex_iterator` 型の定義がある。

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       template<typename BidiIter> struct :cpp:struct:`regex_iterator`;
     }
   }

.. toctree::
   :hidden:

   regex_iterator


<boost/xpressive/regex_primitives.hpp> ヘッダ
---------------------------------------------

静的正規表現を記述するための構文要素がある。

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       struct :cpp:struct:`mark_tag`;

       unsigned int const :cpp:var:`inf`;    // 部分式の無限回の繰り返しに使う。
       :samp:`{unspecified}` :cpp:var:`nil`;    // 空のマッチ。
       :samp:`{unspecified}` :cpp:var:`alnum`;    // 英数字にマッチ。 
       :samp:`{unspecified}` :cpp:var:`alpha`;    // アルファベットにマッチ。 
       :samp:`{unspecified}` :cpp:var:`blank`;    // 空白（水平空白）文字にマッチ。 
       :samp:`{unspecified}` :cpp:var:`cntrl`;    // 制御文字にマッチ。
       :samp:`{unspecified}` :cpp:var:`digit`;    // 数字にマッチ。 
       :samp:`{unspecified}` :cpp:var:`graph`;    // グラフィカルな文字にマッチ。 
       :samp:`{unspecified}` :cpp:var:`lower`;    // 小文字にマッチ。 
       :samp:`{unspecified}` :cpp:var:`print`;    // 印字可能な文字にマッチ。 
       :samp:`{unspecified}` :cpp:var:`punct`;    // 区切り文字にマッチ。 
       :samp:`{unspecified}` :cpp:var:`space`;    // 空白類文字にマッチ。
       :samp:`{unspecified}` :cpp:var:`upper`;    // 大文字にマッチ。 
       :samp:`{unspecified}` :cpp:var:`xdigit`;    // 16 進数字にマッチ。 
       :samp:`{unspecified}` :cpp:var:`bos`;    // シーケンスの先頭を表す表明。 
       :samp:`{unspecified}` :cpp:var:`eos`;    // シーケンスの終端を表す表明。
       :samp:`{unspecified}` :cpp:var:`bol`;    // 行頭を表す表明。
       :samp:`{unspecified}` :cpp:var:`eol`;    // 行末を表す表明。 
       :samp:`{unspecified}` :cpp:var:`bow`;    // 語頭を表す表明。 
       :samp:`{unspecified}` :cpp:var:`eow`;    // 語末を表す表明。 
       :samp:`{unspecified}` :cpp:var:`_b`;    // 単語境界を表す表明。 
       :samp:`{unspecified}` :cpp:var:`_w`;    // 単語構成文字にマッチ。 
       :samp:`{unspecified}` :cpp:var:`_d`;    // 数字にマッチ。 
       :samp:`{unspecified}` :cpp:var:`_s`;    // 空白類文字にマッチ。 
       proto::terminal< char >::type const :cpp:var:`_n`;    // リテラルの改行 '\\n' にマッチ。 
       :samp:`{unspecified}` :cpp:var:`_ln`;    // 論理改行シーケンスにマッチ。
       :samp:`{unspecified}` :cpp:var:`_`;    // あらゆる文字にマッチ。
       :samp:`{unspecified}` :cpp:var:`self`;    // 現在の正規表現オブジェクトへの参照。 
       :samp:`{unspecified}` :cpp:var:`set`;    // 文字セットを作成するのに使用。
       :cpp:struct:`mark_tag` const :cpp:var:`s0`;    // Perl の $& 部分マッチプレースホルダ。 
       :cpp:struct:`mark_tag` const :cpp:var:`s1`;    // Perl の $1 部分マッチプレースホルダ。 
       :cpp:struct:`mark_tag` const :cpp:var:`s2`;
       :cpp:struct:`mark_tag` const :cpp:var:`s3`;
       :cpp:struct:`mark_tag` const :cpp:var:`s4`;
       :cpp:struct:`mark_tag` const :cpp:var:`s5`;
       :cpp:struct:`mark_tag` const :cpp:var:`s6`;
       :cpp:struct:`mark_tag` const :cpp:var:`s7`;
       :cpp:struct:`mark_tag` const :cpp:var:`s8`;
       :cpp:struct:`mark_tag` const :cpp:var:`s9`;
       :samp:`{unspecified}` :cpp:var:`a1`;
       :samp:`{unspecified}` :cpp:var:`a2`;
       :samp:`{unspecified}` :cpp:var:`a3`;
       :samp:`{unspecified}` :cpp:var:`a4`;
       :samp:`{unspecified}` :cpp:var:`a5`;
       :samp:`{unspecified}` :cpp:var:`a6`;
       :samp:`{unspecified}` :cpp:var:`a7`;
       :samp:`{unspecified}` :cpp:var:`a8`;
       :samp:`{unspecified}` :cpp:var:`a9`;
       template<typename :cpp:concept:`~template<> ::boost::Expr`> :samp:`{unspecified}` :cpp:func:`icase`\(Expr const &);
       template<typename Literal> :samp:`{unspecified}` :cpp:func:`as_xpr`\(Literal const &);
       template<typename BidiIter> 
         proto::terminal< reference_wrapper< :cpp:struct:`basic_regex`\< BidiIter > const  > >::type const 
         :cpp:func:`by_ref`\(:cpp:struct:`basic_regex`\< BidiIter > const &);
       template<typename Char> :samp:`{unspecified}` :cpp:func:`range`\(Char, Char);
       template<typename :cpp:concept:`~template<> ::boost::Expr`> 
         proto::result_of::make_expr< proto::tag::logical_not, proto::default_domain, Expr const & >::type const 
         :cpp:func:`optional`\(Expr const &);
       template<unsigned int Min, unsigned int Max, typename :cpp:concept:`~template<> ::boost::Expr`> 
         :samp:`{unspecified}` :cpp:func:`repeat`\(Expr const &);
       template<unsigned int Count, typename :cpp:concept:`~template<> ::boost::Expr`>; 
         :samp:`{unspecified}` :cpp:func:`repeat`\(Expr const &);
       template<typename :cpp:concept:`~template<> ::boost::Expr`> :samp:`{unspecified}` :cpp:func:`keep`\(Expr const &);
       template<typename :cpp:concept:`~template<> ::boost::Expr`> :samp:`{unspecified}` :cpp:func:`before`\(Expr const &);
       template<typename :cpp:concept:`~template<> ::boost::Expr`> :samp:`{unspecified}` :cpp:func:`after`\(Expr const &);
       template<typename Locale> :samp:`{unspecified}` :cpp:func:`imbue`\(Locale const &);
       template<typename Skip> :samp:`{unspecified}` :cpp:func:`skip`\(Skip const &);
     }
   }

.. toctree::
   :hidden:

   mark_tag
   inf
   nil
   alnum
   alpha
   blank
   cntrl
   digit
   graph
   lower
   print
   punct
   space
   upper
   xdigit
   bos
   eos
   bol
   eol
   bow
   eow
   _b
   _w
   _d
   _s
   _n
   _ln
   _
   _self
   set
   s0
   s1
   s2
   s3
   s4
   s5
   s6
   s7
   s8
   s9
   a1
   a2
   a3
   a4
   a5
   a6
   a7
   a8
   a9
   icase
   as_xpr
   by_ref
   range
   optional
   repeat
   keep
   before
   after
   imbue
   skip


<boost/xpressive/regex_token_iterator.hpp> ヘッダ
-------------------------------------------------

:cpp:struct:`!regex_token_iterator` の定義と、正規表現を使って文字列をトークンに分割する STL 互換のイテレータがある。

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       template<typename BidiIter> struct :cpp:struct:`regex_token_iterator`;
     }
   }

.. toctree::
   :hidden:

   regex_token_iterator


<boost/xpressive/regex_traits.hpp> ヘッダ
-----------------------------------------

:c:macro:`!BOOST_XPRESSIVE_USE_C_TRAITS` マクロにしたがって C 正規表現特性か C++ 正規表現特性のヘッダファイルをインクルードする。

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       struct :cpp:struct:`regex_traits_version_1_tag`;
       struct :cpp:struct:`regex_traits_version_2_tag`;
     }
   }

.. toctree::
   :hidden:

   regex_traits_version_1_tag
   regex_traits_version_2_tag


<boost/xpressive/sub_match.hpp> ヘッダ
--------------------------------------

:cpp:struct:`!sub_match\<>` クラステンプレートと、関連するヘルパ関数の定義がある。

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       template<typename BidiIter> struct :cpp:struct:`sub_match`;
       template<typename BidiIter> BidiIter :cpp:func:`range_begin`\(:cpp:struct:`sub_match`\< BidiIter > &);
       template<typename BidiIter> 
         BidiIter :cpp:func:`range_begin`\(:cpp:struct:`sub_match`\< BidiIter > const &);
       template<typename BidiIter> BidiIter :cpp:func:`range_end`\(:cpp:struct:`sub_match`\< BidiIter > &);
       template<typename BidiIter> 
         BidiIter :cpp:func:`range_end`\(:cpp:struct:`sub_match`\< BidiIter > const &);
       template<typename BidiIter, typename Char, typename Traits> 
         std::basic_ostream< Char, Traits > & 
         :ref:`operator\<\< <sub_match.operator.left-shift>`\(std::basic_ostream< Char, Traits > &, 
                    :cpp:struct:`sub_match`\< BidiIter > const &);
       template<typename BidiIter> 
         bool operator==(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator!=(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator<(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                        :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator<=(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator>=(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator>(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                        :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator==(typename iterator_value< BidiIter >::type const \* lhs, 
                      :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator!=(typename iterator_value< BidiIter >::type const \* lhs, 
                         :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator<(typename iterator_value< BidiIter >::type const \* lhs, 
                        :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator>(typename iterator_value< BidiIter >::type const \* lhs, 
                        :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator>=(typename iterator_value< BidiIter >::type const \* lhs, 
                         :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator<=(typename iterator_value< BidiIter >::type const \* lhs, 
                         :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator==(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         typename iterator_value< BidiIter >::type const \* rhs);
       template<typename BidiIter> 
         bool operator!=(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         typename iterator_value< BidiIter >::type const \* rhs);
       template<typename BidiIter> 
         bool operator<(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                        typename iterator_value< BidiIter >::type const \* rhs);
       template<typename BidiIter> 
         bool operator>(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                        typename iterator_value< BidiIter >::type const \* rhs);
       template<typename BidiIter> 
         bool operator>=(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         typename iterator_value< BidiIter >::type const \* rhs);
       template<typename BidiIter> 
         bool operator<=(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         typename iterator_value< BidiIter >::type const \* rhs);
       template<typename BidiIter> 
         bool operator==(typename iterator_value< BidiIter >::type const & lhs, 
                         :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator!=(typename iterator_value< BidiIter >::type const & lhs, 
                         :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator<(typename iterator_value< BidiIter >::type const & lhs, 
                        :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator>(typename iterator_value< BidiIter >::type const & lhs, 
                        :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator>=(typename iterator_value< BidiIter >::type const & lhs, 
                         :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator<=(typename iterator_value< BidiIter >::type const & lhs, 
                         :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         bool operator==(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         typename iterator_value< BidiIter >::type const & rhs);
       template<typename BidiIter> 
         bool operator!=(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         typename iterator_value< BidiIter >::type const & rhs);
       template<typename BidiIter> 
         bool operator<(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                        typename iterator_value< BidiIter >::type const & rhs);
       template<typename BidiIter> 
         bool operator>(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                        typename iterator_value< BidiIter >::type const & rhs);
       template<typename BidiIter> 
         bool operator>=(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         typename iterator_value< BidiIter >::type const & rhs);
       template<typename BidiIter> 
         bool operator<=(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                         typename iterator_value< BidiIter >::type const & rhs);
       template<typename BidiIter> 
         :cpp:struct:`sub_match`\< BidiIter >::string_type 
         operator+(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                   :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         :cpp:struct:`sub_match`\< BidiIter >::string_type 
         operator+(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                   typename iterator_value< BidiIter >::type const & rhs);
       template<typename BidiIter> 
         :cpp:struct:`sub_match`\< BidiIter >::string_type 
         operator+(typename iterator_value< BidiIter >::type const & lhs, 
                   :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         :cpp:struct:`sub_match`\< BidiIter >::string_type 
         operator+(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                   typename iterator_value< BidiIter >::type const \* rhs);
       template<typename BidiIter> 
         :cpp:struct:`sub_match`\< BidiIter >::string_type 
         operator+(typename iterator_value< BidiIter >::type const \* lhs, 
                   :cpp:struct:`sub_match`\< BidiIter > const & rhs);
       template<typename BidiIter> 
         :cpp:struct:`sub_match`\< BidiIter >::string_type 
         operator+(:cpp:struct:`sub_match`\< BidiIter > const & lhs, 
                   typename :cpp:struct:`sub_match`\< BidiIter >::string_type const & rhs);
       template<typename BidiIter> 
         :cpp:struct:`sub_match`\< BidiIter >::string_type 
         operator+(typename :cpp:struct:`sub_match`\< BidiIter >::string_type const & lhs, 
                   :cpp:struct:`sub_match`\< BidiIter > const & rhs);
     }
   }

.. toctree::
   :hidden:

   sub_match
   range_begin
   range_end
   sub_match.operator.left-shift


<boost/xpressive/traits/c_regex_traits.hpp> ヘッダ
--------------------------------------------------

静的・動的正規表現の振る舞いをカスタマイズする C ロカール関数のラッパである :cpp:struct:`!c_regex_traits` テンプレートの定義がある。


<boost/xpressive/traits/cpp_regex_traits.hpp> ヘッダ
----------------------------------------------------

静的・動的正規表現の振る舞いをカスタマイズする :cpp:struct:`!std::locale` のラッパである :cpp:struct:`!cpp_regex_traits` テンプレートの定義がある。


<boost/xpressive/traits/null_regex_traits.hpp> ヘッダ
-----------------------------------------------------

非文字データを検索する静的・動的正規表現で使用する控えの正規表現特性の実装である、:cpp:struct:`!null_regex_traits` テンプレートの定義がある。


<boost/xpressive/xpressive.hpp> ヘッダ
--------------------------------------

静的・動的両方の正規表現サポートを含む xpressive のすべてをインクルードする。


<boost/xpressive/xpressive_dynamic.hpp> ヘッダ
""""""""""""""""""""""""""""""""""""""""""""""

動的正規表現の記述と使用に必要なすべてをインクルードする。


<boost/xpressive/xpressive_fwd.hpp> ヘッダ
------------------------------------------

xpressive のすべての公開データ型の前方宣言。

.. parsed-literal::

   :c:macro:`BOOST_PROTO_FUSION_V2`
   :c:macro:`BOOST_XPRESSIVE_HAS_MS_STACK_GUARD`

.. parsed-literal::

   namespace boost {
     namespace xpressive {
       template<typename BidiIter> struct :cpp:struct:`basic_regex`;
       template<typename Char> struct :cpp:struct:`c_regex_traits`;
       template<typename RegexTraits> struct :cpp:struct:`compiler_traits`;
       template<typename Char> struct :cpp:struct:`cpp_regex_traits`;
       template<typename Traits> struct :cpp:struct:`has_fold_case`;
       template<typename Elem> struct :cpp:struct:`null_regex_traits`;
       template<typename BidiIter> struct :cpp:struct:`regex_token_iterator`;
       template<typename Char, typename Impl> struct :cpp:struct:`regex_traits`;

       typedef void const \* regex_id_type;
       typedef :cpp:struct:`basic_regex`\< std::string::const_iterator > sregex;
       typedef :cpp:struct:`basic_regex`\< char const \* > cregex;
       typedef :cpp:struct:`basic_regex`\< std::wstring::const_iterator > wsregex;
       typedef :cpp:struct:`basic_regex`\< wchar_t const \* > wcregex;
       typedef :cpp:struct:`sub_match`\< std::string::const_iterator > ssub_match;
       typedef :cpp:struct:`sub_match`\< char const \* > csub_match;
       typedef :cpp:struct:`sub_match`\< std::wstring::const_iterator > wssub_match;
       typedef :cpp:struct:`sub_match`\< wchar_t const \* > wcsub_match;
       typedef :cpp:struct:`regex_compiler`\< std::string::const_iterator > sregex_compiler;
       typedef :cpp:struct:`regex_compiler`\< char const \* > cregex_compiler;
       typedef :cpp:struct:`regex_compiler`\< std::wstring::const_iterator > wsregex_compiler;
       typedef :cpp:struct:`regex_compiler`\< wchar_t const \* > wcregex_compiler;
       typedef :cpp:struct:`regex_iterator`\< std::string::const_iterator > sregex_iterator;
       typedef :cpp:struct:`regex_iterator`\< char const \* > cregex_iterator;
       typedef :cpp:struct:`regex_iterator`\< std::wstring::const_iterator > wsregex_iterator;
       typedef :cpp:struct:`regex_iterator`\< wchar_t const \* > wcregex_iterator;
       typedef :cpp:struct:`regex_token_iterator`\< std::string::const_iterator > sregex_token_iterator;
       typedef :cpp:struct:`regex_token_iterator`\< char const \* > cregex_token_iterator;
       typedef :cpp:struct:`regex_token_iterator`\< std::wstring::const_iterator > wsregex_token_iterator;
       typedef :cpp:struct:`regex_token_iterator`\< wchar_t const \* > wcregex_token_iterator;
       typedef :cpp:struct:`match_results`\< std::string::const_iterator > smatch;
       typedef :cpp:struct:`match_results`\< char const \* > cmatch;
       typedef :cpp:struct:`match_results`\< std::wstring::const_iterator > wsmatch;
       typedef :cpp:struct:`match_results`\< wchar_t const \* > wcmatch;
       typedef :cpp:struct:`regex_id_filter_predicate`\< std::string::const_iterator > sregex_id_filter_predicate;
       typedef :cpp:struct:`regex_id_filter_predicate`\< char const \* > cregex_id_filter_predicate;
       typedef :cpp:struct:`regex_id_filter_predicate`\< std::wstring::const_iterator > wsregex_id_filter_predicate;
       typedef :cpp:struct:`regex_id_filter_predicate`\< wchar_t const \* > wcregex_id_filter_predicate;
       namespace op {
         template<typename T> struct :cpp:struct:`~op::as`;
         template<typename T> struct :cpp:struct:`~op::const_cast_`;
         template<typename T> struct :cpp:struct:`~op::construct`;
         template<typename T> struct :cpp:struct:`~op::dynamic_cast_`;
         template<typename T> struct :cpp:struct:`~op::static_cast_`;
         template<typename Except> struct :cpp:struct:`~op::throw_`;
       }
     }

.. toctree::
   :hidden:

   c_regex_traits
   compiler_traits
   cpp_regex_traits
   has_fold_case
   null_regex_traits
   regex_traits


<boost/xpressive/xpressive_static.hpp> ヘッダ
---------------------------------------------

静的正規表現の記述と使用に必要なすべてをインクルードする。


<boost/xpressive/xpressive_typeof.hpp> ヘッダ
---------------------------------------------

xpressive を Boost.Typeof ライブラリとともに使用するための型登録。
