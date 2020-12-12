boost/python/args.hpp
=====================

.. contents::
   :depth: 1
   :local:


.. _v2.args.introduction:

はじめに
--------

ラップした C++ 関数にキーワード引数を指定する多重定義関数群を提供する。


.. _v2.args.keyword-expression:

:token:`!keyword-expression`
----------------------------

.. productionlist::
   keyword-expression: `see-other-document`

:token:`!keyword-expression` の結果は :term:`ntbs` の列を保持するオブジェクトであり、その型は指定したキーワードの数を符号化する。:token:`!keyword-expression` は保持する一部またはすべてのキーワードについて既定値を持つことが可能である。

.. _v2.args.classes:

クラス
------

.. _v2.args.arg-spec:

arg クラス
^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: arg

   :cpp:struct:`!arg` クラスのオブジェクトは 1 つのキーワードを保持する（サイズが 1 である）\ :token:`!keyword-expression` である。


.. cpp:namespace-push:: arg


.. _v2.args.arg-synopsis:

:cpp:struct:`!arg` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
           struct arg 
           {
             template <class T>
                     arg &operator = (T const &value);
             explicit arg (char const *name){elements[0].name = name;}
           };

   }


.. _v2.args.arg-ctor:

:cpp:struct:`!arg` クラスのコンストラクタ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: arg(char const* name)

   :要件: 引数は :term:`ntbs` でなければならない。
   :効果: 名前 :cpp:var:`!name` のキーワードを保持する :cpp:struct:`!arg` オブジェクトを構築する。


.. _v2.args.arg-operator:

:cpp:struct:`!arg` クラスの :cpp:func:`!operator=` テンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: template <class T> \
                  arg & operator =(T const & value)

   :要件: 引数は Python へ変換可能でなければならない。
   :効果: キーワードの既定値を代入する。
   :returns: :cpp:expr:`this` への参照。


.. cpp:namespace-pop::


.. _v2.args.keyword-expression-operators:

:token:`!keyword-expression` の :cpp:func:`!operator ,`
-------------------------------------------------------

.. cpp:function:: keyword_expression operator ,(keyword_expression, const arg &kw) const
                  keyword_expression operator ,(keyword_expression, const char *name) const

   :要件: 引数 :cpp:var:`!name` は :term:`ntbs` でなければならない。
   :効果: 1 つ以上のキーワードで :token:`!keyword-expression` 引数を拡張する。
   :returns: 拡張した :token:`!keyword-expression`。


.. _v2.args.functions:

関数（非推奨）
--------------

.. _v2.args.args-spec:

args(...)
^^^^^^^^^

.. cpp:function:: unspecified1 args(char const* a0, char const* ...an)

   :要件: 引数はすべて :term:`!ntbs` でなければならない。
   :returns: 渡した引数をカプセル化する :token:`keyword-expression` を表すオブジェクト。


.. _v2.args.examples:

例
--

::

   #include <boost/python/def.hpp>
   using namespace boost::python;

   int f(double x, double y, double z=0.0, double w=1.0);

   BOOST_PYTHON_MODULE(xxx)
   {
      def("f", f
               , ( arg("x"), "y", arg("z")=0.0, arg("w")=1.0 ) 
               );
   }
