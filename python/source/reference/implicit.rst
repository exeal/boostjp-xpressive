boost/python/implicit.hpp
=========================

.. _v2.implicit.introduction:

はじめに
--------

:cpp:func:`!implicitly_convertible` は、Python オブジェクトを C++ 引数型に対して照合するとき、C++ の暗黙・明示的な変換について暗黙的な利用を可能にする。


.. _v2.implicit.functions:

関数
----

.. _v2.implicit.implicitly_convertible-spec:

:cpp:func:`!implicitly_convertible` 関数テンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template <class Source, class Target> \
                  void implicitly_convertible()

   :tparam Source: 暗黙の変換における元の型
   :tparam Target: 暗黙の変換における対象の型
   :要件: 宣言 :code:`Target t(s);` が合法である（:cpp:var:`!s` は :cpp:type:`!Source` 型）。
   :効果: :cpp:type:`!Source` の rvalue を生成する登録済み変換器が 1 つでも存在する場合、あらゆる :cpp:expr:`PyObject* p` について変換が成功する :cpp:type:`!Target` rvalue への ``from_python`` 変換器を登録する。
   :根拠: C++ ユーザは、C++ で行っているような相互運用性を Python で利用できると考える。


.. _v2.implicit.examples:

例
--

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/class.hpp>
   #include <boost/python/implicit.hpp>
   #include <boost/python/module.hpp>

   using namespace boost::python;

   struct X
   {
       X(int x) : v(x) {}
       operator int() const { return v; }
       int v;
   };

   int x_value(X const& x)
   {
       return x.v;
   }

   X make_x(int n) { return X(n); }

   BOOST_PYTHON_MODULE(implicit_ext)
   {
       def("x_value", x_value);
       def("make_x", make_x);

       class_<X>("X", 
           init<int>())
           ;

       implicitly_convertible<X,int>();
       implicitly_convertible<int,X>();
   }

.. code-block:: python
   :caption: Python のコード

   >>> from implicit_ext import *
   >>> x_value(X(42))
   42
   >>> x_value(42)
   42
   >>> x = make_x(X(42))
   >>> x_value(x)
   42
