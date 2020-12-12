boost/python/ptr.hpp
====================

.. contents::
   :depth: 1
   :local:


.. _v2.ptr.introduction:

はじめに
--------

:file:`<boost/python/ptr.hpp>` は :cpp:func:`!ptr()` 関数テンプレートを定義する。これによりオーバーライド可能な仮想関数の実装、Python の呼び出し可能オブジェクトの起動、あるいは C++ オブジェクトから Python への明示的な変換において C++ のポインタ値を Python に変換する方法を指定できる。通常、Python のコールバックにポインタを渡すと、Python のオブジェクトが懸垂参照を保持しないようポインタ先はコピーされる。新しい Python のオブジェクトが単にポインタ :cpp:var:`!p` のコピーを持つべきだということを指定するには、ユーザは :cpp:var:`!p` を直接渡すのではなく :cpp:expr:`ptr(p)` を渡すようにする。このインターフェイスは同様に参照のコピーを抑止する `boost::ref() <http://www.boost.org/libs/bind/ref.html>`_ の類似品である。

ptr(p) は :cpp:class:`is_pointer_wrapper\<>` メタ関数で検出可能な :cpp:class:`pointer_wrapper\<>` のインスタンスを返す。:cpp:class:`unwrap_pointer\<>` は :cpp:class:`!pointer_wrapper<>` から元のポインタ型を抽出するメタ関数である。これらのクラスは実装の詳細と考えてよい。


.. _v2.ptr.functions:

ptr
---

.. cpp:function:: template <class T> \
                  pointer_wrapper<T> ptr(T x)

   :要件: :cpp:type:`!T` がポインタ型。
   :returns: :cpp:expr:`pointer_wrapper<T>(x)`
   :例外: なし。


.. _v2.ptr.classes:

クラス
------

.. _v2.ptr.pointer_wrapper-spec:

:cpp:class:`!pointer_wrapper` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:class:: template<class Ptr> pointer_wrapper

   :cpp:func:`ptr()` が返す「型の封筒（envelope）」であり、Python のコールバックへ渡すポインタの参照セマンティクスを示すのに使用する。


.. cpp:namespace-push:: pointer_wrapper


.. _v2.ptr.pointer_wrapper-spec-synopsis:

:cpp:class:`!pointer_wrapper` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       template<class Ptr> class pointer_wrapper
       {
        public:
           typedef Ptr type;

           explicit pointer_wrapper(Ptr x);
           operator Ptr() const;
           Ptr get() const;
       };
   }}


.. _v2.ptr.pointer_wrapper-spec-types:

:cpp:class:`!pointer_wrapper` クラステンプレートの型
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:type:: Ptr type

   ラップするポインタの型。


.. _v2.ptr.pointer_wrapper-spec-ctors:

:cpp:class:`!pointer_wrapper` クラステンプレートのコンストラクタおよびデストラクタ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: explicit pointer_wrapper(Ptr x)

   :要件: :cpp:type:`!Ptr` がポインタ型。
   :効果: :cpp:class:`!pointer_wrapper<>` に :cpp:var:`!x` を格納する。
   :例外: なし。


.. _v2.ptr.pointer_wrapper-spec-observers:

:cpp:class:`!pointer_wrapper` クラステンプレートのオブザーバ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: operator Ptr() const
                  Ptr get() const

   :returns: 格納しているポインタのコピー。
   :根拠: :cpp:class:`!pointer_wrapper<>` は実際のポインタ型の代理を意図しているが、時にはポインタを取得する明示的な方法があったほうがよい。


.. cpp:namespace-pop::


.. _v2.ptr.metafunctions:

メタ関数
--------

.. _v2.ptr.is_pointer_wrapper-spec:

:cpp:class:`!is_pointer_wrapper` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:class:: template<class T> is_pointer_wrapper

   引数が :cpp:class:`!pointer_wrapper<>` である場合に :cpp:member:`!value` が真となる単項メタ関数。

   :戻り値: :cpp:type:`!T` が :cpp:class:`!pointer_wrapper<>` の特殊化であれば ``true``。:cpp:member:`!value` は未規定型の論理値へ変換可能な整数定数。


.. _v2.ptr.is_pointer_wrapper-spec-synopsis:

:cpp:class:`!is_pointer_wrapper` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       template<class T> class is_pointer_wrapper
       { 
           static unspecified value = ...;
       };
   }}


.. _v2.ptr.unwrap_pointer-spec:

:cpp:class:`!unwrap_pointer` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:class:: template<class T> unwrap_pointer

   :cpp:class:`!pointer_wrapper<>` の特殊化からラップしたポインタ型を抽出する単項メタ関数。

   :returns: :cpp:type:`!T` が :cpp:class:`!pointer_wrapper<>` の特殊化の場合、:cpp:type:`!T::type`。それ以外の場合は :cpp:type:`!T`。


.. _v2.ptr.unwrap_pointer-spec-synopsis:

:cpp:class:`!unwrap_pointer` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       template<class T> class unwrap_pointer
       { 
           typedef unspecified type;
       };
   }}


.. _v2.ptr.examples:

例
--

:cpp:func:`!ptr()` を使用してオブジェクトのコピーを抑止する例。 ::

   #include <boost/python/call.hpp>
   #include <boost/python/ptr.hpp>

   class expensive_to_copy
   {
      ...
   };

   void pass_as_arg(expensive_to_copy* x, PyObject* f)
   {
      // Python の関数 f を呼び出し、*x を「ポインタで」参照する
      // Python オブジェクトを渡す。
      //
      // *** 注意：*x を f() の引数として使用した後も延命させるのは ***
      // *** ユーザの責任である！失敗するとクラッシュする！         ***

      boost::python::call<void>(f, ptr(x));
   }
   ...
