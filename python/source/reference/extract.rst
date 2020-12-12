boost/python/extract.hpp
========================

.. contents::
   :depth: 1
   :local:


.. _v2.extract.introduction:

はじめに
--------

一般的な Python オブジェクトから C++ オブジェクトの値を抽出する機構をエクスポートする。:cpp:struct:`!extract<>` は :cpp:class:`object` を特定の :ref:`ObjectWrapper <ObjectWrapper.ObjectWrapper-concept>` に「ダウンキャスト」するのにも使用できるということに注意していただきたい。可変の Python 型について同じ型で呼び出すと（例えば :code:`list([1,2])`）一般的にはその引数の\ **コピー**\が作成されるため、これが元のオブジェクトにおける :ref:`ObjectWrapper <ObjectWrapper.ObjectWrapper-concept>` インターフェイスにアクセスする唯一の方法となる可能性がある。


.. _v2.extract.classes:

クラス
------

.. _v2.extract.extract-spec:

:cpp:struct:`extract` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:struct:: template <class T> extract

   :cpp:struct:`extract<T>` を使用すると :cpp:class:`object` のインスタンスから任意の C++ 型の値を抽出できる。2 つの使用方法をサポートする：

   #. :cpp:expr:`extract<T>(o)` は、:cpp:type:`!T` へ暗黙に変換可能な一時オブジェクトである（オブジェクトの関数呼び出し演算子による明示的な変換も可能である）。しかしながら :cpp:var:`!o` から型 :cpp:type:`!T` のオブジェクトへの変換が利用できない場合は、Python の :py:exc:`!TypeError` 例外を\ :term:`送出する`。
   #. :code:`extract<T> x(o)` は、例外を投げることなく変換が可能か問い合わせる :cpp:func:`~extract::check()` メンバ関数を持つ抽出子を構築する。


.. cpp:namespace-push:: extract


.. _v2.extract.extract-spec-synopsis:

:cpp:struct:`!extract` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     template <class T>
     struct extract
     {
         typedef unspecified result_type;

         extract(PyObject*);
         extract(object const&);

         result_type operator()() const;
         operator result_type() const;

         bool check() const;
     };
   }}


.. _v2.extract.extract-spec-ctors:

:cpp:struct:`!extract` クラステンプレートのコンストラクタおよびデストラクタ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: extract(PyObject* p)
                  extract(object const&)

   :要件: 第 1 形式では :cpp:var:`!p` は非 null でなければならない。
   :効果: コンストラクタの引数が管理する Python オブジェクトへのポインタを格納する。特にオブジェクトの参照カウントは増加しない。抽出子の変換関数が呼び出される前にオブジェクトが破壊されないようにするのはユーザの責任である。


.. _v2.extract.extract-spec-observers:

:cpp:struct:`!extract` クラステンプレートのオブザーバ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: result_type operator()() const
                  operator result_type() const

   :効果: 格納したポインタを :cpp:type:`!result_type` へ変換する。これは :cpp:type:`!T` か :cpp:type:`!T const&` である。
   :returns: 格納したポインタが参照するものに対応する :cpp:type:`!result_type` のオブジェクト。
   :throws error_already_set: そのような変換が不可能な場合（:py:exc:`!TypeError` を設定する）。実際に使用している変換器が未規定の他の例外を投げる可能性がある。

.. cpp:function:: bool check() const

   :事後条件: なし。特に戻り値が ``true`` であっても :cpp:func:`!operator result_type()` か :cpp:func:`!operator()()` が例外を投げないとは限らないことに注意していただきたい。
   :returns: 格納したポインタから :cpp:type:`!T` への変換が不可能な場合のみ ``false``。


.. cpp:namespace-pop::


.. _v2.extract.examples:

例
--

::

   #include <cstdio>
   using namespace boost::python;
   int Print(str s)
   { 
      // Python の文字列オブジェクトから C の文字列を抽出する
      char const* c_str = extract<char const*>(s);

      // printf で印字する
      std::printf("%s\n", c_str);

      // Python の文字列の長さを取得し、整数へ変換する
      return extract<int>(s.attr("__len__")())
   }

以下は :cpp:struct:`!extract<>` と :cpp:class:`class_\<>` を使用して、ラップした C++ クラスのインスタンスを作成しアクセスする例である。 ::

   struct X
   {
      X(int x) : v(x) {}
      int value() { return v; }
    private:
      int v;
   };

   BOOST_PYTHON_MODULE(extract_ext)
   {
       object x_class(
          class_<X>("X", init<int>())
             .def("value", &X::value))
             ;
        
       // Python のインターフェイスを介して X のオブジェクトをインスタンス化する。
       // 寿命は以降、x_objが管理する。
       object x_obj = x_class(3);

       // Python のオブジェクトを使用せずに C++ オブジェクトへの参照を取得する
       X& x = extract<X&>(x_obj);
       assert(x.value() == 3);
   }
