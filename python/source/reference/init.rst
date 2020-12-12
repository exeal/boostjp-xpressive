boost/python/init.hpp
=====================

.. contents::
   :depth: 1
   :local:


.. _v2.init.introduction:

はじめに
--------

:file:`<boost/python/init.hpp>` は、C++ コンストラクタを Python へ拡張クラスの :py:meth:`!__init__` 関数としてエクスポートするインターフェイスを定義する。


.. _v2.init.init-expressions:

:token:`init-expression`
------------------------

.. productionlist::
   init-expression: `see-other-document`

:token:`init-expression` は、拡張クラスについて生成される :py:meth:`!__init__` メソッド群を記述するのに使用する。結果は以下のプロパティを持つ。

docstring
   モジュールの :py:attr:`!__doc__` 属性に束縛する値を持つ :term:`ntbs`\。
keywords
   生成される :py:meth:`!__init__` 関数の引数（の残りの部分列）に名前をつけるのに使用する :token:`keyword-expression`。
call policies
   :ref:`CallPolicies <concepts.callpolicies>` モデルのインスタンス。
argument types
   ラップした C++ オブジェクトを構築するのに使用する C++ 引数型の MPL 列。:token:`init-expression` は、引数型の接頭辞列が与える\ **合法な接頭辞**\を 1 つ以上持つ。


.. _v2.init.classes:

クラス
------

.. _v2.init.init-spec:

:cpp:class:`!init<T1 = unspecified, T2 = unspecified, ...Tn = unspecified>` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class ...Args> init

   1 つ以上の :py:meth:`!__init__` 関数群を指定するのに使用する `MPL 列 <http://www.boost.org/libs/mpl/doc/refmanual/forward-sequence.html>`_\。末尾の T\ :subscript:`i` のみ :cpp:class:`optional\<>` のインスタンスであってもよい。


.. cpp:namespace-push:: init


.. _v2.init.init-spec-synopsis:

:cpp:class:`!init` クラステンプレートの概要
"""""""""""""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python
   {
     template <T1 = unspecified,...Tn = unspecified>
     struct init
     {
         init(char const* doc = 0);
         template <class Keywords> init(Keywords const& kw, char const* doc = 0);
         template <class Keywords> init(char const* doc, Keywords const& kw);

         template <class CallPolicies>
         unspecified operator[](CallPolicies const& policies) const
     };
   }}


.. _v2.init.init-spec-ctors:

:cpp:class:`!init` クラステンプレートのコンストラクタ
"""""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: init(char const* doc = 0)
                  template <class Keywords> \
                  init(Keywords const& kw, char const* doc = 0)
                  template <class Keywords> \
                  init(char const* doc, Keywords const& kw)

   :要件: :cpp:var:`!doc` は与えられた場合 :term:`ntbs`。:cpp:var:`!kw` は与えられた場合 :token:`keyword-expression` の結果でなければならない。
   :効果: 結果は、docstring が :cpp:var:`!doc` 、keywords が :cpp:var:`!kw` への参照である :token:`init-expression` である。第 1 形式を使用した場合、結果の式の keywords は空。式の call policies は :cpp:class:`default_call_policies` のインスタンス。:cpp:type:`!Tn` が :code:`optional<U1, U2, ...Um>` である場合、式の合法な接頭辞群は次のとおり与えられる。 ::

             (T1, T2,...Tn-1), (T1, T2,...T_n-1  , U1), (T1, T2,...Tn-1  , U1, U2), ...(T1, T2,...Tn-1  , U1, U2,...Um)

          それ以外の場合、式の\ **合法な接頭辞**\はユーザが指定したテンプレート引数で与えたものとなる。


.. _v2.init.init-spec-observers:

:cpp:class:`!init` クラスのオブザーバ関数
"""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: template <class Policies> \
                  unspecified operator[](Policies const& policies) const

   :要件: :cpp:type:`!Policies` は :ref:`CallPolicies <concepts.CallPolicies>` のモデル。
   :効果: :cpp:class:`!init` オブジェクトとすべて同じプロパティを持ち、call policies のみ :cpp:var:`!policies` への参照である新しい :token:`init-expression` を返す。


.. cpp:namespace-pop::


.. _v2.init.optional-spec:

:cpp:class:`!optional<T1 = unspecified, T2 = unspecified, ...Tn = unspecified>` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class ...Args> optional

   :py:meth:`!__init__` 関数の省略可能引数を指定するのに使用する `MPL 列 <http://www.boost.org/libs/mpl/doc/refmanual/forward-sequence.html>`_\。


.. _v2.init.optional-spec-synopsis:

:cpp:class:`!optioanal` クラステンプレートの概要
""""""""""""""""""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python
   {
     template <T1 = unspecified,...Tn = unspecified>
     struct optional {};
   }}


.. _v2.init.examples:

例
--

次の C++ 宣言があるとすると、 ::

   class Y;
   class X
   {
    public:
      X(int x, Y* y) : m_y(y) {}
      X(double);
    private:
      Y* m_y;
   };

以下のように対応する Boost.Python 拡張クラスを作成できる。 ::

   using namespace boost::python;

   class_<X>("X", "X のドキュメンテーション文字列。",
             init<int,char const*>(args("x","y"), "X.__init__ のドキュメンテーション文字列")[
                   with_custodian_and_ward<1,3>()]
             )
      .def(init<double>())
      ;
