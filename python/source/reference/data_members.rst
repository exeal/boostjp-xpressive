boost/python/data_members.hpp
=============================

.. contents::
   :depth: 1
   :local:


.. _v2.data_members.introduction:

はじめに
--------

:cpp:func:`make_getter()` および :cpp:func:`make_setter()` は、:cpp:func:`class_\<>::def_readonly` および :cpp:func:`class_\<>::def_readwrite` が C++ データメンバをラップする Python の呼び出し可能オブジェクトを生成するために内部的に使用する関数である。


.. _v2.data_members.functions:

関数
----

.. _v2.data_members.make_getter-spec:

make_getter
^^^^^^^^^^^

.. cpp:function:: template <class C, class D> \
                  object make_getter(D C::*pm)
                  template <class C, class D, class Policies> \
                  object make_getter(D C::*pm, Policies const& policies)

   :要件: :cpp:type:`!Policies` は :ref:`CallPolicies <concepts.callpolicies>` のモデル。
   :効果: :cpp:type:`!C*` へ ``from_python`` 変換可能な引数 1 つをとり、:cpp:type:`!C` オブジェクトの対応メンバ :cpp:type:`!D` を ``to_python`` 変換したものを返す Python の呼び出し可能オブジェクトを作成する。:cpp:var:`!policies` が与えられた場合、:ref:`ここ <concepts.callpolicies>`\に述べるとおり関数に適用される。それ以外の場合、ライブラリは :cpp:type:`!D` がユーザ定義クラス型か判断し、そうであれば :cpp:type:`!Policies` に対して :cpp:struct:`!return_internal_reference<>` を使用する。:cpp:type:`!D` がスマートポインタ型の場合、このテストで :cpp:struct:`!return_internal_reference<>` が不適当に選択される可能性があることに注意していただきたい。これは既知の欠陥である。
   :returns: 新しい Python の呼び出し可能オブジェクトを保持する :cpp:class:`object` のインスタンス。


.. cpp:function:: template <class D> \
                  object make_getter(D const& d)
                  template <class D, class Policies> \
                  object make_getter(D const& d, Policies const& policies)
                  template <class D> \
                  object make_getter(D const* p)
                  template <class D, class Policies> \
                  object make_getter(D const* p, Policies const& policies)

   :要件: :cpp:type:`!Policies` は :ref:`CallPolicies <concepts.callpolicies>` のモデル。
   :効果: 引数をとらず、必要に応じて ``to_python`` 変換した :cpp:var:`!d` か :cpp:expr:`*p` を返す Python の呼び出し可能オブジェクトを作成する。:cpp:var:`!policies` が与えられた場合、:ref:`ここ <concepts.callpolicies>`\に述べるとおり関数に適用される。それ以外の場合、ライブラリは :cpp:type:`!D` がユーザ定義クラス型か判断し、そうであれば :cpp:type:`!D` に対して :cpp:struct:`reference_existing_object` を使用する。
   :returns: 新しい Python の呼び出し可能オブジェクトを保持する :cpp:class:`object` のインスタンス。


.. _v2.data_members.make_setter-spec:

make_setter
^^^^^^^^^^^

.. cpp:function:: template <class C, class D> \
                  object make_setter(D C::*pm)
                  template <class C, class D, class Policies> \
                  object make_setter(D C::*pm, Policies const& policies)

   :要件: :cpp:type:`!Policies` は :ref:`CallPolicies <concepts.callpolicies>` のモデル。
   :効果: Python の呼び出し可能オブジェクトを作成する。このオブジェクトは Python から呼び出されるときに :cpp:type:`!C*` と :cpp:type:`!D const&` にそれぞれ ``from_python`` 変換可能な 2 つの引数をとり、:cpp:type:`!C` オブジェクトの対応する :cpp:type:`!D` メンバを設定する。:cpp:var:`!policies` が与えられた場合、:ref:`ここ <concepts.callpolicies>`\に述べるとおり関数に適用される。
   :returns: 新しい Python の呼び出し可能オブジェクトを保持する :cpp:class:`object` のインスタンス。


.. cpp:function:: template <class D> \
                  object make_setter(D& d)
                  template <class D, class Policies> \
                  object make_setter(D& d, Policies const& policies)
                  template <class D> \
                  object make_setter(D* p)
                  template <class D, class Policies> \
                  object make_setter(D* p, Policies const& policies)

   :要件: :cpp:type:`!Policies` は :ref:`CallPolicies <concepts.callpolicies>` のモデル。
   :効果: Python から :cpp:type:`!D const&` に変換され、:cpp:var:`!d` または :cpp:expr:`*p` に書き込まれる 1 つの引数を受け取る Python の呼び出し可能オブジェクトを作成する。:cpp:var:`!policies` が与えられた場合、:ref:`ここ <concepts.callpolicies>`\に述べるとおり関数に適用される。
   :returns: 新しい Python の呼び出し可能オブジェクトを保持する :cpp:class:`object` のインスタンス。


.. _v2.data_members.examples:

例
--

以下のコードは、:cpp:func:`!make_getter` および :cpp:func:`!make_setter` を使用してデータメンバを関数としてエクスポートする。 ::

   #include <boost/python/data_members.hpp>
   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>

   struct X
   {
       X(int x) : y(x) {}
       int y;
   };

   using namespace boost::python;

   BOOST_PYTHON_MODULE_INIT(data_members_example)
   {
       class_<X>("X", init<int>())
          .def("get", make_getter(&X::y))
          .def("set", make_setter(&X::y))
          ;
   }

Python から次のように使用する。

.. code-block:: python

   >>> from data_members_example import *
   >>> x = X(1)
   >>> x.get()
   1
   >>> x.set(2)
   >>> x.get()
   2
