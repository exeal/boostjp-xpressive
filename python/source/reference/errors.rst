boost/python/errors.hpp
=======================

.. contents::
   :depth: 1
   :local:


.. _v2.errors.introduction:

はじめに
--------

:file:`<boost/python/errors.hpp>` は、Python と C++ の間で例外を管理、変換するための型と関数を提供する。これは Boost.Python でほぼ内部的にのみ使用している、比較的低水準な機能である。ユーザにはほぼ必要ない。


.. _v2.errors.classes:

クラス
------

.. _v2.errors.error_already_set-spec:

:cpp:class:`!error_already_set` クラス
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:class:: error_already_set

   :cpp:class:`!error_already_set` は、Python のエラーが発生したことを示すのに投げられる例外型である。これが投げられた場合、その事前条件は `PyErr_Occurred() <http://docs.python.jp/2/c-api/exceptions.html#PyErr_Occurred>`_ が ``true`` に変換可能な値を返すことである。移植可能なコードではこの例外型を直接投げるべきではなく、代わりに以下の :cpp:func:`throw_error_already_set()` を使用すべきである。 ::

      namespace boost { namespace python
      {
          class error_already_set {};
      }}


.. _v2.errors.functions:

関数
----

.. cpp:function:: template <class T> \
                  bool handle_exception(T f) noexcept
                  void handle_exception() noexcept

   :要件: 第 1 の形式では、式 `function0 <http://www.boost.org/doc/html/boost/functionN.html>`_\ :code:`<void>(f)` が合法でなければならない。第 2 の形式では、C++ 例外が現在処理中（C++ 標準の 15.1 節を見よ）でなければならない。
   :効果: 第 1 の形式では、:code:`try` ブロック内で :cpp:expr:`f()` を呼び出す。最初にすべての登録済みの\ :doc:`例外変換器 <exception_translator>`\を試す。それらの中で例外を変換できるものがなければ、:code:`catch` 節で捕捉した C++ 例外に対する適切な Python 例外を設定し、例外が投げられた場合は ``true`` を、そうでなければ ``false`` を返す。第 2 の形式は、現在処理中の例外を再スローする関数を第 1 形式に渡す。
   :事後条件: 処理中の例外が 1 つもない
   :例外: なし
   :根拠: 言語間の境界においては、C++ 例外を見逃さないようにすることが重要である。大抵の場合、呼び出し側の言語はスタックを正しい方法で巻き戻す機能を持っていないからである。C++ コードを Python API から直接呼び出すときは、例外変換の管理に常に :cpp:func:`!handle_exception` を使用せよ。大体の関数ラッピング機能（:cpp:func:`make_function()` 、:cpp:func:`make_constructor()` 、:cpp:func:`def()` および :cpp:func:`class_::def()`）は自動的にこれを行う。第 2 形式はより便利（以下の\ :ref:`例 <v2.errors.examples>`\を見よ）だが、内側の :code:`try` ブロックから例外を再スローした場合に問題を起こすコンパイラが多数ある。


.. cpp:function:: template <class T> \
              T* expect_non_null(T* x)

   :returns: :cpp:var:`!x`
   :throws error_already_set(): :cpp:expr:`x == 0` の場合。
   :根拠: エラー発生時に 0 を返す `Python/C API <http://docs.python.jp/2/c-api/index.html>`_ 関数を呼び出すときのエラー処理を容易にする。


.. cpp:function:: void throw_error_already_set()

   :効果: :code:`throw error_already_set();`
   :根拠: 多くのプラットフォームおよびコンパイラでは、共有ライブラリの境界をまたいで投げられた例外を捕捉する首尾一貫した方法がない。Boost.Python ライブラリのこの関数を使用することで、:cpp:func:`handle_exception()` 内で適切な :code:`catch` ブロックが例外を捕捉できる。


.. _v2.errors.examples:

例
--

::

   #include <string>
   #include <boost/python/errors.hpp>
   #include <boost/python/object.hpp>
   #include <boost/python/handle.hpp>

   // obj の "__name__" 属性と同じ値を持つ std::string を返す。
   std::string get_name(boost::python::object obj)
   {
      // __name__ 属性がなければ例外を投げる
      PyObject* p = boost::python::expect_non_null(
         PyObject_GetAttrString(obj.ptr(), "__name__"));

      char const* s = PyString_AsString(p);
      if (s != 0) 
           Py_DECREF(p);

      // Python の文字列でなければ例外を投げる
      std::string result(
         boost::python::expect_non_null(
            PyString_AsString(p)));

      Py_DECREF(p); // p の後始末
   
      return result;
   }

   //
   // handle_exception の第 1 形式のデモンストレーション
   //

   // a と b が同じ "__name__" 属性を持つ場合は 1 、それ以外は 0 の Python Int オブジェクトを
   // result に書き込む。
   void same_name_impl(PyObject*& result, boost::python::object a, boost::python::object b)
   {
      result = PyInt_FromLong(
         get_name(a) == get_name(a2));
   }

   object borrowed_object(PyObject* p)
   {
      return boost::python::object(
           boost::python::handle<>(
                boost::python::borrowed(a1)));
   }

   // Python 'C' API インターフェイス関数の例
   extern "C" PyObject*
   same_name(PyObject* args, PyObject* keywords)
   {
      PyObject* a1;
      PyObject* a2;
      PyObject* result = 0;

      if (!PyArg_ParseTuple(args, const_cast<char*>("OO"), &a1, &a2))
         return 0;
   
      // boost::bind を使用してオブジェクトを boost::Function0<void> 互換にする
      if (boost::python::handle_exception(
            boost::bind<void>(same_name_impl, boost::ref(result), borrowed_object(a1),
   borrowed_object(a2))))
      {
         // 例外が投げられた（Python のエラーが handle_exception() により設定された）
         return 0;
      }

      return result;
   }

   //
   // handle_exception の第 2 形式のデモンストレーション。すべてのコンパイラで
   // サポートされているわけではない。
   //
   extern "C" PyObject*
   same_name2(PyObject* args, PyObject* keywords)
   {
      PyObject* a1;
      PyObject* a2;
      PyObject* result = 0;

      if (!PyArg_ParseTuple(args, const_cast<char*>("OO"), &a1, &a2))
         return 0;

      try {
         return PyInt_FromLong(
            get_name(borrowed_object(a1)) == get_name(borrowed_object(a2)));
      }
      catch(...)
      {
         // 例外が投げられたら、Python へ変換する
         boost::python::handle_exception();
         return 0;
      }
   }
