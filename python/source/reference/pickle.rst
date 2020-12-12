Boost.Python における pickle のサポート
=======================================

.. contents::
   :depth: 1
   :local:

pickle はオブジェクトの直列化（または永続化、整列化、平坦化）のための Python モジュールである。

オブジェクトの内容をファイルに保存、またはファイルから復元する必要があることはよくある。解法の 1 つは、特殊な形式でファイルへデータを読み書きする関数の組を書くことである。他の強力な解法は Python の pickle モジュールを使うことである。Python の自己記述機能を利用すると、pickle モジュールはほとんど任意の Python オブジェクトを再帰的にファイルに書き込み可能なバイトストリームへ変換する。

.. 自己記述 = "introspection"

Boost.Python ライブラリは、\ `Python ライブラリリファレンスの pickle の項 <https://docs.python.jp/2/library/pickle.html>`_\に詳細記載のインターフェイスを通じて pickle モジュールをサポートする。このインターフェイスは以下に述べる特殊メソッド :py:meth:`!__getinitargs__` 、:py:meth:`!__getstate__` および :py:meth:`!__setstate__` を必要とする。Boost.Python は Python の cPickle モジュールとも完全に互換であることに注意していただきたい。


Boost.Python の pickle インターフェイス
---------------------------------------

ユーザレベルでは、Boost.Python の pickle インターフェイスは 3 つの特殊メソッドを伴う。

:py:meth:`!__getinitargs__`
   Boost.Python 拡張クラスのインスタンスを pickle 化するとき、pickler はインスタンスが :py:meth:`!__getinitargs__` メソッドを持っているかテストする。このメソッドは Python のタプルを返さなければならない（:cpp:class:`!boost::python::tuple` を使うのが最も便利である）。インスタンスを unpickler が復元するとき、このタプルの内容をクラスのコンストラクタの引数として使用する。

   :py:meth:`!__getinitargs__` が定義されていない場合、:py:meth:`!pickle.load` は引数無しでコンストラクタ（:py:meth:`!__init__`\）を呼び出す。すなわちオブジェクトはデフォルトコンストラクト可能でなければならない。

:py:meth:`!__getstate__`
   Boost.Python 拡張クラスのインスタンスを pickle 化するとき、pickler はインスタンスが :py:meth:`!__getstate__` メソッドを持っているかテストする。このメソッドはインスタンスの状態を表す Python オブジェクトを返さなければならない。

:py:meth:`!__setstate__`
   Boost.Python 拡張クラスのインスタンスを unpickler により復元（:py:meth:`!pickle.load`\）するとき、はじめに :py:meth:`!__getinitargs__` の結果を引数として構築する（上述）。次に unpickler は新しいインスタンスが :py:meth:`!__setstate__` メソッドを持っているかテストする。テストが成功した場合、:py:meth:`!__getstate__` の結果（Python オブジェクト）を引数としてこのメソッドを呼び出す。

上記 3 つの特殊メソッドは、ユーザが個別に :cpp:func:`!.def()` してもよい。しかしながら Boost.Python は簡単に使用できる高水準インターフェイスを :cpp:class:`!boost::python::pickle_suite` クラスで提供している。このクラスは、:py:meth:`!__getstate__` および :py:meth:`!__setstate__` を組として定義しなければならないという一貫性も強制する。このインターフェイスの使用方法は以下の例で説明する。


例
--

.. contents::
   :depth: 1
   :local:

:file:`boost/libs/python/test` に、pickle サポートを提供する方法を示したファイルが 3 つある。

