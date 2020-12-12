はじめに
--------

xpressive とは何か
^^^^^^^^^^^^^^^^^^

xpressive は正規表現のテンプレートライブラリである。正規表現・正規式（regex とも\ [#]_\ ）は実行時に動的に解析される文字列としても（動的正規表現）、またはコンパイル時に解析される式テンプレート\ [#]_ としても（静的正規表現）記述できる。動的正規表現の利点は、実行時にユーザーが入力したり、初期化ファイルから読み取りが可能なことである。静的正規表現には利点がいくつかある。文字列ではなく C++ 式テンプレートなのでコンパイル時に構文チェックを受ける。また、プログラム内のコードとデータを参照可能なので、正規表現マッチの最中にコードを呼び出すこともできる。加えて静的束縛されるので、コンパイラは静的正規表現についてより高速なコードを生成する可能性がある。

xpressive のこの 2 本立ての機能は独特かつ強力である。静的 xpressive は `Spirit パーサフレームワーク <http://spirit.sourceforge.net/>`_\のようなものである。\ `Spirit`_ と同様、式テンプレートを使った静的正規表現で文法を構築できる（\ `Spirit`_ と異なり、xpressive はパターンマッチを探索するためにあらゆる可能性を試行する網羅的なバックトラックを行う）。動的正規表現は `Boost.Regex`_ のようなものである。実際、xpressive のインターフェイスは `Boost.Regex`_ を使ったことのある人にとっては親しみやすいはずである。xpressive の革新的な点は、静的正規表現と動的正規表現を同じプログラム内（同じ式内でも！）で混ぜてマッチできることである。動的正規表現を静的正規表現に組み込むことも\ **その逆も**\可能である。組み込んだ正規表現はパターンマッチに必要な検索やバックトラックに対して完全に機能する。


Hello, world!
^^^^^^^^^^^^^

理論は十分だ。xpressive スタイルの Hello World を見よう。 ::

   #include <iostream>
   #include <boost/xpressive/xpressive.hpp>

   using namespace boost::xpressive;

   int main()
   {
       std::string hello( "hello world!" );

       sregex rex = sregex::compile( "(\\w+) (\\w+)!" );
       smatch what;

       if( regex_match( hello, what, rex ) )
       {
           std::cout << what[0] << '\n'; // マッチ全体
           std::cout << what[1] << '\n'; // 1番目の捕捉
           std::cout << what[2] << '\n'; // 2番目の捕捉
       }

       return 0;
   }

このプログラムは以下を出力する。

.. code-block:: console

   hello world!
   hello
   world

このコードでまず注意すべきは、xpressive の型がすべて :cpp:member:`boost::xpressive` 名前空間にあるということである。

.. note:: 本文書における残りのほとんどの例では :code:`using namespace boost::xpressive;` ディレクティブを省略しているが、実際には必要である。

次に注意すべきは正規表現オブジェクトの型が :cpp:type:`sregex` ということである。\ `Boost.Regex`_ に馴染んでいるのであれば、今まで使っていたものとは違うという点に気をつけなければならない。「:cpp:type:`sregex`\」の「s」は「:cpp:type:`!string`\」のことであり、この正規表現は :cpp:type:`!std::string` オブジェクト内でパターンを探索するのに使用するということを表している。この違いとそれが意味するところについては後で述べる。

正規表現オブジェクトをどのように初期化するかに注目する。 ::

   sregex rex = sregex::compile( "(\\w+) (\\w+)!" );

正規表現オブジェクトを文字列から作成する場合、:cpp:func:`basic_regex::compile()` といったファクトリメソッドを呼び出さなければならない。これもまた、xpressive が他のオブジェクト指向正規表現ライブラリと異なっている点である。他のライブラリでは正規表現は文字列の強化版のような扱いだが、xpressive では正規表現は文字列ではなく、ドメイン固有言語における小さなプログラムである。文字列はそのような言語の表現の 1 つにすぎない。もう1つの表現が式テンプレートである。例えば上のコード行は以下と等価である。 ::

   sregex rex = (s1= +_w) >> ' ' >> (s2= +_w) >> '!';

これは同じ正規表現を表しているが、静的 xpressive が定義するドメイン固有の組み込み言語を用いている点が異なる。

見てのとおり、静的正規表現の構文には標準的な Perl の構文と顕著に違う点がある。これは C++ 構文の制約によるもので、最も大きな違いは「後続」を表す :code:`>>` の使用である。例えば Perl では部分式を続けて書くことができる。

.. code-block:: perl

   abc

しかし C++ では部分式を分離する演算子がなければならない。 ::

   a >> b >> c

Perlでは括弧 :regexp:`()` は特別な意味をもつ。これらはグループ化を行うが、:regexp:`$1` や :regexp:`$2` といった後方参照を作成するという副作用がある。C++ では括弧を多重定義して副作用を与えることはできない。そこで同じ効果を得るために :cpp:var:`s1` や :cpp:var:`s2` という特殊なトークンを使用する。これらに代入を行うことで後方参照を作成する（xpressive では部分マッチ（sub-match）という）。

他に注意すべき点として、1 回以上の繰り返しを表す + 演算子の位置が後置から前置になっているということがある。これは C++ が後置の + 演算子をもたないためである。よって、 ::

   "\\w+"

これは以下と同じである。 ::

   +_w

他のすべての違いについては\ :doc:`後で <grammars>`\触れる。


.. [#] 訳注　Regular expression の省略形ですが、翻訳版では省略せず「正規表現」「正規式」と書きます。
.. [#] `Expression Templates <http://www.osl.iu.edu/~tveldhui/papers/Expression-Templates/exprtmpl.html>`_\（英語）を参照。

.. _Boost.Regex: http://www.boost.org/libs/regex/
.. _Spirit: http://spirit.sourceforge.net/
