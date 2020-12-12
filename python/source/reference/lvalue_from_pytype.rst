boost/python/lvalue_from_pytype.hpp
===================================

.. contents::
   :depth: 1
   :local:


.. _v2.lvalue_from_pytype.introduction:

はじめに
--------

:file:`<boost/python/lvalue_from_pypytype.hpp>` は、与えられた型の Python インスタンスから C++ オブジェクトを抽出する機能を提供する。典型的には、「伝統的な」Python の拡張型を取り扱う場合に有用である。


.. _v2.lvalue_from_pytype.classes:

クラス
------

.. _v2.lvalue_from_pytype.lvalue_from_pytype-spec:

:cpp:struct:`!lvalue_from_pytype` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class Extractor, PyTypeObject const* python_type> lvalue_from_pytype

   :cpp:struct:`!lvalue_from_pytype` クラステンプレートは ``from_python`` 変換器を登録する。この変換器は与えられた Python 型のオブジェクトから個々の C++ 型への参照およびポインタを抽出できる。テンプレート引数は次のとおり。

   .. ここの from_python は型名じゃないの？

   以下の説明において :cpp:var:`!x` は :cpp:type:`!PythonObject&` 型のオブジェクトである。\ [#]_

   :tparam Extractor:
      Python オブジェクトから lvalue を抽出する（オブジェクトの型が適合していれば）。

      :要件: 参照型を返す :cpp:func:`!execute` 関数を持つ :ref:`Extractor <concepts.extractor>` モデル。

   :tparam python_type:
      この変換器が変換可能なインスタンスの Python 型。Python の派生型もまた変換可能である。

      :要件: `PyTypeObject <http://docs.python.jp/2/c-api/typeobj.html>`_ コンパイル時定数。


.. cpp:namespace-push:: lvalue_from_pytype


.. _v2.lvalue_from_pytype.lvalue_from_pytype-spec-synopsis:

:cpp:struct:`!lvalue_from_pytype` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      template <class Extractor, PyTypeObject const* python_type>
      struct lvalue_from_pytype
      {
          lvalue_from_pytype();
      };
   }}


.. _v2.lvalue_from_pytype.lvalue_from_pytype-spec-ctors:

:cpp:struct:`!lvalue_from_pytype` クラステンプレートのコンストラクタ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: lvalue_from_pytype()

   :効果: 与えられた型の Python オブジェクトを :cpp:func:`!Extractor::execute` が返す型の lvalue へ変換する変換器を登録する。


.. cpp:namespace-pop::


.. _v2.extract_identity.extract_identity-spec:

:cpp:struct:`!extract_identity` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class InstanceType> extract_identity

   :cpp:struct:`!extract_identity` は、抽出する C++ 型と Python オブジェクト型が同一であるありふれた場合に使用する :cpp:concept:`Extractor` モデルである。


.. cpp:namespace-push:: extract_identity


.. _v2.extract_identity.extract_identity-spec-synopsis:

:cpp:struct:`!extract_identity` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      template <class InstanceType>
      struct extract_identity
      {
         static InstanceType& execute(InstanceType& c);
      };
   }}


.. _v2.extract_identity.extract_identity-spec-statics:

:cpp:struct:`!extract_identity` クラステンプレートの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: InstanceType& execute(InstanceType& c)

   :returns: :cpp:var:`!c`


.. cpp:namespace-pop::


.. _v2.extract_member-spec:

:cpp:struct:`!extract_member` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class InstanceType, class MemberType, MemberType (InstanceType::*member)> extract_member

   :cpp:struct:`!extract_member` は、抽出する C++ 型が Python オブジェクトのメンバであるありふれた場合に使用する :cpp:concept:`Extractor` モデルである。


.. cpp:namespace-push:: extract_member


.. _v2.extract_member.extract_member-spec-synopsis:

:cpp:struct:`!extract_member` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      template <class InstanceType, class MemberType, MemberType (InstanceType::*member)>
      struct extract_member
      {
         static MemberType& execute(InstanceType& c);
      };
   }}

.. _v2.extract_member.extract_member-spec-statics:

:cpp:struct:`!extract_member` クラステンプレートの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: static MemberType& execute(InstanceType& c)

   :returns: :cpp:expr:`c.*member`


.. cpp:namespace-pop::


.. _v2.lvalue_from_pytype.examples:

例
--

以下の例では、Python のドキュメントにある標準的な `noddy モジュール例 <http://docs.python.jp/2/extending/newtypes.html#dnt-basics>`_\を実装したとして、:py:class:`!Noddy` を操作するモジュールをビルドしたいとする。:cpp:type:`!noddy_NoddyObject` は特に気を引くような情報を持たない単純なものであるので、この例は少しばかりわざとらしい（何らかの理由で、特定の 1 つのオブジェクトに対する追跡を維持したいものとする）。このモジュールは :cpp:type:`!noddy_NoddyType` を定義するモジュールに動的にリンクしなければならない。

.. code-block::
   :caption: C++ のモジュール定義

   #include <boost/python/module.hpp>
   #include <boost/python/handle.hpp>
   #include <boost/python/borrowed.hpp>
   #include <boost/python/lvalue_from_pytype.hpp>

   // Python のドキュメントから引っ張り出した定義
   typedef struct {
      PyObject_HEAD
   } noddy_NoddyObject;

   using namespace boost::python;
   static handle<noddy_NoddyObject> cache;

   bool is_cached(noddy_NoddyObject* x)
   {
      return x == cache.get();
   }

   void set_cache(noddy_NoddyObject* x)
   {
      cache = handle<noddy_NoddyObject>(borrowed(x));
   }

   BOOST_PYTHON_MODULE(noddy_cache)
   {
      def("is_cached", is_cached);
      def("set_cache", set_cache);

      // Noddy の lvalue を扱う変換器
      lvalue_from_pytype<extract_identity<noddy_NoddyObject>,&noddy_NoddyType>();
   }

.. code-block:: python
   :caption: Python のコード

   >>> import noddy
   >>> n = noddy.new_noddy()
   >>> import noddy_cache
   >>> noddy_cache.is_cached(n)
   0
   >>> noddy_cache.set_cache(n)
   >>> noddy_cache.is_cached(n)
   1
   >>> noddy_cache.is_cached(noddy.new_noddy())
   0


.. [#] 訳注　:cpp:var:`!x` も :cpp:type:`!PythonObject` も見当たりませんが…。