:file:`pickle1.cpp` [#]_
^^^^^^^^^^^^^^^^^^^^^^^^

この例の C++ クラスは、コンストラクタに適切な引数を渡すことで完全に復元できる。よって pickle インターフェイスのメソッド :py:meth:`!__getinitargs__` を定義するのに十分である。以下のようにする。

#. C++ の pickle 関数の定義： ::

      struct world_pickle_suite : boost::python::pickle_suite
      {
        static
        boost::python::tuple
        getinitargs(world const& w)
        {
            return boost::python::make_tuple(w.get_country());
        }
      };

#. Python の束縛を確立する。 ::

      class_<world>("world", args<const std::string&>())
          // ...
          .def_pickle(world_pickle_suite())
          // ...


:file:`pickle2.cpp` [#]_
^^^^^^^^^^^^^^^^^^^^^^^^

この例の C++ クラスは、コンストラクタで復元不可能なメンバデータを持つ。よって pickle インターフェイスのメソッド組 :py:meth:`!__getstate__` 、:py:meth:`!__setstate__` を提供する必要がある。

#. C++ の pickle 関数の定義： ::

      struct world_pickle_suite : boost::python::pickle_suite
      {
        static
        boost::python::tuple
        getinitargs(const world& w)
        {
          // ...
        }

        static
        boost::python::tuple
        getstate(const world& w)
        {
          // ...
        }

        static
        void
        setstate(world& w, boost::python::tuple state)
        {
          // ...
        }
      };

#. suite 全体の Python の束縛を確立する。 ::

      class_<world>("world", args<const std::string&>())
          // ...
          .def_pickle(world_pickle_suite())
          // ...

簡単のために、:py:meth:`!__getstate__` の結果に :py:attr:`!__dict__` は含まれない。これは通常は推奨しないが、オブジェクトの :py:attr:`!__dict__` が常に空であると分かっている場合は有効な方法である。この想定が崩れるケースは以下に述べる安全柵で捕捉できる。


:file:`pickle3.cpp` [#]_
^^^^^^^^^^^^^^^^^^^^^^^^

この例は :file:`pickle2.cpp` と似ているが、:py:meth:`!__getstate__` の結果にオブジェクトの :py:attr:`!__dict__` が含まれる。より多くのコードが必要になるが、オブジェクトの :py:attr:`!__dict__` が空とは限らない場合は避けられない。


落とし穴と安全柵
----------------

上述の pickle プロトコルには、Boost.Python 拡張モジュールのエンドユーザが気にかけない重大な落とし穴がある。

.. important:: :py:meth:`!__getstate__` が定義されており、インスタンスの :py:attr:`!__dict__` が空でない。

Boost.Python 拡張クラスの作成者は、以下の可能性を考慮せずに :py:meth:`!__getstate__` を提供する可能性がある。

* クラスが Python 内で基底クラスとして使用される。おそらく派生クラスのインスタンスの :py:attr:`!__dict__` は、インスタンスを正しく復元するために pickle 化する必要がある。
* ユーザがインスタンスの :py:attr:`!__dict__` に直接要素を追加する。この場合もインスタンスの :py:attr:`!__dict__` は pickle 化が必要である。

この高度に不明確な問題をユーザに警告するために、安全柵が提供されている。:py:meth:`!__getstate__` が定義されており、インスタンスの :py:attr:`!__dict__` が空でない場合は、Boost.Python はクラスが属性 :py:attr:`!__getstate_manages_dict__` を持っているかテストする。この属性が定義されていなければ例外を送出する。

.. code-block:: console

   RuntimeError: Incomplete pickle support (__getstate_manages_dict__ not set)

この問題を解決するには、まず :py:meth:`!__getstate__` および :py:meth:`!__setstate__` メソッドがインスタンスの :py:attr:`!__dict__` を正しく管理するようにしなければならない。これは C++ あるいは Python レベルのいずれでも達成可能であることに注意していただきたい。最後に安全柵を故意にオーバーライドしなければならない。例えば C++ では以下のとおり（:file:`pickle3.cpp` から抜粋）。 ::

   struct world_pickle_suite : boost::python::pickle_suite
   {
     // ...

     static bool getstate_manages_dict() { return true; }
   };

あるいは Python では次のとおり。

.. code-block:: python

   import your_bpl_module
   class your_class(your_bpl_module.your_class):
     __getstate_manages_dict__ = 1
     def __getstate__(self):
       # ここにコードを書く
     def __setstate__(self, state):
       # ここにコードを書く


実践的なアドバイス
------------------

#. 多くの拡張クラスを持つ Boost.Python 拡張モジュールでは、すべてのクラスについて pickle の完全なサポートを提供すると著しいオーバーヘッドとなる。通常、完全な pickle サポートの実装は最終的に pickle 化する拡張クラスに限定すべきである。
#. インスタンスが :py:meth:`!__getinitargs__` による再構築も可能な場合は :py:meth:`!__getstate__` は避けよ。これは上記の落とし穴を自動的に避けることになる。
#. :py:meth:`!__getstate__` が必要な場合、返す Python オブジェクトにインスタンスの :py:attr:`!__dict__` を含めよ。


軽量な代替：Python 側での pickle サポートの実装
-----------------------------------------------

:file:`pickle4.cpp` [#]_
^^^^^^^^^^^^^^^^^^^^^^^^

:file:`pickle4.cpp` の例は、pickle サポートの実装に関する別のテクニックのデモンストレーションである。はじめに :cpp:func:`!class_::enable_pickling()` メンバ関数で pickle 化に必要な基本的な属性だけを Boost.Python に定義させる。 ::

   class_<world>("world", args<const std::string&>())
       // ...
       .enable_pickling()
       // ...

これで Python のドキュメントにある標準的な Python の pickle インターフェイスが有効になる。:py:meth:`!__getinitargs__` メソッドをラップするクラス定義に「注入」することで、すべてのインスタンスを pickle 化可能にする。

.. code-block:: python

   # ラップした world クラスをインポート
   from pickle4_ext import world

   # __getinitargs__ の定義
   def world_getinitargs(self):
     return (self.get_country(),)

   # ここで __getinitargs__ を注入（Python は動的言語！）
   world.__getinitargs__ = world_getinitargs

Python から追加のメソッドを注入する方法については、:ref:`チュートリアルの節 <tutorial.techniques.extending_wrapped_objects_in_python>`\も見よ。


.. [#] :download:`http://www.boost.org/libs/python/test/pickle1.cpp`

.. [#] :download:`http://www.boost.org/libs/python/test/pickle2.cpp`

.. [#] :download:`http://www.boost.org/libs/python/test/pickle3.cpp`

.. [#] :download:`http://www.boost.org/libs/python/test/pickle4.cpp`
