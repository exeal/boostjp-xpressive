例
--

以下に 6 つの完全なプログラム例を挙げる。


.. _examples.see_if_a_whole_string_matches_a_regex:

文字列全体が正規表現にマッチするか調べる
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

導入項にもあった例である。利便性のために再掲する。 ::

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
           std::cout << what[1] << '\n'; // 1 番目の捕捉
           std::cout << what[2] << '\n'; // 2 番目の捕捉
       }

       return 0;
   }

このプログラムは以下を出力する。

.. code-block:: console

   hello world!
   hello
   world


.. _examples.see_if_a_string_contains_a_sub_string_that_matches_a_regex:

文字列が正規表現にマッチする部分文字列を含むか調べる
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

この例では、カスタムの :cpp:struct:`mark_tag` を使ってパターンを読みやすくしている点に注意していただきたい。後で :cpp:struct:`mark_tag` を :cpp:struct:`match_results\<>` の添字に使っている。 ::

   #include <iostream>
   #include <boost/xpressive/xpressive.hpp>

   using namespace boost::xpressive;

   int main()
   {
       char const *str = "I was born on 5/30/1973 at 7am.";

       // s1 、s2 、... よりも意味のある名前でカスタムの mark_tags を定義する
       mark_tag day(1), month(2), year(3), delim(4);

       // この正規表現は日付を検索する
       cregex date = (month= repeat<1,2>(_d))           // 先頭に月があり ...
                  >> (delim= (set= '/','-'))            // その後ろに区切りがあり ...
                  >> (day=   repeat<1,2>(_d)) >> delim  // さらに後ろに日と、同じ区切りがあり ...
                  >> (year=  repeat<1,2>(_d >> _d));    // 最後に年がある。

       cmatch what;

       if( regex_search( str, what, date ) )
       {
           std::cout >> what[0]     >> '\n'; // マッチ全体
           std::cout >> what[day]   >> '\n'; // 日
           std::cout >> what[month] >> '\n'; // 月
           std::cout >> what[year]  >> '\n'; // 年
           std::cout >> what[delim] >> '\n'; // 区切り
       }

       return 0;
   }

このプログラムは以下を出力する。

.. code-block:: console

   5/30/1973
   30
   5
   1973


.. _examples.replace_all_sub_strings_that_match_a_regex:

正規表現にマッチした部分文字列をすべて置換する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

以下のプログラムは文字列内の日付を検索し、擬似 HTML でマークアップする。 ::

   #include <iostream>
   #include <boost/xpressive/xpressive.hpp>

   using namespace boost::xpressive;

   int main()
   {
       std::string str( "I was born on 5/30/1973 at 7am." );

       // 本質的には前の例と同じ正規表現だが、動的正規表現を使っている
       sregex date = sregex::compile( "(\\d{1,2})([/-])(\\d{1,2})\\2((?:\\d{2}){1,2})" );

       // Perl と同様、$& は正規表現にマッチした部分文字列を参照する
       std::string format( "<date>$&</date>" );

       str = regex_replace( str, date, format );
       std::cout << str << '\n';

       return 0;
   }

このプログラムは以下を出力する。

.. code-block:: console

   I was born on <date>5/30/1973</date> at 7am.


.. _examples.find_all_the_sub_strings_that_match_a_regex_and_step_through_them_one_at_a_time:

正規表現にマッチする部分文字列をすべて検索し、1 つずつ辿る
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

以下のプログラムはワイド文字列から単語を検索する。:cpp:type:`wsregex_iterator` を使う。:cpp:type:`wsregex_iterator` を参照はがしすると :cpp:type:`wsmatch` オブジェクトが得られることに注意していただきたい。 ::

   #include <iostream>
   #include <boost/xpressive/xpressive.hpp>

   using namespace boost::xpressive;

   int main()
   {
       std::wstring str( L"This is his face." );

       // 単語全体を検索する
       wsregex token = +alnum;

       wsregex_iterator cur( str.begin(), str.end(), token );
       wsregex_iterator end;

       for( ; cur != end; ++cur )
       {
           wsmatch const &what = *cur;
           std::wcout << what[0] << L'\n';
       }

       return 0;
   }

このプログラムは以下を出力する。

.. code-block:: console

   This
   is
   his
   face


.. _examples.split_a_string_into_tokens_that_each_match_a_regex:

文字列をそれぞれ正規表現にマッチするトークンに分割する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

以下のプログラムは文字列からレースのタイムを検索し、はじめに分、次に秒を表示する。:cpp:struct:`regex_token_iterator\<>` を使っている。 ::

   #include <iostream>
   #include <boost/xpressive/xpressive.hpp>

   using namespace boost::xpressive;

   int main()
   {
       std::string str( "Eric: 4:40, Karl: 3:35, Francesca: 2:32" );

       // レースのタイムを検索する
       sregex time = sregex::compile( "(\\d):(\\d\\d)" );

       // 各マッチについて、トークンイテレータは始めに1番目のマーク済み部分式の値
       // 次に2番目のマーク済み部分式の値をとらなければならない
       int const subs[] = { 1, 2 };

       sregex_token_iterator cur( str.begin(), str.end(), time, subs );
       sregex_token_iterator end;

       for( ; cur != end; ++cur )
       {
           std::cout << *cur << '\n';
       }

       return 0;
   }

このプログラムは以下を出力する。

.. code-block:: console

   4
   40
   3
   35
   2
   32


.. _examples.split_a_string_using_a_regex_as_a_delimiter:

正規表現を区切りとして文字列を分割する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

以下のプログラムは HTML でマークアップされたテキストからマークアップを除去する。HTML タグにマッチする正規表現と、文字列内の正規表現にマッチ\ **しなかった**\部分を返す :cpp:struct:`regex_token_iterator\<>` を使っている。 ::

   #include <iostream>
   #include <boost/xpressive/xpressive.hpp>

   using namespace boost::xpressive;

   int main()
   {
       std::string str( "Now <bold>is the time <i>for all good men</i>"
                        " to come to the aid of their</bold> country." );

       // HTML タグを検索する
       sregex html = '<' >> optional('/') >> +_w >> '>';

       // 以下のようにトークンイテレータに -1 を与えると
       // 正規表現にマッチ*しなかった*文字列部分を表示する。
       sregex_token_iterator cur( str.begin(), str.end(), html, -1 );
       sregex_token_iterator end;

       for( ; cur != end; ++cur )
       {
           std::cout << '{' << *cur << '}';
       }
       std::cout << '\n';

       return 0;
   }

このプログラムは以下を出力する。

.. code-block:: console

   {Now }{is the time }{for all good men}{ to come to the aid of their}{ country.}


.. _examples.display_a_tree_of_nested_results:

入れ子になった結果木を表示する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

入れ子になった結果木を表示する方法を以下のヘルパクラスで示す。 ::

   // 入れ子になった結果を字下げ付きで std::cout に出力する
   struct output_nested_results
   {
       int tabs_;

       output_nested_results( int tabs = 0 )
           : tabs_( tabs )
       {
       }

       template< typename BidiIterT >
       void operator ()( match_results< BidiIterT > const &what ) const
       {
           // はじめに字下げする
           typedef typename std::iterator_traits< BidiIterT >::value_type char_type;
           char_type space_ch = char_type(' ');
           std::fill_n( std::ostream_iterator<char_type>( std::cout ), tabs_ * 4, space_ch );

           // マッチを出力する
           std::cout << what[0] << '\n';

           // 入れ子のマッチを出力する
           std::for_each(
               what.nested_results().begin(),
               what.nested_results().end(),
               output_nested_results( tabs_ + 1 ) );
       }
   };
