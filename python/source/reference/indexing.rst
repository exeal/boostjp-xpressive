添字アクセスのサポート
======================

.. contents::
   :depth: 1
   :local:

.. rubric:: ヘッダ <boost/python/indexing/indexing_suite.hpp> 、ヘッダ <boost/python/indexing/vector_indexing_suite.hpp>

.. _v2.indexing.introduction:

はじめに
--------

indexing は、添字アクセス可能（indexable）な C++ コンテナを Python へ容易にエクスポートするための Boost.Python の機能である。添字アクセス可能なコンテナとは :cpp:func:`!operator[]` によりランダムアクセス可能なコンテナである（例：:cpp:class:`!std::vector`）。

:cpp:class:`!std::vector` のようなどこにでもある添字アクセス可能な C++ コンテナを Python へエクスポートするのに必要な機能は Boost.Python はすべて有しているが、その方法はあまり直感的ではない。Python のコンテナから C++ コンテナへの変換は容易ではない。Python のコンテナを Boost.Python を使用して C++ 内でエミュレート（Python リファレンスマニュアルの「\ `コンテナ型をエミュレートする <http://docs.python.jp/2/library/stdtypes.html#str-unicode-list-tuple-bytearray-buffer-xrange>`_\」を見よ）するのは簡単ではない。C++ コンテナを Python へ変換する以前に考慮すべきことが多数ある。これには :py:meth:`!__len__` 、:py:meth:`!__getitem__` 、:py:meth:`!__setitem__` 、:py:meth:`!__delitem__` 、:py:meth:`!__iter__` および :py:meth:`!__contains__` メソッドに対するラッパ関数の実装が含まれる。

目的は、

#. 添字アクセス可能な C++ コンテナの振る舞いを、Python コンテナの振る舞いに一致させる。
#. :cpp:expr:`c[i]` が変更可能であるといった、コンテナ要素のインデクス（:py:meth:`!__getitem__`）に対する既定の参照セマンティクスを提供する。要件は以下のとおり（:cpp:func:`!m` は非 const（可変）メンバ関数（メソッド））。 ::

      val = c[i]
      c[i].m()
      val == c[i]

#. :py:meth:`!__getitem__` から安全な参照を返す：後でコンテナに追加、コンテナから削除しても懸垂参照が発生しない（Python をクラッシュさせない）。
#. スライスの添字をサポート。
#. 適切な場合は Python のコンテナ引数（例：:cpp:class:`!list` 、:cpp:class:`!tuple`）を受け付ける。
#. 再定義可能なポリシークラスによる拡張性。
#. ほとんどの STL および STL スタイルの添字アクセス可能なコンテナに対する定義済みサポートを提供する。


.. _v2.indexing.interface:

Boost.Python の indexing インターフェイス
-----------------------------------------

.. _v2.indexing.indexing_suite:

indexing_suite［ヘッダ <boost/python/indexing/indexing_suite.hpp>］
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:cpp:class:`!indexing_suite` クラスは、Python に調和させる C++ コンテナを管理するための基底クラスである。目的は C++ コンテナの外観と振る舞いを Python コンテナのそれに一致させることである。このクラスは自動的に（Python リファレンスの「\ `コンテナ型をエミュレートする <http://docs.python.jp/2/library/stdtypes.html#str-unicode-list-tuple-bytearray-buffer-xrange>`_\」の）Python の特殊メソッドをラップする。

:py:meth:`!__len__`\(:py:obj:`!self`)
   組み込み関数 :py:func:`!len()` を実装するために呼び出される。オブジェクトの長さ（0 以上の整数）を返さなければならない。また :py:meth:`!__nonzero__()` メソッドを定義せず :py:meth:`!__len__()` メソッドが 0 を返すオブジェクトは、論理値の文脈で偽として扱われる。
:py:meth:`!__getitem__`\(:py:obj:`!self`, :py:obj:`!key`)
   :code:`self[key]` の評価を実装するために呼び出される。シーケンス型では、受け取るキーは整数およびスライスオブジェクトでなければならない。負の添字に対する特殊な解釈（クラスがシーケンス型をエミュレートする場合）は :py:meth:`!__getitem__()` メソッドの仕事であることに注意していただきたい。:py:obj:`!key` が不適な型な場合は :py:exc:`!TypeError` を送出し、値が（負の値に対する特殊な解釈の後）シーケンスの添字の集合外である場合は :py:exc:`!IndexError` を送出しなければならない。注意：シーケンスの終了を適切に検出するため、:code:`for` ループは不正な添字に対して :py:exc:`!IndexError` が送出することを想定している。
