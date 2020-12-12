boost/python/slice.hpp
======================

.. contents::
   :depth: 1
   :local:


.. _v2.slice.introduction:

はじめに
--------

Python の `slice <http://docs.python.jp/2/c-api/slice.html>`_ 型に対する :ref:`TypeWrapper <concepts.objectwrapper.typewrapper_concept_requirements>` をエクスポートする。


.. _v2.slice.classes:

クラス
------

.. _v2.slice.slice-spec:

:cpp:class:`!slice` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:class:: slice : public object

   Python の組み込み :cpp:class:`!slice` 型をラップして拡張スライシングプロトコルをエクスポートする。インターフェイス以下に定義するコンストラクタとメンバ関数のセマンティクスを完全に理解するには、:ref:`concepts.objectwrapper.typewrapper_concept_requirements`\の定義を読むことである。:cpp:class:`!slice` は :cpp:class:`object` から公開派生しているので、:cpp:class:`!object` の公開インターフェイスは :cpp:class:`!slice` のインスタンスにも当てはまる。


.. cpp:namespace-push:: slice


.. _v2.slice.slice-spec-synopsis:

:cpp:class:`!slice` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     class slice : public object
     {
      public:
         slice(); // 空の slice を作成する。[::] と等価

         template <typename Int1, typename Int2>
         slice(Int1 start, Int2 stop);

         template <typename Int1, typename Int2, typename Int3>
         slice(Int1 start, Int2 stop, Int3 step);

         // この slice を作成したときの引数にアクセスする。
         object start();
         object stop();
         object step();

         // slice::get_indices() の戻り値の型
         template <typename RandomAccessIterator>
         struct range
         {
             RandomAccessIterator start;
             RandomAccessIterator stop;
             int step;
         };

         template <typename RandomAccessIterator>
         range<RandomAccessIterator>
         get_indices(
             RandomAccessIterator const& begin, 
             RandomAccessIterator const& end);
     };
   }}


.. _v2.slice.slice-spec-ctors:

:cpp:class:`!slice` クラスのコンストラクタ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: slice()

   :効果: 既定の stop 、start 、step 値で :cpp:class:`!slice` を構築する。Pythonの式 :code:`base[::]` で作成したスライスオブジェクトと等価。
   :例外: なし。


.. cpp:function:: template <typename Int1, typename Int2> \
                  slice(Int1 start, Int2 stop)

   :cpp:var:`!start` および :cpp:var:`!stop` は :cpp:class:`slice_nil` 型、または :cpp:class:`!object` 型へ変換可能。

   :効果: 既定の step 値と与えられた :cpp:var:`!start` 、:cpp:var:`!stop` 値で新しい :cpp:class:`!slice` を構築する。Python の組み込み関数 `slice <http://docs.python.jp/2/library/functions.html#slice>`_\ :cpp:expr:`(start,stop)` 、または Python の式 :code:`base[start:stop]` で作成したスライスオブジェクトと等価。
   :throws error_already_set: 引数を :cpp:class:`!object` 型へ変換できない場合（Python の :py:exc:`!TypeError` 例外を設定する）。


.. cpp:function:: template <typename Int1, typename Int2, typename Int3> \
                  slice(Int1 start, Int2 stop, Int3 step)

   :要件: :cpp:var:`!start` 、:cpp:var:`!stop` および :cpp:var:`!step` は :cpp:class:`!slice_nil` 、または :cpp:class:`!object` 型へ変換可能。
   :効果: :cpp:var:`!start` 、:cpp:var:`!stop` 、:cpp:var:`!step` 値で新しい :cpp:class:`!slice` を構築する。Python の組み込み関数 `slice <http://docs.python.jp/2/library/functions.html#slice>`_\ :cpp:expr:`(start,stop,step)` 、または Python の式 :code:`base[start:stop:step]` で作成したスライスオブジェクトと等価。
   :throws error_already_set: 引数を :cpp:class:`!object` 型へ変換できない場合（Python の :py:exc:`!TypeError` 例外を設定する）。


.. _v2.slice.slice-spec-observers:

:cpp:class:`!slice` クラスのオブザーバ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: object start() const
                  object stop() const
                  object step() const

   :効果: なし。
   :例外: なし。
   :returns: スライスを作成したときに使用した引数。スライスを作成したときに引数を省略したか :cpp:class:`!slice_nil` を使用した場合、その引数は :cpp:var:`!Py_None` への参照でありデフォルトコンストラクトされた :cpp:class:`!object` と等値である。原則的にはスライスオブジェクトを作成するのに任意の型を使用できるが、現実的には大抵は整数である。


.. cpp:function:: template <typename RandomAccessIterator> \
                  range<RandomAccessIterator> get_indices(RandomAccessIterator const& begin, RandomAccessIterator const& end) const

   :param: 半開区間を形成する STL 準拠のランダムアクセスイテレータの組。
   :効果: 引数の ``[begin,end)`` 範囲内の完全閉範囲を定義する RandomAccessIterator の組を作成する。:cpp:var:`!Py_None` か負の添字の効果、および 1 以外の step サイズをどう扱うか説明を求められたときに、この関数がスライスの添字を変換する。
   :returns: 非 0 の step 値と、この関数の引数が与える範囲を指し閉区間を定義する RandomAccessIterator の組で初期化した :cpp:class:`!slice::range`。
   :throws error_already_set: このスライスの引数が :cpp:var:`!Py_None` への参照でも :cpp:type:`!int` へ変換可能でもない場合。Python の :py:exc:`!TypeError` 例外を:term:`送出する`。
   :throws std\:\:invalid_argument: 結果の範囲が空の場合。:cpp:func:`!slice::get_indices()` を呼び出すときは常に :code:`try { ...; } catch (std::invalid_argument) {}` で囲んでこのケースを処理し適切に処置しなければならない。
   :根拠: 閉区間。開空間を使ったとすると、step サイズが 1 以外の場合、終端のイテレータが末尾の直後より後方の位置や指定した範囲より前方を指す状態が必要となる。

          空のスライスに対する例外。空の範囲を表す閉区間を定義することは不可能であるので、未定義の動作を防止するために他の形式のエラーチェックが必要となる。例外が捕捉されない場合、単に既定の例外処理機構により Python に変換される。


.. cpp:namespace-pop::


.. _v2.slice.examples:

例
--

::

   using namespace boost::python;

   // Python リストの拡張スライス。
   // 警告：組み込み型に対する拡張スライシングは Python 2.3 より前ではサポートされていない
   list odd_elements(list l)
   {
       return l[slice(_,_,2)];
   }

   // std::vector のスライスに対して合計をとる。
   double partial_sum(std::vector<double> const& Foo, const slice index)
   {
       slice::range<std::vector<double>::const_iterator> bounds;
       try {
           bounds = index.get_indices<>(Foo.begin(), Foo.end());
       }
       catch (std::invalid_argument) {
           return 0.0;
       }
       double sum = 0.0;
       while (bounds.start != bounds.stop) {
           sum += *bounds.start;
           std::advance( bounds.start, bounds.step);
       }
       sum += *bounds.start;
       return sum;
   }
