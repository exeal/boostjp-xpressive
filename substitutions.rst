文字列の置換
------------

正規表現が威力を発揮するのはテキスト検索のときだけではない。テキストの\ **操作**\においても有効である。最もありふれたテキスト操作の 1 つが、「検索して置換」である。xpressive は検索と置換のために :cpp:func:`regex_replace()` アルゴリズムを提供する。


regex_replace()
^^^^^^^^^^^^^^^

:cpp:func:`regex_replace()` を用いた「検索して置換」処理は簡単である。必要なのは入力シーケンス、正規表現オブジェクト、および書式化文字列か書式化オブジェクトだけである。:cpp:func:`regex_replace()` には複数のバージョンがあり、入力シーケンスを :cpp:type:`std::string` のような双方向コンテナとして受け付けて結果を同じ型の新しいコンテナで返すものや、入力を null 終端文字列で受け付けて :cpp:type:`std::string` を返すもの、イテレータの組で受け付けて結果を出力イテレータに書き込むものがある。置換は書式化シーケンスを含む文字列か書式化オブジェクトで指定する。文字列ベースの置換について、単純な使用例を以下に示す。 ::

   std::string input("This is his face");
   sregex re = as_xpr("his");                // "his" をすべて検索し、...
   std::string format("her");                // ... "her" で置換する

   // regex_replace() の対文字列版を使用
   std::string output = regex_replace( input, re, format );
   std::cout << output << '\n';

   // regex_replace() の対イテレータ版を使用
   std::ostream_iterator< char > out_iter( std::cout );
   regex_replace( out_iter, input.begin(), input.end(), re, format );

上のプログラムは以下を印字する。

.. code-block:: console

   Ther is her face
   Ther is her face

:code:`"his"` が\ **すべて** :code:`"her"` に置換されることに注意していただきたい。

:cpp:func:`regex_replace()` の使い方に関する完全なプログラム例は\ :ref:`ここ <examples.replace_all_sub_strings_that_match_a_regex>`\にある。利用可能な多重定義の完全なリストは :cpp:func:`regex_replace()` のリファレンスを見よ。


置換のオプション
^^^^^^^^^^^^^^^^

:cpp:func:`regex_replace()` アルゴリズムは、省略可能なビットマスク引数により書式化を制御する。使用可能なビットマスク値を以下に示す。

.. list-table:: 書式化フラグ
   :header-rows: 1

   * - フラグ
     - 意味
   * - :cpp:enumerator:`~regex_constants::match_flag_type::format_default`
     - ECMA-262 の書式化シーケンスを使用する（後述）。
   * - :cpp:enumerator:`~regex_constants::match_flag_type::format_first_only`
     - すべてのマッチの中で最初のものだけを置換する。
   * - :cpp:enumerator:`~regex_constants::match_flag_type::format_no_copy`
     - 入力シーケンス内の、正規表現にマッチしなかった部分を出力シーケンスにコピーしない。
   * - :cpp:enumerator:`~regex_constants::match_flag_type::format_literal`
     - 書式化文字列をリテラル（即値）として扱う。エスケープシーケンスを一切解釈しなくなる。
   * - :cpp:enumerator:`~regex_constants::match_flag_type::format_perl`
     - Perl の書式化シーケンスを使用する（後述）。
   * - :cpp:enumerator:`~regex_constants::match_flag_type::format_sed`
     - sed の書式化シーケンスを使用する（後述）。
   * - :cpp:enumerator:`~regex_constants::match_flag_type::format_all`
     - Perl の書式化シーケンス、および Boost 固有の書式化シーケンスを使用する。

これらのフラグは :cpp:member:`xpressive::regex_constants` 名前空間内にある。置換の引数が文字列ではなく関数オブジェクトである場合は、:cpp:enumerator:`~regex_constants::match_flag_type::format_literal` 、:cpp:enumerator:`~regex_constants::match_flag_type::format_perl` 、:cpp:enumerator:`~regex_constants::match_flag_type::format_sed` および :cpp:enumerator:`~regex_constants::match_flag_type::format_all` は無視される。


