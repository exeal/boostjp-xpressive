Python の関数とメソッドの呼び出し
=================================

.. contents::
   :depth: 1
   :local:


.. _v2.calling.introduction:

はじめに
--------

Python 関数を保持する :cpp:class:`object` インスタンス :cpp:var:`!f` が与えられたとき、C++ からその関数を呼び出す最も簡単な方法は、単にその関数呼び出し演算子を起動することである。 ::

   f("tea", 4, 2) // Python の f('tea', 4, 2) と同じ

また、当然のことながら :cpp:class:`object` インスタンス :cpp:var:`!x` のメソッドを呼び出すには対応する属性の関数呼び出し演算子を使用する。 ::

   x.attr("tea")(4, 2); // Python の x.tea(4, 2) と同じ

:cpp:class:`!object` インスタンスがない場合、:c:type:`!PyObject*` に対して Python の関数およびメソッドを呼び出すために、Boost.Python は 2 種類の関数テンプレート :cpp:func:`call` および :cpp:func:`call_method` を提供している。Python の関数オブジェクト（または Python の呼び出し可能オブジェクト）を呼び出すインターフェイスは次のようなものである。 ::

   call<ResultType>(callable_object, a1, a2... aN);

Python オブジェクトのメソッド呼び出しも同様に簡単である。 ::

   call_method<ResultType>(self_object, "method-name", a1, a2... aN);

この比較的低水準なインターフェイスは、Python でオーバーライド可能な C++ 仮想関数を実装するときに使用する。


.. _v2.calling.argument_handling:

引数の処理
----------

引数はその型に従って Python に変換する。既定では引数 :cpp:var:`!a1`...\ :cpp:var:`!aN` は新しい Python オブジェクトにコピーされるが、:cpp:func:`ptr()` および `ref() <http://www.boost.org/libs/bind/ref.html>`_ を使用してこの振る舞いを上書きすることができる。 ::

   class X : boost::noncopyable
   {
      ...
   };

   void apply(PyObject* callable, X& x)
   {
      // callable を呼び出し、x への参照を保持する Python オブジェクトを渡す
      boost::python::call<void>(callable, boost::ref(x));
   }

以下の表において :cpp:var:`!x` は実際の引数オブジェクトであり、:samp:`{cv}` は省略可能な CV 指定子（``const`` 、``volatile`` あるいは ``const volatile``）である。

.. list-table::
   :header-rows: 1

   * - 引数の型
     - 振る舞い
   * - :cpp:type:`!T cv&` 、:cpp:type:`!T cv`
     - :cpp:type:`!T` を返すラップした C++ 関数の戻り値と同じ方法で Python 引数を作成する。:cpp:type:`!T` がクラス型の場合、通常は :cpp:var:`!x` を新しい Python オブジェクト内にコピー構築する。

       .. 'x' は原文だと '*x' になってる

   * - :cpp:type:`!T*`
     - :cpp:expr:`x == 0` の場合、Python 引数は `None <http://docs.python.jp/2/library/stdtypes.html#bltin-null-object>`_ である。それ以外の場合、:cpp:type:`!T` を返すラップする C++ 関数の戻り値と同じ方法で Python 引数を作成する。:cpp:type:`!T` がクラス型の場合、通常は :cpp:expr:`*x` を新しい Python オブジェクト内にコピー構築する。
   * - `boost::reference_wrapper\<> <http://www.boost.org/libs/bind/ref.html>`_
     - Python の引数は（コピーではなく）\ :cpp:expr:`x.get()` へのポインタを持つ。注意：結果のオブジェクトへの参照を保持する Python コードが :cpp:expr:`*x.get()` の寿命を超えて存在しないようにしないと、**クラッシュする！**
   * - :cpp:struct:`pointer_wrapper\<T>`
     - :cpp:expr:`x.get() == 0` の場合、Python 引数は `None <http://docs.python.jp/2/library/stdtypes.html#bltin-null-object>`_ である。それ以外の場合、Python の引数は（コピーではなく）\ :cpp:expr:`x.get()` へのポインタを持つ。注意：結果のオブジェクトへの参照を保持する Python コードが :cpp:expr:`*x.get()` の寿命を超えて存在しないようにしないと、**クラッシュする！**


.. _v2.calling.result_handling:

戻り値の処理
------------

大抵の場合 :cpp:expr:`call<ResultType>()` および :cpp:expr:`call_method<ResultType>()` は、:cpp:type:`!ResultType` に対して登録したすべての lvalue および rvalue の ``from_python`` 変換器を利用し、結果のコピーである :cpp:type:`!ResultType` を返す。しかしながら :cpp:type:`!ResultType` がポインタか参照型の場合、Boost.Python は lvalue の変換器のみを探索する。懸垂ポインタおよび参照を避けるため、結果の Python オブジェクトの参照カウントが 1 の場合は例外を投げる。


