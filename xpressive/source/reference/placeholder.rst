placeholder 構造体テンプレート
==============================

.. cpp:struct:: template<typename T, int I = 0> placeholder

   意味アクション内で変数の代役となるプレースホルダを定義する。

   :tparam T: このオブジェクトが代理となるオブジェクトの型。
   :tparam I = 0: このプレースホルダを、同じ意味アクション内で同じ型を持つ他のものと区別するのに使用する省略可能な識別子。


.. cpp:namespace-push:: placeholder


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   template<typename T, int I = 0>
   struct :cpp:struct:`~::boost::xpressive::placeholder` {
     // :ref:`構築、コピー、解体 <placeholder.construct-copy-destruct>`
     :samp:`{unspecified}` :cpp:func:`operator=`\(T &) const;
     :samp:`{unspecified}` :cpp:func:`operator=`\(T const &) const;
   };


説明
----

:cpp:struct:`!placeholder\<>` は、意味アクション内で実際のオブジェクトの代わりに使用するプレースホルダを定義するのに使用する。プレースホルダを使用すると、アクション付きの正規表現を一度だけ定義しておき、その正規表現を定義した時点では使用できないオブジェクトの読み書きを行う多くの状況で再利用できるようになる。

:cpp:struct:`!placeholder\<>` の使用方法は、:cpp:struct:`!placeholder\<>` 型のオブジェクトを作成し、意味アクション内で型 :cpp:type:`T` のオブジェクトと完全に同じように扱うことである。 ::

   placeholder<int> _i;
   placeholder<double> _d;

   sregex rex = ( some >> regex >> here )
       [ ++_i, _d *= _d ];

次に :cpp:func:`!regex_search()` 、:cpp:func:`!regex_match` 、:cpp:func:`!regex_replace()` のいずれかでパターンマッチを行うには、正規表現オブジェクトの意味アクションで使用するプレースホルダへの束縛を持つ :cpp:struct:`match_results\<>` オブジェクトを渡す。 ::

   int i = 0;
   double d = 3.14;

   smatch what;
   what.let(_i = i)
       .let(_d = d);

   if(regex_match("何かの文字列", rex, what))
   // i と d がここで変化する

意味アクションが未束縛のプレースホルダを持つオブジェクトを評価した場合、:cpp:struct:`regex_error` 型の例外を投げる。

:cpp:func:`!xpressive::let()` の議論とユーザーガイドの「:ref:`非ローカル変数を参照する <semantic_actions_and_user_defined_assertions.referring_to_non_local_variables>`\」の節を見よ。


使用例
^^^^^^

::

   // map オブジェクトに対する placeholder を定義する：
   placeholder<std::map<std::string, int> > _map;

   // => で区切られた単語と整数にマッチし
   // 結果を std::map<> に詰め込む
   sregex pair = ( (s1= +_w) >> "=>" >> (s2= +_d) )
       [ _map[s1] = as<int>(s2) ];

   // 空白で区切られた単語、整数の組
   // 1 つ以上にマッチする。
   sregex rx = pair >> *(+_s >> pair);

   // 解析する文字列
   std::string str("aaa=>1 bbb=>23 ccc=>456");

   // 実際の map：
   std::map<std::string, int> result;

   // _map プレースホルダを実際の map に束縛する
   smatch what;
   what.let( _map = result );

   // マッチを実行し、結果の map を埋める
   if(regex_match(str, what, rx))
   {
       std::cout << result["aaa"] << '\n';
       std::cout << result["bbb"] << '\n';
       std::cout << result["ccc"] << '\n';
   }


.. _placeholder.construct-copy-destruct:

placeholder 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: unspecified operator=(T & t) const

   :param t: このプレースホルダに対応するオブジェクト
   :returns: :cpp:var:`t` と :cpp:expr:`*this` の対応を記録する未規定型のオブジェクト。


.. cpp:function:: unspecified operator=(T const & t) const

   .. include:: -overload-description.rst


.. cpp:namespace-pop::
