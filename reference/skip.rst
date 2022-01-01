skip 関数テンプレート
=====================

.. cpp:function:: template<typename Skip> \
		  unspecified skip(Skip const& skip)

   正規表現マッチ中に読み飛ばす文字を指定する。

   :param skip: 読み飛ばす文字を指定する正規表現。


説明
----

:cpp:func:`!skip()` は、正規表現マッチ中に読み飛ばす文字を正規表現エンジンに対して指示する。空白類文字を無視する正規表現を記述するのに最も有用である。例えば、以下は正規表現について空白類文字と区切り文字を読み飛ばすよう指定する。 ::

   // 文は空白類文字か区切り文字で区切られた
   // 1 つ以上の単語からなる。
   sregex word = +alpha;
   sregex sentence = skip(set[_s | punct])( +word );

上記の例と同じことをするには正規表現内の各プリミティブの前に :cpp:expr:`keep(*set[_s | punct])` を挿入する必要がある。「プリミティブ」とは文字列や文字集合、入れ子の正規表現のことである。最後に正規表現の終端にも :cpp:expr:`*set[_s | punct]` が必要である。上で指定した文の正規表現は以下と等価である。 ::

   sregex sentence = +( keep(*set[_s | punct]) >> word )
                          >> *set[_s | punct];

.. note::
   入れ子の正規表現は不可分として扱われるため、読み飛ばしがこれらの処理方法に影響することはない。文字列リテラルもまた不可分として扱われ、文字列リテラル内で読み飛ばしは発生しない。よって :cpp:expr:`skip(_s)("this that")` は :cpp:expr:`skip(_s)("this" >> as_xpr("that"))` と同じではない。前者は :regex-input:`this` と :regex-input:`that` の間に空白が1つあるものだけにマッチする。後者は :regex-input:`this` と :regex-input:`that` の間の空白をすべて読み飛ばす。
