よくある質問と回答
==================

.. contents::
   :depth: 1
   :local:


.. _faq.how_can_i_wrap_a_function_which_:

関数ポインタを引数にとる関数をラップするにはどうすればよいか
------------------------------------------------------------

次のようにしたい場合は、 ::

   typedef boost::function<void (string s) > funcptr;

   void foo(funcptr fp)
   {
       fp("hello,world!");
   }

   BOOST_PYTHON_MODULE(test)
   {
       def("foo",foo) ;
   }

Python 側はこう。

.. code-block:: python

   >>> def hello(s):
   ...    print s
   ... 
   >>> foo(hello)
   hello, world!

短い答えは「できない」だ。これは Boost.Python の制限ではなく C++ の制限による。問題は Python の関数は実際はデータであり、データと C++ 関数をひとまとめにするには関数の静的変数に格納する以外に方法がないということである。この話の問題は、一握りのデータをすべての関数とひとまとめすることしかできず、:cpp:func:`!foo` へ渡すと決めた Python 関数についてその場で新しい C++ 関数をコンパイルする方法はないということである。言い換えると、C++ 関数が常に同じ Python 関数を呼び出すのであれば動作するが、おそらくあなたの希望ではないだろう。

ラップする C++ コードを変更することに糸目を付けなければ、代わりにそれを :py:class:`!object` へ渡し呼び出すとよい。多重定義された関数呼び出し演算子は、渡した先の :py:class:`!object` の背後にある Python 関数を呼び出す。

