コンセプト
----------

.. _concepts.chart_requirements:

CharT の要件
^^^^^^^^^^^^

型 :cpp:type:`!BidiIterT` を :cpp:struct:`basic_regex\<>` のテンプレート引数とすると、:cpp:type:`!iterator_traits<BidiIterT>::value_type` が :cpp:type:`!CharT` である。型 :cpp:type:`!CharT` は自明な（trivial）既定コンストラクタ、コピーコンストラクタ、代入演算子、およびデストラクタをもたなければならない。さらにオブジェクトに関しては以下の要件を満たさなければならない。:cpp:var:`!c` は :cpp:type:`!CharT` 型、:cpp:var:`!c1` と :cpp:var:`!c2` は :cpp:type:`!CharT const` 型、:cpp:var:`!i` は :cpp:type:`!int` 型である。

.. list-table:: CharT の要件
   :header-rows: 1

   * - 式
     - 戻り値の型
     - 表明、備考、事前・事後条件
   * - :code:`CharT c`
     - :cpp:type:`!CharT`
     - 既定のコンストラクタ（自明でなければならない）。
   * - :code:`CharT c(c1)`
     - :cpp:type:`!CharT`
     - コピーコンストラクタ（自明でなければならない）。
   * - :cpp:expr:`c1 = c2`
     - :cpp:type:`!CharT`
     - 代入演算子（自明でなければならない）。
   * - :cpp:expr:`c1 == c2`
     - :cpp:type:`!bool`
     - :cpp:var:`!c1` の値が :cpp:var:`!c2` と同じであれば ``true``。
   * - :cpp:expr:`c1 != c2`
     - :cpp:type:`!bool`
     - :cpp:var:`!c1` と :cpp:var:`!c2` が等値でなければ ``true``。
   * - :cpp:expr:`c1 < c2`
     - :cpp:type:`!bool`
     - :cpp:var:`!c1` の値が :cpp:var:`!c2` より小さければ ``true``。
   * - :cpp:expr:`c1 > c2`
     - :cpp:type:`!bool`
     - :cpp:var:`!c1` の値が :cpp:var:`!c2` より大きければ ``true``。
   * - :cpp:expr:`c1 <= c2`
     - :cpp:type:`!bool`
     - :cpp:var:`!c1` が :cpp:var:`!c2` より小さいか等値であれば ``true``。
   * - :cpp:expr:`c1 >= c2`
     - :cpp:type:`!bool`
     - :cpp:var:`!c1` が :cpp:var:`!c2` より大きいか等値であれば ``true``。
   * - :code:`intmax_t i = c1`
     - :cpp:type:`!int`
     - :cpp:type:`!CharT` は整数型に変換可能でなければならない。
   * - :code:`CharT c(i);`
     - :cpp:type:`!CharT`
     - :cpp:type:`!CharT` は整数型から構築可能でなければならない。


.. _concepts.traits_requirements:

特性の要件
^^^^^^^^^^

以下の表において :cpp:class:`!X` は :cpp:type:`!CharT` 型の文字コンテナについて型と関数を定義する特性クラスである。:cpp:var:`!u` は :cpp:class:`!X` 型のオブジェクト、:cpp:var:`!v` は :cpp:type:`!const X` 型のオブジェクト、:cpp:var:`!p` は :cpp:type:`!const CharT*` 型の値、:cpp:type:`!I1` と :cpp:type:`!I2` は ``Input Iterator``、:cpp:var:`!c` は :cpp:type:`!const CharT` 型の値、:cpp:var:`!s` は :cpp:type:`!X::string_type` 型のオブジェクト、:cpp:var:`!cs` は :cpp:type:`!const X::string_type` 型のオブジェクト、:cpp:var:`!b` は :cpp:type:`!bool` 型の値、:cpp:var:`!i` は :cpp:type:`!int` 型の値、:cpp:var:`!F1` と :cpp:var:`!F2` は :cpp:type:`!const CharT*` 型の値、:cpp:var:`!loc` は :cpp:type:`!X::locale_type` 型のオブジェクト、:cpp:var:`!ch` は :cpp:type:`!const char` のオブジェクトである。

