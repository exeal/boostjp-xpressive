名前付き捕捉
------------

概要
^^^^

正規表現が複雑になると、番号付き捕捉を取り扱うのが苦痛になる場合がある。左括弧の数を数えてどの捕捉に対応しているのか調べるのはつまらない仕事である。さらに面白くないのは、正規表現を編集するだけで捕捉に新しい番号が割り振られて古い番号を使っていた後方参照が無効になることである。

他の正規表現エンジンでは、\ **名前付き捕捉**\という機能でこの問題を解決している。この機能を使うと捕捉に名前を付けることができ、番号ではなく名前で捕捉を後方参照できる。xpressive も動的・静的正規表現の両方で名前付き捕捉をサポートする。


動的名前付き捕捉
^^^^^^^^^^^^^^^^

動的正規表現については、xpressive は他の一般的な正規表現エンジンの名前付き捕捉の構文に従う。:regexp:`(?P<xxx>...)` で名前付き捕捉を作成し、:regexp:`(?P=xxx)` でこの捕捉を後方参照する。名前付き後方参照を作成し後方参照する例を以下に示す。 ::

   // 1 文字にマッチする "char" という名前付き捕捉を作成し、名前により後方参照する。
   sregex rx = sregex::compile("(?P<char>.)(?P=char)");

上の正規表現は同じ文字が 2 つ続いた部分を検索する。

名前付き捕捉を使ってマッチか検索を行った後、捕捉の名前を使って :cpp:struct:`match_results\<>` により名前付き捕捉にアクセスする。 ::

   std::string str("tweet");
   sregex rx = sregex::compile("(?P<char>.)(?P=char)");
   smatch what;
   if(regex_search(str, what, rx))
   {
       std::cout << "char = " << what["char"] << std::endl;
   }

上のコードは以下を表示する。

.. code-block:: console

   char = e

名前付き捕捉を置換文字列から後方参照することも可能である。:regexp:`\\\\g<xxx>` という構文である。文字列置換において名前付き捕捉を使用する例を以下に示す。 ::

   std::string str("tweet");
   sregex rx = sregex::compile("(?P<char>.)(?P=char)");
   str = regex_replace(str, rx, "**\\g<char>**", regex_constants::format_perl);
   std::cout << str << std::endl;

名前付き捕捉を使用するには :cpp:enumerator:`~regex_constants::match_flag_type::format_perl` を指定しなければならないことに注意していただきたい。:regexp:`\\\\g<xxx>` 構文を解釈するのは Perl の構文だけである。上のコードは以下を表示する。

.. code-block:: console

   tw**e**t


静的名前付き捕捉
^^^^^^^^^^^^^^^^

静的正規表現を使う場合は、名前付き捕捉の作成と使用はより簡単である。:cpp:struct:`mark_tag` 型を使って :cpp:var:`s1` 、:cpp:var:`s2` のような変数を作成するが、より意味のある名前を与えることができる。静的表現を使うと上の例は以下のようになる。\ [#]_ ::

   mark_tag char_(1); // char_ は s1 の別名となる
   sregex rx = (char_= _) >> char_;

マッチを行った後、:cpp:struct:`mark_tag` を :cpp:struct:`match_results\<>` の添字にして名前付き捕捉にアクセスする。 ::

   std::string str("tweet");
   mark_tag char_(1);
   sregex rx = (char_= _) >> char_;
   smatch what;
   if(regex_search(str, what, rx))
   {
       std::cout << what[char_] << std::endl;
   }

上のコードは以下を表示する。

.. code-block:: console

   char = e

:cpp:func:`regex_replace()` を使って文字列置換を行う場合、以下のように名前付き捕捉を使用して\ **書式化式**\を作成できる。 ::

   std::string str("tweet");
   mark_tag char_(1);
   sregex rx = (char_= _) >> char_;
   str = regex_replace(str, rx, "**" + char_ + "**");
   std::cout << str << std::endl;

上のコードは以下を表示する。

.. code-block:: console

   tw**e**t

.. note::
   書式化式を使用するには :file:`<boost/xpressive/regex_actions.hpp>` をインクルードしなければならない。


.. [#] 訳注　リファレンスの項にあるとおり、:cpp:struct:`mark_tag` の初期化に使用する整数は正規表現内で一意でなければなりません。
