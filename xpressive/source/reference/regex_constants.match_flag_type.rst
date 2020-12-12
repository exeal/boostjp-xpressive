match_flag_type 型
==================

.. cpp:enum:: regex_constants::match_flag_type

   正規表現アルゴリズムの動作をカスタマイズするのに使用するフラグ。


   .. cpp:enumerator:: match_default = 0

      ECMA-262、ECMAScript 言語仕様 15 章 10 RegExp (Regular Expression) Objects（FWD.1）の通常規則に一切の変更を加えることなく正規表現マッチを行うことを指定する。


   .. cpp:enumerator:: match_not_bol = 1 << 1

      正規表現 :regexp:`^` が部分シーケンス ``[first,first)`` にマッチしないことを指定する。


   .. cpp:enumerator:: match_not_eol = 1 << 2

      正規表現 :regexp:`$` が部分シーケンス ``[last,last)`` にマッチしないことを指定する。


   .. cpp:enumerator:: match_not_bow = 1 << 3

      正規表現 :regexp:`\\b` が部分シーケンス ``[first,first)`` にマッチしないことを指定する。


   .. cpp:enumerator:: match_not_eow = 1 << 4

      正規表現 :regexp:`\\b` が部分シーケンス ``[last,last)`` にマッチしないことを指定する。


   .. cpp:enumerator:: match_any = 1 << 7

      複数のマッチが可能な場合、それらのいずれでも結果として扱ってよいことを指定する。


   .. cpp:enumerator:: match_not_null = 1 << 8

      正規表現が空のシーケンスにマッチしないことを指定する。


   .. cpp:enumerator:: match_continuous = 1 << 10

      正規表現が :cpp:var:`!first` を先頭とする部分シーケンスにマッチしなければならないことを指定する。


   .. cpp:enumerator:: match_partial = 1 << 11

      マッチが見つからない場合、:cpp:expr:`from != last` であるマッチ ``[from, last)`` を結果として返すことを指定する（``[from, last)`` を接頭辞とするより長い文字シーケンス ``[from, to)`` が完全マッチの結果として存在する可能性がある場合）。


   .. cpp:enumerator:: match_prev_avail = 1 << 12

      :cpp:expr:`--first` が有効なイテレータ位置であることを指定する。このフラグを設定すると、正規表現アルゴリズム（RE.7）およびイテレータ（RE.8）は :cpp:enumerator:`match_not_bol` および :cpp:enumerator:`match_not_bow` フラグを無視する。 [#]_


   .. cpp:enumerator:: format_default = 0

      正規表現マッチを新しい文字列で置換するとき、ECMA-262 、ECMAScript 言語仕様 15 章 5.4.11 String.prototype.replace（FWD.1）が規定する ECMAScript の :cpp:func:`!replace` 関数が使用する規則を用いて新しい文字列を構築する。検索置換操作については、互いに重複しない正規表現マッチを検索・置換し、正規表現にマッチしなかった入力部分を変更することなく出力文字列にコピーする。


   .. cpp:enumerator:: format_sed = 1 << 13

      正規表現マッチを新しい文字列で置換するとき、IEEE Std 1003.1-2001, Portable Operating SystemInterface (POSIX), Shells and Utilities が規定する Unix sed ユーティリティが使用する規則を用いて新しい文字列を構築する。


   .. cpp:enumerator:: format_perl = 1 << 14

      正規表現マッチを新しい文字列で置換するとき、ECMA-262 、ECMAScript言語仕様 15 章 5.4.11 String.prototype.replace（FWD.1）が規定する ECMAScript の :cpp:func:`!replace` 関数の規則のスーパーセットを使って新しい文字列を構築する。


   .. cpp:enumerator:: format_no_copy = 1 << 15

      検索置換操作で指定すると、マッチを行う文字コンテナシーケンスを出力文字列にコピーしない。


   .. cpp:enumerator:: format_first_only = 1 << 16

      検索置換操作で指定すると、最初の正規表現マッチのみを置換する。


   .. cpp:enumerator:: format_literal = 1 << 17

      書式化文字列をリテラルとして扱う。


   .. cpp:enumerator:: format_all = 1 << 18

      条件置換 :regexp:`(?ddexpression1:expression2)` を含むすべての構文拡張を有効にする。


.. [#] 訳注　“RE.n” はN1429の節番号（`<http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2003/n1429.htm>`_）。
