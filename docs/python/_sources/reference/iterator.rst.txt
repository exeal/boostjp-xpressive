boost/python/iterator.hpp
=========================

.. contents::
   :depth: 1
   :local:


.. _v2.iterator.introduction:

はじめに
--------

:file:`<boost/python/iterator.hpp>` は、C++ の\ `コンテナ <http://www.sgi.com/tech/stl/Container.html>`_\と\ `イテレータ <http://www.sgi.com/tech/stl/Iterators.html>`_\から `Python のイテレータ <http://docs.python.jp/2/library/stdtypes.html#typeiter>`_\を作成するための型と関数を提供する。ある :cpp:class:`!class_` がランダムアクセスイテレータをサポートする場合、この機能を使用するより `__getitem__ <http://docs.python.jp/2/reference/datamodel.html#sequence-types>`_\（シーケンスプロトコルともいう）を実装したほうがよい。Python は自動的にイテレータ型を作成し（`iter() <http://docs.python.jp/2/library/functions.html#iter>`_ を見よ）、各アクセスは範囲チェックが行われ、不正な C++ イテレータを介してアクセスする可能性もない。


.. _v2.iterator.classes:

クラス
------

.. _v2.iterator.iterator-spec:

:cpp:struct:`!iterator` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class Container, class NextPolicies = unspecified> \
                iterator : object

   :cpp:struct:`!iterator<C, P>` のインスタンスは、呼び出し可能な Python オブジェクトへの参照を保持する。このオブジェクトは Python から呼び出され、:cpp:type:`!C` へ変換可能な単一の引数 :cpp:var:`!c` を受け取り、[:cpp:expr:`c.begin()`,\ :cpp:expr:`c.end()`) を走査する Python イテレータを作成する。省略可能な :ref:`CallPolicies <concepts.callpolicies>` である :cpp:type:`!P` は、走査中に要素をどのように返すか制御するのに使用する。

   以下の説明において、:cpp:var:`!c` は :cpp:type:`!Container` のインスタンスである。

   :tparam Container:
      結果はその引数を :cpp:var:`!c` に変換し、:cpp:expr:`c.begin()` および :cpp:expr:`c.end()` を呼び出しイテレータを得る。:cpp:type:`!Container` の :code:`const` 版 :cpp:func:`!begin()` および :cpp:func:`!end()` 関数を呼び出すには :code:`const` でなければならない。

      :要件: [:cpp:expr:`c.begin()`,\ :cpp:expr:`c.end()`) が合法な\ `イテレータ範囲 <http://www.sgi.com/tech/stl/Iterators.html>`_\である。

   :tparam NextPolicies:
      結果のイテレータの :cpp:func:`!next()` メソッドに適用される。

      :要件: :ref:`CallPolicies <concepts.callpolicies>` のデフォルトコンストラクト可能なモデル。
      :既定: 常に内部的な C++ イテレータを逆参照した結果のコピーを作成する、未規定の :ref:`CallPolicies <concepts.callpolicies>` モデル。


.. cpp:namespace-push:: iterator


.. _v2.iterator.iterator-spec-synopsis:

:cpp:class:`!iterator` クラステンプレートの概要
"""""""""""""""""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python
   {
     template <class Container
                , class NextPolicies = unspecified>
     struct iterator : object
     {
         iterator();
     };
   }}


.. _v2.iterator.iterator-spec-constructors:

:cpp:class:`!iterator` クラステンプレートのコンストラクタ
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: iterator()

   :効果: 基底クラスを以下の結果で初期化する。

          .. code-block::

             range<NextPolicies>(&iterators<Container>::begin, &iterators<Container>::end)

   :事後条件: :cpp:expr:`this->get()` は、上記のとおり Python のイテレータを作成する Python の呼び出し可能オブジェクトを指す。
   :根拠: ラップする C++ クラスが :cpp:func:`!begin()` および :cpp:func:`!end()` を持つようなありふれた場合について、イテレータを容易に作成する方法を提供する。


.. cpp:namespace-pop::


.. _v2.iterator.iterators-spec:

:cpp:struct:`!iterators` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class C> iterators

   引数の :cpp:func:`!begin()` および :cpp:func:`!end()` メンバ関数を確実に呼び出す方法を提供するユーティリティクラスである。C++ 標準ライブラリにおけるコンテナについて、メンバ関数のアドレスを取る移植可能な方法はないので、それらをラップする場合に :cpp:struct:`!iterators<>` は特に有効である。

   以下の表において、:cpp:var:`!x` は :cpp:type:`!C` のインスタンスである。

   .. list-table::
      :header-rows: 1

      * - 要求する合法な式
        - 型
      * - :cpp:expr:`x.begin()`
        - :cpp:type:`!C` が :code:`const` な型であれば :cpp:type:`!C::const_iterator` へ変換可能。そうでなければ :cpp:type:`!C::iterator` へ変換可能。
      * - :cpp:expr:`x.end()`
        - :cpp:type:`!C` が :code:`const` な型であれば :cpp:type:`!C::const_iterator` へ変換可能。そうでなければ :cpp:type:`!C::iterator` へ変換可能。


.. cpp:namespace-push:: iterators


.. _v2.iterator.iterators-spec-synopsis:

:cpp:struct:`!iterators` クラステンプレートの概要
"""""""""""""""""""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python
   {
     template <class C>
     struct iterators
     {
         typedef typename C::[const_]iterator iterator;
         static iterator begin(C& x);
         static iterator end(C& x);
     };
   }}


.. _v2.iterator.iterators-spec-types:

:cpp:struct:`!iterators` クラステンプレートの入れ子型
"""""""""""""""""""""""""""""""""""""""""""""""""""""

