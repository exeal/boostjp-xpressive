マッチと検索
------------

概要
^^^^

正規表現オブジェクトの作成が終わったら、:cpp:func:`regex_match()` および :cpp:func:`regex_search()` アルゴリズムで文字列からパターンを検索する。本節では正規表現のマッチと検索の基本について述べる。`Boost.Regex <http://www.boost.org/libs/regex/>`_ ライブラリの :cpp:func:`regex_match()` および :cpp:func:`regex_search()` の振る舞いについて理解しているなら、xpressive 版でも同様の動作をすると考えてよい。


文字列が正規表現にマッチするか調べる
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:cpp:func:`regex_match()` アルゴリズムは正規表現が与えられた入力にマッチするか調べる。

.. warning::
   :cpp:func:`regex_match()` アルゴリズムは、正規表現が入力全体の先頭から終端までマッチした場合のみ成功する。正規表現が入力の一部分だけにマッチする場合は :cpp:func:`regex_match()` は偽を返す。文字列から正規表現にマッチする部分文字列を探す場合は、:cpp:func:`regex_search()` アルゴリズムを使うとよい。

入力は :cpp:type:`!std::string`\、C 形式の null 終端文字列、イテレータの組といった双方向範囲である。いずれの場合でも、入力シーケンスを走査するイテレータ型は正規表現オブジェクトの宣言に使用したイテレータ型と一致していなければならない（イテレータに対する正しい正規表現の型は、:ref:`クイックスタート <quick_start.know_your_iterator_type>`\の表を見れば分かる）。 ::

   cregex cre = +_w;  // C 形式の文字列にマッチ
   sregex sre = +_w;  // std::string にマッチ

   if( regex_match( "hello", cre ) )              // OK
       { /*...*/ }

   if( regex_match( std::string("hello"), sre ) ) // OK
       { /*...*/ }

   if( regex_match( "hello", sre ) )              // エラー！ イテレータが一致していない！
       { /*...*/ }

:cpp:func:`regex_match()` アルゴリズムは省略可能な出力引数として :cpp:struct:`match_results\<>` 構造体を受け付ける。この引数が与えられると、:cpp:func:`regex_match()` アルゴリズムは正規表現のどの部分が入力のどの部分にマッチしたかの情報を :cpp:struct:`match_results\<>` 構造体に書き込む。 ::

   cmatch what;
   cregex cre = +(s1= _w);

   // regex_match の結果を "what" に格納する
   if( regex_match( "hello", what, cre ) )
   {
       std::cout << what[1] << '\n'; // "o" を印字する
   }

:cpp:func:`regex_match()` アルゴリズムはさらに省略可能な引数として :cpp:enum:`~regex_constants::match_flag_type` ビットマスクを受け付ける。:cpp:enum:`~regex_constants::match_flag_type` を与えると、マッチをどのように行うかある程度制御できる。このフラグの完全なリストと意味については :cpp:enum:`~regex_constants::match_flag_type` のリファレンスを見よ。 ::

   std::string str("hello");
   sregex sre = bol >> +_w;

   // match_not_bol の意味は、「"bol"（行頭）は [begin,begin) にマッチしない」
   if( regex_match( str.begin(), str.end(), sre, regex_constants::match_not_bol ) )
   {
       // ここには絶対にこない！
   }

:cpp:func:`regex_match()` の使い方に関する完全なプログラム例は\ :ref:`ここ <examples.see_if_a_whole_string_matches_a_regex>`\ にある。利用可能な多重定義の完全なリストは :cpp:func:`regex_match()` のリファレンスを見よ。


部分文字列のマッチを検索する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

入力シーケンスに正規表現にマッチする部分シーケンスが含まれているか調べるには :cpp:func:`regex_search()` を使用する。:cpp:func:`regex_search()` は入力シーケンスの先頭で正規表現マッチを試行し、マッチを見つけるかシーケンスの終端に到達するまでシーケンスを走査する。

その他のすべての面で :cpp:func:`regex_search()` の動作は :cpp:func:`regex_match()` と似たようなものである（上を見よ）。:cpp:type:`!std::string` 、C 形式の null 終端文字列、イテレータの範囲といった双方向範囲を取り扱うという点が特にそうである。正規表現のイテレータ型と入力シーケンスの型を一致させなければならない、ということについても同様の注意が必要である。:cpp:func:`regex_match()` と同様、:cpp:struct:`match_results\<>` 構造体を与えて検索結果を受け取ったり、:cpp:enum:`~regex_constants::match_flag_type` ビットマスクを使ってマッチをどのように行うかを制御できる。

:cpp:func:`regex_search()` の使い方に関する完全なプログラム例は\ :ref:`ここ <examples.see_if_a_string_contains_a_sub_string_that_matches_a_regex>`\にある。利用可能な多重定義の完全なリストは :cpp:func:`regex_search()` のリファレンスを見よ。
