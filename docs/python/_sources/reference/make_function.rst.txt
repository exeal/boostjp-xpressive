boost/python/make_function.hpp
==============================

.. _v2.make_function.introduction:

はじめに
--------

:cpp:func:`make_function()` および :cpp:func:`make_constructor()` は、:cpp:func:`def()` および :cpp:func:`class_\<>::def()` が C++ の関数およびメンバ関数をラップする Python の呼び出し可能オブジェクトを生成するのに内部的に使用する関数である。


.. _v2.make_function.functions:

関数
----

.. _v2.make_function.make_function-spec:

make_function
^^^^^^^^^^^^^

.. cpp:function:: template <class F> \
                  object make_function(F f)
                  template <class F, class Policies> \
                  object make_function(F f, Policies const& policies)
                  template <class F, class Policies, class KeywordsOrSignature> \
                  object make_function(F f, Policies const& policies, KeywordsOrSignature const& ks)
                  template <class F, class Policies, class Keywords, class Signature> \
                  object make_function(F f, Policies const& policies, Keywords const& kw, Signature const& sig)

   :要件: :cpp:type:`!F` は関数ポインタ、またはメンバ関数ポインタ型。:cpp:var:`!policies` が与えられた場合、:ref:`CallPolicies <concepts.callpolicies>` のモデルでなければならない。:cpp:var:`!keywords` が与えられた場合、:cpp:var:`!f` の\ :term:`引数長`\を超えない :token:`keyword-expression` の結果でなければならない。
   :効果: Python の呼び出し可能オブジェクトを作成する。このオブジェクトは Python から呼び出されると、引数を C++ に変換してfを呼び出す。:cpp:type:`!F` がメンバ関数へのポインタ型の場合、Python の第 1 引数が関数呼び出しの対象オブジェクト（:cpp:expr:`*this`）となり、残りの Python 引数は :cpp:var:`!f` に対する引数となる。

          * :cpp:var:`!policies` が与えられた場合、:ref:`ここ <concepts.callpolicies>`\に述べるとおり関数に適用する。
          * :cpp:var:`!keywords` が与えられた場合、結果の関数における最後の引数に適用する。
          * :cpp:type:`!Signature` が与えられた場合、\ `MPL の先頭拡張可能列 <http://www.boost.org/libs/mpl/doc/refmanual/front-extensible-sequence.html>`_\のインスタンスでなければならない。列の先頭が関数の戻り値型、後続が引数の型である。シグニチャが推論できない関数オブジェクト型をラップする場合や、ラップする関数に渡す型をオーバーライドしたい場合は :cpp:type:`!Signature` を渡すとよい。

   :returns: 新しい Python の呼び出し可能オブジェクトを保持する :cpp:class:`object` のインスタンス。

   .. note::
      ポインタ型の引数は、Python から :py:const:`!None` が渡された場合に ``0`` となる可能性がある。``const`` な参照型の引数は、ラップした関数を呼び出す間だけに生存する Python オブジェクトから作成された一時オブジェクトを指す可能性がある。例えば Python のリストからの変換過程で生成した :cpp:class:`!std::vector` がそうである。永続的な lvalue が必要な場合は、非 ``const`` 参照の引数を使うとよい。


.. _v2.make_function.make_constructor-spec:

make_constructor
^^^^^^^^^^^^^^^^

.. cpp:function:: template <class F> \
                  object make_constructor(F f)
                  template <class F, class Policies> \
                  object make_constructor(F f, Policies const& policies)
                  template <class F, class Policies, class KeywordsOrSignature> \
                  object make_constructor(F f, Policies const& policies, KeywordsOrSignature const& ks)
                  template <class F, class Policies, class Keywords, class Signature> \
                  object make_constructor(F f, Policies const& policies, Keywords const& kw, Signature const& sig)

   :要件: :cpp:type:`!F` は関数ポインタ型。:cpp:var:`!policies` が与えられた場合、:ref:`CallPolicies <concepts.callpolicies>` のモデルでなければならない。:cpp:var:`!keywords` が与えられた場合、:cpp:var:`!f` の\ :term:`引数長`\を超えない :token:`keyword-expression` の結果でなければならない。
   :効果: Python から呼び出されると引数を C++ に変換して :cpp:var:`!f` を呼び出す、Python の呼び出し可能オブジェクトを作成する。
   :returns: 新しい Python の呼び出し可能オブジェクトを保持する :cpp:class:`object` のインスタンス。


.. _v2.make_function.examples:

例
--

以下でエクスポートする C++ 関数は、2 つの関数のうち 1 つをラップする呼び出し可能オブジェクトを返す。 ::

   #include <boost/python/make_function.hpp>
   #include <boost/python/module.hpp>

   char const* foo() { return "foo"; }
   char const* bar() { return "bar"; }

   using namespace boost::python;
   object choose_function(bool selector)
   {
       if (selector)
           return boost::python::make_function(foo);
       else
           return boost::python::make_function(bar);
   }

   BOOST_PYTHON_MODULE(make_function_test)
   {
       def("choose_function", choose_function);
   }

Python からは次のように使用する。

.. code-block:: python

   >>> from make_function_test import *
   >>> f = choose_function(1)
   >>> g = choose_function(0)
   >>> f()
   'foo'
   >>> g()
   'bar'
