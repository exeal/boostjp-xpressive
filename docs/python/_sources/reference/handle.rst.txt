boost/python/handle.hpp
=======================

.. contents::
   :depth: 1
   :local:


.. _v2.handle.introduction:

はじめに
--------

:file:`<boost/python/handle.hpp>` は参照カウント付きの Python オブジェクトを管理するスマートポインタである :cpp:class:`!handle` クラステンプレートを提供する。


.. _v2.handle.classes:

クラス
------

.. _v2.handle.handle-spec:

:cpp:class:`!handle` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:class:: template <class T> handle

   :cpp:class:`!handle` は Python のオブジェクト型へのスマートポインタであり、:cpp:type:`!T*` 型のポインタを保持する（:cpp:type:`!T` はそのテンプレート引数）。:cpp:type:`!T` は :c:type:`!PyObject` の派生型か、先頭 :cpp:expr:`sizeof(PyObject)` バイトが :c:type:`PyObject` とレイアウト互換な :term:`POD` 型のいずれかでなければならない。Python/'C' API と高水準コードの境界で :cpp:class:`!handle<>` を使用することだ。一般的なインターフェイスに対しては Python のオブジェクトよりも :cpp:class:`object` を使用すべきだ。

   このドキュメントで「:cpp:expr:`upcast`」は、:cpp:type:`!Y` が :cpp:type:`!T` の派生型の場合 :cpp:expr:`static_castD<T*>` で、そうでない場合 C スタイルのキャストでポインタ :cpp:type:`!Y*` を基底クラスポインタ :cpp:type:`!T*` へ変換する操作を指す。しかしながらYの先頭 :cpp:expr:`sizeof(PyObject)` バイトが PyObject とレイアウト互換でなければ、「:cpp:expr:`upcast`」は違法である。


.. cpp:namespace-push:: handle


.. _v2.handle.handle-spec-synopsis:

:cpp:class:`!handle` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     template <class T>
     class handle
     {
         typedef unspecified-member-function-pointer bool_type;

      public: // 型
         typedef T element_type;

      public: // メンバ関数
         ~handle();

         template <class Y>
         explicit handle(detail::borrowed<null_ok<Y> >* p);

         template <class Y>
         explicit handle(null_ok<detail::borrowed<Y> >* p);

         template <class Y>
         explicit handle(detail::borrowed<Y>* p);

         template <class Y>
         explicit handle(null_ok<Y>* p);

         template <class Y>
         explicit handle(Y* p);

         handle();

         handle& operator=(handle const& r);

         template<typename Y>
         handle& operator=(handle<Y> const & r); // 例外を投げない


         template <typename Y>
         handle(handle<Y> const& r);

         handle(handle const& r);

         T* operator-> () const;
         T& operator* () const;
         T* get() const;
         void reset();
         T* release();

         operator bool_type() const; // 例外を投げない
      private:
         T* m_p;
     };
  
     template <class T> struct null_ok;
     namespace detail { template <class T> struct borrowed; }
   }}


.. _v2.handle.handle-spec-ctors:

:cpp:class:`!handle` クラステンプレートのコンストラクタおよびデストラクタ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: virtual ~handle()

   :効果: :cpp:expr:`Py_XDECREF(upcast<PyObject*>(m_p))`


.. cpp:function:: template <class Y> \
                  explicit handle(detail::borrowed<null_ok<Y> >* p)

   :効果: :cpp:expr:`Py_XINCREF(upcast<PyObject*>(p))`\ :code:`;` :cpp:expr:`m_p = upcast<T*>(p)`


.. cpp:function:: template <class Y> \
                  explicit handle(null_ok<detail::borrowed<Y> >* p)

   :効果: :cpp:expr:`Py_XINCREF(upcast<PyObject*>(p))`\ :code:`;` :cpp:expr:`m_p = upcast<T*>(p)`


.. cpp:function:: template <class Y> \
                  explicit handle(detail::borrowed<Y>* p)

   :効果: :cpp:expr:`Py_XINCREF(upcast<PyObject*>(p))`\ :code:`;` :cpp:expr:`m_p = upcast<T*>(expect_non_null(p))`


.. cpp:function:: template <class Y> \
                  explicit handle(null_ok<Y>* p)

   :効果: :cpp:expr:`m_p = upcast<T*>(p)`


.. cpp:function:: template <class Y> \
                  explicit handle(Y* p)

   :効果: :cpp:expr:`m_p = upcast<T*>(expect_non_null(p))`


.. cpp:function:: handle()

   :効果: :cpp:expr:`m_p = 0`


.. cpp:function:: template <typename Y> \
                  handle(handle<Y> const& r)
                  handle(handle const& r)

   :効果: :cpp:expr:`m_p = r.m_p`\ :code:`;` :cpp:expr:`Py_XINCREF(upcast<PyObject*>(m_p))`


.. _v2.handle.handle-spec-modifiers:

:cpp:class:`!handle` クラステンプレートの変更関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: handle& operator=(handle const& r)
                  template<typename Y> \
                  handle& operator=(handle<Y> const & r) noexcept

   :効果: :cpp:expr:`Py_XINCREF(upcast<PyObject*>(r.m_p))`\ :code:`;` :cpp:expr:`Py_XDECREF( upcast<PyObject*>(m_p))`\ :code:`;` :cpp:expr:`m_p = r.m_p`


.. cpp:function:: T* release()

   :効果: :cpp:expr:`T* x = m_p`\ :code:`;` :cpp:expr:`m_p = 0`\ :code:`; return x`


.. cpp:function:: void reset()

   :効果: :cpp:expr:`*this = handle<T>()`


.. _v2.handle.handle-spec-observers:

:cpp:class:`!handle` クラステンプレートのオブザーバ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: T* operator->() const
                  T* get() const

   :returns: :cpp:expr:`m_p`


.. cpp:function:: T& operator*() const

   :returns: :cpp:expr:`*m_p`


.. cpp:function:: operator bool_type() const noexcept

   :returns: :cpp:expr:`m_p == 0` の場合 0。それ以外の場合、``true`` へ変換可能なポインタ。


.. cpp:namespace-pop::


.. _v2.handle.functions:

関数
----

.. _v2.handle.borrowed-spec:

:cpp:func:`!borrowed`
^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template <class T> detail::borrowed<T>* borrowed(T* p)

   ::

      template <class T>
      detail::borrowed<T>* borrowed(T* p)
      {
          return (detail::borrowed<T>*)p;
      }


.. _v2.handle.allow_null-spec:

:cpp:func:`!allow_null`
^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: template <class T> null_ok<T>* allow_null(T* p)

   ::

      template <class T>
      null_ok<T>* allow_null(T* p)
      {
          return (null_ok<T>*)p;
      }
