クイックスタート
----------------

xpressive で何かするのに知っておくべきことはそう多くない。xpressive が提供する型とアルゴリズムの 5 セント旅行に出かけよう。

.. list-table:: xpressive のツールボックス
   :header-rows: 1

   * - ツール
     - 説明
   * - :cpp:struct:`basic_regex\<>`
     - コンパイル済みの正規表現を保持する。:cpp:struct:`basic_regex\<>` は xpressive で最も重要な型である。xpressive で何かする場合は :cpp:struct:`basic_regex\<>` 型のオブジェクトを作成することから始める。
   * - :cpp:struct:`match_results\<>` 、:cpp:struct:`sub_match\<>`
     - :cpp:struct:`match_results\<>` は、:cpp:func:`regex_match()` や :cpp:func:`regex_search()` 操作の結果を保持する。:cpp:struct:`sub_match\<>` オブジェクトのベクタのように振舞う。個別の :cpp:struct:`sub_match\<>` オブジェクトはマーク済み部分式（Perlにおける後方参照）を保持する。基本的にはマーク済み部分式の開始と終了を表すイテレータの組にすぎない。
   * - :cpp:func:`regex_match()`
     - 文字列が正規表現にマッチするか調べる。:cpp:func:`regex_match()` が成功するのは、文字列全体の先頭から終端までが正規表現にマッチする場合である。:cpp:func:`regex_match()` に :cpp:struct:`match_results\<>` を与えると、見つかったマーク済み部分式が書き込まれる。
   * - :cpp:func:`regex_search()`
     - 正規表現にマッチする部分文字列を文字列内で検索する。:cpp:func:`regex_search()` は文字列内のあらゆる位置でマッチを検索する。文字列の先頭から開始し、マッチを見つけるか文字列内をすべて走査すると終了する。:cpp:func:`regex_match()` と同様、:cpp:func:`regex_search()` に :cpp:struct:`match_results\<>` を与えると、見つかったマーク済み部分式が書き込まれる。
   * - :cpp:func:`regex_replace()`
     - 入力文字列、正規表現、置換文字列を与えると、:cpp:func:`regex_replace()` は入力文字列内の正規表現にマッチした部分を置換文字列で置換した新しい文字列を構築する。置換文字列にはマーク済み部分式への参照を含めることができる。
   * - :cpp:struct:`regex_iterator\<>`
     - 文字列内の正規表現にマッチする位置を見つける STL 互換のイテレータ。:cpp:struct:`regex_iterator\<>` を参照はがしすると :cpp:struct:`match_results\<>` が返る。:cpp:struct:`regex_iterator\<>` をインクリメントすると次のマッチを検索する。
   * - :cpp:struct:`regex_token_iterator\<>`
     - :cpp:struct:`regex_iterator\<>` と似ているが、:cpp:struct:`regex_token_iterator\<>` を参照はがしすると文字列が返る。既定では正規表現にマッチした部分文字列全体が返るが、一度にいずれかあるいはすべてのマーク済み部分式を 1 つずつ返すように設定することもできる。また、文字列の正規表現にマッチ\ **しなかった**\ 部分を返すよう設定することもできる。
   * - :cpp:struct:`regex_compiler\<>`
     - :cpp:struct:`basic_regex\<>` オブジェクトのファクトリ。文字列を正規表現に「コンパイル」する。:cpp:struct:`basic_regex\<>` クラスは内部で :cpp:struct:`regex_compiler\<>` を使用するファクトリメソッドをもっているので、大抵の場合 :cpp:struct:`regex_compiler\<>` を直接取り扱う必要はない。しかし、:cpp:struct:`basic_regex\<>` オブジェクトを異なる :cpp:class:`!std::locale` で作成するなど変わったことをする必要がある場合は、:cpp:struct:`regex_compiler\<>` を明示的に使用しなければならない。

xpressive が提供するツール群について少しは分かったと思う。次の 2 つの質問に答えれば正しいツールを選択できるだろう。

#. データを走査するのに使う\ **イテレータ**\の型は何か。
#. データを使って何を\ **したい**\のか。


.. _quick_start.know_your_iterator_type:

イテレータの型
^^^^^^^^^^^^^^

xpressive において、ほとんどのクラスはイテレータ型を引数にもつテンプレートである。正しい型を簡単に選択できるように xpressive は共通の typedef をいくつか定義している。以下の表を見ればイテレータ型から正しい型が分かる。

.. csv-table:: xpressive の typedef とイテレータ型の対応
   :header-rows: 1

   , std::string::const_iterator, char const *, std::wstring::const_iterator, wchar_t const *
   :cpp:struct:`basic_regex`, :cpp:type:`sregex`, :cpp:type:`cregex`, :cpp:type:`wsregex`, :cpp:type:`wcregex`
   :cpp:struct:`match_results`, :cpp:type:`smatch`, :cpp:type:`cmatch`, :cpp:type:`wsmatch`, :cpp:type:`wcmatch`
   :cpp:struct:`regex_compiler`, :cpp:type:`sregex_compiler`, :cpp:type:`cregex_compiler`, :cpp:type:`wsregex_compiler`, :cpp:type:`wcregex_compiler`
   :cpp:struct:`regex_iterator`, :cpp:type:`sregex_iterator`, :cpp:type:`cregex_iterator`, :cpp:type:`wsregex_iterator`, :cpp:type:`wcregex_iterator`
   :cpp:struct:`regex_token_iterator`, :cpp:type:`sregex_token_iterator`, :cpp:type:`cregex_token_iterator`, :cpp:type:`wsregex_token_iterator`, :cpp:type:`wcregex_token_iterator`

機械的な名前付け規約に注意していただきたい。これらの型の多くは一緒に使用するため、名前付け規約は一貫性という点で助けになる。例えば :cpp:type:`sregex` があれば一緒に使うのは :cpp:type:`smatch` という具合である。

これら 4 つのイテレータ型以外については、テンプレートを直接使用しイテレータ型を指定するとよい。


タスク
^^^^^^

パターンを使うのは 1 度か、複数回か。検索か置換か。xpressive はこれらをすべてカバーし、他にも多くの機能がある。以下が早見表である。

.. list-table:: 処理とツール
   :header-rows: 1

   * - 次を行うには…
     - 以下を使用せよ
   * - .. tip:: :ref:`examples.see_if_a_whole_string_matches_a_regex`
     - :cpp:func:`regex_match()` アルゴリズム
   * - .. tip:: :ref:`examples.see_if_a_string_contains_a_sub_string_that_matches_a_regex`
     - :cpp:func:`regex_search()` アルゴリズム
   * - .. tip:: :ref:`examples.replace_all_sub_strings_that_match_a_regex`
     - :cpp:func:`regex_replace()` アルゴリズム
   * - .. tip:: :ref:`examples.find_all_the_sub_strings_that_match_a_regex_and_step_through_them_one_at_a_time`
     - :cpp:class:`regex_iterator\<>` クラス
   * - .. tip:: :ref:`examples.split_a_string_into_tokens_that_each_match_a_regex`
     - :cpp:class:`regex_token_iterator\<>` クラス
   * - .. tip:: :ref:`examples.split_a_string_using_a_regex_as_a_delimiter`
     - :cpp:class:`regex_token_iterator\<>` クラス

これらのアルゴリズムとクラスの厄介な詳細はリファレンスの節で述べる。

.. tip:: 上の表の各処理をクリックすると、xpressive を使った完全なプログラム例が表示される。
