boost/python/object.hpp
=======================

.. contents::
   :depth: 1
   :local:


.. _v2.object.introduction:

はじめに
--------

汎用的な Python のオブジェクトラッパクラス :cpp:class:`!object` および関連クラスをエクスポートする。引数依存の探索および :cpp:class:`!object` が定義する汎化演算子に絡む潜在的な問題を避けるため、これらの機能はすべて名前空間 :cpp:member:`!boost::python::api` で定義され、:cpp:class:`!object` は ``using`` 宣言で名前空間 :cpp:member:`!boost::python` へインポートされている。


.. _v2.object.types:

型
--

.. _v2.object.slice_nil-spec:

slice_nil
^^^^^^^^^

.. cpp:class:: slice_nil

   ::

      class slice_nil;
      static const _ = slice_nil();

   次のように、Python のスライス式で添字を省く効果を得る型。

   .. code-block:: python

      >>> x[:-1]
      >>> x[::-1]

   C++ で等価なことをするには、 ::

      x.slice(_,-1)
      x[slice(_,_,-1)]


.. _v2.object.classes:

クラス
------

.. _v2.object.const_attribute_policies-spec:

:cpp:struct:`!const_attribute_policies` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: const_attribute_policies

   :cpp:type:`!const object` への属性アクセスを表現するプロキシのためのポリシー。


.. cpp:namespace-push:: const_attribute_policies


.. _v2.object.const_attribute_policies-spec-synopsis:

:cpp:struct:`!const_attribute_policies` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace api
   {
     struct const_attribute_policies
     {
         typedef char const* key_type;
         static object get(object const& target, char const* key);
     };
   }}}


.. _v2.object.const_attribute_policies-spec-statics:

:cpp:struct:`!const_attribute_policies` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: static object get(object const& target, char const* key)

   :要件: :cpp:var:`!key` が :term:`ntbs`。
   :効果: :cpp:var:`!target` の属性 :cpp:var:`!key` にアクセスする。
   :returns: 属性アクセスの結果を管理する :cpp:class:`!object`。
   :throws error_already_set: Python の例外が送出した場合。


.. cpp:namespace-pop::


.. _v2.object.attribute_policies-spec:

:cpp:struct:`!attribute_policies` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: attribute_policies : const_attribute_policies

   変更可能な :cpp:class:`!object` への属性アクセスを表現するプロキシのためのポリシー。

.. cpp:namespace-push:: attribute_policies


.. _v2.object.attribute_policies-spec-synopsis:

:cpp:struct:`!attribute_policies` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace api
   {
     struct attribute_policies : const_attribute_policies
     {
         static object const& set(object const& target, char const* key, object const& value);
         static void del(object const&target, char const* key);
     };
   }}}


.. _v2.object.attribute_policies-spec-statics:

:cpp:struct:`!attribute_policies` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: static object const& set(object const& target, char const* key, object const& value)

   :要件: :cpp:var:`!key` が :term:`ntbs`。
   :効果: :cpp:var:`!target` の属性 :cpp:var:`!key` に :cpp:var:`!value` を設定する。
   :throws error_already_set: Python の例外が送出した場合。

.. cpp:function:: static void del(object const& target, char const* key)

   :要件: :cpp:var:`!key` が :term:`ntbs`。
   :効果: :cpp:var:`!target` の属性 :cpp:var:`!key` を削除する。
   :throws error_already_set: Python の例外が送出した場合。


.. cpp:namespace-pop::


.. _v2.object.const_objattribute_policies-spec:

:cpp:struct:`!const_objattribute_policies` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: const_objattribute_policies

   :cpp:type:`!const object` へのアクセス属性（属性名を :cpp:type:`!const object` で与える場合）を表現するプロキシのためのポリシー。


.. cpp:namespace-push:: const_objattribute_policies


.. _v2.object.const_objattribute_policies-spec-synopsis:

:cpp:struct:`!const_objattribute_policies` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace api
   {
     struct const_objattribute_policies
     {
         typedef object const& key_type;
         static object get(object const& target, object const& key);
     };
   }}}


