チュートリアル
==============

.. pull-quote::

   | **Joel de Guzman**
   | **David Abrahams**
   | © 2002-2005 Joel de Guzman, David Abrahams
   | Distributed under the Boost Software License, Version 1.0. (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt

.. contents::
   :local:
   :depth: 2


.. _tutorial.quickstart:

クイックスタート
----------------

Boost.Python ライブラリは Python と C++ 間のインターフェイスのためのフレームワークである。C++ のクラス、関数、オブジェクトをすばやくシームレスに Python へエクスポートでき、また逆に Python から C++ へエクスポートできる。特別なツールは必要なく、あなたのコンパイラだけで可能だ。このライブラリは C++ インターフェイスを非侵入的にラップするよう設計されており、C++ コードを変更する必要は一切ない。このため、サードパーティ製ライブラリを Python へエクスポートするには Boost.Python が最適である。ライブラリは高度なメタプログラミング技術を使ってその構文を単純化しており、コードのラッピングは宣言的なインターフェイス定義言語（IDL）のような見た目になっている。


.. _tutorial.quickstart.hello_world:

Hello World
^^^^^^^^^^^

C/C++ の伝統に従い「hello, world」から始めるとしよう。 ::

   char const* greet()
   {
      return "hello, world";
   }

この C++ 関数は、次の Boost.Python ラッパを書くことで Python へエクスポートできる。 ::

   #include <boost/python.hpp>

   BOOST_PYTHON_MODULE(hello_ext)
   {
       using namespace boost::python;
       def("greet", greet);
   }

これですべてである。あとはこれを共有ライブラリとしてビルドすると、生成した DLL が Python から可視となる。以下は Python のセッション例である。

.. code-block:: python

   >>> import hello_ext
   >>> print hello_ext.greet()
   hello, world

.. 次回、「Hello Worldモジュールのビルド」。


.. _tutorial.hello:

Hello World のビルド
--------------------

.. _tutorial.hello.from_start_to_finish:

始めから終わりまで
^^^^^^^^^^^^^^^^^^

まず最初は Hello World モジュールをビルドして Python で使ってみることだろう。本節でそのためのステップを明らかにする。あらゆる Boost ディストリビューションに付属するビルドツールである :program:`bjam` を使用する。

.. note::

   .. rubric:: :program:`bjam` を使用せずにビルドする

   当然 :program:`bjam` 以外にモジュールをビルドする方法はある。ここに書いていることが「唯一の方法」というわけではない。:program:`bjam` の他にビルドツールは存在する。

   しかしながら Boost.Python のビルドには :program:`bjam` が適していると記しておく。セットアップを失敗させる方法はたくさんある。経験から言えば「Boost.Python がビルドできない」という問題の 9 割は、他のツールを使用することを余儀なくされた人から寄せられた。

細かいことは省略する。ここでの目的は Hello World モジュールを簡単に作成して Python で走らせることである。Boost.Python のビルドについて完全なリファレンスは「:doc:`building`\」を見るとよい。この短いチュートリアルが終わったら DLL のビルドが完了して Python のプログラムで拡張が走っているはずである。

チュートリアルの例はディレクトリ :file:`/libs/python/example/tutorial` にある。以下のファイルがある。

* :file:`hello.cpp`
* :file:`hello.py`
* :file:`Jamroot`

:file:`hello.cpp` ファイルは C++ の Hello World 例、:file:`Jamroot` は DLL をビルドする最小限の bjam スクリプトである。そして :file:`hello.py` は :file:`hello.cpp` の拡張を使用する Python プログラムである。

何よりもまず bjam の実行可能ファイルを boost ディレクトリか、:program:`bjam` をコマンドラインから実行できるパスに置いておく。ほとんどのプラットフォームでビルド済み Boost.Jam 実行可能ファイルが利用できる。bjam 実行可能ファイルの完全なリストが\ `ここ <http://sourceforge.net/project/showfiles.php?group_id=7586>`_\にある。


.. _tutorial.hello.let_s_jam:

Jam ろう！
^^^^^^^^^^

最小限の Jamroot ファイルを :file:`/libs/python/example/tutorial/Jamroot` に置いておく。そのままファイルをコピーして :code:`use-project boost` の部分を Boost のルートディレクトリに設定すればよい。

必要なことはこの Jamroot ファイルのコメントに書いてある。


.. _tutorial.hello.running_bjam:

bjam を起動する
^^^^^^^^^^^^^^^

オペレーティングシステムのコマンドラインインタープリタから :program:`bjam` を起動する。

では、始めるとしよう。

:file:`user-config.jam` という名前のファイルをホームディレクトリに置いてツールを調整する。Windows の場合、コマンドプロンプトウィンドウで次のようにタイプするとホームディレクトリがわかる。

.. code-block:: console

   ECHO %HOMEDRIVE%%HOMEPATH%

ファイルには少なくともコンパイラと Python のインストールについてのルールを書いておく必要がある。Windows の場合は例えば以下のとおり：

.. code-block:: none

   #  Microsoft Visual C++ の設定
   using msvc : 8.0 ;

   #  Python の設定
   using python : 2.4 : C:/dev/tools/Python ;

1 番目のルールで MSVC 8.0 とその関連ツールを使用することを bjam に設定している。2 番目のルールは Python についての設定であり、Python のバージョンと場所を指定している。上の例では :file:`C:/dev/tools/Python` に Python をインストールした想定である。Python を正しく「標準的に」インストールした場合はこの設定は不要である。

ここまで来れば準備は整った。チュートリアルの :file:`hello.cpp` と :file:`Jamroot` が置いてある :file:`libs/python/example/tutorial` に :program:`cd` で移動するのを忘れないように。

.. code-block:: console

   bjam

これでビルドが始まり、

.. code-block:: console

   cd C:\dev\boost\libs\python\example\tutorial
   bjam
   ...patience...
   ...found 1101 targets...
   ...updating 35 targets...

最終的に例えば以下のように表示される。

.. code-block:: console

   Creating library path-to-boost_python.dll
   Creating library /path-to-hello_ext.exp/
   **passed** ... hello.test
   ...updated 35 targets...

すべて問題なければ、DLL がビルドされ Python のプログラムが走るはずである。

さあ、楽しんでいただきたい！


.. _tutorial.exposing:

クラスのエクスポート
--------------------

では C++ クラスを Python へエクスポートしよう。

エクスポートすべき C++ クラス・構造体を考えよう。 ::

   struct World
   {
       void set(std::string msg) { this->msg = msg; }
       std::string greet() { return msg; }
       std::string msg;
   };

相当する Boost.Python ラッパを書いて Python へエクスポートできる。 ::

   #include <boost/python.hpp>
   using namespace boost::python;

   BOOST_PYTHON_MODULE(hello)
   {
       class_<World>("World")
           .def("greet", &World::greet)
           .def("set", &World::set)
       ;
   }

上記のようにメンバ関数 :cpp:func:`!greet` および :cpp:func:`!set` をエクスポートする C++ クラスラッパを書いた。このモジュールを共有ライブラリとしてビルドすると、Python 側から :cpp:class:`!World` クラスが使用できるようになる。次に示すのは Python のセッション例である。

.. code-block:: python

   >>> import hello
   >>> planet = hello.World()
   >>> planet.set('howdy')
   >>> planet.greet()
   'howdy'


.. _tutorial.exposing.constructors:

コンストラクタ
^^^^^^^^^^^^^^

前回の例では明示的なコンストラクタが登場しなかった。:cpp:class:`!World` はプレーンな構造体として宣言したので、暗黙のデフォルトコンストラクタとなっていた。Boost.Python は既定ではデフォルトコンストラクタをエクスポートするので、以下のように書けた。

.. code-block:: python

   >>> planet = hello.World()

デフォルトでないコンストラクタを使ってクラスをラップしたい場合もあるだろう。前回の例をビルドする。 ::

   struct World
   {
       World(std::string msg): msg(msg) {} // コンストラクタを追加した
       void set(std::string msg) { this->msg = msg; }
       std::string greet() { return msg; }
       std::string msg;
   }

これで :cpp:class:`!World` にデフォルトコンストラクタはなくなった。前回のラップコードは、ライブラリをエクスポートするところでコンパイルに失敗するだろう。代わりにエクスポートしたいコンストラクタについて :cpp:class:`!class_<World>` に通知しなければならない。 ::

   #include <boost/python.hpp>
   using namespace boost::python;

   BOOST_PYTHON_MODULE(hello)
   {
       class_<World>("World", init<std::string>())
           .def("greet", &World::greet)
           .def("set", &World::set)
       ;
   }

:cpp:func:`!init<std::string>()` が、:cpp:type:`!std::string` を引数にとるコンストラクタをエクスポートする（Python ではコンストラクタを「\ :code:`"__init__"`\」と書く）。

:cpp:func:`!def()` メンバ関数に :cpp:class:`!init\<...>` を渡すことでエクスポートするコンストラクタを追加できる。例えば :cpp:class:`!World` に :cpp:type:`!double` を 2 つとる別のコンストラクタがあるとすれば、 ::

   class_<World>("World", init<std::string>())
       .def(init<double, double>())
       .def("greet", &World::greet)
       .def("set", &World::set)
   ;

逆にコンストラクタを 1 つもエクスポートしたくない場合は、代わりに :cpp:var:`!no_init` を使う。 ::

   class_<Abstract>("Abstract", no_init)

これは実際には、常に Python の :py:exc:`RuntimeError` 例外を投げる :py:func:`__init__` メソッドを追加する。


.. _tutorial.exposing.class_data_members:

クラスデータメンバ
^^^^^^^^^^^^^^^^^^

データメンバもまた Python へエクスポートでき、対応する Python クラスの属性としてアクセス可能になる。各データメンバは\ **読み取り専用**\か\ **読み書き可能**\として見なすことができる。以下の :cpp:class:`!Var` クラスを考えよう。 ::

   struct Var
   {
       Var(std::string name) : name(name), value() {}
       std::string const name;
       float value;
   };

C++ クラス :cpp:class:`!Var` とそのデータメンバは次のようにして Python へエクスポートできる。 ::

   class_<Var>("Var", init<std::string>())
       .def_readonly("name", &Var::name)
       .def_readwrite("value", &Var::value);

これで Python 側で :py:mod:`!hello` 名前空間内に :cpp:class:`!Var` クラスがあるように扱うことができる。

.. code-block:: python

   >>> x = hello.Var('pi')
   >>> x.value = 3.14
   >>> print x.name, 'is around', x.value
   pi is around 3.14

:cpp:var:`!name` を\ **読み取り専用**\としてエクスポートしたいっぽうで、:cpp:var:`!value` は\ **読み書き可能**\としてエクスポートしたことに注意していただきたい。

.. code-block:: python

   >>> x.name = 'e' # name は変更できない
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   AttributeError: can't set attribute


.. _tutorial.exposing.class_properties:

クラスプロパティ
^^^^^^^^^^^^^^^^

C++ では、公開データメンバを持つクラスは受け入れられない。カプセル化を利用して適切に設計されたクラスは、クラスのデータメンバを隠蔽しているものである。クラスのデータにアクセスする唯一の方法はアクセス関数（getter および setter）を介したものである。アクセス関数はクラスのプロパティをエクスポートする。以下がその例である。 ::

   struct Num
   {
       Num();
       float get() const;
       void set(float value);
       ...
   };

しかしながら Python における属性アクセスは優れたものである。ユーザが属性を直接処理しても、必ずしもカプセル化が破壊されるわけではない。属性はメソッド呼び出しの別の構文だからである。:cpp:class:`!Num` クラスを Boost.Python を使ってラップすると次のようになる。 ::

   class_<Num>("Num")
       .add_property("rovalue", &Num::get)
       .add_property("value", &Num::get, &Num::set);

これで Python 側は以下のようになる。

.. code-block:: python

   >>> x = Num()
   >>> x.value = 3.14<
   >>> x.value, x.rovalue
   (3.14, 3.14)
   >>> x.rovalue = 2.17 # エラー！

以下のように :py:attr:`rovalue` の setter メンバ関数を渡していないため、クラスのプロパティ :py:attr:`rovalue` は読み取り専用としてエクスポートされることに注意していただきたい。 ::

   .add_property("rovalue", &Num::get)


.. _tutorial.exposing.inheritance:

継承
^^^^

これまでの例では多態的でないクラスを扱ってきたが、通常、そうしたことはあまりない。多くの場合、多態的なクラスや継承が絡んだクラス階層をラップすることになるだろう。仮想基底クラスから派生したクラスについて Boost.Python ラッパを書かなければならなくなるだろう。

次のような簡単な継承構造を考えよう。 ::

   struct Base { virtual ~Base(); };
   struct Derived : Base {};

:cpp:class:`!Base` と :cpp:class:`!Derived` インスタンスを処理する C++ 関数群もあるとする。 ::

   void b(Base*);
   void d(Derived*);
   Base* factory() { return new Derived; }

基底クラス :cpp:class:`!Base` をラップする方法は以前見た。 ::

   class_<Base>("Base")
       /*...*/
       ;

:cpp:class:`!Derived` とその基底クラスである :cpp:class:`!Base` の関係について Boost.Python に伝える。 ::

   class_<Derived, bases<Base> >("Derived")
       /*...*/
       ;

これで自動的に以下の効果が得られる：

#. :cpp:class:`!Derived` は :cpp:class:`!Base` のすべての Python メソッド（ラップされた C++ メンバ関数）を自動的に継承する。
#. :cpp:class:`!Base` が多態的\ **ならば**\、:cpp:class:`!Base` へのポインタか参照で Python へ渡した :cpp:class:`!Derived` オブジェクトは、:cpp:class:`!Derived` へのポインタか参照が期待されているところに渡すことができる。

次に C++ 自由関数 :cpp:func:`!b` 、:cpp:func:`!d` および :cpp:func:`!factory` をエクスポートする。 ::

   def("b", b);
   def("d", d);
   def("factory", factory);

自由関数 :cpp:func:`!factory` が、:cpp:class:`!Derived` クラスの新しいインスタンスを生成するために使われることに注意していただきたい。このような場合は :cpp:class:`!return_value_policy<manage_new_object>` を使って、:cpp:class:`!Base` へのポインタを受け入れ、Python のオブジェクトが破壊されるまでインスタンスを新しい Python の :cpp:class:`!Base` オブジェクトに保持しておくことを Python に伝える。Boost.Python の\ :ref:`呼び出しポリシー <tutorial.functions.call_policies>`\については後で詳しく述べる。 ::

   // factory の結果について所有権を取るよう Python に伝える
   def("factory", factory,
       return_value_policy<manage_new_object>());


.. _tutorial.exposing.class_virtual_functions:

仮想関数
^^^^^^^^

本節では仮想関数を使って関数に多態的な振る舞いをさせる方法について学ぶ。前の例に引き続き、:cpp:class:`!Base` クラスに仮想関数を 1 つ追加しよう。 ::

   struct Base
   {
       virtual ~Base() {}
       virtual int f() = 0;
   };

Boost.Python の目標の 1 つが、既存の C++ の設計に対して侵入を最小限にすることである。原則的にはサードパーティ製ライブラリに対して、インターフェイス部分を変更することなくエクスポート可能であるべきである。:cpp:class:`!Base` クラスに何かを追加するのは望ましいことではない。しかし Python 側でオーバーライドし **C++ から**\多態的に呼び出す関数の場合、正しく動作させるのに足場が必要になる。Python のオーバーライドが呼び出されるように仮想関数に非侵入的にフックする、:cpp:class:`!Base` から派生したラッパクラスを書くことである。 ::

   struct BaseWrap : Base, wrapper<Base>
   {
       int f()
       {
           return this->get_override("f")();
       }
   };

:cpp:class:`!Base` の継承に加え、:cpp:class:`!wrapper<Base>` を多重継承していることに注意していただきたい（:ref:`ラッパ <v2.wrapper.wrapper-spec>`\の節を見よ）。:cpp:class:`!wrapper` テンプレートはラップするクラスを Python 側でオーバーライドできるようにする段取りを容易にする。

.. caution::

   .. rubric:: msvc6/7 におけるバグの回避方法

   Microsoft Visual C++ のバージョン 6 か 7 を使っている場合、:cpp:func:`f` は次のように書かなければならない。 ::

      return call<int>(this->get_override("f").ptr());

:cpp:class:`!BaseWrap` のオーバーライドされた仮想メンバ関数 :cpp:func:`f` は、実際には :cpp:func:`get_override` を介して Python オブジェクトの相当するメソッドを呼び出す。

最後に :cpp:class:`!Base` をエクスポートする。 ::

   class_<BaseWrap, boost::noncopyable>("Base")
       .def("f", pure_virtual(&Base::f))
       ;

:cpp:func:`!pure_virtual` は、関数 :cpp:func:`f` が純粋仮想関数であることを Boost.Python に伝える。

.. note::

   .. rubric:: メンバ関数とメソッド

   Python をはじめ、多くのオブジェクト指向言語では\ **メソッド（methods）**\という用語を使う。メソッドは大雑把に言えば C++ の\ **メンバ関数（member functions）**\に相当する。


.. _tutorial.exposing.virtual_functions_with_default_implementations:

既定の実装をもった仮想関数
^^^^^^^^^^^^^^^^^^^^^^^^^^

前節で Boost.Python の\ :ref:`クラスラッパ <v2.wrapper.wrapper-spec>`\機能を用いて純粋仮想関数を持ったクラスをラップする方法を見てきた。\ **非**\純粋仮想関数をラップする場合、方法は少し異なる。

:ref:`前節 <tutorial.exposing.class_virtual_functions>`\を思い出そう。C++ で実装するか Python で派生クラスを作成する、純粋仮想関数を持ったクラスをラップした。基底クラスは次のように純粋仮想関数 :cpp:func:`f` を持っていた。 ::

   struct Base
   {
       virtual int f() = 0;
   };

しかしながら、仮にメンバ関数 :cpp:func:`f` が純粋仮想関数として宣言されていなかったら、 ::

   struct Base
   {
       virtual ~Base() {}
       virtual int f() { return 0; }
   };

以下のようにラップする。 ::

   struct BaseWrap : Base, wrapper<Base>
   {
       int f()
       {
           if (override f = this->get_override("f"))
               return f(); // ＊注意＊
           return Base::f();
       }

       int default_f() { return this->Base::f(); }
   };

:cpp:func:`BaseWrap::f` の実装方法に注意していただきたい。この場合、:cpp:func:`f` のオーバーライドが存在するかチェックしなければならない。存在しなければ :cpp:func:`Base::f()` を呼び出すとよい。

.. caution::
   .. rubric:: MSVC6/7 におけるバグの回避方法

   Microsoft Visual C++ のバージョン 6 か 7 を使っている場合、＊注意＊と書いた行を次のように変更しなければならない。 ::

      return call<char const*>(f.ptr());

最後にエスクポートを行う。 ::

   class_<BaseWrap, boost::noncopyable>("Base")
       .def("f", &Base::f, &BaseWrap::default_f)
       ;

:cpp:func:`!&Base::f` と :cpp:func:`!&BaseWrap::default_f` の両方をスクスポートしていることに注意していただきたい。Boost.Python は（1）転送（dispatch）関数fと（2）既定の実装への転送（forwarding）関数 :cpp:func:`!default_f` の追跡を維持しなければならない。この目的のための特別な :cpp:func:`def` 関数が用意されている。

Python 側では結果的に次のようになる。

.. code-block:: python

   >>> base = Base()
   >>> class Derived(Base):
   ...     def f(self):
   ...         return 42
   ...
   >>> derived = Derived()

:cpp:func:`!base.f()` を呼び出すと次のようになる。

.. code-block:: python

   >>> base.f()
   0

:cpp:func:`!derived.f()` を呼び出すと次のようになる。

.. code-block:: python

   >>> derived.f()
   42


.. _tutorial.exposing.class_operators_special_functions:

演算子・特殊関数
^^^^^^^^^^^^^^^^

.. _tutorial.exposing.class_operators_special_functions.python_operators:

Python の演算子
~~~~~~~~~~~~~~~

C は演算子が豊富なことでよく知られている。C++ はこれを演算子の多重定義を認めることにより極限まで拡張した。Boost.Python はこれを利用して、演算子を多用した C++ クラスのラップを容易にする。

ファイルの位置を表すクラス :cpp:class:`!FilePos` と、:cpp:class:`!FilePos` インスタンスをとる演算子群を考える。 ::

   class FilePos { /*...*/ };

   FilePos     operator+(FilePos, int);
   FilePos     operator+(int, FilePos);
   int         operator-(FilePos, FilePos);
   FilePos     operator-(FilePos, int);
   FilePos&    operator+=(FilePos&, int);
   FilePos&    operator-=(FilePos&, int);
   bool        operator<(FilePos, FilePos);

これらのクラスと演算子群は幾分簡単かつ直感的に Python へエクスポートできる。 ::

   class_<FilePos>("FilePos")
       .def(self + int())          // __add__
       .def(int() + self)          // __radd__
       .def(self - self)           // __sub__
       .def(self - int())          // __sub__
       .def(self += int())         // __iadd__
       .def(self -= other<int>())
       .def(self < self);          // __lt__

上記のコード片は非常に明確であり、ほとんど説明不要である。演算子のシグニチャと実質同じである。<constant>self</constant> が :cpp:class:`!FilePos` オブジェクトを表すということにのみ注意していただきたい。また、演算子式に現れるクラス :cpp:type:`!T` がすべて（容易に）デフォルトコンストラクト可能であるとは限らない。「self 式」を書くときに実際の :cpp:type:`!T` インスタンスの代わりに :cpp:expr:`other<T>()` が使える。


.. _tutorial.exposing.class_operators_special_functions.special_methods:

特殊メソッド
~~~~~~~~~~~~

Python には他にいくつか\ **特殊メソッド**\がある。Boost.Python は、実際の Python クラスインスタンスがサポートする標準的な特殊メソッド名をすべてサポートする。直感的なインターフェイス群で、これらの Python **特殊関数**\に相当する C++ 関数をラップできる。以下に例を示す。 ::

   class Rational
   { public: operator double() const; };

   Rational pow(Rational, Rational);
   Rational abs(Rational);
   ostream& operator<<(ostream&,Rational);

   class_<Rational>("Rational")
       .def(float_(self))                  // __float__
       .def(pow(self, other<Rational>))    // __pow__
       .def(abs(self))                     // __abs__
       .def(str(self))                     // __str__
       ;

他に言うことは？

.. note::
   :cpp:func:`operator<<` の役割は？ メソッド :py:meth:`str` が動作するために :cpp:func:`operator<<` が必要なのだ（:cpp:func:`operator<<` は :cpp:expr:`def(str(self))` が定義するメソッドが使用する）。


.. _tutorial.functions:

関数
----

本章では、Boost.Python の強力な関数について詳細を見る。懸垂ポインタや懸垂参照のような潜在的な落とし穴を避けつつ、C++ 関数を Python へエクスポートするための機能について見ていく。また、多重定義や既定の引数といった C++ 機能を利用した C++ 関数のエクスポートを容易にする機能についても見ていく。

先を続けよう。

しかしその前に Python 2.2 以降を立ち上げて :code:`>>> import this` とタイプしたくなるかもしれない。

.. code-block:: python

   >>> import this
   The Zen of Python, by Tim Peters
   Beautiful is better than ugly.
   Explicit is better than implicit.
   Simple is better than complex.
   Complex is better than complicated.
   Flat is better than nested.
   Sparse is better than dense.
   Readability counts.
   Special cases aren't special enough to break the rules.
   Although practicality beats purity.
   Errors should never pass silently.
   Unless explicitly silenced.
   In the face of ambiguity, refuse the temptation to guess.
   There should be one-- and preferably only one --obvious way to do it.
   Although that way may not be obvious at first unless you're Dutch.
   Now is better than never.
   Although never is often better than *right* now.
   If the implementation is hard to explain, it's a bad idea.
   If the implementation is easy to explain, it may be a good idea.
   Namespaces are one honking great idea -- let's do more of those!


.. _tutorial.functions.call_policies:

呼び出しポリシー
^^^^^^^^^^^^^^^^

C++ では引数や戻り値の型としてポインタや参照を扱うことがよくある。これら単純型は非常に低水準であり表現力に乏しい。少なくとも、ポインタや参照先のオブジェクトの所有権がどこにあるか知る方法はない。もっとも、Java や Python といった言語ではそのような低水準な実体を扱うことはない。C++ では、所有権のセマンティクスを正確に記述するスマートポインタの使用をよい慣習であると考えることが多い。それでも生の参照やポインタを使う C++ インターフェイスがよいとされる場合もあり、Boost.Python がそれらに対処できなければならない。このためには、あなたの助けが必要である。次のような C++ 関数を考える。 ::

   X& f(Y& y, Z* z);

ライブラリはこの関数をどのようにラップすべきだろうか？ 単純なアプローチとしては、返される参照について Python の :cpp:type:`!X` オブジェクトを構築することである。この解法は動作する場合もあるが、動作しないこともある。以下が後者の例である。

.. code-block:: python

   >>> x = f(y, z) # x は C++ の X を参照する
   >>> del y
   >>> x.some_method() # クラッシュ！

何が起きたのか？

実は :cpp:func:`!f()` が次のように実装されていたのだった。 ::

   X& f(Y& y, Z* z)
   {
       y.z = z;
       return y.x;
   }

問題は、:cpp:func:`!f()` がオブジェクト :cpp:var:`!y` のメンバへの参照を返すため、結果の :cpp:type:`!X&` の寿命が :cpp:var:`!y` の寿命に縛られることである。このイディオムは珍しいものではなく、C++ の文脈では完全に受け入れられるものである。しかしながら Python のユーザとしてはこの C++ インターフェイスを使用するだけでシステムをクラッシュさせるわけにはいかない。今回の場合、:cpp:var:`!y` を削除した段階で :cpp:type:`!X` への参照が無効となり、懸垂参照が残るのである。

以下のようなことが起こっている。

#. :cpp:var:`!y` への参照と :cpp:var:`!z` へのポインタを渡して :cpp:func:`!f` が呼び出される
#. :cpp:expr:`y.x` への参照が返される
#. :cpp:var:`!y` が削除される。:cpp:var:`!x` は懸垂参照となる
#. :cpp:expr:`x.some_method()` が呼び出される
#. **バン！**

結果を新しいオブジェクトにコピーしてみる。

.. code-block:: python

   >>> f(y, z).set(42) # 結果を消失
   >>> y.x.get()       # クラッシュしないが、改善の余地がある
   3.14

これは今回の C++ インターフェイスで本当に実現したかったことではない。Python インターフェイスが可能な限り綿密に C++ インターフェイスを反映すべきであるという約束を破っている。

問題はこれで終わりではない。:cpp:class:`!Y` の実装が次のようになっているとしたら、 ::

   struct Y
   {
       X x; Z* z;
       int z_value() { return z->value(); }
   };

データメンバ :cpp:member:`!z` がクラス :cpp:class:`!Y` に生のポインタで保持されていることに注意していただきたい。潜在的な懸垂ポインタの問題が :cpp:class:`!Y` の内部で発生している。

.. code-block:: python

   >>> x = f(y, z) # y は z を参照する
   >>> del z       # オブジェクト z を削除
   >>> y.z_value() # クラッシュ！

参考のために :cpp:func:`!f` の実装を再掲する。 ::

   X& f(Y& y, Z* z)
   {
       y.z = z;
       return y.x;
   }

以下のようなことが起こっている。

#. :cpp:var:`!y` への参照と :cpp:var:`!z` へのポインタを渡して :cpp:func:`!f` が呼び出される
#. :cpp:var:`!y` が :cpp:var:`!z` へのポインタを保持する
#. :cpp:expr:`y.x` への参照が返される
#. :cpp:var:`!z` が削除される。:cpp:expr:`y.z` は懸垂ポインタとなる
#. :cpp:expr:`y.z_value()` が呼び出される
#. :cpp:expr:`z->value()` が呼び出される
#. **バン！**


.. _tutorial.functions.call_policies.call_policies:

呼び出しポリシー
~~~~~~~~~~~~~~~~

上で扱った例のような状況では、呼び出しポリシーが使える。今回の例では :cpp:class:`!return_internal_reference` と :cpp:class:`!with_custodian_and_ward` が助けになる。 ::

   def("f", f,
       return_internal_reference<1,
           with_custodian_and_ward<1, 2> >());

引数の ``1`` とか ``2`` って何だい？ ::

   return_internal_reference<1

これは「1 番目の引数（:cpp:expr:`Y& y`）が、返される参照（:cpp:type:`!X&`）の所有者である」と Boost.Python に伝えている。「1」は単に 1 番目の引数という意味である。まとめると「第 1 引数 :cpp:expr:`Y& y` が所有する内部参照 :cpp:type:`!X&` を返す」となる。 ::

   with_custodian_and_ward<1, 2>

これは「ward（被後見人）で指定した引数（第 2 引数。:cpp:expr:`Z* z`）の寿命が、custodian（後見人）で指定した引数（第 1 引数。:cpp:expr:`Y& y`）の寿命に依存する」と Boost.Python に伝えている。

上で 2 つのポリシーを定義していることに注意していただきたい。2 つ以上のポリシーは数珠繋ぎに結合できる。汎用的な構文は以下のようになる。 ::

   policy1<args...,
       policy2<args...,
           policy3<args...> > >

定義済みの呼び出しポリシーを以下のリストに挙げる。完全なリファレンスは\ :ref:`ここ <function_invocation_and_creation.models_of_callpolicies>`\にある。

:cpp:class:`!with_custodian_and_ward`
   引数の寿命を他の引数で縛る
:cpp:class:`!with_custodian_and_ward_postcall`
   引数の寿命を他の引数や返り値で縛る
:cpp:class:`!return_internal_reference`
   1 つの引数の寿命を返り値の寿命で縛る
:cpp:class:`!return_value_policy<T>`\（:cpp:type:`!T` は以下のいずれか）
   :cpp:class:`!reference_existing_object`
      単純（で危険）なアプローチ
   :cpp:class:`!copy_const_reference`
      Boost.Python v1 のアプローチ
   :cpp:class:`!copy_non_const_reference`
      …
   :cpp:class:`!manage_new_object`
      ポインタを受け取りインスタンスを保持する

禅（Zen）を思い出そう、Luke [#]_\：

「ごちゃごちゃ難しいのより、白黒はっきりしてるのがいい」

「あいまいなことをてきとーに処理しちゃいけません」


.. _tutorial.functions.overloading:

多重定義
^^^^^^^^

多重定義したメンバ関数を手動でラップする方法を以下に示す。非メンバ関数の多重定義をラップする場合も、当然同様のテクニックが使える。

次のような C++ クラスを考える。 ::

   struct X
   {
       bool f(int a)
       {
           return true;
       }

       bool f(int a, double b)
       {
           return true;
       }

       bool f(int a, double b, char c)
       {
           return true;
       }

       int f(int a, int b, int c)
       {
           return a + b + c;
       };
   };

クラス :cpp:class:`!X` に多重定義された関数が 4 つある。まずメンバ関数ポインタ変数を導入するところから始める。 ::

   bool    (X::*fx1)(int)              = &X::f;
   bool    (X::*fx2)(int, double)      = &X::f;
   bool    (X::*fx3)(int, double, char)= &X::f;
   int     (X::*fx4)(int, int, int)    = &X::f;

これがあれば、続けて Python のために定義とラップができる。 ::

   .def("f", fx1)
   .def("f", fx2)
   .def("f", fx3)
   .def("f", fx4)


.. _tutorial.functions.default_arguments:

既定の引数
^^^^^^^^^^

Boost.Python は（メンバ）関数ポインタをラップするが、残念ながら C++ 関数ポインタは既定の引数について情報を持たない。既定の引数を持った関数 :cpp:func:`!f` を考える。 ::

   int f(int, double = 3.14, char const* = "hello");

しかし関数 :cpp:func:`!f` へのポインタ型は、その既定の引数について情報を持たない。 ::

   int(*g)(int,double,char const*) = f;    // 既定の引数が失われる！

この関数ポインタを :cpp:func:`!def` 関数へ渡すとしても、既定の引数を取得する方法はない。 ::

   def("f", f);                            // 既定の引数が失われる！

このため C++ ラップコードを書くときは、:ref:`前節 <tutorial.functions.overloading>`\で示したような手動のラップか薄いラッパを書くことに頼るしかない。 ::

   // 「薄いラッパ」を書く
   int f1(int x) { return f(x); }
   int f2(int x, double y) { return f(x,y); }

   /*...*/

       // init モジュール内
       def("f", f);  // 3 引数バージョン
       def("f", f2); // 2 引数バージョン	
       def("f", f1); // 1 引数バージョン

以下のいずれかの関数（、メンバ関数）をラップするときは、次節に進むとよい。

* 既定の引数を持つ
* 引数の先頭部分に共通列を持つ形で多重定義されている


.. _tutorial.functions.default_arguments.boost_python_function_overloads:

BOOST_PYTHON_FUNCTION_OVERLOADS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Boost.Python はこれを容易にする方法を提供する。例えば次の関数が与えられたとする。 ::

   int foo(int a, char b = 1, unsigned c = 2, double d = 3)
   {
       /*...*/
   }

次のマクロ呼び出しにより、薄いラッパが作成される。 ::

   BOOST_PYTHON_FUNCTION_OVERLOADS(foo_overloads, foo, 1, 4)

このマクロは、:cpp:expr:`def(...)` に渡すことができる :cpp:class:`!foo_overloads` クラスを作成する。このマクロの 3 番目と 4 番目の引数は、それぞれ引数の最小数と最大数である。:cpp:func:`!foo` 関数では引数の最小数は 1 、最大数は 4 である。:cpp:expr:`def(...)` 関数は :cpp:func:`!foo` のファミリをすべて自動的に追加する。 ::

   def("foo", foo, foo_overloads());


.. _tutorial.functions.default_arguments.boost_python_member_function_overloads:

BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

オブジェクトはここにも、そこにも、あそこにも、どこにでもある。Python にエクスポートするのは、クラスのメンバ関数が最も頻度が高い。ここでまた、以前の既定の引数や引数の先頭部分が共通列である多重定義の場合の不便が出てくる。これを容易にするマクロが提供されている。

:c:macro:`BOOST_PYTHON_FUNCTION_OVERLOADS` と同様、メンバ関数をラップする薄いラッパを自動的に作成するのに :c:macro:`BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS` を使用する。例を挙げる。 ::

   struct george
   {
       void
       wack_em(int a, int b = 0, char c = 'x')
       {
           /*...*/
       }
   };

ここで次のようにマクロを呼び出すと、 ::

   BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS(george_overloads, wack_em, 1, 3)

:cpp:class:`!george` の :cpp:func:`wack_em` メンバ関数について最少で 1 、最多で 3（マクロの 3 番目と 4 番目の引数）の薄いラッパ群を生成する。薄いラッパはすべて :cpp:class:`!george_overloads` という名前のクラスに収められ、:cpp:expr:`def(...)` に引数として渡すことができる。 ::

   .def("wack_em", &george::wack_em, george_overloads());

詳細は\ :ref:`多重定義のリファレンス <v2.overloads.macros>`\を見よ。


.. _tutorial.functions.default_arguments.init_and_optional:

init と optional
~~~~~~~~~~~~~~~~

クラスのコンストラクタ、特に既定の引数と多重定義については類似の機能が提供されている。:cpp:class:`!init<...>` を覚えているだろうか？ 例えばクラス :cpp:class:`!X` とそのコンストラクタがあるとすると、 ::

   struct X
   {
       X(int a, char b = 'D', std::string c = "constructor", double d = 0.0);
       /*...*/
   }

このコンストラクタを一発で Boost.Python に追加するには、 ::

   .def(init<int, optional<char, std::string, double> >())

:cpp:class:`!init<...>` と :cpp:class:`!optional<...>` の使うことで、既定（省略可能な引数）であることを表現している点に注意していただきたい。


.. _tutorial.functions.auto_overloading:

自動多重定義
^^^^^^^^^^^^

前節で :c:macro:`BOOST_PYTHON_FUNCTION_OVERLOADS` および :c:macro:`BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS` が、引数列の先頭部分が共通である多重定義関数およびメンバ関数に対しても使用できることを見た。以下に例を示す。 ::

   void foo()
   {
      /*...*/
   }

   void foo(bool a)
   {
      /*...*/
   }

   void foo(bool a, int b)
   {
      /*...*/
   }

   void foo(bool a, int b, char c)
   {
      /*...*/
   }

前節と同様、これらの多重定義された関数について薄いラッパを一発で生成できる。 ::

   BOOST_PYTHON_FUNCTION_OVERLOADS(foo_overloads, foo, 0, 3)

その結果、次のように書ける。 ::

   .def("foo", (void(*)(bool, int, char))0, foo_overloads());

この例では引数の個数は最少で 0 、最多で 3 となっていることに注意していただきたい。


.. _tutorial.functions.auto_overloading.manual_wrapping:

手動のラッピング
~~~~~~~~~~~~~~~~

**多重定義した関数は引数列の先頭に共通部分を持っていなければならない**\ということを強調しておく。それ以外の場合、上で述べた方法は動作せず、関数を\ :ref:`手動で <tutorial.functions.overloading>`\ラップしなければならない。

実際には多重定義関数の手動ラッピングと、:c:macro:`BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS` とその姉妹版である :c:macro:`BOOST_PYTHON_FUNCTION_OVERLOADS` による自動的なラッピングを混用することは可能である。:ref:`多重定義 <tutorial.functions.overloading>`\の節で見た例だと 4 つの多重定義関数は引数の先頭列が共通であるので、:c:macro:`BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS` を使って最初の 3 つの :cpp:func:`!def` を自動的にラップでき、残り 1 つだけを手動でラップすることになる。以下のようにする。 ::

   BOOST_PYTHON_MEMBER_FUNCTION_OVERLOADS(xf_overloads, f, 1, 4)

両方の :cpp:func:`X::f` 多重定義について、以前と同様にメンバ関数ポインタを作成すると、 ::

   bool    (X::*fx1)(int, double, char)    = &X::f;
   int     (X::*fx2)(int, int, int)        = &X::f;

結果、以下のように書ける。 ::

   .def("f", fx1, xf_overloads());
   .def("f", fx2)


.. _tutorial.object:

オブジェクトのインターフェイス
------------------------------

C++ が静的型付けであるのに対し、Python は動的型付けである。Python の変数は整数、浮動小数点数、リスト、辞書、タプル、文字列、長整数、その他を保持できる。Boost.Python と C++ の視点では、これら Python 的な変数は :cpp:class:`!object` クラスのインスタンスにすぎない。本章で Python のオブジェクトをどのように扱うか見ていく。

以前述べたように Boost.Python の目的の 1 つは、C++ と Python 間における Python 的な感覚の双方向マッピングの提供である。Boost.Python における C++ の :cpp:class:`!object` は可能な限り Python に類似したものとなっている。これにより学習曲線は著しく最小化されるはずである。


.. _tutorial.object.basic_interface:

基本的なインターフェイス
^^^^^^^^^^^^^^^^^^^^^^^^

:cpp:class:`!object` クラスは :cpp:type:`!PyObject*` をラップする。参照カウントの管理といった :cpp:type:`!PyObject` の複雑な取り扱いは、すべて :cpp:class:`!object` クラスが処理する。C++ オブジェクトの相互運用性はシームレスなものである。実際のところ、Boost.Python における C++ の :cpp:class:`!object` はあらゆる C++ オブジェクトから明示的に構築できる。

説明のために、以下のような Python コード片を考える。

.. code-block:: python

   def f(x, y):
        if (y == 'foo'):
            x[3:7] = 'bar'
        else:
            x.items += y(3, x)
        return x

   def getfunc():
      return f

Boost.Python の機能を用いて C++ で書き直すと次のようになる。 ::

   object f(object x, object y) {
        if (y == "foo")
            x.slice(3,7) = "bar";
        else
            x.attr("items") += y(3, x);
        return x;
   }
   object getfunc() {
       return object(f);
   }

C++ でコードを書いているという外観的な差を除けば、そのルックアンドフィールは Python のプログラマにも明確である。


.. _tutorial.object.derived_object_types:

object の派生型
^^^^^^^^^^^^^^^

Boost.Python には、Python の各型に対応する :cpp:class:`!object` の派生型がある。

* :cpp:class:`!list`
* :cpp:class:`!dict`
* :cpp:class:`!tuple`
* :cpp:class:`!str`
* :cpp:class:`!long_`
* :cpp:class:`!enum_`

.. 原文は 'enum' になってる

これらの :cpp:class:`!object` の派生型は実際の Python 型と同様に振舞う。例を挙げる。

.. code-block:: python

   str(1) ==> "1"

個々の派生 :cpp:class:`!object` は対応する Python 型のメソッドを持つ。例えば :cpp:class:`!dict` は :cpp:func:`keys()` メソッドを持つ。

.. code-block:: python

   d.keys()

**タプルリテラル**\を宣言するのに :cpp:func:`!make_tuple` が提供されている。例を挙げる。 ::

   make_tuple(123, 'D', "Hello, World", 0.0);

C++ において、Boost.Python の :cpp:class:`!object` を関数の引数に渡す場合は派生型の一致が要求される。例えば以下に示す関数 :cpp:func:`!f` をラップする場合、Python の :cpp:class:`!str` 型とその派生型のみを受け付ける。 ::

   void f(str name)
   {
       object n2 = name.attr("upper")();   // NAME = name.upper()
       str NAME = name.upper();            // のほうがよい
       object msg = "%s is bigger than %s" % make_tuple(NAME,name);
   }

細かく見ると、 ::

   str NAME = name.upper();

このコードから分かるように、:cpp:class:`!str` 型のメソッドを C++ メンバ関数として提供している。次に、 ::

   object msg = "%s is bigger than %s" % make_tuple(NAME,name);

上記のコードのように Python の :code:`"format" % x,y,z` を C++ で書ける。標準の C++ で同じことを簡単に行う方法がないため便利である。

.. caution::
   Python 同様、Python の可変型の多くがコンストラクタでコピーを行うというよく知られた落とし穴があるので注意が必要である。

   Python の場合：

   .. code-block:: python

      >>> d = dict(x.__dict__)     # x.__dict__ をコピーする
      >>> d['whatever'] = 3        # コピーを変更する

   C++ の場合： ::

      dict d(x.attr("__dict__"));  // x.__dict__ をコピーする
      d["whatever"] = 3;           // コピーを変更する


.. _tutorial.object.derived_object_types.class_t_as_objects:

object としての class_<T>
~~~~~~~~~~~~~~~~~~~~~~~~~~

Boost.Python における :cpp:class:`!object` の動的な性質に従えば、あらゆる :cpp:class:`!class_<T>` もまたこれら型の 1 つである！ 以下のコード片はクラス（型）オブジェクトをラップする。

これを使って、ラップされたインスタンスを作成できる。 ::

   object vec345 = (
       class_<Vec2>("Vec2", init<double, double>())
           .def_readonly("length", &Point::length)
           .def_readonly("angle", &Point::angle)
       )(3.0, 4.0);

   assert(vec345.attr("length") == 5.0);


.. _tutorial.object.extracting_c___objects:

C++ オブジェクトの抽出
^^^^^^^^^^^^^^^^^^^^^^

:cpp:class:`!object` インスタンスを使用せずに C++ の値が必要になることがある。これは :cpp:func:`!extract<T>` 関数で実現できる。以下を考える。 ::

   double x = o.attr("length"); // コンパイルエラー

Boost.Python の :cpp:class:`!object` は :cpp:type:`!double` へ暗黙に変換できないため、上記のコードはコンパイルエラーとなる。代わりに以下のように書けば希望どおりとなる。 ::

   double l = extract<double>(o.attr("length"));
   Vec2& v = extract<Vec2&>(o);
   assert(l == v.length());

1 行目は Boost.Python の :py:class:`!object` の :py:attr:`~object.length` 属性を抽出しようとしている。2 行目は Boost.Python の :cpp:class:`!object` が保持している :cpp:type:`!Vec2` オブジェクトを抽出しようとしている。

「～しようとしている」と書いたことに注意していただきたい。Boost.Python の :cpp:class:`!object` が実際には :cpp:type:`!Vec2` 型を保持していなかったらどうなるだろうか？ これは Python の :py:class:`!object` がもつ動的な性質を考えれば十分ありうることである。安全のため、希望する C++ 型を抽出できない場合は適当な例外が投げられる。例外を避けるには抽出できるかテストする必要がある。 ::

   extract<Vec2&> x(o);
   if (x.check()) {
       Vec2& v = x(); ...

明敏な読者は :cpp:func:`!extract<T>` の機能が変更可能コピーの問題を解決することに気付いたかもしれない。 ::

   dict d = extract<dict>(x.attr("__dict__"));
   d["whatever"] = 3;          // x.__dict__ を変更する！


.. _tutorial.object.enums:

列挙
^^^^

Boost.Python には、C++ の列挙を捕捉、ラップする気の利いた機能がある。Python に :code:`enum` 型はないが、C++ の列挙を Python へ :py:class:`!int` としてエクスポートしたいことがよくある。Python の動的型付けから C++ の強い静的型付けへの適切な変換に気を付けていれば Boost.Python の列挙機能で容易に可能である（C++ では、整数から列挙へ暗黙に変換することはできない）。次のような C++ の列挙があったとして、 ::

   enum choice { red, blue };

次のようにして Python へエクスポートする。 ::

   enum_<choice>("choice")
       .value("red", red)
       .value("blue", blue)
       ;

新しい列挙は現在の :cpp:func:`~scope::scope()` に作成される。これは大抵の場合現在のモジュールである。上記のコード片は Python の :py:class:`!int` 型から派生した、第 1 引数に渡した C++ 型に対応する Python クラスを作成する。

.. note::
   .. rubric:: scope とは

   :cpp:class:`!scope` は、新しい拡張クラスやラップした関数が属性として定義される Python の名前空間を制御するグローバルな関連 Python オブジェクトを持つクラスである。詳細は\ :ref:`リファレンス <v2.scope.scope-spec>`\を見よ。

Python からはこれらの値に以下のようにしてアクセスできる。

.. code-block:: python

   >>> my_module.choice.red
   my_module.choice.red

ここで :py:mod:`!my_module` は列挙を宣言したモジュールである。新しいスコープをクラスに対して作成することもできる。 ::

   scope in_X = class_<X>("X")
                   .def( ... )
                   .def( ... )
               ;

   // X::nested を X.nested としてエクスポートする
   enum_<X::nested>("nested")
       .value("red", red)
       .value("blue", blue)
       ;


.. _tutorial.object.creating_python_object:

:cpp:type:`!PyObject*` から :cpp:class:`!boost::python::object` を作成する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:cpp:type:`!PyObject*` である :cpp:var:`!pyobj` へのポインタを :cpp:class:`!boost::python::object` で管理したい場合、以下のようにする。 ::

   boost::python::object o(boost::python::handle<>(pyobj));

この場合、オブジェクト :cpp:var:`!o` は :cpp:var:`!pyobj` を管理するが、構築時に参照カウントを増やさない。

あるいは借用（borrowed）参照を使う方法として、 ::

   boost::python::object o(boost::python::handle<>(boost::python::borrowed(pyobj)));

この場合 :c:macro:`!Py_INCREF` が呼び出されるので、オブジェクト :cpp:var:`!o` がスコープ外に出ても :cpp:var:`!pyobj` は破壊されない。


.. _tutorial.embedding:

組み込み
--------

Boost.Python を使って Python から C++ のコードを呼び出す方法について理解できたと思う。しかしときには逆のこと、つまり C++ 側から Python のコードを呼び出す必要が出てくるはずである。これには Python のインタープリタを C++ のプログラムに\ **組み込む**\必要がある。

現時点では Boost.Python は組み込みに必要なことをすべてサポートしているわけではない。したがってこのギャップを埋めるには `Python の C API <http://www.python.org/doc/current/api/api.html>`_ を使う必要が出てくる。とはいえ Boost.Python は組み込みの大部分を容易にしており、将来のバージョンでは Python の C API に触れる必要はなくなるかもしれない。そういうわけだから期待しておいて欲しい。


.. _tutorial.embedding.building_embedded_programs:

組み込みプログラムをビルドする
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Python をプログラムに組み込み可能にするには、Python だけでなく Boost.Python 本体の実行時ライブラリにもリンクしなければならない。

Boost.Python のライブラリは 2 種類ある。いずれも Boost の :file:`/libs/python/build/bin-stage` サブディレクトリにある。Windows ではライブラリの名前は :file:`boost_python.lib`\（リリースビルド用）と :file:`boost_python_debug.lib`\（デバッグ用）である。ライブラリが見つからない場合は、おそらくまだ Boost.Python をビルドしていないのだろう。\ :doc:`building`\を見て方法を確認するとよい。

Python のライブラリは、Python ディレクトリの :file:`/libs` サブディレクトリにある。Windows では pythonXY.lib のような名前で、X.Y が Python のメジャーバージョンの番号である。

また Python の :file:`/include` サブディレクトリをインクルードパスに追加しておかなければならない。

Jamfile に以上のことをすべて要約すると、

.. code-block:: none

   projectroot c:\projects\embedded_program ; # プログラムの場所

   # Python 用の規則
   SEARCH on python.jam = $(BOOST_BUILD_PATH) ;
   include python.jam ;

   exe embedded_program # 実行可能ファイルの名前
     : # ソースファイル
        embedded_program.cpp
     : # 必須条件
        <find-library>boost_python <library-path>c:\boost\libs\python
     $(PYTHON_PROPERTIES)
       <library-path>$(PYTHON_LIB_PATH)
       <find-library>$(PYTHON_EMBEDDED_LIBRARY) ;


.. _tutorial.embedding.getting_started:

はじめに
^^^^^^^^

ビルドできるようになったのはよいが、まだビルドするものがない。Python のインタープリタを C++ のプログラムに組み込むには、以下の 3 段階が必要である。

#. :file:`<boost/python.hpp>` をインクルードする。
#. :cpp:func:`!Py_Initialize <http://docs.python.jp/2/c-api/init.html#Py_Initialize>()` を呼び出してインタープリタを起動、:py:mod:`!__main__` モジュールを作成する。
#. 他の Python C API を呼び出してインタープリタを使用する。

.. note::
   現時点ではインタープリタを停止するのに :cpp:func:`!Py_Finalize <http://docs.python.jp/2/c-api/init.html#Py_Finalize>()` を呼び出してはならない。これは Boost.Python の将来のバージョンで修正する。

（当然ながら、上記の各段階の間に他の C++ コードを挟んでもよい。）

これでプログラムにインタープリタを組み込み可能になった。次に使用方法を見ていく。


.. _tutorial.embedding.using_the_interpreter:

インタープリタを使用する
^^^^^^^^^^^^^^^^^^^^^^^^

すでに知っていることと思うが、Python のオブジェクトは参照カウントで管理されている。当然、Python C API の :cpp:type:`!PyObject` も参照カウンタを持っているが、違いがある。参照カウントは Python では完全に自動で行われているが、Python C API では\ `手動で <http://docs.python.jp/2/c-api/refcounting.html>`_\行う必要がある。これは厄介で、とりわけ C++ 例外が現れるコードで正しく取り扱うのが困難である。幸いにも Boost.Python には :cpp:class:`handle` および :cpp:class:`object` クラステンプレートがあり、この処理を自動化できる。


.. _tutorial.embedding.using_the_interpreter.running_python_code:

Python のコードを起動する
~~~~~~~~~~~~~~~~~~~~~~~~~

Boost.Python は、C++ から Python のコードを起動する関数を 3 つ提供している。 ::

   object eval(str expression, object globals = object(), object locals = object())
   object exec(str code, object globals = object(), object locals = object())
   object exec_file(str filename, object globals = object(), object locals = object())

:cpp:func:`!eval` は与えられた式を評価し結果の値を返す。:cpp:func:`!exec` は与えられたコード（典型的には文の集まり）を実行し結果を返す。:cpp:func:`!exec_file` は与えられたファイル内のコードを実行する。

これらについては第 1 引数が :cpp:class:`!str` ではなく :cpp:type:`!char* const` となっている多重定義もある。

:cpp:var:`!globals` と :cpp:var:`!locals` 引数は、コードを実行するコンテキストの :cpp:var:`!globals` と :cpp:var:`!locals` に相当する Python の辞書である。ほとんどの目的において、:py:mod:`!__main__` モジュールの名前空間辞書を両方の引数に使用するとよい。

Boost.Python はモジュールをインポートする関数を提供する。 ::

   object import(str name)

:cpp:func:`!import` は Python のモジュールをインポートし（潜在的には、はじめに起動しているプロセスに読み込む）、返す。

:py:mod:`!__main__` モジュールをインポートし、その名前空間で Python のコードを走らせてみよう。 ::

   object main_module = import("__main__");
   object main_namespace = main_module.attr("__dict__");

   object ignored = exec("hello = file('hello.txt', 'w')\n"
                         "hello.write('Hello world!')\n"
                         "hello.close()",
                         main_namespace);

このコードは現在のディレクトリに :file:`hello.txt` という名前のファイルを作成し、プログラミングサークルでよく知られたフレーズを書き込む。


.. _tutorial.embedding.using_the_interpreter.manipulating_python_objects:

Python のオブジェクトを操作する
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Python オブジェクトを操作するクラスが欲しくなることがよくある。しかしすでに上記や\ :ref:`前節 <tutorial.object>`\でそのようなクラスを見た。文字通りの名前を持つ :cpp:class:`!object` とその派生型である。またそれらを :cpp:class:`!handle` から構築できることも見た。以下の例を見ればより明らかだろう。 ::

   object main_module = import("__main__");
   object main_namespace = main_module.attr("__dict__");
   object ignored = exec("result = 5 ** 2", main_namespace);
   int five_squared = extract<int>(main_namespace["result"]);

:py:mod:`!__main__` モジュールの名前空間に相当する辞書オブジェクトを作成している。次に 5 の 2 乗を結果の変数に代入し、この変数を辞書から読んでいる。同じ結果を得る他の方法としては代わりに :cpp:func:`!eval` を使用する方法があり、こちらは結果を直接返す。 ::

   object result = eval("5 ** 2");
   int five_squared = extract<int>(result);


.. _tutorial.embedding.using_the_interpreter.exception_handling:

例外処理
~~~~~~~~

Python の式を評価中に例外を送出した場合、:cpp:class:`error_already_set` が投げられる。 ::

   try
   {
       object result = eval("5/0");
       // ここには絶対に来ない：
       int five_divided_by_zero = extract<int>(result);
   }
   catch(error_already_set const &)
   {
       // 何らかの方法で例外を処理する
   }

:cpp:class:`!error_already_set` 例外クラス自体は何の情報も持たない。送出された Python の例外について詳細を調べるには、catch 文内で Python C API の\ `例外処理関数 <http://www.python.org/doc/api/exceptionHandling.html>`_\を使用する必要がある。これは単純に `PyErr_Print() <http://docs.python.jp/2/c-api/exceptions.html>`_ を呼び出して例外のトレースバックをコンソールへプリントするか、あるいは例外の型を\ `標準の例外 <http://docs.python.jp/2/c-api/exceptions.html#standardexceptions>`_\と比較する程度となるだろう。 ::

   catch(error_already_set const &)
   {
       if (PyErr_ExceptionMatches(PyExc_ZeroDivisionError))
       {
           // ZeroDivisionError を特別扱いする
       }
       else
       {
           // 他のすべてのエラーを stderr にプリントする
           PyErr_Print();
       }
   }

（例外についてより多くの情報を取得するには、\ `このリスト <http://docs.python.jp/2/c-api/exceptions.html>`_\にある例外処理関数を使用する。）


.. _tutorial.iterators:

イテレータ
----------

C++ 、特に STL においてイテレータはあらゆる場面で使用されている。Python にもイテレータがあるが、両者には大きな違いがある。

C++ のイテレータ：
   * C++ のイテレータは 5 つに分類される（ランダムアクセス、双方向、単方向、入力、出力）
   * 再配置とアクセスの 2 種類の操作がある
   * 範囲を表すのにイテレータの組（先頭と末尾）が必要
Python のイテレータ：
   * 分類は 1 つしかない（単方向）
   * 操作は 1 種類しかない（:code:`next()`）
   * 終了時に :py:exc:`!StopIteration` 例外を投げる

典型的な Python の走査プロトコルである :code:`for y in x...` は以下のようである。

.. code-block:: python

   iter = x.__iter__()         # イテレータを取得する
   try:
       while 1:
       y = iter.next()         # 各要素を取得する
       ...                     # y を処理する
   except StopIteration: pass  # イテレータが尽きた

Boost.Python は、C++ のイテレータを Python のイテレータとして振舞うようにする機構をいくつか提供している。必要なことは C++ のイテレータから Python の走査プロトコルと互換性のある適切な :py:func:`!__iter__` 関数を用意することである。例えば、 ::

   object get_iterator = iterator<vector<int> >();
   object iter = get_iterator(v);
   object first = iter.next();

あるいは :cpp:class:`!class_<>` で以下のようにする。 ::

   .def("__iter__", iterator<vector<int> >())


range
^^^^^

:cpp:func:`!range` 関数を使用すると、Python の実践的なイテレータを作成できる。

* :code:`range(start, finish)`
* :code:`range<Policies, Target>(start, finish)`

ここで :samp:`{start}` 、:samp:`{finish}` は以下のいずれかである。

* メンバデータポインタ
* メンバ関数ポインタ
* 関数オブジェクト（:cpp:type:`!Target` 引数を使用）


iterator
^^^^^^^^

* :cpp:expr:`iterator<T, Policies>()`

コンテナ :cpp:type:`!T` が与えられた場合、:cpp:class:`!iterator` は単に :cpp:expr:`&T::begin` と :cpp:expr:`&T::end` で :cpp:func:`!range` を呼び出すショートカットとなる。

実際にやってみよう。以下はある仮説の粒子加速器のコードからの例である。

.. code-block:: python

   f = Field()
   for x in f.pions:
       smash(x)
   for y in f.bogons:
       count(y)

C++ のラッパは以下のようになるだろう。 ::

   class_<F>("Field")
       .property("pions", range(&F::p_begin, &F::p_end))
       .property("bogons", range(&F::b_begin, &F::b_end));


stl_input_iterator
^^^^^^^^^^^^^^^^^^

ここまで C++ のイテレータと範囲を Python へエクスポートする方法を見てきた。しかしこれ以外に、Python のシーケンスを STL アルゴリズムに渡したり、STL コンテナを初期化したい場合がある。Python のイテレータを STL のイテレータのように見せかける必要がある。これには :cpp:class:`!stl_input_iterator<>` を使用する。:cpp:func:`std::list<int>::assign()` を Python へエクスポートする関数の実装方法を考えよう。 ::

   template<typename T>
   void list_assign(std::list<T>& l, object o) {
       // Python のシーケンスを STL の入力範囲に変換する
       stl_input_iterator<T> begin(o), end;
       l.assign(begin, end);
   }

   // list<int> のラッパの一部
   class_<std::list<int> >("list_int")
       .def("assign", &list_assign<int>)
       // ...
       ;

これで Python 側であらゆる整数シーケンスを :cpp:var:`!list_int` オブジェクトへ代入できる。 ::

   x = list_int();
   x.assign([1,2,3,4,5])


.. _tutorial.exception:

例外の変換
----------

C++ の例外はすべて Python コードとの境界で捕捉しなければならない。この境界は C++ が Python と接する地点である。Boost.Python は、選択した標準の例外を変換して処理を中止する既定の例外ハンドラを提供する。

.. code-block:: python

   raise RuntimeError, 'unidentifiable C++ Exception'

ユーザがカスタムの変換器を提供してもよい。例えば、\ [#]_ ::

   struct PodBayDoorException;
   void translator(PodBayDoorException const& x) {
       PyErr_SetString(PyExc_UserWarning, "I'm sorry Dave...");
   }
   BOOST_PYTHON_MODULE(kubrick) {
        register_exception_translator<
             PodBayDoorException>(translator);
        ...


.. _tutorial.techniques:

典型的なテクニック
------------------

Boost.Python でコードをラップするのに使えるテクニックをいくつか紹介する。


.. _tutorial.techniques.creating_packages:

パッケージを作成する
^^^^^^^^^^^^^^^^^^^^

Python のパッケージは、ユーザに一定の機能を提供するモジュールの集まりである。パッケージの作成についてなじみがなければ、\ `Python のチュートリアル <http://docs.python.jp/2/tutorial/modules.html>`_\によい導入がある。

しかし今は Boost.Python を使って C++ コードをラップしているのである。優れたパッケージインターフェイスをユーザに提供するにはどうすればよいだろうか？ 概念的なことを捉えるために例を使って考えよう。

音に関する C++ ライブラリがあったとする。様々な形式で読み書きし、音データにフィルタをかける等するものとする。（便宜的に）名前を :py:mod:`!sounds` としておこう。以下のような整理された C++ 名前空間の階層がすでにあるとする。

.. code-block:: none

   sounds::core
   sounds::io
   sounds::filters

Python ユーザに同じ階層を提示し、次のようなコードが書けるようにしたい。

.. code-block:: python

   import sounds.filters
   sounds.filters.echo(...) # echo は C++ 関数

第 1 段階はラップコードを書くことである。以下のように Boost.Python を使って各モジュールを個別にエクスポートしなければならない。 ::

   /* ファイル core.cpp */
   BOOST_PYTHON_MODULE(core)
   {
       /* 名前空間 sounds::core 内のものをすべてエクスポートする */
       ...
   }

   /* ファイル io.cpp */
   BOOST_PYTHON_MODULE(io)
   {
       /* 名前空間 sounds::io 内のものをすべてエクスポートする */
       ...
   }

   /* ファイル filters.cpp */
   BOOST_PYTHON_MODULE(filters)
   {
       /* 名前空間 sounds::filters 内のものをすべてエクスポートする */
       ...
   }

これらのファイルをコンパイルすると、:file:`core.pyd` 、:file:`io.pyd` および :file:`filters.pyd` の Python 拡張が生成される。

.. note::
   拡張子 :file:`.pyd` は Python の拡張モジュールで使用するものであり、単純に共有ライブラリである。システムで既定のもの（Unix の場合は :file:`.so` 、Windows の場合は :file:`.dll`）を使用しても差し支えない。

次に以下の Python パッケージ用のディレクトリ構造を作成する。

.. code-block:: none

   sounds/
       __init__.py
       core.pyd
       filters.pyd
       io.pyd

ファイル :file:`__init__.py` は、ディレクトリ :file:`sounds/` が実際は Python のパッケージであることを Python に伝える。このファイルは空でもよいが、後述するようにここでマジックを行うことも可能だ。

これでパッケージの準備が整った。ユーザがなすべきなのは、:file:`sounds` を `PYTHONPATH <http://docs.python.jp/2/tutorial/modules.html#tut-searchpath>`_ に置いてインタープリタを起動することだけである。

.. code-block:: python

   >>> import sounds.io
   >>> import sounds.filters
   >>> sound = sounds.io.open('file.mp3')
   >>> new_sound = sounds.filters.echo(sound, 1.0)

何も問題無いようだが、どうだろう？

これはパッケージ階層を作成する最も単純な方法だが、柔軟性がまるでない。\ **純粋な** Python の関数、例えば音オブジェクトに 3 つのフィルタを同時にかける関数を :py:mod:`!filters` パッケージに追加したい場合はどうだろうか？ 確かにC++ で書いてエクスポートすれば可能だが、Python でやってみてはどうか。そうすれば拡張モジュールの再コンパイルが不要で、書くのも簡単である。

こういった柔軟性が必要な場合、パッケージ階層を少しばかり複雑にしなければならない。まず拡張モジュール群の名前を変更しなければならない。 ::

   /* ファイル core.cpp */
   BOOST_PYTHON_MODULE(_core)
   {
       ...
       /* 名前空間 sounds::core 内のものをすべてエクスポートする */
   }

モジュール名にアンダースコアを追加したことに注意していただきたい。ファイル名も :file:`_core.pyd` に変わるはずである。他の拡張モジュールも同様である。これでパッケージ階層は以下のように変更された。

.. code-block:: none

   sounds/
       __init__.py
       core/
           __init__.py
           _core.pyd
       filters/
           __init__.py
           _filters.pyd
       io/
           __init__.py
           _io.pyd

各拡張モジュールについてディレクトリを作成し、それぞれに :file:`__init__.py` を追加したことに注意していただきたい。しかしこれをこのままおいておくと、ユーザは次のような構文で :py:mod:`!core` モジュールの関数にアクセスしなければならない。

.. code-block:: python

   >>> import sounds.core._core
   >>> sounds.core._core.foo(...)

これは望ましいことではない。しかしここで :file:`__init__.py` のマジックが発動する。:file:`__init__.py` の名前空間に持ち込まれるものはすべてユーザが直接アクセスできるのである。そういうわけで、名前空間全体を :file:`_core.pyd` から :file:`core/__init__.py` へ持ち込むだけでよい。つまり次のコード行を :file:`sounds/core/__init__.py` へ追加する。

.. code-block:: python

   from _core import *

他のパッケージも同様に行う。これでユーザは以前のように拡張モジュール内と関数とクラスにアクセスできるようになる。

.. code-block:: python

   >>> import sounds.filters
   >>> sounds.filters.echo(...)

他にも純粋な Python 関数をあらゆるモジュールに容易に追加できるという利点もある。この方法であればユーザには C++ 関数と Python 関数の見分けが付かない。では\ **純粋な** Python 関数 :cpp:func:`!echo_noise` を :py:mod:`!filters` パッケージに追加しよう。この関数は与えられた :cpp:var:`!sound` オブジェクトに :cpp:func:`!echo` と :cpp:func:`!noise` の両方のフィルタを順番に適用する。:file:`sounds/filters/echo_noise.py` という名前でファイルを作成して関数のコードを書く。

.. code-block:: python

   import _filters
   def echo_noise(sound):
       s = _filters.echo(sound)
       s = _filters.noise(sound)
       return s

次に以下の行を :file:`sounds/filters/__init__.py` に追加する。

.. code-block:: python

   from echo_noise import echo_noise

これで終わりだ。ユーザは、:py:mod:`!filters` パッケージの他の関数と同様にこの関数にアクセスできる。

.. code-block:: python

   >>> import sounds.filters
   >>> sounds.filters.echo_noise(...)


.. _tutorial.techniques.extending_wrapped_objects_in_python:

ラップしたオブジェクトを Python で拡張する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Python の柔軟性に感謝することだ。クラスを作成した後であってもメソッドを容易に追加できる。

.. code-block:: python

   >>> class C(object): pass
   >>>> 
   >>>> # 普通の関数
   >>>> def C_str(self): return 'C のインスタンス！'
   >>> 
   >>> # メンバ関数に変更する
   >>> C.__str__ = C_str
   >>> 
   >>> c = C()
   >>> print c
   C のインスタンス！
   >>> C_str(c)
   C のインスタンス！

やはり Python は素晴らしい。

同様のことが Boost.Python でラップしたクラスでもできる。C++ 側に :cpp:class:`!point` クラスがあるとする。 ::

   class point {...};

   BOOST_PYTHON_MODULE(_geom)
   {
       class_<point>("point")...;
   }

前節『\ :ref:`パッケージを作成する <tutorial.techniques.creating_packages>`\』のテクニックを使うと :file:`geom/__init__.py` に直接コードが書ける。

.. code-block:: python

   from _geom import *

   # 普通の関数
   def point_str(self):
       return str((self.x, self.y))

   # メンバ関数に変更する
   point.__str__ = point_str

C++ で作成した\ **すべての** :cpp:class:`!point` インスタンスがこのメンバ関数を持つことになる！ このテクニックには色々と利点がある。

* 追加する関数についてのコンパイル時間増加がゼロになる
* メモリのフットプリントが見かけ上ゼロに削減する
* 再コンパイルの必要が最小になる
* 高速なプロトタイピング（インターフェイスを変更しないことが要求されている場合、コードを C++ に移動することが可能）

.. メタクラスを使って簡単な構文糖を追加することもできる。メソッドを他のクラスに「注入する」特別なメタクラスを作成しよう。
.. .. code-block:: python
..
..    # Boost.Python がすべてのラップされたクラスに対して使用するもの。
..    # "point" の代わりに Boost でエクスポートしたあらゆるクラスが使用できる
..    BoostPythonMetaclass = point.__class__
..
..    class injector(object):
..        class __metaclass__(BoostPythonMetaclass):
..            def __init__(self, name, bases, dict):
..                for b in bases:
..                    if type(b) not in (self, type):
..                        for k,v in dict.items():
..                            setattr(b,k,v)
..                return type.__init__(self, name, bases, dict)
..
..    # point にいくつかメソッドを注入する
..    class more_point(injector, point):
..        def __repr__(self):
..            return 'Point(x=%s, y=%s)' % (self.x, self.y)
..        def foo(self):
..            print 'foo!'</programlisting>
..
.. これでどうなるか見てみよう。
..
.. .. code-block:: python
..
..    >>> print point()
..    Point(x=10, y=10)
..    >>> point().foo()
..    foo!

別の有用な考えとして、コンストラクタをファクトリ関数で置き換える方法がある。

.. code-block:: python

   _point = point

   def point(x=0, y=0):
       return _point(x, y)

このような簡単な例ではつまらない感じがするが、多重定義や引数が多数あるコンストラクタにおいては優れた単純化となることが多い。キーワードサポートに対してコンパイル時間のオーバーヘッドがゼロ、メモリのフットプリントも事実上ゼロとなる。


.. _tutorial.techniques.reducing_compiling_time:

コンパイルにかかる時間を短縮する
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

クラスを大量にエクスポートすると、Boost.Python ラッパのコンパイルにかなりの時間がかかる。またメモリの消費量が容易に過大となる。これが問題となるのであれば、:cpp:class:`!class_` 定義を複数のファイルに分割するとよい。 ::

   /* ファイル point.cpp */
   #include <point.h>
   #include <boost/python.hpp>

   void export_point()
   {
       class_<point>("point")...;
   }

   /* ファイル triangle.cpp */
   #include <triangle.h>
   #include <boost/python.hpp>

   void export_triangle()
   {
       class_<triangle>("triangle")...;
   }

そして :c:macro:`!BOOST_PYTHON_MODULE` マクロを含んだ :file:`main.cpp` ファイルを作成し、その中でエクスポート関数を呼び出す。 ::

   void export_point();
   void export_triangle();

   BOOST_PYTHON_MODULE(_geom)
   {
       export_point();
       export_triangle();
   }

これらのファイルをすべてコンパイル、リンクすると、通常の方法の場合と同じ結果が得られる。しかしメモリはまともな状態が維持できる。 ::

   #include <boost/python.hpp>
   #include <point.h>
   #include <triangle.h>

   BOOST_PYTHON_MODULE(_geom)
   {
       class_<point>("point")...;
       class_<triangle>("triangle")...;
   }

C++ ライブラリ開発と Python へのエクスポートを同時に行っている場合にも、この方法を推奨する。クラス内で変更があっても、ラッパコード全体ではなく単一の cpp ファイルについてコンパイルが必要になるだけである。

.. 1.61 で削除
..
.. .. note:: :ref:`Pyste <pyste>` を使ってクラスをエクスポートする場合は、:option:`!--multiple` オプションを覚えておくとよい。ここで示したように複数のファイルにラッパを生成する。

.. note:: 巨大なソースファイルをコンパイルしてエラーメッセージ「致命的なエラー C1204：コンパイラの制限：内部構造がオーバーフローしました。」が出た場合にも、この方法を推奨する。:ref:`FAQ <faq.fatal_error_c1204_compiler_limit>` に説明がある。


.. [#] 訳注　この日本語訳は http://www.python.jp/Zope/Zope/articles/misc/zen によりました（Copyright © 2001-2012 Python Japan User's Group）。

.. [#] 訳注　『2001 年宇宙の旅』（“2001: A Space Odyssey” : Stanley Kubrick and Arthur C. Clarke, 1968）かな？
