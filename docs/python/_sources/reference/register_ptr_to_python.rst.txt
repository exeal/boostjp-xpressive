boost/python/register_ptr_to_python.hpp
=======================================

.. contents::
   :depth: 1
   :local:


.. _v2.register_ptr_to_python.introduction:

はじめに
--------

:file:`<boost/python/register_ptr_to_python.hpp>` は、スマートポインタから Python への変換を登録する関数テンプレート :cpp:func:`!register_ptr_to_python` を提供する。結果の Python オブジェクトは変換したスマートポインタのコピーを保持するが、参照先のラップ済みコピーであるかのように振舞う。参照先の型が仮想関数を持ちそのクラスが動的（最派生）型を表現する場合、Python のオブジェクトは最派生型に対するラッパのインスタンスとなる。1 つの参照先クラスに対して 2 つ以上のスマートポインタ型を登録可能である。

Python の :cpp:type:`!X` オブジェクトを :cpp:type:`!smart_ptr<X>&`\（非 const 参照）へ変換するため、組み込む C++ オブジェクトは :cpp:type:`!smart_ptr<X>` が保持しなければならない。またラップしたオブジェクトを Python からコンストラクタを呼び出して作成するとき、どのように保持するかは :cpp:class:`!class_<>` インスタンスの :cpp:type:`!HeldType` 引数で決められることに注意していただきたい。


.. _v2.register_ptr_to_python.functions:

関数
----

.. cpp:function:: template <class P> \
                  void register_ptr_to_python()

   :要件: :cpp:type:`!P` が :ref:`Dereferenceable <concepts.dereferenceable>`。
   :効果: :cpp:type:`!P` のインスタンスの Python への変換を可能にする。


.. _v2.register_ptr_to_python.examples:

例
--

C++ のラッパコード
^^^^^^^^^^^^^^^^^^

以下の例は仮想関数を持つクラス :cpp:struct:`!A` と、:cpp:class:`!boost::shared_ptr<A>` を扱う関数を持つモジュールである。 ::

   struct A
   {
       virtual int f() { return 0; }
   };

   shared_ptr<A> New() { return shared_ptr<A>( new A() ); }

   int Ok( const shared_ptr<A>& a ) { return a->f(); }

   int Fail( shared_ptr<A>& a ) { return a->f(); }

   struct A_Wrapper: A
   {
       A_Wrapper(PyObject* self_): self(self_) {}
       int f() { return call_method<int>(self, "f"); }    
       int default_f() { return A::f(); }    
       PyObject* self;
   };

   BOOST_PYTHON_MODULE(register_ptr)
   {
       class_<A, A_Wrapper>("A")
           .def("f", &A::f, &A_Wrapper::default_f)
       ;

       def("New", &New);
       def("Ok", &Call);
       def("Fail", &Fail);
    
       register_ptr_to_python< shared_ptr<A> >();
   }


Python のコード
^^^^^^^^^^^^^^^

.. code-block:: python

   >>> from register_ptr import *
   >>> a = A()
   >>> Ok(a)     # OK 、shared_ptr<A> として渡した
   0
   >>> Fail(a)   # shared_ptr<A>& として渡してしまった（Python 内で作成したのだった！）
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   TypeError: bad argument type for built-in operation
   >>> 
   >>> na = New()   # ここで "na" は実際は shared_ptr<A>
   >>> Ok(a)
   0
   >>> Fail(a)
   0
   >>> 

:cpp:type:`!shared_ptr<A>` を以下のように登録したとすると、 ::

       class_<A, A_Wrapper, shared_ptr<A> >("A")
           .def("f", &A::f, &A_Wrapper::default_f)
       ;

:cpp:type:`!shared_ptr<A>` を :cpp:type:`!shared_ptr<A_Wrapper>` に変換しようとするとエラーになる。

.. code-block:: python

   >>> a = New()
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   TypeError: No to_python (by-value) converter found for C++ type: class boost::shared_ptr<struct A>
   >>> 