この問題についてより多くの考え方に触れるには、\ `このポスト <http://aspn.activestate.com/ASPN/Mail/Message/1554837>`_\ [#]_\ を見よ。


.. _faq.i_m_getting_the_attempt_to_retur:

「懸垂参照を返そうとしました」エラーが出る。何が間違っているのか
----------------------------------------------------------------

厄介なクラッシュの発生を防ぐために発生している例外である。大抵は次のようなコードを書いたときに発生する。 ::

   period const& get_floating_frequency() const
   {
     return boost::python::call_method<period const&>(
         m_self,"get_floating_frequency");
   }

次のようなエラーが発生する。

.. code-block:: console

   ReferenceError: Attempt to return dangling reference to object of type:
   class period

この場合、:cpp:func:`!call_method` が呼び出す Python のメソッドが新しい Python オブジェクトを構築する。その Python が所有し内包する C++ オブジェクト（:cpp:expr:`class period` のインスタンス）への参照を返そうとしている。呼び出されるメソッドは短命な新しいオブジェクトを戻すため、それへの参照のみが上記の :cpp:expr:`get_floating_frequency()` の存続期間で保持される。関数が返ると Python のオブジェクトが破壊されるため、:cpp:class:`!period` クラスのインスタンスが破壊され、返った参照は懸垂したままとなる。もはや未定義の振る舞いであり、この参照で何かしようとするとクラッシュする。Boost.Python はこのような状況を実行時に検出し、クラッシュする前に例外を投げる。


.. _faq.is_return_internal_reference_eff:

return_internal_reference の効率はどうか
----------------------------------------

   質問

   12 個の :cpp:expr:`double` を持つオブジェクトがある。別のクラスのメンバ関数がこのオブジェクトへの :code:`const&` を返す。返されるオブジェクトを Python で使用するという観点では、得られるのが戻り値のオブジェクトのコピーと参照のどちらであるかは気にしていない。Boost.Python のバージョン 2 で、:cpp:class:`!copy_const_referece` か :cpp:class:`!return_internal_reference` のどちらを使用するか決めようと思う。生成されるコードのサイズやメモリオーバーヘッド等、どちらかを選択するのに決め手になるものはあるか。

:cpp:class:`!copy_const_reference` はオブジェクトに対しストレージを使用してインスタンスを作成し、そのサイズは base_size + 12 * sizeof(double) である。:cpp:class:`!return_internal_reference` はオブジェクトへのポインタに対しストレージを使用してインスタンスを作成し、そのサイズは base_size + sizeof(void*) である。しかしながら、元のオブジェクトの弱参照リストに入る弱い参照オブジェクトと、内部で参照するオブジェクトの寿命を管理するための特別なコールバックオブジェクトも作成する。私の考えはどうかというと、この場合は :cpp:class:`!copy_const_reference` がよいと思う。全メモリ使用量と断片化が減少し、トータルサイクルも削減することだろう。


.. _faq.how_can_i_wrap_functions_which_t:

C++ コンテナを引数にとる関数をラップするにはどうすればよいか
------------------------------------------------------------

Ralf W. Grosse-Kunstleve が次のようなノートを残している。

#. 通常の :cpp:class:`!class_<>` ラッパを使用する。 ::

      class_<std::vector<double> >("std_vector_double")
        .def(...)
        ...
        ;

   これをテンプレート内に持っていくと、様々な型を同じコードでラップできる。このテクニックは scitbx パッケージ内のファイル :file:`scitbx/include/scitbx/array_family/boost_python/flex_wrapper.h` で使用している。このファイルを :cpp:class:`!std::vector<>` インスタンスをラップするよう変更するのは容易である。

   この種の C++/Python の束縛は多数（10000 以上）の要素を持つコンテナに最も適している。

#. カスタムの rvalue 変換器を使用する。Boost.Python の「rvalue 変換器」は次のような関数シグニチャにマッチする。 ::

      void foo(std::vector<double> const& array); // const 参照渡し
      void foo(std::vector<double> array); // 値渡し

   ファイル :file:`scitbx/include/scitbx/boost_python/container_conversions.h` にいくつか rvalue 変換器の実装がある。このコードを使えば、:cpp:class:`!std::vector<>` や :cpp:class:`!std::list<>` といった C++ コンテナ型から Python のタプルへの変換、あるいはその逆が可能である。ファイル :file:`scitbx/array_family/boost_python/regression_test_module.cpp` に簡単な例がある。

   自動的な C++ コンテナ－ Python タプルの変換は、中サイズのコンテナに最も適している。これらの変換器が生成するオブジェクトコードは 1 番目の方法に比較して著しく小さい。

2 番目の方法の欠点は :code:`+` 、:code:`-` 、:code:`*` 、:code:`/` 、:code:`%` といった算術演算子が利用できないことである。タプルの代わりに「:cpp:type:`!math_array`」型へ変換するカスタムの rvalue 変換器があると便利だろう。現時点では実装されていないが、数週間以内にリリースする Boost.Python V2 のフレームワークで可能になる（2002 年 3 月 10 日のポスト）。

:cpp:class:`!std::vector<>` － Python リスト間の「カスタムの lvalue 変換器」もあると便利だろう。これらの変換器は C++ からの Python リストの変更をサポートする。例えば、

.. code-block:: c++
   :caption: C++ 側

   void foo(std::vector<double>& array)
   {
     for(std::size_t i=0;i<;array.size();i++) {
       array[i] *= 2;
     }
   }

.. code-block: python
   :caption: Python 側

   >>> l = [1, 2, 3]
   >>> foo(l)
   >>> print l
   [2, 4, 6]

カスタムの lvalue 変換器については Boost.Python コアライブラリの変更が必要であり、現時点では利用できない。

追伸：上で触れた scitbx ファイル群は匿名 CVS で利用できる。

.. code-block:: console

   cvs -d:pserver:anonymous@cvs.cctbx.sourceforge.net:/cvsroot/cctbx login
   cvs -d:pserver:anonymous@cvs.cctbx.sourceforge.net:/cvsroot/cctbx co scitbx


.. _faq.fatal_error_c1204_compiler_limit:

致命的なエラー C1204：コンパイラの制限 : 内部構造がオーバーフローしました。
---------------------------------------------------------------------------

   大きなソースファイルをコンパイルすると、このエラーメッセージが出る。どうすればよいか。

選択肢が 2 つある。

#. コンパイラをアップグレードする（推奨）。
#. ソースファイルを複数の翻訳単位に分割する。

.. code-block:: c++
   :caption: my_module.cpp

   ...
   void more_of_my_module();
   BOOST_PYTHON_MODULE(my_module)
   {
      def("foo", foo);
      def("bar", bar);
      ...
      more_of_my_module();
   }

.. code-block:: c++
   :caption: more_of_my_module.cpp

   void more_of_my_module()
   {
      def("baz", baz);
      ...
   }

:cpp:class:`class_\<>` 宣言を単一のソースファイルに押し込むことがエラーにより不可能な場合、:cpp:class:`!class_` オブジェクトへの参照を他のソースファイルの関数へ渡して、その補助ソースファイル内でメンバ関数（:cpp:func:`!.def(...)` 等）を呼び出すとよい。

.. code-block:: c++
   :caption: more_of_my_class.cpp

   void more_of_my_class(class_<my_class>& x)
   {
      x
        .def("baz", baz)
        .add_property("xx", &my_class::get_xx, &my_class::set_xx)
        ;

      ...
   }


.. _faq.how_do_i_debug_my_python_extensi:

Python 拡張をデバッグするにはどうすればよいか
---------------------------------------------

Greg Burley が Unix GCC ユーザに対して以下の回答をしている。

   C++ ライブラリかクラスについて Boost.Python 拡張を作成すると、コードのデバッグが必要になる。結局のところ、Python でライブラリをラップする理由の 1 つがこれだ。:abbr:`BPL` を使用することで期待される副作用や利益は、Python のコードが最小限の状況で boost::python が動作しない場合（すなわち、ラップするメソッドが正しくないとエラーが出るが、そのほとんどはコンパイラが捕捉するだろう）でも、デバッグがテスト段階の C++ ライブラリに隔離できるということである。

   :program:`gdb` セッションを始めて Python による C++ ライブラリのデバッグを行うための基本的なステップを以下に示す。あなたの :acronym:`BPL` モジュール :file:`my_ext.so` を含むディレクトリで :program:`gdb` セッションを開始しなければならないことに注意していただきたい。

   .. code-block:: console

      (gdb) target exec python
      (gdb) run
      >>> from my_ext import *
      >>> [C-c]
      (gdb) break MyClass::MyBuggyFunction
      (gdb) cont
      >>> pyobj = MyClass()
      >>> pyobj.MyBuggyFunction()
      Breakpoint 1, MyClass::MyBuggyFunction ...
      Current language:  auto; currently c++
      (gdb) do debugging stuff

Greg の方法はステップ実行したソースファイルの各行が表示されるので、Emacs の :program:`gdb` コマンドより優れたものである。

**Windows** における私のお気に入りのデバッグツールは :program:`Microsoft Visual C++ 7` に付属のデバッガだ。このデバッガは、Microsoft および :program:`Metrowerks` ツールセットのすべてのバージョンが生成するコードで動作するようである。安定していて、ユーザが特別なトリックを使わなくても「とりあえず動作する」。

Raoul Gough は Windows 上の :program:`gdb` について以下を提供している。

   最近 :program:`gdb` の Windows DLL サポートが改善され、少しのトリックで Python 拡張をデバッグできるようになった。まず、DLL から最小限のシンボルを抽出する機能をサポートした最新の :program:`gdb` が必要である。バージョン 6 以降の :program:`gdb` か Cygwin gdb-20030214-1 以降が対応している。適切なリリースであれば :file:`gdb.info` ファイルに Configuration – Native – Cygwin Native – Non-debug DLL symbols 節がある。本稿で概略を示す方法について、この info 節に詳細がある。

   次に、:kbd:`^C` で実行を中断するのではなく Python インタープリタ内にブレークポイントを設定する必要がある。ブレークポイントを設定する適切な場所は :c:func:`!PyOS_Readline` である。Python の対話コマンドを読み込む直前に毎回実行が停止する。デバッガが開始したらブレークポイントを設定可能になる前に Python を開始して自身の DLL を読み込まなければならない。

   .. code-block:: console

      $ gdb python
      GNU gdb 2003-09-02-cvs (cygwin-special)
      [...]

      (gdb)
      Starting program: /cygdrive/c/Python22/python.exe
      Python 2.2.2 (#37, Oct 14 2002, 17:02:34) [MSC 32 bit (Intel)] on win32
      Type "help", "copyright", "credits" or "license" for more information.
      >>> ^Z


      Program exited normally.
      (gdb) break *&PyOS_Readline
      Breakpoint 1 at 0x1e04eff0
      (gdb) run
      Starting program: /cygdrive/c/Python22/python.exe
      Python 2.2.2 (#37, Oct 14 2002, 17:02:34) [MSC 32 bit (Intel)] on win32
      Type "help", "copyright", "credits" or "license" for more information.

      Breakpoint 1, 0x1e04eff0 in python22!PyOS_Readline ()
         from /cygdrive/c/WINNT/system32/python22.dll
      (gdb) cont
      Continuing.
      >>> from my_ext import *

      Breakpoint 1, 0x1e04eff0 in python22!PyOS_Readline ()
         from /cygdrive/c/WINNT/system32/python22.dll
      (gdb) # my_ext now loaded (with any debugging symbols it contains)


.. _faq.how_do_i_debug_my_python_extensi.debugging_extensions_through_boo:

Boost.Build で拡張をデバッグする
--------------------------------

`Boost.Build <http://www.boost.org/boost-build2/>`_ で boost-python-runtest 規則を使用して拡張モジュールのテストを起動する場合、:program:`bjam` コマンドラインに :option:`!--debugger=debugger` を追加して好きなデバッガを起動できる。

.. code-block:: console

   bjam -sTOOLS=vc7.1 "--debugger=devenv /debugexe" test
   bjam -sTOOLS=gcc -sPYTHON_LAUNCH=gdb test

テストを走らせるときに :option:`!-d+2` オプションを追加すると、Boost.Build がテストを起動するのに使用する完全なコマンドを表示するので非常に便利である。このためには :envvar:`!PYTHONPATH` およびデバッガが正しく動作するのに必要な :envvar:`LD_LIBRARY_PATH` のような他の重要な環境関数がセットアップされていなければならない。


.. _faq.why_doesn_t_my_operator_work:

私の :code:`*=` 演算子が動作しないのはなぜか
--------------------------------------------

   多数の多重定義演算子とともにクラスを Python へエクスポートした。他はちゃんと動作するのに、:code:`*=` 演算子だけが正しく動作しない。毎回「シーケンスは非 int 型と乗算できません」と言われる。:code:`p1 *= p2` の代わりに :code:`p1.__imul__(p2)` とすると、コードの実行は成功する。私の何が間違っているのか。

あなたは何も間違っていない。これは Python 2.2 のバグだ。Python 単体でも同じことが起こるはずである（Python 単体で新形式のクラスを使ってみると、Boost.Python 内で何が起こっているか理解できるだろう）。

.. code-block:: python

   >>> class X(object):
   ...     def __imul__(self, x):
   ...         print 'imul'
   ... 
   >>> x = X()
   >>> x *= 1

この問題を解決するには Python をバージョン 2.2.1 以降へアップグレードする必要があり、他の方法はない。


.. _faq.does_boost_python_work_with_mac_:

Boost.Python は Mac OS X で動作するか
-------------------------------------

10.2.8 および 10.3 では Apple の gcc 3.3 コンパイラで動作することが分かっている。

.. code-block:: console

   gcc (GCC) 3.3 20030304 (Apple Computer, Inc. build 1493)

10.2.8 の場合は gcc の 2003 年 8 月アップデートを入手する（http://connect.apple.com/ で無償配布されている）。10.3 の場合は :program:`Xcode Tools` バージョン 1.0 を入手する（こちらも無償である）。

Python 2.3 が必要である。10.3 に付属の Python がよい。10.2.8 では次のコマンドを使用して Python をフレームワークとしてインストールする。

.. code-block:: console

   ./configure –enable-framework
   make
   make frameworkinstall

ターゲットディレクトリが :file:`/Library/Frameworks/Python.framework/Versions/2.3` であるので、最後のコマンドは root 権限が必要である。しかしながら、このインストールは 10.2.8 に付属の Python バージョンと競合しない。

コンパイルの前に ``stacksize`` を増やしておくことも肝要である。例えば次のようにする。

.. code-block:: console

   limit stacksize 8192k

``stacksize`` が小さいと内部コンパイラエラーが出てビルドがクラッシュする場合がある。

:cpp:class:`!boost::python::class_<your_type>` テンプレートの実体化をコンパイル中に、たまに Apple のコンパイラが以下のようなエラーを印字（バグ）することがある。

.. code-block:: console

   .../inheritance.hpp:44: error: cannot
    dynamic_cast `p' (of type `struct cctbx::boost_python::<unnamed>::add_pair*
      ') to type `void*' (source type is not polymorphic)

一般的な回避方法はないが、:cpp:type:`!your_type` の定義を以下のように修正するとすべての場合で動作するようだ。 ::

   struct your_type
   {
     // メンバデータを定義する前
   #if defined(__MACH__) && defined(__APPLE_CC__) && __APPLE_CC__ == 1493
     bool dummy_;
   #endif
     // 例えばここにメンバデータを置く
     double x;
     int j;
     // 以下続く
   };


.. _faq.how_can_i_find_the_existing_pyob:

C++ オブジェクトを保持する既存の PyObject を探し出すにはどうすればよいか
------------------------------------------------------------------------

   「常に保持済みの C++ オブジェクトへのポインタを返す関数をラップしたい。」

方法の 1 つとしては、仮想関数を持つクラスをラップするのに使用する機構をハイジャックすることである。コンストラクタで第 1 引数として :c:type:`!PyObject*` を取り、その :c:type:`!PyObject*` を :cpp:var:`!self` として格納するラッパクラスを作成する場合、薄いラッパ関数内でラッパ型へダウンキャストして元に戻すことができる。例えば、 ::

   class X { X(int); virtual ~X(); ... };
   X* f();  // Python オブジェクトが管理するXを返す


   // ラップのためのコード

   struct X_wrap : X
   {
       X_wrap(PyObject* self, int v) : self(self), X(v) {}
       PyObject* self;
   };

   handle<> f_wrap()
   {
       X_wrap* xw = dynamic_cast<X_wrap*>(f());
       assert(xw != 0);
       return handle<>(borrowed(xw->self));
   }

   ...

   def("f", f_wrap());
   class_<X,X_wrap,boost::noncopyable>("X", init<int>())
      ...
      ;

当然、:cpp:class:`!X` が仮想関数を持たない場合、:code:`dynamic_cast` の代わりに実行時チェックを行わない（行わなくてもよい）:code:`static_cast` を使用しなければならない。C++ から構築した :cpp:var:`!x` が :cpp:class:`!X_wrap` オブジェクトとなることは当然ないため、この方法が動作するのは :cpp:var:`!x` オブジェクトが Python から構築された場合だけである。

別の方法では C++ コードをわずかに変更しなければならない（可能であればこちらのほうがよい）。:cpp:class:`!shared_ptr<X>` が Python から変換されると、:cpp:class:`!shared_ptr` は実際は内包する Python オブジェクトへの参照を管理する。逆に :cpp:class:`!shared_ptr<X>` を Python へ変換すると、ライブラリはそれが「Python オブジェクト管理者」の 1 つであるかチェックし、そうであれば元の Python オブジェクトをそのまま返す。よって :cpp:expr:`object(p)` と書くだけで Python オブジェクトを戻すことができる。これを利用するには、ラップする C++ コードを生のポインタではなく :cpp:class:`!shared_ptr` で扱えるよう変更可能にしなければならない。

さらに別の方法もある。返したい Python オブジェクトを受け取る関数は、オブジェクトのアドレスと内包する Python オブジェクトの対応関係を記録する薄いラッパでラップでき、このマッピングから Python オブジェクトを捜索する :cpp:func:`!f_wrap` 関数を用意しておくことができる。


.. _faq.how_can_i_wrap_a_function_which0:

生のポインタの所有権を持つ必要がある関数をラップするにはどうすればいいか
------------------------------------------------------------------------

   私がラップしている API の一部分は次のようなものである。 ::

      struct A {}; struct B { void add( A* ); }
      // B::add() は渡されたポインタの所有権を獲得する。

   しかしながら、 ::

      a = mod.A()
      b = mod.B()
      b.add( a )
      del a
      del b
      # メモリの改変により
      # Python インタープリタがクラッシュする。

   :cpp:class:`!with_custodian_and_ward` を使って :cpp:var:`!a` の寿命を :cpp:var:`!b` に束縛したとしても、結局のところポインタ先の Python オブジェクト :cpp:var:`!a` が削除されるのを防ぐことはできない。ラップした C++ オブジェクトの「所有権を移動する」方法はあるか。

   -- Bruce Lowery

ある。C++ オブジェクトが :cpp:class:`!auto_ptr` に保持されるようにしておく。 ::

   class_<A, std::auto_ptr<A> >("A")
       ...
       ;

次に :cpp:class:`!auto_ptr` 引数をとる薄いラッパ関数を作成する。 ::

   void b_insert(B& b, std::auto_ptr<A> a)
   {
       b.insert(a.get());
       a.release();
   }

これを :cpp:func:`!B.add` でラップする。:cpp:class:`!manage_new_object` が返すポインタもまた :cpp:class:`!auto_ptr` で保持されているため、この所有権の移動が正しく動作することに注意していただきたい。


.. _faq.compilation_takes_too_much_time_:

コンパイルに時間がかかりメモリも大量に消費する！高速化するにはどうすればよいか
------------------------------------------------------------------------------

チュートリアルの\ :ref:`tutorial.techniques.reducing_compiling_time`\の節を参照いただきたい。


.. _faq.how_do_i_create_sub_packages_usi:

Boost.Python を使用してサブパッケージを作成するにはどうすればよいか
-------------------------------------------------------------------

チュートリアルの\ :ref:`tutorial.techniques.creating_packages`\の節を参照いただきたい。


.. _faq.error_c2064_term_does_not_evalua:

error C2064：2 引数を取り込む関数には評価されません
---------------------------------------------------

Niall Douglas が次のノートを提供している。

   :program:`Microsoft Visual C++ 7.1（MS Visual Studio .NET 2003）`\で以下のようなエラーメッセージが出る場合、ほとんどはコンパイラのバグである。

   .. code-block:: console

      boost\boost\python\detail\invoke.hpp(76):
      error C2064: 2 引数を取り込む関数には評価されません"

   このメッセージは以下のようなコードで引き起こされる。 ::

      #include <boost/python.hpp>

      using namespace boost::python;

      class FXThread
      {
      public:
          bool setAutoDelete(bool doso) throw();
      };

      void Export_FXThread()
      {
          class_< FXThread >("FXThread")
              .def("setAutoDelete", &FXThread::setAutoDelete)
          ;
      }

   このバグは :code:`throw()` 修飾子が原因である。回避方法は修飾子を取り除くことである。例えば、 ::

              .def("setAutoDelete", (bool (FXThread::*)(bool)) &FXThread::setAutoDelete)

   （このバグは Microsoft に報告済みである。）


.. _faq.how_can_i_automatically_convert_:

カスタム文字列型と Python 文字列を自動的に相互変換するにはどうすればよいか
--------------------------------------------------------------------------

Ralf W. Grosse-Kunstleve が次のノートを提供している。

   以下は、必要なものがすべて揃った小型の拡張モジュールのデモである。次のは対応する簡単なテストである。

   .. code-block:: python

      import custom_string
      assert custom_string.hello() == "Hello world."
      assert custom_string.size("california") == 10

   コードを見れば分かるが、

   * カスタムの to_python 変換器（容易）：:cpp:class:`!custom_string_to_python_str`
   * カスタムの lvalue 変換器（より多くのコードが必要）：:cpp:class:`!custom_string_from_python_str`

   カスタム変換器は、モジュール初期化関数のトップ近傍のグローバルな Boost.Python レジストリに登録する。一度制御フローが登録コードに渡ると、同じプロセス内でインポートしたあらゆるモジュールで Python 文字列の自動的な相互変換が動作するようになる。 ::

      #include <boost/python/module.hpp>
      #include <boost/python/def.hpp>
      #include <boost/python/to_python_converter.hpp>

      namespace sandbox { namespace {

      class custom_string
      {
        public:
          custom_string() {}
          custom_string(std::string const& value) : value_(value) {}
          std::string const& value() const { return value_; }
        private:
          std::string value_;
      };

      struct custom_string_to_python_str
      {
        static PyObject* convert(custom_string const& s)
        {
          return boost::python::incref(boost::python::object(s.value()).ptr());
        }
      };

      struct custom_string_from_python_str
      {
        custom_string_from_python_str()
        {
          boost::python::converter::registry::push_back(
            &convertible,
            &construct,
            boost::python::type_id<custom_string>());
        }

        static void* convertible(PyObject* obj_ptr)
        {
          if (!PyString_Check(obj_ptr)) return 0;
          return obj_ptr;
        }

        static void construct(
          PyObject* obj_ptr,
          boost::python::converter::rvalue_from_python_stage1_data* data)
        {
          const char* value = PyString_AsString(obj_ptr);
          if (value == 0) boost::python::throw_error_already_set();
          void* storage = (
            (boost::python::converter::rvalue_from_python_storage<custom_string>*)
              data)->storage.bytes;
          new (storage) custom_string(value);
          data->convertible = storage;
        }
      };

      custom_string hello() { return custom_string("Hello world."); }

      std::size_t size(custom_string const& s) { return s.value().size(); }

      void init_module()
      {
        using namespace boost::python;

        boost::python::to_python_converter<
          custom_string,
          custom_string_to_python_str>();

        custom_string_from_python_str();

        def("hello", hello);
        def("size", size);
      }

      }} // namespace sandbox::<anonymous>

      BOOST_PYTHON_MODULE(custom_string)
      {
        sandbox::init_module();
      }


.. _faq.why_is_my_automatic_to_python_co:

Python への自動変換器が見つからないのはなぜか
---------------------------------------------

Niall Douglas が次のノートを提供している。

   上記のようなカスタム変換器を定義すると、メンバデータへの直接アクセスのために :cpp:class:`!boost::python::class_` が提供する :cpp:func:`!def_readonly()` および :cpp:func:`!def_readwrite()` メンバ関数は期待どおりに動作しない。これは :cpp:expr:`def_readonly("bar", &foo::bar)` が次と等価だからである。 ::

      .add_property("bar", make_getter(&foo::bar, return_internal_reference()))

   同様に :cpp:expr:`def_readwrite("bar", &foo::bar)` は次と等価である。 ::

      .add_property("bar", make_getter(&foo::bar, return_internal_reference()),
                         make_setter(&foo::bar, return_internal_reference())

   戻り値のポリシーをカスタム変換に互換性のある形で定義するには、:cpp:func:`!def_readonly()` および :cpp:func:`def_readwrite()` を :cpp:func:`!add_property()` で置き換える。例えば、 ::

      .add_property("bar", make_getter(&foo::bar, return_value_policy<return_by_value>()),
                         make_setter(&foo::bar, return_value_policy<return_by_value>()))


.. _faq.is_boost_python_thread_aware_com:

インタープリタが複数の場合 Boost.Python はスレッドに対して問題ないか
--------------------------------------------------------------------

Niall Douglas が次のノートを提供している。

   短い答え：ノー。

   長い答え：解決するパッチは書けるが、困難である。Boost.Python を使用するあらゆるコード（特に仮想関数の多重定義部分）をカスタムのロック・アンロックで囲む必要があり、加えて :file:`boost/python/detail/invoke.hpp` を大幅に修正して Boost.Python があなたのコードを使用するあらゆる部分をカスタムのアンロック・ロックで囲む必要がある。さらに Boost.Python が :file:`invoke.hpp` によりイテレータ変更を起動するときにアンロック・ロックしないように注意しなければならない。

   パッチを当てた :file:`invoke.hpp` は C++-SIG メーリングリストにポストされ、アーカイブになっている。機械的に必要な実際の全実装は TnFOX プロジェクト（`SourceForge <http://sourceforge.net/projects/tnfox/>`_ 内の場所）にある。


.. [#] 訳注　ActiveState サイトへのリンクは移動してしまいました。http://code.activestate.com/lists/python-cplusplus-sig/ 以下が移動先と思われますが、訳者には個々のメッセージの場所が分かりませんでした。
