check 関数テンプレート
======================

.. cpp:function:: template<typename T> \
		  unspecified check(T const& t)

   正規表現にユーザー定義表明を追加する。

   :param t: UnaryPredicate オブジェクトか論理型の意味アクション


説明
----

:ref:`ユーザー定義表明 <semantic_actions_and_user_defined_assertions.user_defined_assertions>`\は、論理型のラムダを評価する意味アクションの一種である（評価結果が偽であれば、文字列内の当該位置でマッチは失敗となる）。結果的にバックトラッキングが起こり、最終的にはマッチが成功する可能性がある。

:cpp:func:`!check()` を使用して正規表現内でユーザー定義表明を指定するには、次の構文を使用する。 ::

   sregex s = (_d >> _d)[check( XXX )]; // XXX はカスタムの表明

表明は :cpp:struct:`sub_match\<>` オブジェクトとともに評価される。このオブジェクトは、表明をアタッチした部分式が文字列のどの部分にマッチしたかを表したものである。

次に示すように、:cpp:func:`!check()` は :cpp:struct:`sub_match\<>` オブジェクトを引数にとる通常の述語とともに使用できる。 ::

   // 部分マッチの長さが 3 か 6 のいずれかであれば
   // 真となる述語。
   struct three_or_six
   {
       bool operator()(ssub_match const &sub) const
       {
           return sub.length() == 3 || sub.length() == 6;
       }
   };

   // 3 文字か 6 文字の単語にマッチする。
   sregex rx = (bow >> +_w >> eow)[ check(three_or_six()) ] ;

あるいは :cpp:func:`!check()` は、意味アクションを定義する場合と同じ構文でインラインのカスタム表明を定義するのに使用できる。次のコードは 1 つ前のものと等価である。 ::

   // 3 文字か 6 文字の単語にマッチする。
   sregex rx = (bow >> +_w >> eow)[ check(length(_)==3 || length(_)==6) ] ;

カスタム表明内では :cpp:var:`!_` が :cpp:struct:`sub_match\<>` のプレースホルダとなり、文字列のどの部分がカスタム表明をアタッチした部分式にマッチしたかを表す。