:py:meth:`!__setitem__`\(:py:obj:`!self`, :py:obj:`!key`, :py:obj:`!value`)
   :code:`self[key]` への代入を実装するために呼び出される。注意すべき点は :py:meth:`!__getitem__()` と同じである。このメソッドは、マップ型についてはオブジェクトがキーに対する値の変更をサポートするか新しいキーを追加可能な場合、シーケンス型については要素が置換可能な場合のみ実装すべきである。不適な :py:obj:`!key` 値に対しては :py:meth:`!__getitem__()` メソッドと同様の例外を送出しなければならない。
:py:meth:`!__delitem__`\(:py:obj:`!self`, :py:obj:`!key`)
   :code:`self[key]` の削除を実装するために呼び出される。注意すべき点は :py:meth:`!__getitem__()` と同じである。このメソッドは、マップ型についてはオブジェクトがキーの削除をサポートする場合、シーケンス型については要素をシーケンスから削除可能な場合のみ実装すべきである。不適な :py:obj:`!key` 値に対しては :py:meth:`!__getitem__()` メソッドと同様の例外を送出しなければならない。
:py:meth:`!__iter__`\(:py:obj:`!self`)
   このメソッドは、コンテナに対してイテレータが要求されたときに呼び出される。このメソッドは、コンテナ内のすべてのオブジェクトを走査する新しいイテレータオブジェクトを返さなければならない。マップ型については、コンテナのキーを走査しなければならず、:py:meth:`!iterkeys()` メソッドとしても利用可能でなければならない。

   イテレータオブジェクトもまたこのメソッドを実装する必要があり、自分自身を返さなければならない。イテレータオブジェクトの詳細については、\ `Python ライブラリリファレンス <https://docs.python.jp/3/library/index.html>`_\の「\ `イテレータ型 <https://docs.python.jp/3/library/stdtypes.html#iterator-types>`_\」を見よ。
:py:meth:`!__contains__`\(:py:obj:`!self`, :py:obj:`!item`)
   メンバ関係テスト操作を実装するために呼び出される。:py:obj:`!self` 内に :py:obj:`!item` があれば真を、そうでなければ偽を返さなければならない。マップ型オブジェクトについては、値やキー・値の組ではなくキーを対象とすべきである。


.. _v2.indexing.indexing_suite_subclasses:

indexing_suite の派生クラス
---------------------------

.. contents::
   :depth: 1
   :local:

:cpp:class:`!indexing_suite` はそのままで使用することを意図していない。:cpp:class:`!indexing_suite` の派生クラスにより 2 、3 のポリシー関数を提供しなければならない。しかしながら、標準的な添字アクセス可能な STL コンテナのための :cpp:class:`!indexing_suite` 派生クラス群が提供されている。ほとんどの場合、単に定義済みのクラス群を使用すればよい。場合によっては必要に応じて定義済みクラスを改良してもよい。

.. _v2.indexing.vector_indexing_suite:

vector_indexing_suite［ヘッダ <boost/python/indexing/vector_indexing_suite.hpp>］
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:cpp:class:`!vector_indexing_suite` クラスは、:cpp:class:`!std::vector` クラス（および :cpp:class:`!std::vector` スタイルのクラス（例：:cpp:class:`!std::vector` のインターフェイスを持つクラス））をラップするために設計された定義済みの :cpp:class:`!indexing_suite` 派生クラスである。:cpp:class:`!indexing_suite` が要求するポリシーをすべて提供する。

.. code-block::
   :caption: 使用例

   class X {...};
   ...

   class_<std::vector<X> >("XVec")
       .def(vector_indexing_suite<std::vector<X> >())
   ;

:cpp:class:`!XVec` は完全な Python コンテナとなる（完全な例と Python のテストも見よ）。


.. _v2.indexing.map_indexing_suite:

map_indexing_suite［ヘッダ <boost/python/indexing/map_indexing_suite.hpp>］
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

:cpp:class:`!map_indexing_suite` クラスは、:cpp:class:`!std::map` クラス（および :cpp:class:`!std::map` スタイルのクラス（例：:cpp:class:`!std::map` のインターフェイスを持つクラス））をラップするために設計された定義済みの :cpp:class:`!indexing_suite` 派生クラスである。:cpp:class:`!indexing_suite` が要求するポリシーをすべて提供する。

