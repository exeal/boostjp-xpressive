boost/python/call.hpp
=====================

.. contents::
   :depth: 1
   :local:


.. _v2.call.introduction:

はじめに
--------

:file:`<boost/python/call.hpp>` は、C++ から Python の呼び出し可能オブジェクトを起動する :cpp:func:`call` 関数テンプレート多重定義群を定義する。


.. _v2.call.functions:

関数
----

.. _v2.call.call-spec:

call
^^^^

.. cpp:function:: template <class R, class ...Args> \
                  R call(PyObject* callable, Args const&)

   :要件: :cpp:type:`!R` はポインタ型、参照型、またはアクセス可能なコピーコンストラクタを持つ完全型。
   :効果: Python 内で :code:`callable(a1, a2, ...an)` を起動する。:py:obj:`!a1` … :py:obj:`!an` は :cpp:func:`!call()` に対する引数で、Python のオブジェクトに変換したもの。
   :returns: Python の呼び出し結果を C++ の型 :cpp:type:`!R` に変換したもの。
   :根拠: 完全なセマンティクスの説明と根拠については、:ref:`このページ <v2.callbacks>`\を見よ。


.. _v2.call.examples:

例
--

以下の C++ 関数は、Python の呼び出し可能オブジェクトをその 2 つの引数に適用し結果を返す。Python の例外が送出した場合や結果を :cpp:type:`!double` に変換できない場合は例外を投げる。 ::

   double apply2(PyObject* func, double x, double y)
   {
      return boost::python::call<double>(func, x, y);
   }
