付録 2：未実装の項目
--------------------

以下の機能は xpressive 2.x で実装を予定している。

* :cpp:var:`syntax_option_type::collate`
* :regexp:`[.a.]` のような照合シーケンス
* :regexp:`[=a=]` のような等価クラス
* :cpp:var:`syntax_option_type::nosubs` を使用したときの入れ子結果の生成制御。静的正規表現における :cpp:func:`nosubs()` 修飾子。
  
ウィッシュリスト。あなたやあなたの会社がお金をくれるなら考えてもいいよ！
  
* 単純な正規表現を高速化する、最適化 DFA バックエンド。
* basic 、extended 、awk 、grep および egrep 正規表現構文のための別の正規表現コンパイラフロントエンド。
* 動的正規表現構文のより細かい制御。
* ICU を使った完全な Unicode サポート。
* 地域化サポートの強化（可能な限り :cpp:class:`std::locale` のカスタムファセットを使う）。