.. code-block::
   :caption: 使用例

   class X {...};
   ...

   class_<std::map<X> >("XMap")
       .def(map_indexing_suite<std::map<X> >())
   ;

既定では添字アクセスした要素はプロキシで返される。:cpp:type:`!NoProxy` テンプレート引数で ``true`` を与えるとこれは無効化できる。:cpp:class:`!XMap` は完全な Python コンテナとなる（\ `完全な例 <http://www.boost.org/libs/python/test/map_indexing_suite.cpp>`_\と `Python のテスト <http://www.boost.org/libs/python/test/map_indexing_suite.py>`_\も見よ）。


.. _v2.indexing.indexing_suite_class:

indexing_suite クラス
---------------------

.. cpp:class:: template <class Container, class DerivedPolicies, \
               bool NoProxy = false, bool NoSlice = false, \
               class Data = typename Container::value_type, \
               class Index = typename Container::size_type, \
               class Key = typename Container::value_type> \
               indexing_suite : unspecified

   :tparam Container:
      Python に対してラップするコンテナ型。

      :要件: クラス型

   :tparam DerivedPolicies:
      ポリシーフックを提供する派生クラス群。以下の :ref:`v2.indexing.DerivedPolicies` を見よ。

      :要件: :cpp:class:`!indexing_suite` の派生クラス

   :tparam NoProxy:
      既定では添字アクセスした要素は Python の参照のセマンティクスを持ち、プロキシにより返される。これは :cpp:var:`!NoProxy` テンプレート引数に真を与えることで無効化できる。

      :要件: 論理値
      :既定: ``false``

   :tparam NoSlice:
      スライスを許可しない。

      :要件: 論理値
      :既定: ``false``

   :tparam Data:
      コンテナのデータ型。

      :既定: :cpp:type:`!Container::value_type`

   :tparam Index:
      コンテナの添字型。

      :既定: :cpp:type:`!Container::size_type`

   :tparam Key:
      コンテナのキー型。

      :既定: :cpp:type:`!Container::value_type`

   ::

      template <
            class Container
          , class DerivedPolicies
          , bool NoProxy = false
          , bool NoSlice = false
          , class Data = typename Container::value_type
          , class Index = typename Container::size_type
          , class Key = typename Container::value_type
      >
      class indexing_suite
          : unspecified
      {
      public:

          indexing_suite(); // デフォルトコンストラクタ
      }


.. _v2.indexing.DerivedPolicies:

:cpp:type:`!DerivedPolicies`
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

派生クラスは :cpp:class:`!indexing_suite` が必要なフックを提供する。 ::

   data_type&
   get_item(Container& container, index_type i);

   static object
   get_slice(Container& container, index_type from, index_type to);

   static void
   set_item(Container& container, index_type i, data_type const& v);

   static void
   set_slice(
       Container& container, index_type from,
       index_type to, data_type const& v
   );

   template <class Iter>
   static void
   set_slice(Container& container, index_type from,
       index_type to, Iter first, Iter last
   );

   static void
   delete_item(Container& container, index_type i);

   static void
   delete_slice(Container& container, index_type from, index_type to);

   static size_t
   size(Container& container);

   template <class T>
   static bool
   contains(Container& container, T const& val);

   static index_type
   convert_index(Container& container, PyObject* i);

   static index_type
   adjust_index(index_type current, index_type from,
       index_type to, size_type len
   );

これらのポリシーの大部分は自己説明的であるが、:cpp:func:`!convert_index` と :cpp:func:`!adjust_index` は少し説明が必要である。

:cpp:func:`!convert_index` は Python の添字をコンテナが処理可能な C++ の添字に変換する。例えば Python における負の添字は右から数え始める（例：:code:`C[-1]` は :py:obj:`!C` 内の最も右の要素を差す）。:cpp:func:`!convert_index` は C++ コンテナのために必要な変換を処理しなければならない（例：``-1`` は :cpp:expr:`C.size()-1` である）。:cpp:func:`!convert_index` はまた、添字の型（Python の動的型）を C++ コンテナが想定する実際の型に変換できなければならない。

コンテナが拡張か縮小すると、要素への添字はデータの移動に追従して調整しなければならない。例えば 5 要素から成るベクタの 0 番目（a）から 3 つの要素を削除すると、添字 4 は添字 1 となる。

.. code-block:: none

   [a][b][c][d][e] ---> [d][e]
                ^           ^
                4           1