:cpp:type:`!C` が :code:`const` 型の場合、 ::

   typedef typename C::const_iterator iterator;

それ以外の場合、 ::

   typedef typename C::iterator iterator;


.. _v2.iterator.iterators-spec-statics:

:cpp:struct:`!iterators` クラステンプレートの静的関数
"""""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: static iterator begin(C&)

   :returns: :cpp:expr:`x.begin()`


.. cpp:function:: static iterator end(C&)

   :returns: :cpp:expr:`x.end()`


.. cpp:namespace-pop::


.. _v2.iterator.functions:

関数
----

.. cpp:function:: template <class NextPolicies, class Target, class Accessor1, class Accessor2> \
                  object range(Accessor1 start, Accessor2 finish)
                  template <class NextPolicies, class Accessor1, class Accessor2> \
                  object range(Accessor1 start, Accessor2 finish)
                  template <class Accessor1, class Accessor2> \
                  object range(Accessor1 start, Accessor2 finish)

   :要件: :cpp:type:`!NextPolicies` は、デフォルトコンストラクト可能な :ref:`CallPolicies <concepts.callpolicies>` モデル。
   :効果: 第 1 形式は Python の呼び出し可能オブジェクトを作成する。このオブジェクトは呼び出されるとその引数を :cpp:type:`!Target` オブジェクト :cpp:var:`!x` に変換し、[`bind <http://www.boost.org/libs/bind/bind.html>`_\ :cpp:expr:`(start,_1)(x)`,\ `bind <http://www.boost.org/libs/bind/bind.html>`_\ :cpp:expr:`(finish,_1)(x)`) を走査する Python のイテレータを作成する。イテレータの :cpp:func:`!next()` 関数には :cpp:func:`!NextPolicies` を適用する。第 2 形式は、以下のように :cpp:type:`!Accessor1` から :cpp:type:`!Target` を推論する点以外は第 1 形式と同じである。

          * :cpp:type:`!Accessor1` が関数型の場合、:cpp:type:`!Target` はその第 1 引数の型。
          * :cpp:type:`!Accessor1` がデータメンバポインタ :cpp:type:`!R (T::\*)` の場合、:cpp:type:`!Target` は :cpp:type:`!T` と同じ。
          * :cpp:type:`!Accessor1` がメンバ関数ポインタ :cpp:type:`!R (T::\*)(arguments...) cv-opt`\（:samp:`{cv-opt}` は省略可能な :token:`cv-qualifier`\）の場合、:cpp:type:`!Target` は :cpp:type:`!T` と同じ。

          第 3 形式は、:cpp:type:`!NextPolicies` が常に内部的な C++ イテレータを逆参照した結果のコピーを作成する :ref:`CallPolicies <concepts.CallPolicies>` の未規定のモデルであること以外は第 2 形式と同じである。

   :根拠: `boost::bind() <http://www.boost.org/libs/bind/bind.html>`_ を使用することで、関数、メンバ関数、データメンバポインタを通じて C++ イテレータへアクセスできる。ラップしたクラス型のシーケンス要素のコピーが高コストな場合、:cpp:type:`!NextPolicies` のカスタマイズが有効である（例えば :cpp:struct:`return_internal_reference` を使用する）。:cpp:type:`!Accessor1` が関数オブジェクトであるか、対象型の基底クラスが他から推論される場合は、:cpp:type:`!Target` のカスタマイズが有効である。


.. _v2.iterator.examples:

例
--

::

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>

   #include <vector>

   using namespace boost::python;
   BOOST_PYTHON_MODULE(demo)
   {
       class_<std::vector<double> >("dvec")
           .def("__iter__", iterator<std::vector<double> >())
           ;
   }

より包括的な例が以下にある。

* :file:`http://www.boost.org/libs/python/test/iterator.cpp`
* :file:`http://www.boost.org/libs/python/test/input_iterator.cpp`
* :file:`http://www.boost.org/libs/python/test/input_iterator.py`
