boost/python/str.hpp
====================

.. contents::
   :depth: 1
   :local:


.. _v2.str.introduction:

はじめに
--------

Python の `str <http://docs.python.jp/2/c-api/string.html>`_ 型に対する :ref:`TypeWrapper <concepts.objectwrapper.typewrapper_concept_requirements>` をエクスポートする。


.. _v2.str.classes:

クラス
------

.. _v2.str.str-spec:

:cpp:class:`!str` クラス
^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:class:: str : public object

   Python の組み込み :cpp:class:`!str` 型の\ `文字列メソッド <http://docs.python.jp/2/c-api/string.html>`_\をエクスポートする。文字の範囲から :cpp:class:`!str` オブジェクトを構築する2引数コンストラクタ以外の以下に定義するコンストラクタとメンバ関数のセマンティクスを完全に理解するには、:ref:`concepts.objectwrapper.typewrapper_concept_requirements`\の定義を読むことである。:cpp:class:`!str` は :cpp:class:`object` から公開派生しているので、:cpp:class:`!object` の公開インターフェイスは :cpp:class:`!str` のインスタンスにも当てはまる。


.. _v2.str.str-spec-synopsis:

:cpp:class:`!str` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
     class str : public object
     {
      public:
         str(); // str を新規作成する

         str(char const* s); // str を新規作成する

         str(char const* start, char const* finish); // str を新規作成する
         str(char const* start, std::size_t length); // str を新規作成する

         template <class T>
         explicit str(T const& other);

         str capitalize() const;

         template <class T>
         str center(T const& width) const;

         template<class T>
         long count(T const& sub) const;
         template<class T1, class T2>
         long count(T1 const& sub,T2 const& start) const;
         template<class T1, class T2, class T3>
         long count(T1 const& sub,T2 const& start, T3 const& end) const;

         object decode() const;
         template<class T>
         object decode(T const& encoding) const;
         template<class T1, class T2>
         object decode(T1 const& encoding, T2 const& errors) const;

         object encode() const;
         template <class T>
         object encode(T const& encoding) const;
         template <class T1, class T2>
         object encode(T1 const& encoding, T2 const& errors) const;

         template <class T>
         bool endswith(T const& suffix) const;
         template <class T1, class T2>
         bool endswith(T1 const& suffix, T2 const& start) const;
         template <class T1, class T2, class T3>
         bool endswith(T1 const& suffix, T2 const& start, T3 const& end) const;

         str expandtabs() const;
         template <class T>
         str expandtabs(T const& tabsize) const;

         template <class T>
         long find(T const& sub) const;
         template <class T1, class T2>
         long find(T1 const& sub, T2 const& start) const;
         template <class T1, class T2, class T3>
         long find(T1 const& sub, T2 const& start, T3 const& end) const;

         template <class T>
         long index(T const& sub) const;
         template <class T1, class T2>
         long index(T1 const& sub, T2 const& start) const;
         template <class T1, class T2, class T3>
         long index(T1 const& sub, T2 const& start, T3 const& end) const;

         bool isalnum() const;
         bool isalpha() const;
         bool isdigit() const;
         bool islower() const;
         bool isspace() const;
         bool istitle() const;
         bool isupper() const;

         template <class T>
         str join(T const& sequence) const;

         template <class T>
         str ljust(T const& width) const;

         str lower() const;
         str lstrip() const;

         template <class T1, class T2>
         str replace(T1 const& old, T2 const& new_) const;
         template <class T1, class T2, class T3>
         str replace(T1 const& old, T2 const& new_, T3 const& maxsplit) const;

         template <class T>
         long rfind(T const& sub) const;
         template <class T1, class T2>
         long rfind(T1 const& sub, T2 const& start) const;
         template <class T1, class T2, class T3>
         long rfind(T1 const& sub, T2 const& start, T3 const& end) const;

         template <class T>
         long rindex(T const& sub) const;
         template <class T1, class T2>
         long rindex(T1 const& sub, T2 const& start) const;
         template <class T1, class T2, class T3>
         long rindex(T1 const& sub, T2 const& start, T3 const& end) const;

         template <class T>
         str rjust(T const& width) const;

         str rstrip() const;

         list split() const; 
         template <class T>
         list split(T const& sep) const;
         template <class T1, class T2>
         list split(T1 const& sep, T2 const& maxsplit) const;

         list splitlines() const;
         template <class T>
         list splitlines(T const& keepends) const;

         template <class T>
         bool startswith(T const& prefix) const;
         template <class T1, class T2>
         bool startswidth(T1 const& prefix, T2 const& start) const;
         template <class T1, class T2, class T3>
         bool startswidth(T1 const& prefix, T2 const& start, T3 const& end) const;

         str strip() const;
         str swapcase() const;
         str title() const;

         template <class T>
         str translate(T const& table) const;
         template <class T1, class T2>
         str translate(T1 const& table, T2 const& deletechars) const;

         str upper() const;
     };
   }}


.. _v2.str.examples:

例
--

::

   using namespace boost::python;
   str remove_angle_brackets(str x)
   {
     return x.strip('<').strip('>');
   }