:cpp:func:`!adjust_index` の仕事は調整である。添字 :cpp:var:`!current` を与えると、この関数はコンテナにおける添字 :cpp:var:`!from`\..\ :cpp:var:`!to` におけるデータを :cpp:var:`!len` 個の要素で置換したときの調整後の添字を返す。


.. _v2.indexing.vector_indexing_suite_class:

vector_indexing_suite クラス
----------------------------

.. cpp:class:: template <class Container, bool NoProxy = false, class DerivedPolicies = unspecified_default> \
               vector_indexing_suite : unspecified_base

   :tparam Container:
      Python に対してラップするコンテナ型。

      :要件: クラス型

   :tparam NoProxy:
      既定では添字アクセスした要素は Python の参照のセマンティクスを持ち、プロキシにより返される。これは :cpp:var:`!NoProxy` テンプレート引数に真を与えることで無効化できる。

      :要件: 論理値
      :既定: ``false``

   :tparam DerivedPolicies:
      :cpp:class:`!vector_indexing_suite` はさらに定義済みのポリシーに派生している可能性がある。CRTP（James Coplien の「奇妙に再帰したテンプレートパターン」、C++ レポート、1995 年 2 月）を介した静的な多態により基底クラス :cpp:class:`!indexing_suite` が最派生クラスのポリシー関数を呼び出せる。

      :要件: :cpp:class:`!indexing_suite` の派生クラス

   ::

      template <
          class Container,
          bool NoProxy = false,
          class DerivedPolicies = unspecified_default >
      class vector_indexing_suite : unspecified_base
      {
      public:

          typedef typename Container::value_type data_type;
          typedef typename Container::value_type key_type;
          typedef typename Container::size_type index_type;
          typedef typename Container::size_type size_type;
          typedef typename Container::difference_type difference_type;

          data_type&
          get_item(Container& container, index_type i);

          static object
          get_slice(Container& container, index_type from, index_type to);

          static void
          set_item(Container& container, index_type i, data_type const& v);

          static void
          set_slice(Container& container, index_type from, 
              index_type to, data_type const& v);

          template <class Iter>
          static void
          set_slice(Container& container, index_type from,
              index_type to, Iter first, Iter last);

          static void 
          delete_item(Container& container, index_type i);

          static void 
          delete_slice(Container& container, index_type from, index_type to);
 
          static size_t
          size(Container& container);
 
          static bool
          contains(Container& container, key_type const& key);
 
          static index_type
          convert_index(Container& container, PyObject* i);
 
          static index_type
          adjust_index(index_type current, index_type from, 
              index_type to, size_type len);
      };


.. _v2.indexing.map_indexing_suite_class:

map_indexing_suite クラス
-------------------------

.. cpp:class:: template <class Container, bool NoProxy = false, class DerivedPolicies = unspecified_default > \
               map_indexing_suite : unspecified_base

   :tparam Container:
      Python に対してラップするコンテナ型。

      :要件: クラス型

   :tparam NoProxy:
      既定では添字アクセスした要素は Python の参照のセマンティクスを持ち、プロキシにより返される。これは :cpp:var:`!NoProxy` テンプレート引数に真を与えることで無効化できる。

      :要件: 論理値
      :既定: ``false``

   :tparam DerivedPolicies:
      :cpp:class:`!map_indexing_suite` はさらに定義済みのポリシーに派生している可能性がある。CRTP（James Coplien の「奇妙に再帰したテンプレートパターン」、C++ レポート、1995 年 2 月）を介した静的な多態により基底クラス :cpp:class:`!indexing_suite` が最派生クラスのポリシー関数を呼び出せる。

      :要件: :cpp:class:`!indexing_suite` の派生クラス

   ::

      template <
          class Container,
          bool NoProxy = false,
          class DerivedPolicies = unspecified_default >
      class map_indexing_suite : unspecified_base
      {
      public:

          typedef typename Container::value_type value_type;
          typedef typename Container::value_type::second_type data_type;
          typedef typename Container::key_type key_type;
          typedef typename Container::key_type index_type;
          typedef typename Container::size_type size_type;
          typedef typename Container::difference_type difference_type;

          static data_type&
          get_item(Container& container, index_type i);

          static void
          set_item(Container& container, index_type i, data_type const& v);

          static void 
          delete_item(Container& container, index_type i);
 
          static size_t
          size(Container& container);
 
          static bool
          contains(Container& container, key_type const& key);
 
          static bool
          compare_index(Container& container, index_type a, index_type b);

          static index_type
          convert_index(Container& container, PyObject* i);
      };
