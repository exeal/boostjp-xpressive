boost/python/stl_iterator.hpp
=============================

.. contents::
   :depth: 1
   :local:


.. _v2.stl_iterator.introduction:

はじめに
--------

:file:`<boost/python/stl_iterator.hpp>` は、Python の走査可能オブジェクトから C++ のイテレータを作成する型を提供する。


.. _v2.stl_iterator.classes:

クラス
------

.. _v2.stl_iterator.stl_input_iterator-spec:

:cpp:struct:`!stl_input_iterator` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class ValueType> stl_input_iterator

   :cpp:struct:`!stl_input_iterator<T>` のインスタンスは Python のイテレータを保持し、それを STL アルゴリズムで使用できるよう適合させる。:cpp:struct:`!stl_input_iterator<T>` は\ `入力イテレータ <http://www.sgi.com/tech/stl/InputIterator.html>`_\の要件を満たす。

   :tparam ValueType:
      :cpp:struct:`!stl_input_iterator<T>` のインスタンスを参照剥がしすると :cpp:type:`!ValueType` 型の rvalue が返る。

      :要件: :cpp:type:`!ValueType` がコピー構築可能でなければならない。


.. cpp:namespace-push:: stl_input_iterator


.. _v2.stl_iterator.stl_input_iterator-spec-synopsis:

:cpp:struct:`!stl_input_iterator` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     template <class ValueType>
     struct stl_input_iterator
     {
         typedef std::ptrdiff_t difference_type;
         typedef ValueType value_type;
         typedef ValueType* pointer;
         typedef ValueType reference;
         typedef std::input_iterator_tag iterator_category;

         stl_input_iterator();
         stl_input_iterator(object const& ob);

         stl_input_iterator& operator++();
         stl_input_iterator operator++(int);

         ValueType operator*() const;

         friend bool operator==(stl_input_iterator const& lhs, stl_input_iterator const& rhs);
         friend bool operator!=(stl_input_iterator const& lhs, stl_input_iterator const& rhs);
     private:
         object it; // 説明のためにのみ記載
         object ob; // 説明のためにのみ記載
     };
   }}


.. _v2.stl_iterator.stl_input_iterator-spec-constructors:

:cpp:struct:`!stl_input_iterator` クラステンプレートのコンストラクタ
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: stl_input_iterator()

   :効果: シーケンスの終端を表すのに使用する、末尾の直後を指す入力イテレータを作成する。
   :事後条件: :cpp:expr:`this` が末尾の直後。
   :例外: なし。


.. cpp:function:: stl_input_iterator(object const& ob)

   :効果: :cpp:expr:`ob.attr("__iter__")()` を呼び出し、結果の Python のイテレータオブジェクトを :cpp:expr:`this->it` に格納する。次に :cpp:expr:`this->it.attr("next")()` を呼び出し、結果を :cpp:expr:`this->ob` に格納する。シーケンスに走査するものが残っていない場合は :cpp:expr:`this->ob` に :cpp:expr:`object()` を設定する。
   :事後条件: :cpp:expr:`this` が参照剥がし可能か末尾の直後。


.. _v2.stl_iterator.stl_input_iterator-spec-modifiers:

:cpp:struct:`stl_input_iterator` クラステンプレートの変更メソッド
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: stl_input_iterator& operator++()

   :効果: :cpp:expr:`this->it.attr("next")()` を呼び出し、結果を :cpp:expr:`this->ob` に格納する。シーケンスに走査するものが残っていない場合は :cpp:expr:`this->ob` に :cpp:expr:`object()` を設定する。
   :事後条件: :cpp:expr:`this` が参照剥がし可能か末尾の直後。
   :returns: :cpp:expr:`*this`。


.. cpp:function:: stl_input_iterator operator++(int)

   :効果: :code:`stl_input_iterator tmp = *this; ++*this; return tmp;`
   :事後条件: :cpp:expr:`this` が逆参照可能か末尾の直後。


.. _v2.stl_iterator.stl_input_iterator-spec-observers:

:cpp:struct:`stl_input_iterator` クラステンプレートのオブザーバ
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

.. cpp:function:: ValueType operator*() const

   :効果: シーケンス内の現在の要素を返す。
   :returns: :cpp:expr:`extract<ValueType>(this->ob)`


.. cpp:function:: friend bool operator==(stl_input_iterator const& lhs, stl_input_iterator const& rhs)

   :効果: 両方のイテレータが参照剥がし可能であるか両方のイテレータが末尾の直後であれば真、それ以外は偽を返す。
   :returns: :cpp:expr:`(lhs.ob == object()) == (rhs.ob == object())`


.. cpp:function:: friend bool operator!=(stl_input_iterator const& lhs, stl_input_iterator const& rhs)

   :効果: 両方のイテレータが参照剥がし可能であるか両方のイテレータが末尾の直後であれば偽、それ以外は真を返す。
   :returns: :cpp:expr:`!(lhs == rhs)`


.. cpp:namespace-pop::


.. _v2.stl_iterator.examples:

例
--

::

   #include <boost/python/object.hpp>
   #include <boost/python/stl_iterator.hpp>

   #include <list>

   using namespace boost::python;
   std::list<int> sequence_to_int_list(object const& ob)
   {
       stl_input_iterator<int> begin(ob), end;
       return std::list<int>(begin, end);
   }
