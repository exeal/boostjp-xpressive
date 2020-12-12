記号表と属性
------------

概要
^^^^

xpressive の正規表現で記号表を構築するには、:cpp:class:`!std::map\<>` を使うだけでよい。辞書のキーはマッチした文字列であり、辞書の値は意味アクションが返すデータである。xpressive の 属性 :cpp:var:`a1` 、:cpp:var:`a2` 、…、:cpp:var:`a9` はマッチしたキーに相当する値を保持し、意味アクション内で使用する。記号が見つからなかった場合の属性の既定値を指定することも可能である。


記号表
^^^^^^

xpressive の記号表は単純に :cpp:class:`!std::map\<>` であり、キーは文字列型、値は何でもよい。例えば以下の正規表現は、:cpp:var:`!map1` のキーにマッチし対応する値を属性 :cpp:var:`a1` に代入する。次に意味アクションにおいて、属性 :cpp:var:`a1` に格納した値を結果の整数に代入する。 ::

   int result;
   std::map<std::string, int> map1;
   // ...（辞書を埋める）
   sregex rx = ( a1 = map1 ) [ ref(result) = a1 ];

次のコード例は数値の名前を整数に変換する。説明は以下に示す。 ::

   #include <string>
   #include <iostream>
   #include <boost/xpressive/xpressive.hpp>
   #include <boost/xpressive/regex_actions.hpp>
   using namespace boost::xpressive;

   int main()
   {
       std::map<std::string, int> number_map;
       number_map["one"] = 1;
       number_map["two"] = 2;
       number_map["three"] = 3;
       // number_map の文字列でマッチを行い
       // 整数値を 'result' に格納する
       // 見つからなければ -1 を 'result' に格納する
       int result = 0;
       cregex rx = ((a1 = number_map ) | *_)
           [ ref(result) = (a1 | -1)];

       regex_match("three", rx);
       std::cout << result << '\n';
       regex_match("two", rx);
       std::cout << result << '\n';
       regex_match("stuff", rx);
       std::cout << result << '\n';
       return 0;
   }

このプログラムは以下を印字する。

.. code-block:: console

   3
   2
   -1

このプログラムは始めに、数の名前をキー文字列とし対応する整数を値とする数値の辞書を構築している。次に記号表の探索結果を表す属性 :cpp:var:`a1` を使って静的正規表現を構築している。意味アクション内では属性を整数変数 :cpp:var:`!result` に代入している。記号が見つからなければ既定値の ``-1`` を :cpp:var:`!result` に代入する。記号が見つからなくてもマッチが成功するために、ワイルドカード :cpp:expr:`*_` を使っている。

この例のより完全版は :file:`libs/xpressive/example/numbers.cpp` にある。\ [#]_ このコードは「999,999,999」以下の数の名前（「ダース」のような特殊な数の名前が混ざっていてもよい）を数値に変換する。

記号表のマッチは既定では大文字小文字を区別するが、式を :cpp:func:`icase()` で囲むことにより大文字小文字を区別しないようにできる。


属性
^^^^

1 つの正規表現内で使用できる属性は最大 9 つであり、:cpp:var:`a1` 、:cpp:var:`a2` 、…、:cpp:var:`a9` という名前で :cpp:member:`boost::xpressive` 名前空間内にある。属性の型は代入元の辞書の 2 番目の要素と同じである。属性の既定値は意味アクション内で :samp:`(a1 | {default-value})` のような構文で指定する。

属性のスコープは適切に設定されるため、:code:`( (a1=sym1) >> (a1=sym2)[ref(x)=a1] )[ref(y)=a1]` のようなとてつもないこともできる。内側の意味アクションは内側の :cpp:var:`a1` を参照し、外側の意味アクションは外側の属性を参照する。これらは型が異なっていてもよい。

.. note::
   xpressive は検索を高速化するために、辞書から不可視の 3 分探索木を構築する。:c:macro:`!BOOST_DISABLE_THREADS` を定義した場合、この不可視の 3 分木は検索後に「毎回自身を再構築」し、前回の検索頻度に基づいて次回の検索効率を向上する。


.. [#] この例を寄贈してくれた David Jenkins に感謝する。
