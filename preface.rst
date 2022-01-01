前口上 [#]_
===========

    Wife: New Shimmer is a floor wax!

    Husband: No, new Shimmer is a dessert topping!

    Wife: It's a floor wax!

    Husband: It's a dessert topping!

    Wife: It's a floor wax, I'm telling you!

    Husband: It's a dessert topping, you cow!

    Announcer: Hey, hey, hey, calm down, you two. New Shimmer is both a floor wax and a dessert topping!

    -- Saturday Night Live


説明
----

xpressive は正規表現の高度な C++ オブジェクト指向テンプレートライブラリである。正規表現（正規式）を文字列で渡して実行時に解析することもできれば、式テンプレートを使ってコンパイル時に解析することもできる。正規表現はお互いを参照しあうことも、自身を再帰的に参照することもでき、これらから複雑な文法を任意に構築できる。


動機
----

C++ でテキスト処理をする場合、2 つの別々な選択肢がある。正規表現エンジンとパーサジェネレータである。正規表現エンジン（`Boost.Regex`_ 等）は強力で柔軟性がある。パターンは文字列で表現し、実行時に指定する。しかしながら構文エラーもまた、実行時まで検出されない。また正規表現は、入れ子かつ数の合った HTML タグに対するマッチのような、より高度なテキスト処理問題には適していない。従来、こういった処理はパーサジェネレータ（`Spirit パーサジェネレータ <http://spirit.sourceforge.net/>`_\ 等）により取り扱われてきた。こうした怪物級の連中はより強力だが柔軟性がなく、通常はその場での文法規則の任意修正を許していない。さらに言えば、正規表現の網羅的なバックトラックのセマンティクス（意味）も有していないため、パターンの種類によっては大変な労力が必要になる場合がある。

xpressive はこれら2つのアプローチを相互にシームレスに接続し、C++ テキスト処理の世界において固有の地位を築く。xpressive を使えば、`Boost.Regex`_ を使うのと同様に正規表現を文字列で表現できる。あるいは `Spirit <http://spirit.sourceforge.net/>`_ を使うのと同様に正規表現を C++ の式として記述でき、テキスト処理専用の組み込み言語による恩恵を受けることができる。さらに、この 2 つを混ぜて両方の利点を引き出すこともできる。つまり正規表現\ **文法**\を、あるときは静的に束縛（ハードコードし、コンパイラによる構文チェックが可能）、またあるときは動的に束縛し実行時に記述できる。これら 2 種類の正規表現はお互いに再帰的に参照可能で、普通の正規表現では不可能なマッチが可能である。


影響を受けたか関係のあるライブラリ
----------------------------------

xpressive のインターフェイスの設計については、John Maddock の `Boost.Regex`_ と、正規表現が標準ライブラリに追加されることになった彼の\ `草案 <http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2003/n1429.htm>`_\に多大な影響を受けた。また、静的 xpressive のモデルとなった Joel de Guzman の `Spirit パーサフレームワーク <http://spirit.sourceforge.net/>`_\にも大きなインスピレーションを受けた。他にインスピレーションを受けたものとして、`Perl 6 <http://www.perl.com/pub/a/2002/06/04/apo5.html>`_ の設計と `GRETA <http://research.microsoft.com/projects/greta>`_ がある（正規表現の慣習を変える Perl 6 の変更について、概要が\ `ここ <http://dev.perl.org/perl6/doc/design/syn/S05.html>`_\にある）。


.. _Boost.Regex: http://www.boost.org/libs/regex/


.. [#] 訳注　http://snltranscripts.jt.org/75/75ishimmer.phtml とか。検索すると動画も出てきます。
