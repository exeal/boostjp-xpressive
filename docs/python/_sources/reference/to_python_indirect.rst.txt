boost/python/to_python_indirect.hpp
===================================

.. contents::
   :depth: 1
   :local:

.. _v2.to_python_indirect.introduction:

はじめに
--------

:file:`<boost/python/to_python_indirect.hpp>` は、ラップした C++ クラスインスタンスをポインタかスマートポインタで保持する新しい Python オブジェクトを構築する手段を提供する。


.. _v2.to_python_indirect.classes:

クラス
------

.. _v2.to_python_indirect.to_python_indirect-spec:

:cpp:struct:`!to_python_indirect` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class T, class MakeHolder> to_python_indirect

   :cpp:struct:`!to_python_indirect` クラステンプレートは第 1 引数型のオブジェクトを拡張クラスのインスタンスとして Python に変換する。第 2 引数で与えた所有権ポリシーを使用する。

   以下において :cpp:var:`!x` は型 :cpp:type:`!T` のオブジェクト、:cpp:var:`!h` は :cpp:type:`!boost::python::objects::instance_holder*` 型のオブジェクト、:cpp:var:`!p` は型 :cpp:type:`!U*` のオブジェクトである。

   :tparam T:
      :cpp:class:`class_` クラステンプレートで Python へエクスポートする C++ クラスを参照剥がしする型。

      :要件: :cpp:type:`!U cv&`\（:samp:`{cv}` は省略可能な CV 指定子）か、:cpp:expr:`*x` が :cpp:type:`!U const&` に変換可能な :ref:`Dereferenceable <concepts.dereferenceable>` 型のいずれか（:cpp:type:`!U` はクラス型）。

   :tparam MakeHolder:
      静的関数 :cpp:func:`!execute()` が :cpp:class:`!instance_holder` を作成するクラス。

      :要件: :cpp:expr:`h = MakeHolder::execute(p)`

   :cpp:struct:`!to_python_indirect` のインスタンスは :ref:`ResultConverter <ResultConverter.ResultConverter-concept>` のモデルである。


.. cpp:namespace-push:: to_python_indirect


.. _v2.to_python_indirect.to_python_indirect-spec-synopsis:

:cpp:struct:`!to_python_indirect` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     template <class T, class MakeHolder>
     struct to_python_indirect
     {
        static bool convertible();
        PyObject* operator()(T ptr_or_reference) const;
      private:
        static PyTypeObject* type();
     };
   }}


.. _v2.to_python_indirect.to_python_indirect-spec-observers:

:cpp:struct:`!to_python_indirect` クラステンプレートのオブザーバ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: PyObject* operator()(T x) const

   :要件: :cpp:var:`!x` はオブジェクトへの参照（ポインタ型の場合、非 null)。かつ :cpp:expr:`convertible() == true`。
   :効果: 適切に型付けされた Boost.Python 拡張クラスのインスタンスを作成し、:cpp:type:`!MakeHolder` を使用して :cpp:var:`!x` から :cpp:class:`instance_holder` を作成する。次に新しい拡張クラスインスタンス内に :cpp:class:`!instance_holder` をインストールし、最後にそれへのポインタを返す。


.. _v2.to_python_indirect.to_python_indirect-spec-statics:

:cpp:struct:`!to_python_indirect` クラステンプレートの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: bool convertible()

   :効果: いずれかのモジュールが :cpp:type:`!U` に対応する Python 型を登録していれば ``true``。


.. cpp:namespace-pop::


.. _v2.to_python_indirect.examples:

例
--

:cpp:struct:`!reference_existing_object` の機能をコンパイル時のエラーチェックを省いて模造した例。 ::

   struct make_reference_holder
   {
      typedef boost::python::objects::instance_holder* result_type;
      template <class T>
      static result_type execute(T* p)
      {
         return new boost::python::objects::pointer_holder<T*, T>(p);
      }
   };

   struct reference_existing_object
   {
      // ResultConverter を返すメタ関数
      template <class T>
      struct apply
      {
         typedef boost::python::to_python_indirect<T,make_reference_holder> type;
      };
   };
