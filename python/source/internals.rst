.. Copyright David Abrahams 2006. Distributed under the Boost
.. Software License, Version 1.0. (See accompanying
.. file LICENSE_1_0.txt or copy at
.. http://www.boost.org/LICENSE_1_0.txt)

Boost.Python の裏側
===================

Brett Calcott と David Abrahams のやりとり
------------------------------------------

.. sectionauthor:: Copyright 2003 David Abrahams, Brett Calcott

（訳注：素の文が David Abrahams 、引用文が Brett Calcott のメッセージ。以下の 2 問が Brett から David に投げかけられた。その上で）\ [#]_\これらのケースではいずれもコードを読んでいくことはできるのだが、アーキテクチャの意図がソースからは構造的にも時間的にも分からなかった（つまりその、私が言いたいのはそれらがどのような順序で行われるかだ）。

   1. 次のようにすると何が起こるか： ::

	 struct boring {};
         // ...etc...
         class_<boring>("boring")
             ;

      先を続けさせてもらうと、次のようにいろいろ出てくると思うのだが。

      * Python は新しい ClassType の登録を必要とする。
      * :cpp:class:`!boring` 構造体を保持可能な新しい型を構築する必要がある。
      * この型に対して内向きと外向きの変換器を登録する必要がある。

      これらの方法について汎用的な方向性を提示してもらえるだろうか？

時間の関係で確かこうだったぐらいの回答しかできないけど。このメールを読んだあとにデバッガを使ってコードの詳細を調べるのはどうかな（別に忘れちゃったわけじゃないけどね）。

:cpp:func:`!Boost.Python.class`\（メタ型）を呼び出すと、:cpp:class:`!Boost.Python.Instance` の新しい（Python の）派生クラスが作成される（:file:`libs/python/src/object/class.cpp` を参照）：

.. code-block:: python

   >>> boring = Boost.Python.class(
   ...     'boring'
   ...   , bases_tuple       # この場合は単に ()
   ...   , { 
   ...         '__module__' : module_name
   ...       , '__doc__' : doc_string # 省略可能
   ...     }
   ... )

このオブジェクトに対するハンドルは :cpp:class:`!registration` の :cpp:member:`m_class_object` フィールドで :cpp:expr:`typeid(boring)` に紐付けされる。（たぶんよろしくないことだけど）拡張モジュールの :cpp:struct:`!boring` 属性を一掃したとしても、レジストリはこのオブジェクトを永久に生存させる。

:code:`class_<boring, non_copyable, ...>` を指定していないので、:cpp:struct:`!boring` の Python への変換器を登録する。この変換器は Python の :py:obj:`!boring` オブジェクトが保持する :py:attr:`!value_holder` へその引数をコピーする。

:code:`class<boring, ...>(no_init)` を指定していないので、:py:attr:`!__init__` 関数オブジェクトをクラスの辞書に追加する。この関数オブジェクトは（ホルダとしてスマートポインタか派生ラッパクラスを指定していないので）Python の :py:obj:`!boring` オブジェクトが保持する :py:attr:`!value_holder` に :py:obj:`boring` をデフォルトコンストラクトする。

:cpp:func:`!register_class_from_python` は、:cpp:class:`!shared_ptr<boring>` に対する Python からの変換器を登録するのに使う。:cpp:class:`!boost::shared_ptr` はスマートポインタの中でも特殊なものだ。Deleter 引数を使えば、（C++ オブジェクトの保持がどのような形態であれ）その内包する C++ オブジェクトのみならず Python オブジェクト全体をも管理できるからだ。

:cpp:class:`!bases<>` を与えておくと、これら基底クラス群と :cpp:struct:`!boring` 間の継承図（:file:`inheritance.[hpp/cpp]`\）における関係も登録する。

このコードの以前のバージョンでは、このクラスに対して Python から lvalue への変換器を登録していた。現在はラップされたクラスの Python からの変換は、変換元の Python オブジェクトのメタクラスが Boost.Python のメタクラスである場合、レジストリを調べる前に特殊な場合として処理される。

とまぁ、こういった Python からの変換器は、たぶん明示的に変換を登録しない場合の変換器クラスと同様に扱うべきだね。

   2. レジストリ内に現れるデータ構造について、手短な概要は

レジストリは簡単で、:code:`typeid` から :cpp:class:`!registration` への写像（:file:`boost/python/converter/registrations.hpp` を参照）でしかない。:cpp:var:`!lvalue_chain` と :cpp:var:`!rvalue_chain` は単に内部的なリンクリストだ。

他に知りたいことがあったら、また聞いてくれ。

継承図について知りたいことがあったら、他のメッセージで個別に聞いてくれ。

   同時に C++ から Python およびその逆方向の型変換について処理の概要はどうか。

難題だね。背景について調べることを勧めるよ。LLNL 進捗レポート内の関連情報と、そこからリンクしているメッセージを探すといい。あとは、\ [#]_

* http://mail.python.org/pipermail/c++-sig/2002-May/001023.html
* http://mail.python.org/pipermail/c++-sig/2002-December/003115.html
* http://aspn.activestate.com/ASPN/Mail/Message/1280898
* http://mail.python.org/pipermail/c++-sig/2002-July/001755.html


C++ から Python への変換：
^^^^^^^^^^^^^^^^^^^^^^^^^^

型と使っている呼び出しポリシーによる。あるいは :cpp:func:`!call\<>(...)` 、:cpp:func:`!call_method\<>(...)` 、:cpp:func:`!object(...)` については :cpp:func:`!ref` や :cpp:func:`!ptr` を使っているかによる。Python への変換は基本的には、「戻り値」の変換（Python から C++ の呼び出し）と「引数」の変換（C++ から Python の呼び出しと明示的な :cpp:func:`!object()` の変換）の 2 つに分けられる。詳細はすぐには思い出せないけど、これら 2 つの振る舞いの違いはとにかくわずかなものだ。上の参考にたぶんその答えがあるし、コードを見たら確実に見つかる。

「既定の」場合だと値による（コピー）変換になるので、Python への変換器として :cpp:class:`!to_python_value` を使う。

普通に考えると、ある型を Python へ変換する方法は 1 つしかないはず（スコープ付きのレジストリを使う方法もあるが今は無視しよう）なので、Python への変換は当然テンプレートの特殊化で処理する。この型が組み込みの変換（:file:`builtin_converters.hpp`\）で処理するものであれば、相当する :cpp:class:`!to_python_value` のテンプレート特殊化を使う。

上記以外の場合、:cpp:class:`!to_python_value` は C++ 型に対する registration 内の :cpp:func:`!m_to_python` 関数を使う。

参照による変換のような他の変換はラップしたクラスでのみ有効で、明示的に要求されるのは :cpp:func:`!ref(...)` か :cpp:func:`!ptr(...)` を使うか異なる CallPolicies を指定（異なる Python への変換器を使う）した場合だ。:cpp:class:`!registration` を使って参照先の C++ 型に対応する Python クラスを見つける必要があるが、これらの変換器はどこにも登録されない。これらは単に Python の新しいインスタンスを構築し、適当な :cpp:type:`!Holder` インスタンスを紐付ける。


Python から C++ への変換：
^^^^^^^^^^^^^^^^^^^^^^^^^^

もう一度、「戻り値」の変換と「引数」の変換には違いがあることを覚えておこう。そしてその正確な意味は忘れよう。

何が起こるかは lvalue の変換が必要かどうかによる（http://mail.python.org/pipermail/c++-sig/2002-May/001023.html を参照）。rvalue が登録されていれば lvalue は確実に問題ないので、あらゆる lvalue の変換器は型の rvalue の変換チェインにも登録される。

rvalue の変換は、ラップした関数の多重定義と与えられた対象の C++ 型に対する複数の変換器をサポートするために 2 ステップ必要とする（まず変換が可能か判断して、次のステップで変換したオブジェクトを構築する）。いっぽう、lvalue の変換は 1 ステップで完了できる（オブジェクトへのポインタを得るだけだ。変換が不可能な場合は NULL の可能性がある）。


.. [#] 訳注　元のメッセージは https://mail.python.org/pipermail/cplusplus-sig/2003-July/004480.html\ 。

.. [#] 訳注　Python.org の URL は移動してしまいました。https://mail.python.org/pipermail/cplusplus-sig/ 以下が移動先と思われますが、訳者には個々のメッセージの場所が分かりませんでした。
