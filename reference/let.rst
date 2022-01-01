let 関数テンプレート
====================

.. cpp:function:: template<typename... ArgBindings> \
		  unspecified let(ArgBindings const&... args)

   :cpp:struct:`regex_iterator` か :cpp:struct:`regex_token_iterator` の構築時に、意味アクション内でローカル変数をプレースホルダに束縛する。

   :param args: 引数束縛の集合。各引数束縛は代入式であり、その左辺は :cpp:struct:`!placeholder<X>` のインスタンスでなければならず、右辺は型 :cpp:type:`!X` の lvalue である。


説明
----

:cpp:func:`!xpressive::let()` は :cpp:func:`!match_results::let()` と同じ目的で提供している。すなわち、プレースホルダをローカル変数に束縛する。これにより意味アクション付きの正規表現を、その時点で存在していないオブジェクトを参照するよう定義できる。オブジェクトを直接参照するのではなく、意味アクションはプレースホルダを参照でき、プレースホルダの値は後で let 式を用いて指定できる。:cpp:func:`!let()` で作成した let 式は、:cpp:struct:`regex_iterator` または :cpp:struct:`regex_token_iterator` のコンストラクタに渡される。

さらなる議論については、ユーザーガイドの節\ :ref:`「非ローカル変数を参照する」 <semantic_actions_and_user_defined_assertions.referring_to_non_local_variables>`\を見よ。

使用例を示す。 ::

   // map オブジェクトに対するプレースホルダを定義する：
   placeholder<std::map<std::string, int> > _map;

   // => で区切られた単語と整数の組にマッチし
   // 結果を std::map<> に詰め込む
   sregex pair = ( (s1= +_w) >> "=>" >> (s2= +_d) )
       [ _map[s1] = as<int>(s2) ];

   // 解析する文字列
   std::string str("aaa=>1 bbb=>23 ccc=>456");

   // 結果を詰め込む実際の map：
   std::map<std::string, int> result;

   // すべてのマッチを検索するため regex_iterator を作成する
   sregex_iterator it(str.begin(), str.end(), pair, let(_map=result));
   sregex_iterator end;

   // すべてのマッチを素通りし、
   // 結果の map を埋める
   while(it != end)
       ++it;

   std::cout << result["aaa"] << '\n';
   std::cout << result["bbb"] << '\n';
   std::cout << result["ccc"] << '\n';

このコードは以下を表示する。

.. code-block:: console

   1
   23
   456