ECMA-262 書式化シーケンス
^^^^^^^^^^^^^^^^^^^^^^^^^

上記のフラグを指定せずに書式化文字列を渡した場合は、ECMAScript の標準である ECMA-262 の定義が使われる。ECMA-262 モードで使用するエスケープシーケンスを以下に示す。

.. list-table:: 書式化エスケープシーケンス
   :header-rows: 1

   * - エスケープシーケンス
     - 意味
   * - :regex-substitution:`$1` 、:regex-substitution:`$2` 、…
     - 部分マッチ
   * - :regex-substitution:`&`
     - マッチ全体
   * - :regex-substitution:`$\``
     - マッチの前
   * - :regex-substitution:`$'`
     - マッチの後
   * - :regex-substitution:`$$`
     - リテラルの文字 :cpp:expr:`'$'`

その他、:regex-substitution:`$` で始まるシーケンスは、単純にそれ自身を表す。例えば書式化文字列が :regex-substitution:`$a` であれば、出力シーケンスに「$a」が挿入される。


sed 書式化シーケンス
^^^^^^^^^^^^^^^^^^^^

:cpp:func:`regex_replace()` に :cpp:enumerator:`~regex_constants::match_flag_type::format_sed` フラグを指定した場合に使用するエスケープシーケンスを以下に示す。

.. list-table:: sed 書式化エスケープシーケンス
   :header-rows: 1

   * - エスケープシーケンス
     - 意味
   * - :regex-substitution:`\1` 、:regex-substitution:`\2` 、…
     - 部分マッチ
   * - :regex-substitution:`&`
     - マッチ全体
   * - :regex-substitution:`\a`
     - リテラルの :cpp:expr:`'\a'`
   * - :regex-substitution:`\e`
     - リテラルの :cpp:expr:`char_type(27)`
   * - :regex-substitution:`\f`
     - リテラルの :cpp:expr:`'\f'`
   * - :regex-substitution:`\n`
     - リテラルの :cpp:expr:`'\n'`
   * - :regex-substitution:`\r`
     - リテラルの :cpp:expr:`'\r'`
   * - :regex-substitution:`\t`
     - リテラルの :cpp:expr:`'\t'`
   * - :regex-substitution:`\v`
     - リテラルの :cpp:expr:`'\v'`
   * - :regex-substitution:`\xFF`
     - リテラルの :samp:`char_type(0x{FF})`。:samp:`{F}` は 16 進数字
   * - :regex-substitution:`\x{FFFF}`
     - リテラルの :samp:`char_type(0x{FFFF})`。:samp:`{F}` は 16 進数字</td>
   * - :regex-substitution:`\cX`
     - 制御文字 :samp:`{X}`


Perl 書式化シーケンス
^^^^^^^^^^^^^^^^^^^^^

:cpp:func:`regex_replace()` に :cpp:enumerator:`~regex_constants::match_flag_type::format_perl` フラグを指定した場合に使用するエスケープシーケンスを以下に示す。

