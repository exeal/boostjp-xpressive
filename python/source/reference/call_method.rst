boost/python/call_method.hpp
============================

.. contents::
   :depth: 1
   :local:


.. _v2.call_method.introduction:

はじめに
--------

:file:`<boost/python/call_method.hpp>` は、C++ から Python の呼び出し可能属性を起動する :cpp:func:`call_method` 関数テンプレート多重定義群を定義する。


.. _v2.call_method.functions:

関数
----

.. _v2.call_method.call_method-spec:

call_method
^^^^^^^^^^^

.. cpp:function:: template <class R, class ...Args> \
                  R call_method(PyObject* self, char const* method, Args const&)

   :要件: :cpp:type:`!R` はポインタ型、参照型、またはアクセス可能なコピーコンストラクタを持つ完全型。
   :効果: Python 内で :code:`self.method(a1, a2, ...an)` を起動する。:py:obj:`!a1` … :py:obj:`!an` は :cpp:func:`!call_method()` に対する引数で、Python のオブジェクトに変換したもの。完全なセマンティクスの説明については、:ref:`このページ <v2.callbacks>`\を見よ。
   :returns: Python の呼び出し結果を C++ の型 :cpp:type:`!R` に変換したもの。
   :根拠: 下の例で見るように、Python でオーバーライド可能な C++ 仮想関数を実装するのに重要である。


.. _v2.call_method.examples:

例
--

以下の C++ コードは、:cpp:func:`!call_method` を使用して Python でオーバーライド可能な仮想関数を持つクラスをラップする方法を示している。

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>
   #include <boost/utility.hpp>
   #include <cstring>

   // ラップするクラス
   class Base
   {
    public:
      virtual char const* class_name() const { return "Base"; }
      virtual ~Base();
   };

   bool is_base(Base* b)
   {
      return !std::strcmp(b->class_name(), "Base");
   }

   // ここからラッパコード
   using namespace boost::python;

   // コールバッククラス
   class Base_callback : public Base
   {
    public:
      Base_callback(PyObject* self) : m_self(self) {}

      char const* class_name() const { return call_method<char const*>(m_self, "class_name"); }
      char const* Base_name() const { return Base::class_name(); }
    private:
      PyObject* const m_self;
   };

   using namespace boost::python;
   BOOST_PYTHON_MODULE(my_module)
   {
       def("is_base", is_base);

       class_<Base,Base_callback, noncopyable>("Base")
           .def("class_name", &Base_callback::Base_name)
           ;

   }

.. code-block:: python
   :caption: Python のコード

   >>> from my_module import *
   >>> class Derived(Base):
   ...    def __init__(self):
   ...       Base.__init__(self)
   ...    def class_name(self):
   ...       return self.__class__.__name__
   ... 
   >>> is_base(Base()) # C++ から class_name() メソッドを呼び出す
   1
   >>> is_base(Derived())
   0
