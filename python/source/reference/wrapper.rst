boost/python/wrapper.hpp
========================

.. contents::
   :depth: 1
   :local:


.. _v2.wrapper.introduction:

はじめに
--------

仮想関数を「Python でオーバーライド」可能なクラス :cpp:class:`!T` をラップするため、つまり C++ から仮想関数を呼び出すときに Python における派生クラスの当該メソッドが呼び出されるよう、これらの仮想関数を Python から呼び出せるようオーバーライドする C++ ラッパクラスをTから派生させて作成しなければならない。このヘッダのクラスを使用して、そういった作業を容易にできる。


.. _v2.wrapper.classes:

クラス
------

.. _v2.wrapper.override-spec:

:cpp:class:`override` クラス
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:class:: override : object

   C++ 仮想関数の Python オーバーライドをカプセル化する。:cpp:class:`!override` オブジェクトは Python の呼び出し可能オブジェクトか :py:const:`!None` のいずれかを保持する。


.. cpp:namespace-push:: override


.. _v2.wrapper.override-spec-synopsis:

:cpp:class:`!override` クラスの概要
"""""""""""""""""""""""""""""""""""

::

   namespace boost
   {
     class override : object
     {
      public:
         unspecified operator() const;
         template <class A0>
         unspecified operator(A0) const;
         template <class A0, class A1>
         unspecified operator(A0, A1) const;
         ...
         template <class A0, class A1, ...class An>
         unspecified operator(A0, A1, ...An) const;
     };
   };


.. _v2.wrapper.override-spec-observers:

:cpp:class:`!override` クラスのオブザーバ関数
"""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: template<class ...Args> \
                  unspecified operator()(Args) const

   :効果: :cpp:expr:`*this` が Python の呼び出し可能オブジェクトを保持している場合、\ :doc:`ここ <callbacks>`\に示す方法で指定した引数で呼び出す。それ以外の場合、:cpp:class:`error_already_set` を投げる。
   :returns: Python の呼び出し結果を保持する未規定型のオブジェクト。C++ 型 :cpp:type:`!R` への変換は、結果のオブジェクトの :cpp:type:`!R` への変換により行われる。変換に失敗した場合、:cpp:class:`error_already_set` を投げる。

   .. v2.callbacks が原文から無くなった。原文でもリンクが切れてる

   .. 'R' って何？


.. cpp:namespace-pop::


.. _v2.wrapper.wrapper-spec:

:cpp:class:`!wrapper` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:class:: wrapper

   ラッパクラスを :cpp:type:`!T` と :cpp:class:`!wrapper<T>` の両方から派生することで、その派生クラスの記述が容易になる。


.. cpp:namespace-push:: wrapper


.. _v2.wrapper.wrapper-spec-synopsis:

:cpp:class:`!wrapper` クラステンプレートの概要
""""""""""""""""""""""""""""""""""""""""""""""

::

   namespace boost
   {
     class wrapper
     {
      protected:
         override get_override(char const* name) const;
     };
   };


.. _v2.wrapper.wrapper-spec-observers:

:cpp:class:`!wrapper` クラステンプレートのオブザーバ関数
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: override get_override(char const* name) const

   :要件: :cpp:var:`!name` は :term:`ntbs`。
   :returns: Python 派生クラスインスタンスが名前 :cpp:var:`!name` の関数をオーバーライドしているとして、:cpp:expr:`*this` がその C++ 基底クラスのサブオブジェクトである場合、Python のオーバーライドに委譲する :cpp:class:`!override` オブジェクトを返す。それ以外の場合、:py:const:`!None` を保持する :cpp:class:`!override` オブジェクトを返す。


.. cpp:namespace-pop::


.. _v2.wrapper.examples:

例
--

::

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/wrapper.hpp>
   #include <boost/python/call.hpp>

   using namespace boost::python;

   // 純粋仮想関数を 1 つ持つクラス
   struct P
   {
       virtual ~P(){}
       virtual char const* f() = 0;
       char const* g() { return "P::g()"; }
   };

   struct PCallback : P, wrapper<P>
   {
       char const* f()
       {
   #if BOOST_WORKAROUND(BOOST_MSVC, <= 1300) // vc6/vc7 のための workaround
           return call<char const*>(this->get_override("f").ptr());
   #else 
           return this->get_override("f")();
   #endif 
       }
   };

   // 非純粋仮想関数を 1 つ持つクラス
   struct A
   {
       virtual ~A(){}
       virtual char const* f() { return "A::f()"; }
   };

   struct ACallback :  A, wrapper<A>
   {
       char const* f()
       {
           if (override f = this->get_override("f"))
   #if BOOST_WORKAROUND(BOOST_MSVC, <= 1300) // vc6/vc7 のための workaround
               return call<char const*>(f.ptr());
   #else 
               return f();
   #endif 

           return A::f();
       }

       char const* default_f() { return this->A::f(); }
   };

   BOOST_PYTHON_MODULE_INIT(polymorphism)
   {
       class_<PCallback,boost::noncopyable>("P")
           .def("f", pure_virtual(&P::f))
           ;

       class_<ACallback,boost::noncopyable>("A")
           .def("f", &A::f, &Acallback::default_f)
           ;
   }
