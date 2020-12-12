match_results 構造体テンプレート
================================

.. cpp:struct:: template<typename BidiIter> match_results

   :cpp:struct:`match_results\<>` クラステンプレートは :cpp:func:`regex_match()` や :cpp:func:`regex_search()` の結果を :cpp:struct:`sub_match` オブジェクトのコレクションとして保持する。


.. cpp:namespace-push:: match_results


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/match_results.hpp`>

   template<typename BidiIter> 
   struct :cpp:struct:`match_results` {
     // 型
     typedef iterator_value< BidiIter >::type      char_type;          
     typedef :samp:`{unspecified}`                           string_type;        
     typedef std::size_t                           size_type;          
     typedef :cpp:struct:`sub_match`\< BidiIter >                 value_type;         
     typedef iterator_difference< BidiIter >::type difference_type;    
     typedef value_type const &                    reference;          
     typedef value_type const &                    const_reference;    
     typedef :samp:`{unspecified}`                           iterator;           
     typedef :samp:`{unspecified}`                           const_iterator;     
     typedef :samp:`{unspecified}`                           nested_results_type;

     // :ref:`構築、コピー、解体 <match_results.construct-copy-destruct>`
     :cpp:func:`~match_results::match_results`\();
     :cpp:func:`~match_results::match_results`\(:cpp:struct:`match_results`\< BidiIter > const &);
     :cpp:struct:`match_results`\< BidiIter >& :cpp:func:`operator=`\(:cpp:struct:`match_results`\< BidiIter > const &);
     :cpp:func:`~match::results::~match_results`\();

     // :ref:`公開メンバ関数 <match_results.public-member-functions>`
     size_type :cpp:func:`size`\() const;
     bool :cpp:func:`empty`\() const;
     difference_type :cpp:func:`length`\(size_type = 0) const;
     difference_type :cpp:func:`position`\(size_type = 0) const;
     string_type :cpp:func:`str`\(size_type = 0) const;
     template<typename Sub> const_reference :cpp:func:`operator[]`\(Sub const &) const;
     const_reference :cpp:func:`prefix`\() const;
     const_reference :cpp:func:`suffix`\() const;
     const_iterator :cpp:func:`begin`\() const;
     const_iterator :cpp:func:`end`\() const;
     operator :cpp:func:`bool_type`\() const;
     bool :cpp:func:`operator!`\() const;
     regex_id_type :cpp:func:`regex_id`\() const;
     nested_results_type const & :cpp:func:`nested_results`\() const;
     template<typename Format, typename OutputIterator> 
       OutputIterator 
       :cpp:func:`format`\(OutputIterator, Format const &, 
              regex_constants::match_flag_type = regex_constants::format_default, 
              :samp:`{unspecified}` = 0) const;
     template<typename OutputIterator> 
       OutputIterator 
       :cpp:func:`format`\(OutputIterator, char_type const \*, 
              regex_constants::match_flag_type = regex_constants::format_default) const;
     template<typename Format, typename OutputIterator> 
       string_type :cpp:func:`format`\(Format const &, 
                          regex_constants::match_flag_type = regex_constants::format_default, 
                          :samp:`{unspecified}` = 0) const;
     string_type :cpp:func:`format`\(char_type const \*, 
                        regex_constants::match_flag_type = regex_constants::format_default) const;
     void :cpp:func:`swap`\(:cpp:struct:`match_results`\< BidiIter > &);
     template<typename Arg> :cpp:struct:`match_results`\< BidiIter > & :cpp:func:`let`\(Arg const &);
   }


説明
----

クラステンプレート :cpp:struct:`match_results\<>` は、正規表現マッチの結果を表すシーケンスのコレクションである。コレクションの領域は :cpp:struct:`match_results\<>` クラスのメンバ関数が必要に応じて確保・解放する。

クラステンプレート :cpp:struct:`match_results\<>` は、lib.sequence.reqmts が規定するシーケンスの要件に適合するが、const なシーケンスに対して定義された演算だけをサポートする。


.. _match_results.construct-copy-destruct:

match_results の構築、コピー、解体公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: match_results()

   :事後条件: :cpp:expr:`regex_id() == 0`
   :事後条件: :cpp:expr:`size() == 0`
   :事後条件: :cpp:expr:`empty() == true`
   :事後条件: :cpp:expr:`str() == string_type()`


.. cpp:function:: match_results(match_results< BidiIter > const & that)

   :param that: コピーする :cpp:struct:`~boost::xpressive::match_results` オブジェクト。
   :事後条件: :cpp:expr:`regex_id() == that.regex_id()`
   :事後条件: :cpp:expr:`size() == that.size()`
   :事後条件: :cpp:expr:`empty() == that.empty()`
   :事後条件: :cpp:expr:`n < that.size()` であるすべての自然数 :samp:`{n}` について :cpp:expr:`str(n) == that.str(n)`
   :事後条件: :cpp:expr:`prefix() == that.prefix()`
   :事後条件: :cpp:expr:`suffix() == that.suffix()`
   :事後条件: :cpp:expr:`n < that.size()` であるすべての自然数 :samp:`{n}` について :cpp:expr:`(*this)[n] == that[n]`
   :事後条件: :cpp:expr:`n < that.size()` であるすべての自然数 :samp:`{n}` について :cpp:expr:`length(n) == that.length(n)`
   :事後条件: :cpp:expr:`n < that.size()` であるすべての自然数 :samp:`{n}` について :cpp:expr:`position(n) == that.position(n)`


.. cpp:function:: match_results< BidiIter >& operator=(match_results< BidiIter > const & that)

   :param that: コピーする :cpp:struct:`match_results` オブジェクト。
   :事後条件: :cpp:expr:`regex_id() == that.regex_id()`
   :事後条件: :cpp:expr:`size() == that.size()`
   :事後条件: :cpp:expr:`empty() == that.empty()`
   :事後条件: :cpp:expr:`n < that.size()` であるすべての自然数 :samp:`{n}` について :cpp:expr:`str(n) == that.str(n)`
   :事後条件: :cpp:expr:`prefix() == that.prefix()`
   :事後条件: :cpp:expr:`suffix() == that.suffix()`
   :事後条件: :cpp:expr:`n < that.size()` であるすべての自然数 :samp:`{n}` について :cpp:expr:`(*this)[n] == that[n]`
   :事後条件: :cpp:expr:`n < that.size()` であるすべての自然数 :samp:`{n}` について :cpp:expr:`length(n) == that.length(n)`
   :事後条件: :cpp:expr:`n < that.size()` であるすべての自然数 :samp:`{n}` について :cpp:expr:`position(n) == that.position(n)`


.. cpp:function:: ~match_results()


.. _match_results.public-member-functions:

match_results 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: size_type size() const

   :cpp:expr:`*this` が成功したマッチ結果を表す場合は、マッチしたマーク済み部分式の総数に 1 を足した数を返す。それ以外の場合は 0 を返す。


.. cpp:function:: bool empty() const

   :cpp:expr:`size() == 0` を返す。


.. cpp:function:: difference_type length(size_type sub = 0) const

   :cpp:expr:`(*this)[sub].length()` を返す。


.. cpp:function:: difference_type position(size_type sub = 0) const

   :cpp:expr:`!(*this)[sub].matched` であれば ``-1`` を返す。それ以外の場合は :cpp:expr:`std::distance(base, (*this)[sub].first)` を返す（:cpp:var:`!base` は検索対象のシーケンスの開始イテレータ）。

   .. note::
      :cpp:struct:`regex_iterator` による繰り返し検索の途中でなければ、:cpp:var:`!base` は :cpp:expr:`prefix().first` と同じである。


.. cpp:function:: string_type str(size_type sub = 0) const

   :cpp:expr:`(*this)[sub].str()` を返す。


.. cpp:function:: template<typename Sub> \
		  const_reference operator[](Sub const & sub) const

   マーク済み部分式 :cpp:var:`sub` にマッチしたシーケンスを表す :cpp:struct:`sub_match` オブジェクトへの参照を返す。:cpp:expr:`sub == 0` であれば正規表現全体にマッチしたシーケンスを表す :cpp:struct:`sub_match` オブジェクトへの参照を返す。:cpp:expr:`sub >= size()` であればマッチしなかった部分式を表す :cpp:struct:`sub_match` オブジェクトへの参照を返す。


.. cpp:function:: const_reference prefix() const

   マッチ・検索対象文字列の先頭からマッチが見つかった位置までの文字シーケンスを表す :cpp:struct:`sub_match` オブジェクトへの参照を返す。

   :要件: :cpp:expr:`(*this)[0].matched` が真


.. cpp:function:: const_reference suffix() const

   マッチが見つかった位置の終端からマッチ・検索対象文字列の終端までの文字シーケンスを表す :cpp:struct:`sub_match` オブジェクトへの参照を返す。

   :要件: :cpp:expr:`(*this)[0].matched` が真


.. cpp:function:: const_iterator begin() const

   :cpp:expr:`*this` に格納されたマーク済み部分式マッチをすべて列挙する開始イテレータを返す。


.. cpp:function:: const_iterator end() const

   :cpp:expr:`*this` に格納されたマーク済み部分式マッチをすべて列挙する終了イテレータを返す。


.. cpp:function:: operator bool_type() const

   :cpp:expr:`(*this)[0].matched` であれば真を、そうでなければ偽を返す。


.. cpp:function:: bool operator!() const

   :cpp:expr:`empty() || !(*this)[0].matched` であれば真を、そうでなければ偽を返す。


.. cpp:function:: regex_id_type regex_id() const

   この :cpp:struct:`match_results` オブジェクトで最近使用した :cpp:struct:`basic_regex` オブジェクトの識別子を返す。


.. cpp:function:: nested_results_type const & nested_results() const
	  
   入れ子の :cpp:struct:`match_results` 要素のシーケンスを返す。


.. cpp:function:: template<typename Format, typename OutputIterator> \
                  OutputIterator format(OutputIterator out, Format const & fmt, regex_constants::match_flag_type flags = regex_constants::format_default, unspecified = 0) const

   :cpp:var:`Format` が ForwardRange か null 終端文字列であれば、:cpp:var:`fmt` 内の文字シーケンスを OutputIterator である :cpp:var:`out` にコピーする。:cpp:var:`fmt` 内の各書式化子およびエスケープシーケンスについて、それらが表す文字（列）かそれらが参照する :cpp:expr:`*this` 内のシーケンスで置換する。:cpp:var:`flags` で指定したビットマスクは、どの書式化子あるいはエスケープシーケンスを使用するかを決定する。既定では『ECMA-262 、ECMAScript 言語仕様 15 章 5.4.11 String.prototype.replace』が使用する書式である。

   それ以外で :cpp:var:`Format` が :cpp:type:`!Callable<match_results<BidiIter>, OutputIterator, regex_constants::match_flag_type>` であれば、この関数は :cpp:expr:`fmt(*this, out, flags)` を返す。

   それ以外で :cpp:var:`Format` が :cpp:type:`!Callable<match_results<BidiIter>, OutputIterator>` であれば、この関数は :cpp:expr:`fmt(*this, out)` を返す。

   それ以外で :cpp:var:`Format` が :cpp:type:`!Callable<match_results<BidiIter> >` であれば、この関数は :cpp:expr:`std::copy(x.begin(), x.end(), out)` を返す。:cpp:var:`x` は :cpp:expr:`fmt(*this)` を呼び出した結果である。


.. cpp:function:: template<typename OutputIterator> \
                  OutputIterator format(OutputIterator out, char_type const * fmt, regex_constants::match_flag_type flags = regex_constants::format_default) const

   .. include:: -overload-description.rst


.. cpp:function:: template<typename Format, typename OutputIterator> \
                  string_type format(Format const & fmt, regex_constants::match_flag_type flags = regex_constants::format_default, unspecified = 0) const

   :cpp:var:`Format` が ForwardRange か null 終端文字列であれば、この関数は文字シーケンス :cpp:var:`fmt` のコピーを返す。:cpp:var:`fmt` 内の各書式化子およびエスケープシーケンスについて、それらが表す文字（列）かそれらが参照する :cpp:expr:`*this` 内のシーケンスで置換する。:cpp:var:`flags` で指定したビットマスクは、どの書式化子あるいはエスケープシーケンスを使用するかを決定する。既定では『ECMA-262 、ECMAScript 言語仕様 15 章 5.4.11 String.prototype.replace』が使用する書式である。

   それ以外で :cpp:var:`Format` が :cpp:type:`!Callable<match_results<BidiIter>, OutputIterator, regex_constants::match_flag_type>` であれば、この関数は :cpp:expr:`fmt(*this, out, flags)` 呼び出しで得られた :cpp:type:`string_type` オブジェクト :cpp:var:`x` を返す。:cpp:var:`out` は :cpp:var:`x` への :cpp:class:`!back_insert_iterator` である。

   それ以外で :cpp:var:`Format` が :cpp:type:`!Callable<match_results<BidiIter>, OutputIterator>` であれば、この関数は :cpp:expr:`fmt(*this, out)` の呼び出しで得られた :cpp:type:`string_type` オブジェクト :cpp:var:`x` を返す。:cpp:var:`out` は :cpp:var:`x` への :cpp:class:`!back_insert_iterator` である。

   それ以外で :cpp:var:`Format` が :cpp:type:`!Callable<match_results<BidiIter> >` であれば、この関数は :cpp:expr:`fmt(*this)` を返す。


.. cpp:function:: string_type format(char_type const * fmt, regex_constants::match_flag_type flags = regex_constants::format_default) const

   .. include:: -overload-description.rst


.. cpp:function:: void swap(match_results< BidiIter > & that)

   2 つの :cpp:struct:`match_results` オブジェクトの内容を交換する。例外を投げないことを保証する。

   :param that: 交換する :cpp:struct:`match_results` オブジェクト。
   :事後条件: :cpp:expr:`*this` が :cpp:var:`that` 内にあった部分式マッチのシーケンスをもつ。:cpp:var:`that` が :cpp:expr:`*this` 内にあった部分式マッチのシーケンスをもつ。
   :例外: 送出しない。


.. cpp:function:: template<typename Arg> \
                  match_results< BidiIter > & let(Arg const & arg)

   TODO document me

   .. note:: 訳注　この節はまだ原文がありません。


.. cpp:namespace-pop::
