文字列の分割とトークン分割
--------------------------

:cpp:class:`regex_token_iterator\<>` はテキスト操作の世界における GINSU [#]_ のナイフである。薄切りもさいの目切りも思いのまま！ 本節では高度に設定可能な :cpp:class:`regex_token_iterator` で入力シーケンスを分割する方法を述べる。


概要
^^^^

:cpp:class:`regex_token_iterator\<>` は入力シーケンス、正規表現、省略可能な設定引数で初期化する。:cpp:class:`regex_token_iterator\<>` は :cpp:func:`regex_search()` を使って、シーケンス内で最初に正規表現にマッチする位置を見つける。:cpp:class:`regex_token_iterator\<>` を参照はがしすると、:cpp:class:`std::basic_string` 形式で\ **トークン**\を返す。どの文字列を返すかは設定引数による。既定ではマッチ全体に相当する文字列を返すが、マーク済み部分式のみならずシーケンス内のマッチ\ **しなかった**\部分を返すことも可能である。:cpp:class:`regex_token_iterator\<>` をインクリメントすると次のトークンに移動する。次がどのトークンかは設定引数による。単純に現在のマッチにおける異なるマーク済み部分式の場合もあれば、次のマッチの全体か一部分である場合、マッチ\ **しなかった**\部分である場合もある。

以上のことからわかるように、:cpp:class:`regex_token_iterator\<>` には多くの機能がある。すべてを説明するのは難しいが、いくつか例を見れば理解できるだろう。


例 1：単純なトークン分割
^^^^^^^^^^^^^^^^^^^^^^^^

この例では :cpp:class:`regex_token_iterator\<>` を使ってシーケンスを単語のトークンに切っている。 ::

   std::string input("This is his face");
   sregex re = +_w;                      // 単語を検索する

   // 入力中の単語をすべて走査する
   sregex_token_iterator begin( input.begin(), input.end(), re ), end;

   // すべての単語を std::cout に出力する
   std::ostream_iterator< std::string > out_iter( std::cout, "\n" );
   std::copy( begin, end, out_iter );

このプログラムは以下を表示する。

.. code-block:: console

   This
   is
   his
   face


例 2：単純なトークン分割・リローデッド
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

この例も :cpp:class:`regex_token_iterator` を使ってシーケンスを単語トークンに切っているが、正規表現を区切りとして使っている。:cpp:class:`regex_token_iterator` コンストラクタの最後の引数に ``-1`` を渡すと、入力内の正規表現にマッチ\ **しなかった**\部分がトークンとなる。 ::

   std::string input("This is his face");
   sregex re = +_s;                      // 空白を検索する

   // 入力中の非空白をすべて走査する。-1 に注意
   sregex_token_iterator begin( input.begin(), input.end(), re, -1 ), end;

   // すべての単語を std::cout に出力する
   std::ostream_iterator< std::string > out_iter( std::cout, "\n" );
   std::copy( begin, end, out_iter );

このプログラムは以下を出力する。

.. code-block:: console

   This
   is
   his
   face


例 3：単純なトークン分割・レボリューションズ [#]_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

この例も :cpp:class:`regex_token_iterator\<>` を使って日付の束が入ったシーケンスを年だけのトークンに切っている。:cpp:class:`regex_token_iterator` コンストラクタの最後の引数に正の整数 :samp:`{N}` を渡すと、各マッチの :samp:`{N}` 番目のマーク済み部分式のみがトークンとなる。 ::

   std::string input("01/02/2003 blahblah 04/23/1999 blahblah 11/13/1981");
   sregex re = sregex::compile("(\\d{2})/(\\d{2})/(\\d{4})"); // 日付を検索する

   // 入力中のすべての年を走査をする。3（3 番目の部分式）に注意
   sregex_token_iterator begin( input.begin(), input.end(), re, 3 ), end;

   // すべての単語を std::cout に出力する
   std::ostream_iterator< std::string > out_iter( std::cout, "\n" );
   std::copy( begin, end, out_iter );

このプログラムは以下を出力する。

.. code-block:: console

   2003
   1999
   1981


例 4：あまり単純でないトークン分割
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

この例は 1 つ前のものと似ているが、年だけでなく月と日をトークンに入れている点が異なる。:cpp:class:`regex_token_iterator\<>` コンストラクタの最後の引数に整数の配列 :code:`{I,J,...}` を渡すと、各マッチの :samp:`{I}` 番目、:samp:`{J}` 番目、…のマーク済み部分式がトークンとなる。 ::

   std::string input("01/02/2003 blahblah 04/23/1999 blahblah 11/13/1981");
   sregex re = sregex::compile("(\\d{2})/(\\d{2})/(\\d{4})"); // 日付を検索する

   // 入力中の年月日を走査する
   int const sub_matches[] = { 2, 1, 3 }; // 日、月、年
   sregex_token_iterator begin( input.begin(), input.end(), re, sub_matches ), end;

   // すべての単語を std::cout に出力する
   std::ostream_iterator< std::string > out_iter( std::cout, "\n" );
   std::copy( begin, end, out_iter );

このプログラムは以下を出力する。

.. code-block:: console

   02
   01
   2003
   23
   04
   1999
   13
   11
   1981

:cpp:var:`sub_matches` 配列により、:cpp:class:`regex_token_iterator\<>` は最初に 2 番目の部分マッチ、次に 1 番目の部分マッチ、最後に 3 番目の部分マッチの値を取る。イテレータをインクリメントすると :cpp:func:`regex_search()` を使って次のマッチを検索する。ここで処理が繰り返され、イテレータは 2 番目の部分マッチを取り、次に 1 番目…となる。


.. [#] 訳注　刃物メーカー（http://www.genuineginsu.com/）。GINSU のナイフはよく切れると評判らしいです。Wikipedia によるとテレビ CM が画期的なものだったとか。
.. [#] 訳注　マトリックスですね。