.. list-table:: Perl 書式化エスケープシーケンス
   :header-rows: 1

   * - エスケープシーケンス
     - 意味
   * - :regex-substitution:`$1` 、:regex-substitution:`$2` 、…
     - 部分マッチ
   * - :regex-substitution:`&`
     - マッチ全体
   * - :regex-substitution:`$\``
     - マッチの前
   * - :regex-substitution:`$'`
     - マッチの後
   * - :regex-substitution:`$$`
     - リテラルの :cpp:expr:`'$'`
   * - :regex-substitution:`\a`
     - リテラルの :cpp:expr:`'\a'`
   * - :regex-substitution:`\e`
     - リテラルの :cpp:expr:`char_type(27)`
   * - :regex-substitution:`\f`
     - リテラルの :cpp:expr:`'\f'`
   * - :regex-substitution:`\n`
     - リテラルの :cpp:expr:`'\n'`
   * - :regex-substitution:`\r`
     - リテラルの :cpp:expr:`'\r'`
   * - :regex-substitution:`\t`
     - リテラルの :cpp:expr:`'\t'`
   * - :regex-substitution:`\v`
     - リテラルの :cpp:expr:`'\v'`
   * - :regex-substitution:`\xFF`
     - リテラルの :samp:`char_type(0x{FF})`。:samp:`{F}` は 16 進数字
   * - :regex-substitution:`\x{FFFF}`
     - リテラルの :samp:`char_type(0x{FFFF})`。:samp:`{F}` は 16 進数字
   * - :regex-substitution:`\cX`
     - 制御文字 :samp:`{X}`
   * - :regex-substitution:`\l`
     - 次の文字を小文字にする
   * - :regex-substitution:`\L`
     - 次に ``\E`` が現れるまで残りの置換を小文字にする
   * - :regex-substitution:`\u`
     - 次の文字を大文字にする
   * - :regex-substitution:`\U`
     - 次に ``\E`` が現れるまで残りの置換を大文字にする
   * - :regex-substitution:`\E`
     - ``\L`` 、``\U`` の効果を終了する
   * - :regex-substitution:`\1` 、:regex-substitution:`\2` 、…
     - 部分マッチ
   * - :regex-substitution:`\g<name>`
     - 名前付き後方参照 :samp:`{name}`


Boost 固有の書式化シーケンス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:cpp:func:`regex_replace()` に :cpp:enumerator:`~regex_constants::match_flag_type::format_all` を指定した場合に使用するエスケープシーケンスは上に挙げた :cpp:enumerator:`~regex_constants::match_flag_type::format_perl` と同じである。さらに以下の形式の条件式を使用する。 ::

   ?Ntrue-expression:false-expression

N は部分マッチを表す 10 進数字である。この部分マッチがマッチ全体に含まれる場合は置換は true-expression となり、それ以外の場合は false-expression となる。このモードでは括弧 :regexp:`()` でグループ化を行う。リテラルの括弧は :regexp:`\(` のようにエスケープが必要である。


書式化オブジェクト
^^^^^^^^^^^^^^^^^^

テキスト置換において、書式化文字列の表現能力が常に十分とは限らない。入力文字列を環境変数で置換して出力文字列にコピーする単純な例を考えよう。こういう場合は、書式化\ **文字列**\ ではなく書式化\ **オブジェクト**\ を使ったほうがよい。次のコードを考えよう。:regex-input:`$(xyz)` の形式で埋め込まれた環境変数を検索し、辞書に照らし合わせて見つかった置換文字列を算出する。 ::

   #include <map>
   #include <string>
   #include <iostream>
   #include <boost/xpressive/xpressive.hpp>
   using namespace boost;
   using namespace xpressive;

   std::map<std::string, std::string> env;

   std::string const &format_fun(smatch const &what)
   {
       return env[what[1].str()];
   }

   int main()
   {
       env["X"] = "this";
       env["Y"] = "that";

       std::string input("\"$(X)\" has the value \"$(Y)\"");

       // "$(XYZ)" のような文字列を検索し、env["XYZ"] の結果で置換する
       sregex envar = "$(" >> (s1 = +_w) >> ')';
       std::string output = regex_replace(input, envar, format_fun);
       std::cout << output << std::endl;

       return 0;
   }

この場合、関数 :cpp:func:`format_fun()` を使って置換文字列をその場で算出している。この関数は現在のマッチ結果が入った :cpp:class:`match_results\<>` オブジェクトを受け取る。:cpp:func:`format_fun()` は「1 番目の部分マッチ」をグローバルな :cpp:var:`!env` 辞書のキーに使っている。上記コードは次を表示する。

.. code-block:: console

   "this" has the value "that"