.. _v2.object.const_objattribute_policies-spec-statics:

:cpp:struct:`!const_objattribute_policies` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: static object get(object const& target, object const& key)

   :要件: :cpp:var:`!key` が文字列を保持する :cpp:class:`!object`。
   :効果: :cpp:var:`!target` の属性 :cpp:var:`!key` にアクセスする。
   :returns: 属性アクセスの結果を管理する :cpp:class:`!object`。
   :throws error_already_set: Python の例外が送出した場合。


.. cpp:namespace-pop::


.. _v2.object.objattribute_policies-spec:

:cpp:struct:`!objattribute_policies` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: objattribute_policies : const_objattribute_policies

   変更可能な :cpp:class:`!object` へのアクセス属性（属性名を :cpp:type:`!const object` で与える場合）を表現するプロキシのためのポリシー。


.. cpp:namespace-push:: objattribute_policies


.. _v2.object.objattribute_policies-spec-synopsis:

:cpp:struct:`!objattribute_policies` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace api
   {
     struct objattribute_policies : const_objattribute_policies
     {
         static object const& set(object const& target, object const& key, object const& value);
         static void del(object const&target, object const& key);
     };
   }}}


.. _v2.object.objattribute_policies-spec-statics:

:cpp:struct:`!objattribute_policies` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: static object const& set(object const& target, object const& key, object const& value)

   :要件: :cpp:var:`!key` が文字列を保持する :cpp:class:`!object`。
   :効果: :cpp:var:`!target` の属性 :cpp:var:`!key` に :cpp:var:`!value` を設定する。
   :throws error_already_set: Python の例外が送出した場合。

.. cpp:function:: static void del(object const& target, object const& key)

   :要件: :cpp:var:`!key` が文字列を保持する :cpp:class:`!object`。
   :効果: :cpp:var:`!target` の属性 :cpp:var:`!key` を削除する。
   :throws error_already_set: Python の例外が送出した場合。


.. cpp:namespace-pop::


.. _v2.object.const_item_policies-spec:

:cpp:struct:`!const_item_policies` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: const_item_policies

   :cpp:type:`!const object` への（Python の角括弧演算子 :py:meth:`![]` による）要素アクセスを表現するプロキシのためのポリシー。


.. cpp:namespace-push:: const_item_policies


.. _v2.object.const_item_policies-spec-synopsis:

:cpp:struct:`!const_item_policies` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace api
   {
     struct const_item_policies
     {
         typedef object key_type;
         static object get(object const& target, object const& key);
     };
   }}}


.. _v2.object.const_item_policies-spec-statics:

:cpp:struct:`!const_item_policies` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: static object get(object const& target, object const& key)

   :効果: :cpp:var:`!target` の :cpp:var:`!key` で指定する要素へアクセスする。
   :returns: 属性アクセスの結果を管理する :cpp:class:`!object`。
   :throws error_already_set: Python の例外が送出した場合。


.. cpp:namespace-pop::


.. _v2.object.item_policies-spec:

:cpp:struct:`!item_policies` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: item_policies : const_item_policies

   変更可能な :cpp:class:`!object` への（Python の角括弧演算子 :py:meth:`![]` による）要素アクセスを表現するプロキシのためのポリシー。


.. cpp:namespace-push:: item_policies


.. _v2.object.item_policies-spec-synopsis:

:cpp:struct:`!item_policies` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace api
   {
     struct item_policies : const_item_policies
     {
         static object const& set(object const& target, object const& key, object const& value);
         static void del(object const& target, object const& key);
     };
   }}}


.. _v2.object.item_policies-spec-statics:

:cpp:struct:`!item_policies` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: static object const& set(object const& target, object const& key, object const& value)

   :効果: :cpp:var:`!target` の :cpp:var:`!key` で指定する要素を :cpp:var:`!value` に設定する。
   :throws error_already_set: Python の例外が送出した場合。


