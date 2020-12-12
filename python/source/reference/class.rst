boost/python/class.hpp
======================

.. contents::
   :depth: 1
   :local:

.. _v2.class.introduction:

はじめに
--------

:file:`<boost/python/class.hpp>` は、ユーザが C++ クラスを Python へエクスポートするためのインターフェイスを定義する。:cpp:class:`!class_` クラステンプレートを宣言し、その引数はエクスポートするクラス型である。また :cpp:class:`!init` 、:cpp:class:`!optional` および :cpp:class:`!bases` ユーティリティクラステンプレートもエクスポートし、これらは :cpp:class:`!class_` クラステンプレートと組み合わせて使用する。

:file:`<boost/python/class_fwd.hpp>` には :cpp:class:`!class_` クラステンプレートの先行宣言がある。


.. _v2.class.classes:

クラス
------

.. _v2.class.class_-spec:

:cpp:class:`!class_\<T, Bases, HeldType, NonCopyable>` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:class:: template<class T, class Bases = bases<>, class HeldType = T, class NonCopyable = unspecified> \
	       class_ : public object

   第 1 引数として渡した C++ 型に対応する Python クラスを作成する。引数は 4 つあるが、必須なのは 1 番目だけである。3 つの省略可能な引数は\ **どのような順序でもよく**\、Boost.Python は引数の型から役割を判断する。

   :tparam Bases:
      ラップした :cpp:type:`!T` インスタンスからその直接的または間接的な基本型それぞれへの ``from_python`` 変換を登録する。多態的な各基底型 :cpp:type:`!B` について、間接的に保持されたラップした :cpp:type:`!B` インスタンスから :cpp:type:`!T` への変換を登録する。

      :要件: それ以前にエクスポートした :cpp:type:`!T` の C++ 基底クラス群を指定する :cpp:class:`bases\<>` の特殊化。\ [#]_
      :既定: :cpp:class:`bases\<>`
   :tparam HeldType:
      :cpp:type:`!T` のコンストラクタを呼び出したとき、または :cpp:type:`!T` や :cpp:type:`!T*` を :cpp:func:`ptr` 、:cpp:func:`ref` 、あるいは :cpp:struct:`return_internal_reference` 等の :ref:`CallPolicies <concepts.callpolicies>` を使用せずに Python へ変換したとき、:cpp:type:`!T` のインスタンスをラップする Python オブジェクトへ実際に組み込む型を指定する。詳細は\ :ref:`後述する <v2.class.HeldType>`\。

      :要件: :cpp:type:`!T` 、:cpp:type:`!T` の派生クラス、または :cpp:struct:`pointee`\ :cpp:type:`!\<HeldType>::type` が :cpp:type:`!T` か :cpp:type:`!T` の派生クラスである :ref:`Dereferenceable <concepts.dereferenceable>` 型。
      :既定: :cpp:type:`!T`
   :tparam NonCopyable:
      :cpp:type:`!T` のインスタンスをコピーする ``to_python`` 変換の自動的な登録を抑止する。:cpp:type:`!T` が公開アクセス可能なコピーコンストラクタを持たない場合に必要である。

      :要件: 与えられた場合、\ `boost::noncopyable <http://www.boost.org/libs/utility/utility.htm#Class_noncopyable>`_ でなければならない。
      :既定: :cpp:class:`!boost::noncopyable` 以外の未規定の型。

.. cpp:namespace-push:: class_


.. _v2.class.HeldType:

HeldType のセマンティクス
"""""""""""""""""""""""""

   #. :cpp:type:`!HeldType` が :cpp:type:`!T` から派生している場合、そのエクスポートしたコンストラクタは、:cpp:type:`!HeldType` インスタンスを持つ Python オブジェクトを逆向きに参照する :c:type:`!PyObject*` を第 1 引数に受け取らなければならない（:ref:`例 <v2.call_method.examples>`）。この引数は :cpp:expr:`def(init_expr)` に渡される :token:`init-expression` には含まれず、:cpp:type:`!T` の Python インスタンスが作成されるときユーザが明示的に渡すこともない。このイディオムにより、Python 側でオーバーライドする C++ 仮想関数が Python オブジェクトにアクセス可能となり、Python のメソッドが呼び出し可能となる。Boost.Python は :cpp:type:`!HeldType` 引数を要求するラップした C++ 関数に :cpp:type:`!T` のラップしたインスタンスを渡すための変換器を自動的に登録する。
   #. Boost.Python は :cpp:type:`!T` のラップしたインスタンスが :cpp:type:`!HeldType` 型の引数として渡すことを認めているため、:cpp:type:`!HeldType` のスマートポインタを指定することでユーザは :cpp:type:`!T` へのスマートポインタを受け取るところに Python の :cpp:type:`!T` インスタンスを渡すことができる。:cpp:class:`!std::auto_ptr` や `boost::shared_ptr\<> <http://www.boost.org/libs/smart_ptr/smart_ptr.htm>`_ といった対象の型を指す入れ子の :cpp:type:`!element_type` 型を持つスマートポインタは自動的にサポートされる。\ [#]_ :cpp:struct:`pointee\<HeldType>` を特殊化することで、他のスマートポインタ型もサポートされる。
   #. 上の 1. で述べたとおり、:cpp:type:`!HeldType` が :cpp:type:`!T` の派生型に対するスマートポインタの場合、:cpp:type:`!HeldType` のエクスポートしたコンストラクタすべてで :c:type:`!PyObject*` を第 1 引数として与えなければならない。
   #. 上記 1. および 3. 以外でユーザは :cpp:class:`has_back_reference\<>` を特殊化することで、:cpp:type:`!T` 自身が第 1 引数である :c:type:`!PyObject*` で初期化されることをオプション的に指定できる。


.. _v2.class.class_-spec-synopsis:

:cpp:class:`!class_` クラステンプレートの概要
"""""""""""""""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python
   {
     template <class T
         , class Bases = bases<>
               , class HeldType = T
               , class NonCopyable = unspecified
              >
     class class_ : public object
     {
       // 既定の __init__ を使用するコンストラクタ
       class_(char const* name);
       class_(char const* name, char const* docstring);

       // 既定でない __init__ を指定するコンストラクタ
       template <class Init>
       class_(char const* name, Init);
       template <class Init>
       class_(char const* name, char const* docstring, Init);

       // 追加の __init__ 関数のエクスポート
       template <class Init>
       class_& def(Init);

       // メソッドの定義
       template <class F>
       class_& def(char const* name, F f);
       template <class Fn, class A1>
       class_& def(char const* name, Fn fn, A1 const&);
       template <class Fn, class A1, class A2>
       class_& def(char const* name, Fn fn, A1 const&, A2 const&);
       template <class Fn, class A1, class A2, class A3>
       class_& def(char const* name, Fn fn, A1 const&, A2 const&, A3 const&);

       // メソッドを static として宣言
       class_& staticmethod(char const* name);
    
       // 演算子のエクスポート
       template <unspecified>
       class_& def(detail::operator_<unspecified>);

       // 生の属性の変更
       template <class U>
       class_& setattr(char const* name, U const&);

       // データメンバのエクスポート
       template <class D>
       class_& def_readonly(char const* name, D T::*pm);

       template <class D>
       class_& def_readwrite(char const* name, D T::*pm);

       // static データメンバのエクスポート
       template <class D>
       class_& def_readonly(char const* name, D const& d);
       template <class D>
       class_& def_readwrite(char const* name, D& d);

       // プロパティの作成
       template <class Get>
       void add_property(char const* name, Get const& fget, char const* doc=0);
       template <class Get, class Set>
       void add_property(
           char const* name, Get const& fget, Set const& fset, char const* doc=0);

       template <class Get>
       void add_static_property(char const* name, Get const& fget);
       template <class Get, class Set>
       void add_static_property(char const* name, Get const& fget, Set const& fset);

       // pickle のサポート
       template <typename PickleSuite>
       self& def_pickle(PickleSuite const&);
       self& enable_pickling();
     };
   }}


.. _v2.class.class_-spec-ctors:

:cpp:class:`!class_` クラステンプレートのコンストラクタ
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: class_(char const* name)
                  class_(char const* mame, char const* docstring)
                  template <class Init> \
                  class_(char const* name, Init init_spec)
                  template <class Init> \
                  class_(char const* name, char const* docstring, Init init_spec)

   :要件: :cpp:var:`!name` は Python の\ `識別子の名前付け規約 <http://docs.python.jp/2/reference/lexical_analysis.html#identifiers>`_\にしたがった :term:`ntbs`\。:cpp:var:`!docstring` が与えられた場合は :term:`ntbs` でなければならない。:cpp:var:`!init_spec` が与えられた場合、特殊な列挙定数 :cpp:var:`!no_init` か :cpp:type:`!T` と互換性のある :token:`init-expression` のいずれかでなければならない。
   :効果: 名前 :cpp:var:`!name` の Boost.Python 拡張クラスを保持する :cpp:class:`!class_` オブジェクトを構築する。\ :ref:`現在のスコープ <v2.scope.introduction>`\において属性 :cpp:var:`!name` を新しい拡張クラスに束縛する。

          * :cpp:var:`!docstring` が与えられた場合、その値を拡張クラスの :py:attr:`!__doc__` 属性に束縛する。
          * :cpp:var:`!init_spec` が :cpp:var:`!no_init` である場合、常に Python 例外を投げる特殊な :py:func:`!__init__` 関数を生成する。それ以外の場合は :cpp:expr:`this->def(init_spec)` を呼び出す。
          * :cpp:var:`!init_spec` が与えられなかった場合、:cpp:expr:`this->def(init<>())` を呼び出す。
   :根拠: 必要な :cpp:type:`!T` インスタンスを作成する :py:func:`!__init__` 関数をエクスポートせずにラップしたメンバ関数を呼び出すことによって発生する、よくある実行時エラーを避けられるよう、:cpp:class:`!class_<>` コンストラクタ内でコンストラクタ引数を指定できる。


.. _v2.class.class_-spec-modifiers:

クラステンプレート :cpp:class:`!class_` の変更関数
""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: template <class Init> \
                  class_& def(Init init_expr)

   :要件: :cpp:var:`!init_expr` は :cpp:type:`!T` と互換性のある :token:`init-expression` の結果。
   :効果: :cpp:type:`!Init` の\ :ref:`合法な接頭辞 <v2.init.init-expressions>` :samp:`{P}` それぞれについて、:samp:`{P}` を引数として受け取る拡張クラスに :py:func:`!__init__(...)` 関数の多重定義を追加する。生成された各多重定義は、上述のセマンティクスに従って :cpp:var:`!init_expr` の呼び出しポリシーのコピーを使用して :cpp:type:`!HeldType` のオブジェクトを構築する。:cpp:type:`!Init` の\ :ref:`合法な接頭辞 <v2.init.init-expressions>`\の最長のものが :samp:`{M}` 個の型を有しており :cpp:var:`!init_expr` が :samp:`{M}` 個のキーワードを保持しているとすると、各多重定義の先頭の :samp:`{N}` - :samp:`{M}` 個の引数に使用される。
   :returns: :cpp:expr:`*this`
   :根拠: ユーザはクラスのコンストラクタを容易に Python へエクスポートできる。


.. cpp:function:: template <class F> \
                  def(char const* name, Fn fn)
                  template <class Fn, class A1> \
                  def(char const* name, Fn fn, A1 const& a1)
                  template <class Fn, class A1, class A2> \
                  def(char const* name, Fn fn, A1 const& a1, A2 const& a2)
                  template <class Fn, class A1, class A2, class A3> \
                  def(char const* name, Fn fn, A1 const& a1, A2 const& a2, A3 const& a3)

   :要件: * :cpp:var:`!name` が Python の\ `識別子の名前付け規約 <http://docs.python.jp/2/reference/lexical_analysis.html#identifiers>`_\にしたがった :term:`ntbs`。

          * :cpp:var:`!a1` が :token:`overload-dispatch-expression` の結果である場合、有効なのは 2 番目の形式のみであり :cpp:var:`!fn` は\ :term:`引数長`\が :cpp:type:`!A1` の\ :ref:`最大引数長 <v2.overloads.overload-dispatch-expression>`\と同じである関数かメンバ関数へのポインタでなければならない。
   :効果: * :cpp:type:`!Fn` の引数型列の接頭辞 :samp:`{P}` それぞれについて、その長さが :cpp:type:`!A1` の\ :ref:`最小引数長 <v2.overloads.overload-dispatch-expression>`\であるものから、拡張クラスに :py:meth:`!name(...)` メソッドの多重定義を追加する。生成された各多重定義は、:cpp:var:`!a1` の :ref:`CallPolicies <concepts.callpolicies>` のコピーを使用して :cpp:var:`!a1` の :token:`call-expression` を :samp:`{P}` とともに呼び出す。:cpp:type:`!A1` の合法な接頭辞の最長のものが :samp:`{N}` 個の型を有しており :cpp:var:`!a1` が :samp:`{M}` 個のキーワードを保持しているとすると、各多重定義の先頭の :samp:`{N}` - :samp:`{M}` 個の引数に使用される。

          * それ以外の場合、:cpp:var:`!fn` に対してメソッドの多重定義を 1 つ構築する。:cpp:type:`!Fn` は null であってはならない。

            * :cpp:var:`!fn` が関数ポインタである場合、第 1 引数は :cpp:type:`!U` 、:cpp:type:`!U cv&` 、:cpp:type:`!U cv*` 、:cpp:type:`!U cv* const&` のいずれか（:cpp:type:`!T*` が :cpp:type:`!U*` に変換可能とする）でなければならない。:cpp:var:`!a1` から :cpp:var:`!a3` が与えられた場合、下表から任意の順番であってよい。
            * 上記以外で :cpp:var:`!fn` がメンバ関数へのポインタである場合、参照先は :cpp:type:`!T` かその公開基底クラスでなければならない。:cpp:var:`!a1` から :cpp:var:`!a3` が与えられた場合、下表から任意の順番であってよい。
            * それ以外の場合、:cpp:type:`!Fn` は :cpp:class:`object` かその派生型でなければならない。:cpp:var:`!a1` から :cpp:var:`!a2` が与えられた場合、下表の 2 行目までから任意の順番であってよい。:cpp:var:`!fn` が\ `呼び出し可能 <http://docs.python.jp/2/library/functions.html#callable>`_\でなければならない。

              .. list-table::
                 :header-rows: 1

		 * - 名前
                   - 要件・型特性
		   - 効果
		 * - docstring
                   - :term:`ntbs`。
		   - 値は結果の多重定義メソッドの :py:attr:`!__doc__` 属性に束縛される。それ以前の多重定義でドキュメンテーション文字列が与えられている場合は、改行 2 文字と新しいドキュメンテーション文字列がそこに追加される。
		 * - policies
		   - :ref:`CallPolicies <concepts.callpolicies>` のモデル
		   - 結果の多重定義メソッドの呼び出しポリシーとしてコピーが使用される。
		 * - keywords
		   - :cpp:var:`!fn` の\ :term:`引数長`\を超えることがないことを指定する :token:`keyword-expression` の結果。
		   - 結果の多重定義メソッドの呼び出しポリシーとしてコピーが使用される。

   :returns: :cpp:expr:`*this`


.. cpp:function:: class_& staticmethod(char const* name)

   :要件: :cpp:var:`!name` は Python の\ `識別子の名前付け規約 <http://docs.python.jp/2/reference/lexical_analysis.html#identifiers>`_\にしたがった :term:`ntbs` であり、多重定義がすべて定義済みのメソッドの名前。
   :効果: 既存の名前 :samp:`{x}` の属性を Python の :code:`staticmethod(x)` 呼び出し結果で置換する。当該メソッドが静的でありオブジェクトを渡さないことを指定する。これは以下の Python 文と等価である。

          .. code-block:: python

             setattr(self, name, staticmethod(getattr(self, name)))

   :注意: :cpp:expr:`staticmethod(name)` 呼び出し後に :cpp:expr:`def(name,...)` を呼び出すと、:py:exc:`!RuntimeError` を\ :term:`送出する`\。
   :returns: :cpp:expr:`*this`


.. cpp:function:: template <unspecified> \
                  class_& def(detail::operator_<unspecified>)

   :効果: :doc:`ここ <operators>`\に示す Python の\ `特殊関数 <http://docs.python.jp/2/library/operator.html>`_\を追加する。
   :returns: :cpp:expr:`*this`


.. cpp:function:: template <class U> \
                  class_& setattr(char const* name, U const& u)

   :要件: :cpp:var:`!name` は Python の\ `識別子の名前付け規約 <http://docs.python.jp/2/reference/lexical_analysis.html#identifiers>`_\にしたがった :term:`ntbs`\。
   :効果: :cpp:var:`!u` を Python へ変換し、拡張クラスの属性辞書に追加する。

          .. parsed-literal::

             `PyObject_SetAttrString <http://docs.python.jp/2/c-api/object.html#PyObject_SetAttrString>`_\ :cpp:expr:`(this->ptr(), name, object(u).ptr())`

   :returns: :cpp:expr:`*this`


.. cpp:function:: template <class Get> \
                  void add_property(char const* name, Get const& fget, char const* doc = 0)
                  template <class Get, class Set> \
                  void add_property(char const* name, Get const& fget, Set const& fset, char const* doc = 0)

   :要件: :cpp:var:`!name` は Python の\ `識別子の名前付け規約 <http://docs.python.jp/2/reference/lexical_analysis.html#identifiers>`_\にしたがった :term:`ntbs`\。
      :効果: 新しい Python の `property <http://www.python.org/2.2.2/descrintro.html#property>`_ クラスインスタンスを作成し、:cpp:expr:`object(fget)`\（2 番目の形式では :cpp:expr:`object(fset)` も）および（省略可能な）ドキュメンテーション文字列 :cpp:var:`!doc` をコンストラクタに渡す。最後にこのプロパティを構築中の Python のクラスオブジェクトに与えられた属性名 :cpp:var:`!name` で追加する。
   :returns: :cpp:expr:`*this`
   :根拠: ユーザは、Python の属性アクセス構文で呼び出せる関数を容易にエクスポートできる。


.. cpp:function:: template <class Get> \
                  void add_static_property(char const* name, Get const& fget)
                  template <class Get, class Set> \
                  void add_static_property(char const* name, Get const& fget, Set const& fset)

   :要件: :cpp:var:`!name` は Python の\ `識別子の名前付け規約 <http://docs.python.jp/2/reference/lexical_analysis.html#identifiers>`_\にしたがった :term:`ntbs`\。
   :効果: Boost.Python.StaticProperty オブジェクトを作成し、:cpp:expr:`object(fget)`\（2 番目の形式では :cpp:expr:`object(fset)` も）をコンストラクタに渡す。最後にこのプロパティを構築中の Python のクラスオブジェクトに与えられた属性名 :cpp:var:`!name` で追加する。StaticProperty は先頭の :cpp:var:`!self` 引数なしで呼び出せる Python の `property <http://www.python.org/2.2.2/descrintro.html#property>`_ クラスの特殊な派生クラスである。
   :returns: :cpp:expr:`*this`
   :根拠: ユーザは、Python の属性アクセス構文で呼び出せる関数を容易にエクスポートできる。


.. cpp:function:: template <class D> \
                  class_& def_readonly(char const* name, D T::* pm, char const* doc = 0)
                  template <class D> \
                  class_& def_readonly(char const* name, D const& d)

   :要件: :cpp:var:`!name` は Python の\ `識別子の名前付け規約 <http://docs.python.jp/2/reference/lexical_analysis.html#identifiers>`_\にしたがった :term:`ntbs`\。
   :効果: それぞれ、

          .. parsed-literal::

             this->add_property(name, :cpp:func:`make_getter`\(pm), doc);

          および

          .. parsed-literal::

             this->add_static_property(name, :cpp:func:`make_getter`\(d));

   :returns: :cpp:expr:`*this`
   :根拠: ユーザは、Python から自然な構文で取得可能なクラスのデータメンバや自由変数を容易にエクスポートできる。


.. cpp:function:: template <class D> \
                  class_& def_readwrite(char const* name, D T::* pm, char const* doc = 0)
                  template <class D> \
                  class_& def_readwrite(char const* name, D& d)

   :効果: それぞれ、

          .. parsed-literal::

             this->add_property(name, :cpp:func:`make_getter`\(pm), :cpp:func:`make_setter`\(pm), doc);

          および

          .. parsed-literal::

             this->add_static_property(name, :cpp:func:`make_getter`\(d), :cpp:func:`make_setter`\(pm));

   :returns: :cpp:expr:`*this`
   :根拠: ユーザは、Python から自然な構文で取得・設定可能なクラスのデータメンバや自由変数を容易にエクスポートできる。


.. cpp:function:: template <typename PickleSuite> \
                  class_& def_pickle(PickleSuite const&)

   :要件: :cpp:type:`!PickleSuite` は :cpp:class:`pickle_suite` の公開派生型でなければならない。
   :効果: 次の特殊な属性およびメソッドの合法な組み合わせを定義する：:py:meth:`!__getinitargs__` 、:py:meth:`!__getstate__` 、:py:meth:`!__setstate__` 、:py:attr:`!__getstate_manages_dict__` 、:py:attr:`!__safe_for_unpickling__` 、:py:meth:`!__reduce__`
   :returns: :cpp:expr:`*this`
   :根拠: ユーザは、ラップしたクラスについて完全な pickle サポートを確立するための\ :doc:`高水準インターフェイスを容易に使用 <pickle>`\できる。


.. cpp:function:: class_& enable_pickling()

   :効果: :py:meth:`!__reduce__` メソッドと :py:attr:`!__safe_for_unpickling__` 属性を定義する。
   :returns: :cpp:expr:`*this`
   :根拠: :cpp:func:`!def_pickle()` の軽量な代替。Python から :doc:`pickle サポート <pickle>`\の実装を有効にする。


.. cpp:namespace-pop::


.. _v2.class.bases-spec:

:class:`!bases<T1, T2, ...TN>` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template<class ...Ts> bases

   :cpp:class:`!class_` のインスタンス化において基底クラスのリストを記述するのに使用する `MPL シーケンス <http://www.boost.org/libs/mpl/doc/refmanual/forward-sequence.html>`_\。


.. _v2.class.bases-spec-synopsis:

:cpp:class:`!bases` クラステンプレートの概要
""""""""""""""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python
   {
     template <T1 = unspecified,...Tn = unspecified>
     struct bases
     {};
   }}


.. _v2.class.examples:

例
--

次のような C++ クラス宣言があるとすると、 ::

   class Foo : public Bar, public Baz
   {
    public:
      Foo(int x, char const* y);
      Foo(double);

      std::string const& name() { return m_name; }
      void name(char const*);

      double value; // 公開データ
    private:
      ...
   };

対応する Boost.Python 拡張クラスは以下のように作成できる。 ::

   using namespace boost::python;

   class_<Foo,bases<Bar,Baz> >("Foo",
             "これは Foo のドキュメンテーション文字列。"
             "Foo 拡張クラスの記述がここに入る",

             init<int,char const*>(args("x","y"), "__init__ のドキュメンテーション文字列")
             )
      .def(init<double>())
      .def("get_name", &Foo::get_name, return_internal_reference<>())
      .def("set_name", &Foo::set_name)
      .def_readwrite("value", &Foo::value)
      ;


.. [#] 「それ以前にエクスポートした」とは :cpp:class:`!bases` 内の各 :cpp:class:`!B` について、:cpp:class:`!class_<B, ...>` が構築済みでなければならないという意味である。

       .. code-block::

          class_<Base>("Base");
          class_<Derived, bases<Base> >("Derived");

.. [#] 訳注　:cpp:class:`!std::shared_ptr`\（C++11 以降）も自動的にサポートされます。
