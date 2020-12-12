syntax_option_type 型
=====================

.. cpp:enum:: regex_constants::syntax_option_type

   正規表現構文をカスタマイズするのに使用するフラグ。


   .. cpp:enumerator:: ECMAScript = 0

      正規表現エンジンが通常の文法を使用するよう指定する。この文法は ECMA-262 、ECMAScript 言語仕様 15 章 10 RegExp (Regular Expression) Objects（FWD.1）に示されているものと同じである。


   .. cpp:enumerator:: icase = 1 << 1

      文字コンテナシーケンスに対して正規表現マッチを大文字小文字を区別せずに行うことを指定する。


   .. cpp:enumerator:: nosubs = 1 << 2

      正規表現が文字コンテナシーケンスに対してマッチしたとき、与えられた :cpp:class:`match_results` 構造体に部分式マッチを格納しないことを指定する。


   .. cpp:enumerator:: optimize = 1 << 3

      正規表現エンジンに対して、マッチの高速化により注意を払うよう指定する。これを行うと正規表現オブジェクトの構築速度が低下する。検出不可能な作用がプログラム出力に現れることはない。


   .. cpp:enumerator:: collate = 1 << 4

      :regexp:`[a-b]` 形式の文字範囲がロカールを考慮することを指定する。


   .. cpp:enumerator:: single_line = 1 << 10

      メタ文字 :regexp:`^` および :regexp:`$` が内部の改行にマッチ\ **しない**\ことを指定する。これは Perl の既定と逆であることに注意していただきたい。Perl の /m（複数行）修飾子と反対である。


   .. cpp:enumerator:: not_dot_null = 1 << 11

      メタ文字 :regexp:`.` が null 文字 :regex-input:`\0` にマッチしないことを指定する。


   .. cpp:enumerator:: not_dot_newline = 1 << 12

      メタ文字 :regexp:`.` が改行文字 :regex-input:`\n` にマッチしないことを指定する。


   .. cpp:enumerator:: ignore_white_space = 1 << 13

      エスケープされていない空白類を無視するよう指定する。