.. cpp:function:: static void del(object const& target, object const& key)

   :効果: :cpp:var:`!target` の :cpp:var:`!key` で指定する要素を削除する。
   :throws error_already_set: Python の例外が送出した場合。
.. cpp:namespace-pop::


.. _v2.object.const_slice_policies-spec:

:cpp:struct:`!const_slice_policies` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: const_slice_policies

   :cpp:type:`!const object` への（Python のスライス表記 :code:`[x:y]` による）スライスアクセスを表現するプロキシのためのポリシー。


.. cpp:namespace-push:: const_slice_policies


.. _v2.object.const_slice_policies-spec-synopsis:

:cpp:struct:`!const_slice_policies` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace api
   {
     struct const_slice_policies
     {
         typedef std::pair<handle<>, handle<> > key_type;
         static object get(object const& target, key_type const& key);
     };
   }}}


.. _v2.object.const_slice_policies-spec-statics:

:cpp:struct:`!const_slice_policies` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: static object get(object const& target, key_type const& key)

   :効果: :cpp:var:`!target` の :cpp:var:`!key` で指定するスライスへアクセスする。
   :returns: スライスアクセスの結果を管理する :cpp:class:`!object`。
   :throws error_already_set: Python の例外が送出した場合。


.. cpp:namespace-pop::


.. _v2.object.slice_policies-spec:

:cpp:struct:`!slice_policies` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: slice_policies : const_slice_policies

   変更可能な :cpp:class:`!object` へのスライスアクセスを表現するプロキシのためのポリシー。


.. cpp:namespace-push:: slice_policies


.. _v2.object.slice_policies-spec-synopsis:

:cpp:struct:`!slice_policies` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace api
   {
     struct slice_policies : const_slice_policies
     {
         static object const& set(object const& target, key_type const& key, object const& value);
         static void del(object const& target, key_type const& key);
     };
   }}}


.. _v2.object.slice_policies-spec-statics:

:cpp:struct:`!slice_policies` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: static object const& set(object const& target, key_type const& key, object const& value)

   :効果: :cpp:var:`!target` の :cpp:var:`!key` で指定するスライスに :cpp:var:`!value` を設定する。
   :throws error_already_set: Python の例外が送出した場合。

.. cpp:function:: static void del(object const& target, key_type const& key)

   :効果: :cpp:var:`!target` の :cpp:var:`!key` で指定するスライスを削除する。
   :throws error_already_set: Python の例外が送出した場合。


.. cpp:namespace-pop::


.. _v2.object.object_operators-spec:

:cpp:class:`!object_operators<U>` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:class:: template <class U> object_operators

   これは :cpp:class:`!object` およびその :cpp:class:`!proxy` テンプレートの基底クラスであり、共通のインターフェイス（メンバ関数およびクラス本体内で定義しなければならない演算子）を提供する。テンプレート引数 :cpp:type:`!U` は :cpp:class:`!object_operators<U>` の派生型という想定である。実際にはユーザはこのクラスを直接使用すべきではないが、:cpp:class:`!object` とそのプロキシに対して重要なインターフェイスを提供するので、ここに記載する。


.. cpp:namespace-push:: object_operators


.. _v2.object.object_operators-spec-synopsis:

:cpp:struct:`!object_operators` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace api
   {
     template <class U>
     class object_operators
     {
      public:
         // 関数呼び出し
         //
         object operator()() const;

         template <class A0>
         object operator()(A0 const&) const;
         template <class A0, class A1>
         object operator()(A0 const&, A1 const&) const;
         ...
         template <class A0, class A1,...class An>
         object operator()(A0 const&, A1 const&,...An const&) const;

         detail::args_proxy operator* () const; 
         object operator()(detail::args_proxy const &args) const; 
         object operator()(detail::args_proxy const &args, 
                           detail::kwds_proxy const &kwds) const; 

         // 真偽値のテスト
         //
         typedef unspecified bool_type;
         operator bool_type() const;

         // 属性アクセス
         //
         proxy<const_object_attribute> attr(char const*) const;
         proxy<object_attribute> attr(char const*);
         proxy<const_object_objattribute> attr(object const&) const;
         proxy<object_objattribute> attr(object const&);

         // 要素アクセス
         //
         template <class T>
         proxy<const_object_item> operator[](T const& key) const;
    
         template <class T>
         proxy<object_item> operator[](T const& key);

         // スライシング
         //
         template <class T, class V>
         proxy<const_object_slice> slice(T const& start, V const& end) const
    
         template <class T, class V>
         proxy<object_slice> slice(T const& start, V const& end);
     };
   }}}