書式化オブジェクトは単純な関数である必要はなく、クラス型のオブジェクトでもよい。また文字列を返す以外に、出力イテレータに置換結果を書き込んでもよい。以下は上記と機能的に等価なコードである。 ::

   #include <map>
   #include <string>
   #include <iostream>
   #include <boost/xpressive/xpressive.hpp>
   using namespace boost;
   using namespace xpressive;

   struct formatter
   {
       typedef std::map<std::string, std::string> env_map;
       env_map env;

       template<typename Out>
       Out operator()(smatch const &what, Out out) const
       {
           env_map::const_iterator where = env.find(what[1]);
           if(where != env.end())
           {
               std::string const &sub = where->second;
               out = std::copy(sub.begin(), sub.end(), out);
           }
           return out;
       }

   };

   int main()
   {
       formatter fmt;
       fmt.env["X"] = "this";
       fmt.env["Y"] = "that";

       std::string input("\"$(X)\" has the value \"$(Y)\"");

       sregex envar = "$(" >> (s1 = +_w) >> ')';
       std::string output = regex_replace(input, envar, fmt);
       std::cout << output << std::endl;
   }

書式化オブジェクトは、シグニチャが以下の表に示す 3 種類のどれか 1 つである呼び出し可能オブジェクト（関数か関数オブジェクト）でなければならない。表中の :cpp:var:`!fmt` は関数ポインタか関数オブジェクト、:cpp:var:`!what` は :cpp:struct:`match_results\<>` オブジェクト、:cpp:var:`!out` は OutputIterator 、:cpp:var:`!flags` は :cpp:enum:`regex_constants::match_flag_type` の値である。

.. list-table:: 書式化オブジェクトのシグニチャ
   :header-rows: 1

   * - 書式化オブジェクトの呼び出し
     - 戻り値の型
     - 意味
   * - :cpp:expr:`fmt(what)`
     - 文字の範囲（:cpp:class:`!std::string` など）か null 終端文字列
     - 正規表現にマッチした文字列を書式化オブジェクトが返した文字列で置換する。
   * - :cpp:expr:`fmt(what, out)`
     - OutputIterator
     - 書式化オブジェクトは置換文字列を :cpp:var:`!out` に書き込み、:cpp:var:`!out` を返す。
   * - :cpp:expr:`fmt(what, out, flags)`
     - OutputIterator
     - 書式化オブジェクトは置換文字列を :cpp:var:`!out` に書き込み、:cpp:var:`!out` を返す。:cpp:var:`!flags` 引数は :cpp:func:`regex_replace()` アルゴリズムに渡したマッチフラグの値。


書式化式
^^^^^^^^

書式化\ **文字列**\、書式化\ **オブジェクト**\に加えて、:cpp:func:`regex_replace()` は書式化\ **式**\も受け付ける。書式化式は文字列を生成するラムダ式である。使用する構文は後述する\ :doc:`意味アクション <actions>`\と同じである。文字列を :cpp:func:`regex_replace()` を用いて環境変数で置換する上の例を書式化式を使って書き直すと、次のようになる。 ::

   #include <map>
   #include <string>
   #include <iostream>
   #include <boost/xpressive/xpressive.hpp>
   #include <boost/xpressive/regex_actions.hpp>
   using namespace boost::xpressive;
   int main()
   {
       std::map<std::string, std::string> env;
       env["X"] = "this";
       env["Y"] = "that";

       std::string input("\"$(X)\" has the value \"$(Y)\"");

       sregex envar = "$(" >> (s1 = +_w) >> ')';
       std::string output = regex_replace(input, envar, ref(env)[s1]);
       std::cout << output << std::endl;

       return 0;
   }

上のコードの :cpp:expr:`ref(env)[s1]` が書式化式で、1 番目の部分マッチの値 :cpp:var:`s1` を辞書 :cpp:var:`!env` のキーとするという意味となる。ここで :cpp:func:`xpressive::ref()` を使っているのは、ローカル変数 :cpp:var:`!env` への参照を\ **遅延**\して :cpp:var:`s1` の置換対象が判明するまで添字演算を遅らせるためである。
