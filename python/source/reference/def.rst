boost/python/def.hpp
====================

.. contents::
   :depth: 1
   :local:


.. _v2.def.introduction:

はじめに
--------

:cpp:func:`def()` は現在の :cpp:class:`scope` で C++ の関数や呼び出し可能オブジェクトを Python の関数としてエクスポートする関数である。


.. _v2.def.functions:

関数
----

.. cpp:function:: template <class Fn> \
                  void def(char const* name, Fn fn)
                  template <class Fn, class A1> \
                  void def(char const* name, Fn fn, A1 const&)
                  template <class Fn, class A1, class A2> \
                  void def(char const* name, Fn fn, A1 const, A2 const&)
                  template <class Fn, class A1, class A2, class A3> \
                  void def(char const* name, Fn fn, A1 const&, A2 const&, A3 const&)

   :要件: :cpp:var:`!name` は Python の\ `識別子の名前付け規約 <http://docs.python.jp/2/reference/lexical_analysis.html#identifiers>`_\にしたがった :term:`ntbs`\。

          * :cpp:type:`!Fn` が :cpp:class:`object` かその派生型である場合、現在のスコープに多重定義の1つとして追加される。:cpp:var:`!fn` は\ `呼び出し可能 <http://docs.python.jp/2/library/functions.html#callable>`_\でなければならない。
          * :cpp:var:`!a1` が :token:`overload-dispatch-expression` の結果である場合、有効なのは 2 番目の形式のみであり :cpp:var:`!fn` は\ :term:`引数長`\が :cpp:type:`!A1` の\ :ref:`最大引数長 <v2.overloads.overload-dispatch-expression>`\と同じ関数へのポインタかメンバ関数へのポインタでなければならない。

   :効果: :cpp:type:`!Fn` の引数型列の接頭辞 :samp:`{P}` それぞれについて、その長さが :cpp:type:`!A1` の\ :ref:`最小引数長 <v2.overloads.overload-dispatch-expression>`\であるものから、\ :doc:`現在のスコープ <scope>`\に :code:`name(...)` 関数の多重定義を追加する。生成された各多重定義は、:cpp:var:`!a1` の<link linkend="v2.CallPolicies">呼び出しポリシー</link>のコピーを使用して :cpp:var:`!a1` の :token:`call-expression` を :samp:`{P}` とともに呼び出す。:cpp:type:`!A1` の合法な接頭辞の最長のものが :samp:`{N}` 個の型を有しており :cpp:var:`!a1` が :samp:`{N}` 個のキーワードを保持しているとすると、各多重定義の先頭の :samp:`{N}` - :samp:`{M}` 個の引数に使用される。

          それ以外の場合、:cpp:var:`!fn` は null でない関数へのポインタかメンバ関数へのポインタでなければならず、\ :doc:`現在のスコープ <scope>`\に :cpp:var:`!fn` の多重定義を 1 つ追加する。:cpp:var:`!a1` から :cpp:var:`!a3` のいずれかが与えられた場合、下表から任意の順番であってよい。

          .. list-table::
             :header-rows: 1

             * - 名前
               - 要件・型の特性
               - 効果
             * - docstring
               - :term:`ntbs`\。
               - 値は結果の多重定義メソッドの :py:attr:`!__doc__` 属性に束縛される。
             * - policies
               - :ref:`CallPolicies <concepts.callpolicies>` のモデル
               - 結果の多重定義メソッドの呼び出しポリシーとしてコピーが使用される。
             * - keywords
               - :cpp:var:`!fn` の\ :term:`引数長`\を超えることがないことを指定する :token:`keyword-expression` の結果。
               - 結果の多重定義メソッドの呼び出しポリシーとしてコピーが使用される。


.. _v2.def.examples:

例
--

::

   #include <boost/python/def.hpp>
   #include <boost/python/module.hpp>
   #include <boost/python/args.hpp>

   using namespace boost::python;

   char const* foo(int x, int y) { return "foo"; }

   BOOST_PYTHON_MODULE(def_test)
   {
       def("foo", foo, args("x", "y"), "foo のドキュメンテーション文字列");
   }
