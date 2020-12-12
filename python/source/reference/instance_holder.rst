boost/python/instance_holder.hpp
================================

.. contents::
   :depth: 1
   :local:


.. _v2.instance_holder.introduction:

はじめに
--------

:file:`<boost/python/instance_holder.hpp>` は、ラップするクラスの C++ インスタンスを保持する型の基底クラスである :cpp:class:`!instance_holder` クラスを提供する。


.. _v2.instance_holder.classes:

クラス
------

.. _v2.instance_holder.instance_holder-spec:

:cpp:class:`!instance_holder` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:class:: instance_holder : noncopyable

   :cpp:class:`!instance_holder` は、その具象派生クラスが Python のオブジェクトラッパ内で C++ クラスインスタンスを保持する抽象基底クラスである。Python 内で C++ クラスラッパからの多重継承を可能にするために、そのような各 Python オブジェクトは数珠繋ぎの :cpp:class:`!instance_holder` を持つ。ラップする C++ クラスの :py:meth:`!__init__` 関数が呼び出されると新しい :cpp:class:`!instance_holder` インスタンスが作成され、その :cpp:func:`~instance_holder::install()` 関数を使用して Python オブジェクトにインストールされる。:cpp:class:`!instance_holder` の各具象派生クラスは、保持する型について Boost.Python が問い合わせできるよう :cpp:func:`~instance_holder::holds()` の実装を提供しなければならない。保持する型をラップするコンストラクタをサポートするため、クラスは所有する Python オブジェクトを第 1 引数 :c:type:`!PyObject*` として受け取り、残りの引数を保持する型のコンストラクタに転送するコンストラクタも提供しなければならない。第 1 引数は Python 内で仮想関数をオーバーライド可能にするのに必要であり、:cpp:class:`!instance_holder` 派生クラスによっては無視される可能性がある。


.. cpp:namespace-push:: instance_holder


.. _v2.instance_holder.instance_holder-spec-synopsis:

:cpp:class:`!instance_holder` クラスの概要\ [#]_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     class instance_holder : noncopyable
     {
      public:
         // デストラクタ
         virtual ~instance_holder();

         // instance_holder の変更関数
         void install(PyObject* inst) throw();

         // instance_holder のオブザーバ
         virtual void* holds(type_info) = 0;
     };
   }}


.. _v2.instance_holder.instance_holder-spec-ctors:

:cpp:class:`!instance_holder` クラスのデストラクタ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: virtual ~instance_holder()

   :効果: オブジェクトを破壊する。


.. _v2.instance_holder.instance_holder-spec-modifiers:

:cpp:class:`!instance_holder` クラスの変更関
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: void install(PyObject* inst) noexcept

   :要件: :cpp:var:`!inst` が、ラップする C++ クラス型かその派生型の Python のインスタンスである。
   :効果: 新しいインスタンスを、保持するインスタンスの Python オブジェクトの数珠繋ぎの先頭にインストールする。
   :例外: なし。


.. _v2.instance_holder.instance_holder-spec-observers:

:cpp:class:`!instance_holder` クラスのオブザーバ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: virtual void* holds(type_info x = 0)

   :returns: :cpp:expr:`*this` がオブジェクトを保持している場合、:cpp:var:`!x` が示す型のオブジェクトへのポインタ。それ以外の場合 0。


.. cpp:namespace-pop::


.. _v2.instance_holder.examples:

例
--

以下の例は、Boost.Python がスマートポイントが保持するクラスをラップするのに使用しているインスタンスホルダテンプレートの簡易バージョンである。 ::

   template <class SmartPtr, class Value>
   struct pointer_holder : instance_holder
   {
      // SmartPtr 型から構築する
      pointer_holder(SmartPtr p)
          :m_p(p)

      // 保持する型の転送コンストラクタ
      pointer_holder(PyObject*)
          :m_p(new Value())
      {
      }

      template<class A0>
      pointer_holder(PyObject*,A0 a0)
          :m_p(new Value(a0))
      {
      }

      template<class A0,class A1>
      pointer_holder(PyObject*,A0 a0,A1 a1)
          :m_p(new Value(a0,a1))
      {
      }
      ...

    private: // ホルダに必要な実装
      void* holds(type_info dst_t)
      {
          // SmartPtr 型のインスタンスと...
          if (dst_t == python::type_id<SmartPtr>())
              return &this->m_p;

          // ...SmartPtr の element_type インスタンス
          // （ポインタが非 null の場合）を保持する
          return python::type_id<Value>() == dst_t ? &*this->m_p : 0;
      }

    private: // データメンバ
      SmartPtr m_p;
   };


.. [#] 訳注　`noncopyable <http://www.boost.org/doc/libs/utility/utility.htm#Class_noncopyable>`_