.. _v2.object.object_operators-spec-observers:

:cpp:class:`!object_operators` クラステンプレートのオブザーバ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: template<class ...Args> object operator()(Args const& ...args) const

   :効果: :cpp:expr:`call<object>(object(\*static_cast<U\*>(this)).ptr(), args)`


.. cpp:function:: object operator()(detail::args_proxy const & args) const

   :効果: タプル :cpp:var:`!args` で与えた引数で :cpp:class:`!object` を呼び出す。


.. cpp:function:: object operator()(detail::args_proxy const & args, detail::kwds_proxy const & kwds) const

   :効果: タプル :cpp:var:`!args` で与えた引数と辞書 :cpp:var:`!kwds` で与えた名前付き引数で :cpp:class:`!object` を呼び出す。


.. cpp:function:: operator bool_type() const

   :効果: :cpp:expr:`*this` の真偽値をテストする。
   :returns: :cpp:expr:`call<object>(object(\*static_cast<U\*>(this)).ptr(), args)`


.. cpp:function:: proxy<const_object_attribute> attr(char const*) const
                  proxy<object_attribute> attr(char const*)

   :要件: :cpp:var:`!name` が :term:`ntbs`。
   :効果: :cpp:expr:`*this` の名前 :cpp:var:`!name` の属性にアクセスする。
   :returns: ターゲットに :cpp:expr:`object(\*static_cast<U\*>(this))` を、キーに :cpp:var:`!name` を束縛した :cpp:class:`!proxy` オブジェクト。


.. cpp:function:: proxy<const_object_objattribute> attr(object const&) const
                  proxy<object_objattribute> attr(object const&)

   :要件: :cpp:var:`!name` は文字列を保持する :cpp:class:`!object`。
   :効果: :cpp:expr:`*this` の名前 :cpp:var:`!name` の属性にアクセスする。
   :returns: ターゲットに :cpp:expr:`object(\*static_cast<U\*>(this))` を、キーに :cpp:var:`!name` を束縛した :cpp:class:`!proxy` オブジェクト。


.. cpp:function:: template <class T> proxy<const_object_item> operator[](T const& key) const
                  template <class T> proxy<object_item> operator[](T const& key)

   :効果: :cpp:expr:`*this` の :cpp:var:`!key` が示す要素にアクセスする。
   :returns: ターゲットに :cpp:expr:`object(\*static_cast<U\*>(this))` を、キーに :cpp:expr:`object(key)` を束縛した :cpp:class:`!proxy` オブジェクト。


.. cpp:function:: template <class T, class V> proxy<const_object_slice> slice(T const& start, V const& end) const
                  template <class T, class V> proxy<object_slice> slice(T const& start, V const& end)

   :効果: :cpp:expr:`*this` の :cpp:expr:`std::make_pair(object(start), object(end))` が示すスライスにアクセスする。
   :returns: ターゲットに :cpp:expr:`object(\*static_cast<U\*>(this))` を、キーに :cpp:expr:`std::make_pair(object(start), object(end))` を束縛した :cpp:class:`!proxy` オブジェクト。


.. cpp:namespace-pop::


.. _v2.object.object-spec:

:cpp:class:`!object` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:class:: object : public object_operators<object>

   目的は :cpp:class:`!object` が可能な限り Python の変数のように振舞うことである。これにより Python で動作する式は概して C++ でも同じ方法で動作するはずである。:cpp:class:`!object` の大部分のインターフェイスは、基底クラス :cpp:class:`object_operators\<object>` とこのヘッダが定義する\ :ref:`自由関数 <v2.object.functions>`\が提供する。


.. cpp:namespace-push:: object


.. _v2.object.object-spec-synopsis:

:cpp:class:`!object` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace api
   {
     class object : public object_operators<object>
     {
      public:
         object();

         object(object const&);
      
         template <class T>
         explicit object(T const& x);

         ~object();

         object& operator=(object const&); 

         PyObject* ptr() const;

         bool is_none() const;
     };
   }}}


.. _v2.object.object-spec-ctors:

:cpp:class:`!object` クラスのコンストラクタおよびデストラクタ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: object()

   :効果: Python の :py:const:`!None` オブジェクトへの参照を管理するオブジェクトを構築する。
   :例外: なし。


.. cpp:function:: template <class T> explicit object(T const& x)

   :効果: :cpp:var:`!x` を Python に変換し、それへの参照を管理する。
   :throws error_already_set: 上記の変換が不可能な場合（Python の :py:exc:`!TypeError` 例外を設定する）。


.. cpp:function:: ~object()

   :効果: 内部で保持するオブジェクトの参照カウントを減らす。


.. _v2.object.object-spec-modifiers:

:cpp:class:`!object` クラスの変更メソッド
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: object& operator=(object const& rhs)

   :効果: :cpp:var:`!rhs` が保持するオブジェクトの参照カウントを増やし、:cpp:expr:`*this` が保持するオブジェクトの参照カウントを減らす。


.. _v2.object.object-spec-observers:

:cpp:class:`!object` クラスのオブザーバ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: PyObject* ptr() const

   :returns: 内部で保持している Python オブジェクトへのポインタ。


.. cpp:function:: bool is_none() const

   :returns: :cpp:expr:`(ptr() == Py_None)` の結果。


.. cpp:namespace-pop::


.. _v2.object.proxy-spec:

:cpp:class:`!proxy` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:class:: template <class Policies> proxy : public object_operators<proxy<Policies> >

   :cpp:class:`!object` に対する属性、要素およびスライスアクセスを実装するために、このドキュメントで述べた種々のポリシー（Policies）とともにこのテンプレートをインスタンス化する。:cpp:type:`!Policies::key_type` 型のオブジェクトを格納する。


.. cpp:namespace-push:: proxy


.. _v2.object.proxy-spec-synopsis:

:cpp:class:`!proxy` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python { namespace api
     template <class Policies>
     class proxy : public object_operators<proxy<Policies> >
     {
      public:
         operator object() const;

         proxy const& operator=(proxy const&) const;
         template <class T>
         inline proxy const& operator=(T const& rhs) const;
      
         void del() const;

         template <class R>
         proxy operator+=(R const& rhs);
         template <class R>
         proxy operator-=(R const& rhs);
         template <class R>
         proxy operator*=(R const& rhs);
         template <class R>
         proxy operator/=(R const& rhs);
         template <class R>
         proxy operator%=(R const& rhs);
         template <class R>
         proxy operator<<=(R const& rhs);
         template <class R>
         proxy operator>>=(R const& rhs);
         template <class R>
         proxy operator&=(R const& rhs);
         template <class R>
         proxy operator|=(R const& rhs);
     };
   }}}


.. _v2.object.proxy-spec-observers:

:cpp:class:`!proxy` クラステンプレートのオブザーバ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: operator object() const

   :効果: :cpp:expr:`Policies::get(target, key)` にプロキシのターゲットオブジェクトとキーオブジェクトを適用する。


.. _v2.object.proxy-spec-modifiers:

:cpp:class:`!proxy` クラステンプレートの変更関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: proxy const& operator=(proxy const&) const
                  template <class T> inline proxy const& operator=(T const& rhs) const

   :効果: プロキシのターゲットオブジェクトとキーオブジェクトを使用して :cpp:expr:`Policies::set(target, key, object(rhs))`。