.. list-table:: 特性の要件
   :header-rows: 1

   * - 式
     - 戻り値の型
     - 表明、備考、事前・事後条件
   * - :cpp:expr:`X::char_type`
     - :cpp:type:`!CharT`
     - :cpp:struct:`basic_regex\<>` クラステンプレートを実装する文字コンテナ型。
   * - :cpp:expr:`X::string_type`
     - :cpp:type:`!std::basic_string<CharT>` か :cpp:type:`!std::vector<CharT>`
     - なし。
   * - :cpp:expr:`X::locale_type`
     - :cpp:type:`!（実装定義）`
     - 特性クラスが使用するロカールを表現する、コピー構築可能な型。
   * - :cpp:expr:`X::char_class_type`
     - :cpp:type:`!（実装定義）`
     - 個々の文字分類（文字クラス）を表現するビットマスク型。この型の複数の値をビット和すると別の有効な値を得る。
   * - :cpp:expr:`X::hash(c)`
     - :cpp:type:`!unsigned char`
     - ``0`` 以上 :cpp:var:`!UCHAR_MAX` 以下の値を生成する。
   * - :cpp:expr:`v.widen(ch)`
     - :cpp:type:`!CharT`
     - 指定した :cpp:type:`!char` のワイド版を :cpp:type:`!CharT` で返す。
   * - :cpp:expr:`v.in_range(r1, r2, c)`
     - :cpp:type:`!bool`
     - 任意の文字 :cpp:var:`!r1` と :cpp:var:`!r2` について、:cpp:expr:`r1 <= c && c <= r2` であれば ``true`` を返す。:cpp:expr:`r1 <= r2` でなければならない。
   * - :cpp:expr:`v.in_range_nocase(r1, r2, c)`
     - :cpp:type:`!bool`
     - 任意の文字 :cpp:var:`!r1` と :cpp:var:`!r2` について、:cpp:expr:`v.translate_nocase(d) == v.translate_case(c)` かつ :cpp:expr:`r1 <= d && d <= r2` となる文字 :cpp:var:`!d` が存在すれば ``true`` を返す。:cpp:expr:`r1 <= r2` でなければならない。
   * - :cpp:expr:`v.translate(c)`
     - :cpp:type:`!X::char_type`
     - :cpp:var:`!c` と等価、つまり :cpp:expr:`v.translate(c) == v.translate(d)` となるような文字 :cpp:var:`!d` を返す。
   * - :cpp:expr:`v.translate_nocase(c)`
     - :cpp:type:`!X::char_type`
     - 大文字小文字を区別せずに比較したとき :cpp:var:`!c` と等価、つまり :cpp:expr:`v.translate_nocase(c) == v.translate_nocase(C)` となるような文字 :cpp:var:`!C`。
   * - :cpp:expr:`v.transform(F1, F2)`
     - :cpp:type:`!X::string_type`
     - イテレータ範囲 ``[F1, F2)`` が示す文字シーケンスのソートキーを返す。文字シーケンス ``[G1, G2)`` が文字シーケンス ``[H1, H2)`` の前にソートされる場合に :cpp:expr:`v.transform(G1, G2) < v.transform(H1, H2)` とならなければならない。
   * - :cpp:expr:`v.transform_primary(F1, F2)`
     - :cpp:type:`!X::string_type`
     - イテレータ範囲 ``[F1, F2)`` が示す文字シーケンスのソートキーを返す。大文字小文字を区別せずにソートして文字シーケンス ``[G1, G2)`` が文字シーケンス ``[H1, H2)`` の前に現れる場合に :cpp:expr:`v.transform_primary(G1, G2) < v.transform_primary(H1, H2)` とならなければならない。
   * - :cpp:expr:`v.lookup_classname(F1, F2)`
     - :cpp:type:`!X::char_class_type`
     - イテレータ範囲 ``[F1, F2)`` が示す文字シーケンスを、:cpp:func:`!isctype` に渡せるビットマスク型に変換する。:cpp:func:`!lookup_classname` が返した値同士でビット和を取っても安全である。文字シーケンスがXが解釈できる文字クラス名でなければ ``0`` を返す。文字シーケンス内の大文字小文字の違いで戻り値が変化することはない。
   * - :cpp:expr:`v.lookup_collatename(F1, F2)`
     - :cpp:type:`!X::string_type`
     - イテレータ範囲 ``[F1, F2)`` が示す文字シーケンスが構成する照合要素を表す文字シーケンスを返す。文字シーケンスが正しい照合要素でなければ空文字列を返す。
   * - :cpp:expr:`v.isctype(c, v.lookup_classname(F1, F2))`
     - :cpp:type:`!bool`
     - 文字 :cpp:var:`!c` が、イテレータ範囲 ``[F1, F2)`` が示す文字クラスのメンバであれば真を返す。それ以外は偽を返す。
   * - :cpp:expr:`v.value(c, i)`
     - :cpp:type:`!int`
     - 文字 :cpp:var:`!c` が基数 :cpp:var:`!i` で有効な数字であれば、数字 :cpp:var:`!c` の基数 :cpp:var:`!i` での数値を返す。\ [#]_ それ以外の場合は ``-1`` を返す。
   * - :cpp:expr:`u.imbue(loc)`
     - :cpp:type:`!X::locale_type`
     - ロカール :cpp:var:`!loc` を :cpp:var:`!u` に指示する。:cpp:var:`!u` が直前まで使用していたロカールを返す。
   * - :cpp:expr:`v.getloc()`
     - :cpp:type:`!X::locale_type`
     - :cpp:var:`!v` が使用中のロカールを返す。


謝辞
^^^^

この節は `Boost.Regex <http://www.boost.org/libs/regex/>`_ ドキュメントの同じページと、正規表現を標準ライブラリに追加することになった\ `草案 <http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2003/n1429.htm>`_\をもとに作成した。


.. [#] :cpp:var:`i` の値は 8 、10 、16 のいずれかである。
