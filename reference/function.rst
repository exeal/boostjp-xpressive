function 構造体テンプレート
===========================

.. cpp:struct:: template<typename PolymorphicFunctionObject> function

   通常の関数オブジェクト型を xpressive の意味アクションで使用する、遅延関数オブジェクト型に変換する単項メタ関数。


.. cpp:namespace-push:: function


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   template<typename PolymorphicFunctionObject>
   struct :cpp:struct:`~::boost::xpressive::function` {
     // 型
     typedef proto::terminal< PolymorphicFunctionObject >::type type;
   };


説明
----

通常の多態的関数オブジェクト型を xpressive の意味アクションで使用するオブジェクトを宣言する型に変換するには、:cpp:class:`xpressive::function\<>` を使用する。

例えば :cpp:var:`!xpressive::push_back` グローバルオブジェクトは、値をコンテナに追加する遅延アクションを作成するのに使用する。これは :cpp:struct:`xpressive::function\<>` を使って以下のように定義する： ::

   xpressive::function<xpressive::op::push_back>::type const push_back = {};

ここで :cpp:struct:`op::push_back` は、その第 2 引数を第 1 引数へ追加する通常の関数オブジェクトである。この定義により、:cpp:var:`!xpressive::push_back` を以下のように意味アクション内で使用できる： ::

   namespace xp = boost::xpressive;
   using xp::_;
   std::list<int> result;
   std::string str("1 23 456 7890");
   xp::sregex rx = (+_d)[ xp::push_back(xp::ref(result), xp::as<int>(_) ]
       >> *(' ' >> (+_d)[ xp::push_back(xp::ref(result), xp::as<int>(_) ) ]);


.. cpp:namespace-pop::
