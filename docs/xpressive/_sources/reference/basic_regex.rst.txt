basic_regex 構造体テンプレート
================================

.. cpp:struct:: template<typename BidiIter> basic_regex

   :cpp:struct:`!basic_regex\<>` クラステンプレートはコンパイル済み正規表現を保持するクラスである。

.. cpp:namespace-push:: basic_regex


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/basic_regex.hpp`>

   template<typename BidiIter>
   struct basic_regex {
     // :ref:`構築、コピー、解体 <basic_regex.construct-copy-destruct>`
     :cpp:func:`~basic_regex::basic_regex`\();
     :cpp:func:`~basic_regex::basic_regex`\(basic_regex< BidiIter > const &);
     template<typename Expr> :cpp:func:`~basic_regex::basic_regex`\(Expr const &);
     basic_regex< BidiIter >& :cpp:func:`operator=`\(basic_regex< BidiIter > const &);
     template<typename Expr> basic_regex< BidiIter >& :cpp:func:`operator=`\(Expr const &);

     // :ref:`公開メンバ関数 <basic_regex.public-member-functions>`
     std::size_t :cpp:func:`mark_count`\() const;
     regex_id_type :cpp:func:`\regex_id`\() const;
     void :cpp:func:`swap`\(basic_regex< BidiIter > &);

     // :ref:`公開静的メンバ関数 <basic_regex.public-static-functions>`
     template<typename InputIter> 
       static basic_regex< BidiIter > 
       :cpp:func:`compile`\(InputIter, InputIter, flag_type = regex_constants::ECMAScript);
     template<typename InputRange> 
       static basic_regex< BidiIter > 
       :cpp:func:`compile`\(InputRange const &, flag_type = regex_constants::ECMAScript);
     static basic_regex< BidiIter > 
     :cpp:func:`compile`\(char_type const \*, flag_type = regex_constants::ECMAScript);
     static basic_regex< BidiIter > 
     :cpp:func:`compile`\(char_type const \*, std::size_t, flag_type);
   };


説明
----

.. _basic_regex.construct-copy-destruct:

basic_regex 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: basic_regex()

   :事後条件: :cpp:expr:`regex_id() == 0`
   :事後条件: :cpp:expr:`mark_count() == 0`


.. cpp:function:: basic_regex(basic_regex< BidiIter > const & that)

   :param that: コピーする :cpp:struct:`!basic_regex` オブジェクト。
   :事後条件: :cpp:expr:`regex_id() == that.regex_id()`
   :事後条件: :cpp:expr:`mark_count() == that.mark_count()`


.. cpp:function:: template<typename Expr> basic_regex(Expr const & expr)

   静的正規表現から構築する。

   :param expr: 静的正規表現。
   :要件: :cpp:type:`!Expr` は静的正規表現の型。
   :事後条件: :cpp:expr:`regex_id() != 0`
   :事後条件: :cpp:expr:`mark_count() >= 0`


.. cpp:function:: basic_regex< BidiIter >& operator=(basic_regex< BidiIter > const & that)

   :param that: コピーする :cpp:struct:`!basic_regex` オブジェクト。
   :事後条件: :cpp:expr:`regex_id() == that.regex_id()`
   :事後条件: :cpp:expr:`mark_count() == that.mark_count()`
   :returns: \*this


.. cpp:function:: template<typename Expr> basic_regex< BidiIter >& operator=(Expr const & expr)

   静的正規表現から構築する。

   :param expr: 静的正規表現。
   :要件: :cpp:type:`!Expr` は静的正規表現の型。
   :事後条件: :cpp:expr:`regex_id() != 0`
   :事後条件: :cpp:expr:`mark_count() >= 0`
   :returns: \*this
   :throws std\:\:bad_alloc: メモリ不足のとき


.. _basic_regex.public-member-functions:

basic_regex の公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: std::size_t mark_count() const

   この正規表現内の捕捉済み部分式の数を返す。


.. cpp:function:: regex_id_type regex_id() const

   この正規表現を一意に識別するトークンを返す。


.. cpp:function:: void swap(basic_regex< BidiIter > & that)

   この :cpp:struct:`!basic_regex` オブジェクトの内容を別のものと交換する。

   .. note:: 参照まで追跡しない浅い交換である。:cpp:struct:`basic_regex` オブジェクトを参照により別の正規表現に組み込み、他の :cpp:struct:`basic_regex` オブジェクトと内容を交換すると、外側の正規表現からはこの変更を検出できない。これは :cpp:func:`!swap()` が例外を送出できないためである。

   :param that: 他の :cpp:struct:`!basic_regex` オブジェクト。
   :例外: 例外を送出しない。


.. _basic_regex.public-static-functions:

basic_regex の公開静的メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template<typename InputIter> static basic_regex< BidiIter > compile(InputIter begin, InputIter end, flag_type flags)

   文字の範囲から正規表現オブジェクトを構築するファクトリメソッド。:cpp:expr:`regex_compiler< BidiIter >().compile(begin, end, flags)` と等価。

   :param begin: コンパイルする正規表現を表す文字範囲の先頭。
   :param end: コンパイルする正規表現を表す文字範囲の終端。
   :param flags: 文字列をどのように解釈するかを指定する省略可能なビットマスク（:cpp:enum:`!syntax_option_type` を見よ）。
   :要件: ``[begin, end)`` が有効な範囲である。``[begin, end)`` で指定した文字の範囲が正規表現の有効な文字列表現である。
   :returns: 文字の範囲が表す正規表現に相当する :cpp:struct:`!basic_regex` オブジェクト。
   :throws regex_error:


.. cpp:function:: template<typename InputRange> static basic_regex< BidiIter > compile(InputRange const & pat, flag_type flags)

   .. include:: -overload-description.rst


.. cpp:function:: static basic_regex< BidiIter > compile(char_type const * begin, flag_type flags)

   .. include:: -overload-description.rst


.. cpp:function:: static basic_regex< BidiIter > compile(char_type const * begin, std::size_t len, flag_type flags)

   .. include:: -overload-description.rst


.. cpp:namespace-pop::
