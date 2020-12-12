boost/python/exception_translator.hpp
=====================================

.. contents::
   :depth: 1
   :local:


.. _v2.exception_translator.introduction:

はじめに
--------

:ref:`他節 <v2.errors.functions>`\で述べたように、C++ コードが投げた例外が Python のインタープリタコアに渡らないようにすることが重要である。既定では、Boost.Python はラップした関数およびモジュール初期化関数が投げたすべての例外を Python へ変換するが、既定の変換器はきわめて限定的なものである（大半の C++ 例外は、Python においては :code:`'Unidentifiable C++ Exception'` という表現を持つ `RuntimeError <http://www.python.org/doc/current/lib/module-exceptions.html>`_ 例外である）。以下に述べる例外変換器の登録を行うと、より優れたエラーメッセージを生成できる。


.. _v2.exception_translator.functions:

関数
----

.. _v2.exception_translator.register_exception_translator-spec:

:cpp:func:`!register_exception_translator`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: template<class ExceptionType, class Translate> \
                  void register_exception_translator(Translate translate)

   :要件: :cpp:type:`!Translate` は `CopyConstructible <http://www.boost.org/libs/utility/CopyConstructible.html>`_ 、かつ以下のコードが合法。 ::

             void f(ExceptionType x) { translate(x); }

          式 :cpp:expr:`translate(x)` は C++ 例外を投げるか、後続の `PyErr_Occurred() <http://docs.python.jp/2/c-api/exceptions.html>`_ 呼び出しが 1 を返さなければならない。

   :効果: :cpp:var:`!translate` のコピーを例外変換器の列に追加する。この列は Python のコアインタープリタへ渡そうとしている例外を Boost.Python が捕捉したときに試行するものである。新しい変換器は、上で見た :code:`catch` 節群にマッチするすべての例外を変換するときに最初に呼び出される。後で登録した例外変換器は、より前の例外を変換してもよい。与えられた C++ 例外を変換できない変換器は再スローしてもよく、そのような例外はより前に登録した変換器（または既定の変換器）が処理する。


.. _v2.exception_translator.examples:

例
--

::

   #include <boost/python/module.hpp>
   #include <boost/python/def.hpp>
   #include <boost/python/exception_translator.hpp>
   #include <exception>

   struct my_exception : std::exception
   {
     char const* what() throw() { return "どれかの例外"; }
   };

   void translate(my_exception const& e)
   {
       // Python 'C' API を使用して例外オブジェクトをセットアップする
       PyErr_SetString(PyExc_RuntimeError, e.what());
   }

   void something_which_throws()
   {
       ...
       throw my_exception();
       ...
   }

   BOOST_PYTHON_MODULE(exception_translator_ext)
   {
     using namespace boost::python;
     register_exception_translator<my_exception>(&translate);
  
     def("something_which_throws", something_which_throws);
   }