.. _v2.calling.rationale:

根拠
----

通常 :cpp:var:`!a1`...\ :cpp:var:`!aN` に対応する Python の引数を得るには、それぞれについて新しい Python オブジェクトを作成しなければならない。C++ オブジェクトをその Python オブジェクトにコピーすべきだろうか、あるいは Python オブジェクトが単に C++ オブジェクトへの参照かポインタを保持すべきだろうか。大抵の場合、呼び出される関数はどこかに行ってしまった Python オブジェクトへの参照を保持する可能性があるため、後者の方法は安全ではない。C++ オブジェクトを破壊した後に Python オブジェクトを使用すると、Python がクラッシュする。

Python 側のユーザがインタープリタのクラッシュについて気を払うべきでないという原理を踏まえ、既定の振る舞いは C++ オブジェクトをコピーすることとなっており、コピーを行わない振る舞いはユーザが直接 :cpp:expr:`a1` と書く代わりに `boost::ref <http://www.boost.org/libs/ref.html>`_\ :code:`(a1)` とした場合のみ認められる。こうすることで、少なくとも「意図せず」危険な振る舞いを遭遇することはない。コピーを伴わない（「参照」による）振る舞いは通常、クラス型でのみ利用可能であり、それ以外で使用すると実行時に Python の例外を送出して失敗する\ [#]_\ことも付記しておく。

しかしながらポインタ型が問題となる。方法の 1 つはいずれかの :cpp:var:`!aN` がポインタ型である場合にコンパイルを拒絶することである。何といってもユーザは「値渡し」として :cpp:expr:`*aN` を渡すことができ、:cpp:expr:`ref(*aN)` で参照渡しの振る舞いを示すことができる。しかしこれでは null ポインタから :py:const:`!None` への変換で問題が起こる。null ポインタ値を参照剥がしすることは違法である。

折衷案として私が下した決断は以下のとおりだ：

#. 既定の振る舞いは値渡しとする。非 null ポインタを渡すと、参照先が新しい Python オブジェクトにコピーされる。それ以外の場合、対応する Python 引数は :py:const:`!None` である。
#. 参照渡しの振る舞いが必要な場合は、:cpp:var:`!aN` がポインタであれば :cpp:expr:`ptr(aN)` を、そうでなければ :cpp:expr:`ref(aN)` を使用する。:cpp:expr:`ptr(aN)` に null ポインタを渡すと、対応する Python 引数は :py:const:`!None` である。

戻り値についても類似の問題がある。:cpp:type:`!ResultType` にポインタ型か参照型を認めてしまうと、参照先のオブジェクトの寿命はおそらく Python オブジェクトに管理されることになる。この Python オブジェクトが破壊されるとポインタは懸垂する。:cpp:type:`!ResultType` が :cpp:type:`!char const*` の場合、特に問題は深刻である。対応する Python の String オブジェクトは一般に参照カウントが 1 であり、つまり :cpp:expr:`call<char const*>(...)` が返った直後にポインタは懸垂する。

以前の Boost.Python v1 は :cpp:expr:`call<char const*>()` のコンパイルを拒絶することでこの問題に対処したが、これは極端でありかつ何の解決にもならない。極端というのは、所有する Python の文字列オブジェクト（例えば Python のクラス名である場合）が呼び出しを超えて生存する可能性があるためである。また、他の型のポインタや参照の戻り値についてもまったく同様の問題があるため、結局は解決にならないわけである。

Boost.Python v2 では次のように対処した。

#. コールバックの :cpp:type:`!const char*` 戻り値型に対するコンパイル時の制限を除去した。
#. :cpp:type:`!U` がポインタ型か参照型の場合、戻り値の Python オブジェクトの参照カウントが 1 である場合を検出し、:cpp:expr:`call<U>(...)` 内で例外を投げる。

ユーザは :cpp:expr:`call<U>` 内で :cpp:type:`!U` について明示的にポインタ、参照を指定しなければならないため安全であり、実行時の懸垂からも保護される。少なくとも :cpp:expr:`call<U>(...)` の呼び出しから抜け出すには十分である。


.. [#] :cpp:type:`!int` や :cpp:type:`!char` のような非クラス型についてはコンパイル時に失敗させることも可能だろうが、それがこの制限を課す優れた方法であるか私にはよく分からない。
