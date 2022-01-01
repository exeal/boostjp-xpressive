error_type 型
=============

.. cpp:enum:: regex_constants::error_type

   :cpp:struct:`regex_error` が使用するエラーコード。


   .. cpp:enumerator:: error_collate

      正規表現内に不正な照合要素名がある。


   .. cpp:enumerator:: error_ctype

      正規表現内に不正な文字クラス名がある。


   .. cpp:enumerator:: error_escape

      正規表現内に不正なエスケープ付き文字があるか単独のエスケープがある。


   .. cpp:enumerator:: error_subreg

      正規表現内に不正な後方参照がある。


   .. cpp:enumerator:: error_brack

      正規表現内に一致しない :regexp:`[` と :regexp:`]` がある。


   .. cpp:enumerator:: error_paren

      正規表現内に一致しない :regexp:`(` と :regexp:`)` がある。


   .. cpp:enumerator:: error_brace

      正規表現内に一致しない :regexp:`{` と :regexp:`}` がある。


   .. cpp:enumerator:: error_badbrace

      正規表現内の :regexp:`{}` 式に不正な範囲がある。


   .. cpp:enumerator:: error_range

      正規表現内に不正な文字範囲がある（例：:regexp:`[b-a]`）。


   .. cpp:enumerator:: error_space

      正規表現を有限状態マシンに変換するのにメモリが不足している。


   .. cpp:enumerator:: error_badrepeat

      :regexp:`*` 、:regexp:`?` 、:regexp:`+` 、:regexp:`{` のいずれかが正しい正規表現の後にない。


   .. cpp:enumerator:: error_complexity

      マッチを行う正規表現の計算量が規定の水準を超えた。


   .. cpp:enumerator:: error_stack

      指定した文字シーケンスに対して正規表現がマッチするか、を決定するのに必要なメモリが不足している。


   .. cpp:enumerator:: error_badref

      入れ子の正規表現が未初期化である。


   .. cpp:enumerator:: error_badmark

      名前付き捕捉の使用が不正。


   .. cpp:enumerator:: error_badlookbehind

      可変幅の後方先読み表明の作成を検出した。


   .. cpp:enumerator:: error_badrule

      規則の不正な使用を検出した。


   .. cpp:enumerator:: error_badarg

      アクションの引数が束縛されていない。


   .. cpp:enumerator:: error_badattr

      未初期化の属性を読み取ろうとした。


   .. cpp:enumerator:: error_internal

      内部エラーが発生した。