.. cpp:function:: template <class R> proxy operator+=(R const& rhs)
                  template <class R> proxy operator-=(R const& rhs)
                  template <class R> proxy operator*=(R const& rhs)
                  template <class R> proxy operator/=(R const& rhs)
                  template <class R> proxy operator%=(R const& rhs)
                  template <class R> proxy operator<<=(R const& rhs)
                  template <class R> proxy operator>>=(R const& rhs)
                  template <class R> proxy operator&=(R const& rhs)
                  template <class R> proxy operator|=(R const& rhs)

   :効果: 与えられた operator@= について、:cpp:expr:`object(*this)` :code:`@=` :cpp:expr:`rhs`
   :returns: :cpp:expr:`*this`


.. cpp:function:: void del() const

   :効果: プロキシのターゲットオブジェクトとキーオブジェクトを使用して :cpp:expr:`Policies::del(target, key)`。


.. cpp:namespace-pop::


.. _v2.object.functions:

関数
----

.. cpp:function:: template <class T> void del(proxy<T> const& x)

   :効果: :cpp:expr:`x.del()`


.. cpp:function:: template<class L,class R> object operator>(L const& l, R const& r)
                  template<class L,class R> object operator>=(L const& l, R const& r)
                  template<class L,class R> object operator<(L const& l, R const& r)
                  template<class L,class R> object operator<=(L const& l, R const& r)
                  template<class L,class R> object operator==(L const& l, R const& r)
                  template<class L,class R> object operator!=(L const& l, R const& r)

   :効果: Python 内で演算子をそれぞれ :cpp:expr:`object(l)` および :cpp:expr:`object(r)` に適用した結果を返す。


.. cpp:function:: template<class L,class R> object operator+(L const& l, R const& r)
                  template<class L,class R> object operator-(L const& l, R const& r)
                  template<class L,class R> object operator*(L const& l, R const& r)
                  template<class L,class R> object operator/(L const& l, R const& r)
                  template<class L,class R> object operator%(L const& l, R const& r)
                  template<class L,class R> object operator<<(L const& l, R const& r)
                  template<class L,class R> object operator>>(L const& l, R const& r)
                  template<class L,class R> object operator&(L const& l, R const& r)
                  template<class L,class R> object operator^(L const& l, R const& r)
                  template<class L,class R> object operator|(L const& l, R const& r)

   :効果: Python 内で演算子をそれぞれ :cpp:expr:`object(l)` および :cpp:expr:`object(r)` に適用した結果を返す。


.. cpp:function:: template<class R> object& operator+=(object& l, R const& r)
                  template<class R> object& operator-=(object& l, R const& r)
                  template<class R> object& operator*=(object& l, R const& r)
                  template<class R> object& operator/=(object& l, R const& r)
                  template<class R> object& operator%=(object& l, R const& r)
                  template<class R> object& operator<<=(object& l, R const& r)
                  template<class R> object& operator>>=(object& l, R const& r)
                  template<class R> object& operator&=(object& l, R const& r)
                  template<class R> object& operator^=(object& l, R const& r)
                  template<class R> object& operator|=(object& l, R const& r)

   :効果: 対応する Python の複合演算子をそれぞれ :cpp:var:`!l` および :cpp:expr:`object(r)` に適用した結果をlに代入する。
   :returns: :cpp:var:`!l`


.. cpp:function:: inline long len(object const& obj)

   :効果: :cpp:expr:`PyObject_Length(obj.ptr())`
   :returns: オブジェクトの :cpp:expr:`len()`


.. _v2.object.examples:

例
--

.. code-block:: python
   :caption: Python のコード

   def sum_items(seq):
      result = 0
      for x in seq:
         result += x
      return result

.. code-block::
   :caption: C++ 版

   object sum_items(object seq)
   {
      object result = object(0);
      for (int i = 0; i < len(seq); ++i)
         result += seq[i];
      return result;
   }
