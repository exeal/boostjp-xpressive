boost/python/enum.hpp
=====================

.. _v2.enum.introduction:

はじめに
--------

:file:`<boost/python/enum.hpp>` は、ユーザが C++ 列挙型を Python へエクスポートするためのインターフェイスを定義する。エクスポートする列挙型を引数に持つ :cpp:class:`!enum_` クラステンプレートを宣言する。


.. _v2.enum.classes:

クラス
------

.. _v2.enum.enum_-spec:

:cpp:class:`!enum_<T>` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:class:: template<class T> enum_ : public object

   第 1 引数に渡した C++ 型に対応する、Python の :py:class:`!int` 型から派生した Python クラスを作成する。 ::

      namespace boost { namespace python
      {
        template <class T>
        class enum_ : public object
        {
          enum_(char const* name, char const* doc = 0);
          enum_<T>& value(char const* name, T);
          enum_<T>& export_values();
        };
      }}


.. cpp:namespace-push:: enum_


.. _v2.enum.enum_-spec-ctors:

:cpp:class:`!enum_` クラステンプレートのコンストラクタ
""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: enum_(char const* name, char const* doc = 0)

   :要件: :cpp:var:`!name` は Python の\ `識別子の名前付け規約 <http://docs.python.jp/2/reference/lexical_analysis.html#identifiers>`_\にしたがった :term:`ntbs`\。
   :効果: 名前 :cpp:var:`!name` の :py:class:`!int` から派生した Python 拡張型を保持する :cpp:class:`!enum_` オブジェクトを構築する。\ :ref:`現在のスコープ <v2.scope.introduction>`\の名前 :cpp:var:`!name` の属性を新しい列挙型に束縛する。


.. _v2.enum.enum_-spec-modifiers:

:cpp:class:`!enum_` クラステンプレートの変更関数
""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: inline enum_<T>& value(char const* name, T x)

   :要件: :cpp:var:`!name` は Python の\ `識別子の名前付け規約 <http://docs.python.jp/2/reference/lexical_analysis.html#identifiers>`_\にしたがった :term:`ntbs`\。
   :効果: ラップした列挙型のインスタンスを名前 :cpp:var:`!name` 、値 :cpp:var:`!x` とともに型の辞書へ追加する。


.. cpp:function:: inline enum_<T>& export_values()

   :効果: :cpp:func:`!value()` の呼び出しでエクスポートしたすべての列挙値を同じ名前で現在の :cpp:class:`scope` の属性として設定する。
   :returns: :cpp:expr:`*this`


.. cpp:namespace-pop::


.. _v2.enum.examples:

例
--

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/enum.hpp>
   #include <boost/python/def.hpp>
   #include <boost/python/module.hpp>

   using namespace boost::python;

   enum color { red = 1, green = 2, blue = 4 };

   color identity_(color x) { return x; }

   BOOST_PYTHON_MODULE(enums)
   {
       enum_<color>("color")
           .value("red", red)
           .value("green", green)
           .export_values()
           .value("blue", blue)
           ;
    
       def("identity", identity_);
   }

.. code-block:: python
   :caption: Python の対話コード

   >>> from enums import *

   >>> identity(red)
   enums.color.red

   >>> identity(color.red)
   enums.color.red

   >>> identity(green)
   enums.color.green

   >>> identity(color.green)
   enums.color.green

   >>> identity(blue)
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   NameError: name blue' is not defined

   >>> identity(color.blue)
   enums.color.blue

   >>> identity(color(1))
   enums.color.red

   >>> identity(color(2))
   enums.color.green

   >>> identity(color(3))
   enums.color(3)

   >>> identity(color(4))
   enums.color.blue

   >>> identity(1)
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   TypeError: bad argument type for built-in operation
