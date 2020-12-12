boost/python/operators.hpp
==========================

.. contents::
   :depth: 1
   :local:


.. _v2.operators.introduction:

はじめに
--------

:file:`<boost/python/operators.hpp>` は、Python の\ `特殊メソッド <http://docs.python.jp/2/library/operator.html>`_\を C++ の対応する構造から自動的に生成する型と関数を提供する。これらの構造の大半は演算子式であり、ヘッダの名前はそこから来ている。この機能を使用するには、エクスポートする式中でラップするクラス型のオブジェクトを :cpp:var:`self` オブジェクトで置き換え、その結果を :cpp:func:`class_\<>::def()` へ渡す。このヘッダがエクスポートするものの大半は実装部分と考えるべきであり、本稿では詳細について記述しない。


.. _v2.operators.classes:

クラス
------

.. _v2.operators.self_t-spec:

:cpp:class:`!self_ns::self_t` クラス
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:class:: self_ns::self_t

   :cpp:class:`!self_ns::self_t` は :cpp:var:`self` オブジェクトの実際の型である。ライブラリは :cpp:class:`!self_t` を自身の名前空間 :cpp:member:`!self_ns` 内に分離し、他の文脈で引数依存の探索により一般化された演算子テンプレートが発見されるのを防ぐ。ユーザが直接 :cpp:class:`!self_t` に触れることはないため、これは実装の詳細と考えるべきである。


.. _v2.operators.self_t-spec-synopsis:

:cpp:class:`!self_ns::self_t` クラスの概要
""""""""""""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python { namespace self_ns {
   {
      unspecified-type-declaration self_t;

      // 複合演算子
      template <class T> operator_<unspecified> operator+=(self_t, T);
      template <class T> operator_<unspecified> operator-=(self_t, T);
      template <class T> operator_<unspecified> operator*=(self_t, T);
      template <class T> operator_<unspecified> operator/=(self_t, T);
      template <class T> operator_<unspecified> operator%=(self_t, T);
      template <class T> operator_<unspecified> operator>>=(self_t, T);
      template <class T> operator_<unspecified> operator<<=(self_t, T);
      template <class T> operator_<unspecified> operator&=(self_t, T);
      template <class T> operator_<unspecified> operator^=(self_t, T);
      template <class T> operator_<unspecified> operator|=(self_t, T);

      // 比較演算子
      template <class L, class R> operator_<unspecified> operator==(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator!=(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator<(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator>(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator<=(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator>=(L const&, R const&);

      // 非メンバ演算子
      template <class L, class R> operator_<unspecified> operator+(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator-(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator*(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator/(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator%(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator>>(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator<<(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator&(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator^(L const&, R const&);
      template <class L, class R> operator_<unspecified> operator|(L const&, R const&);
      template <class L, class R> operator_<unspecified> pow(L const&, R const&);

      // 単項演算子
      operator_<unspecified> operator-(self_t);
      operator_<unspecified> operator+(self_t);
      operator_<unspecified> operator~(self_t);
      operator_<unspecified> operator!(self_t);

      // 値操作
      operator_<unspecified> int_(self_t);
      operator_<unspecified> long_(self_t);
      operator_<unspecified> float_(self_t);
      operator_<unspecified> complex_(self_t);
      operator_<unspecified> str(self_t);

      operator_<unspecified> repr(self_t);

   }}};

各式の結果を :cpp:func:`class_\<>::def()` の引数として渡したときに生成されるメソッドを以下の表に挙げる。:cpp:var:`!x` はラップするクラス型のオブジェクトである。


.. _v2.operators.self_t-spec-inplace:

:cpp:class:`!self_ns::self_t` クラスの複合演算子
""""""""""""""""""""""""""""""""""""""""""""""""

下表において :cpp:var:`!r` が :cpp:class:`other<T>` 型のオブジェクトの場合、:cpp:var:`!y` は型 :cpp:type:`!T` のオブジェクトである。それ以外の場合、:cpp:var:`!y` は :cpp:var:`!r` と同じ型のオブジェクトである。

.. list-table::
   :header-rows: 1

   * - C++ の式
     - Python のメソッド名
     - C++ の実装
   * - :cpp:expr:`self += r`
     - :py:meth:`!__iadd__`
     - :cpp:expr:`x += y`
   * - :cpp:expr:`self -= r`
     - :py:meth:`!__isub__`
     - :cpp:expr:`x -= y`
   * - :cpp:expr:`self *= r`
     - :py:meth:`!__imul__`
     - :cpp:expr:`x *= y`
   * - :cpp:expr:`self /= r`
     - :py:meth:`!__idiv__`
     - :cpp:expr:`x /= y`
   * - :cpp:expr:`self %= r`
     - :py:meth:`!__imod__`
     - :cpp:expr:`x %= y`
   * - :cpp:expr:`self >>= r`
     - :py:meth:`!__irshift__`
     - :cpp:expr:`x >>= y`
   * - :cpp:expr:`self <<= r`
     - :py:meth:`!__ilshift__`
     - :cpp:expr:`x <<= y`
   * - :cpp:expr:`self &= r`
     - :py:meth:`!__iand__`
     - :cpp:expr:`x &= y`
   * - :cpp:expr:`self ^= r`
     - :py:meth:`!__ixor__`
     - :cpp:expr:`x ^= y`
   * - :cpp:expr:`self |= r`
     - :py:meth:`!__ior__`
     - :cpp:expr:`x |= y`


.. _v2.operators.self_t-spec-comparisons:

:cpp:class:`!self_ns::self_t` クラスの比較関数
""""""""""""""""""""""""""""""""""""""""""""""

下表において :cpp:var:`!r` が :cpp:class:`self_t` 型の場合、:cpp:var:`!y` は :cpp:var:`!x` と同じ型のオブジェクトである。:cpp:var:`!l` か :cpp:var:`!r` が :cpp:class:`other\<T>` 型のオブジェクトの場合、:cpp:var:`!y` は型 :cpp:type:`!T` のオブジェクトである。それ以外の場合、:cpp:var:`!y` は :cpp:var:`!l` か :cpp:var:`!r` と同じ型のオブジェクトであり、:cpp:var:`!l` は :cpp:class:`self_t` 型以外である。

「Python の式」の列は、:cpp:var:`!x` および :cpp:var:`!y` の型へ変換可能なオブジェクトについて Python がサポートする式を表す。2 番目の演算は Python の高水準比較演算子の\ `反射則 <http://docs.python.org/2/reference/datamodel.html>`_\（可換則）により生じるもので、対応する演算が :cpp:var:`!y` オブジェクトのメソッドとして定義されない場合のみ使用される。

.. list-table::
   :header-rows: 1

   * - C++ の式
     - Python のメソッド名
     - C++ の実装
     - Python の式（1 番目、2 番目）
   * - :cpp:expr:`self == r`
     - :py:meth:`!__eq__`
     - :cpp:expr:`x == y`
     - :code:`x == y, y == x`
   * - :cpp:expr:`l == self`
     - :py:meth:`!__eq__`
     - :cpp:expr:`y == x`
     - :code:`y == x, x == y`
   * - :cpp:expr:`self != r`
     - :py:meth:`!__ne__`
     - :cpp:expr:`x != y`
     - :code:`x != y, y != x`
   * - :cpp:expr:`l != self`
     - :py:meth:`!__ne__`
     - :cpp:expr:`y != x`
     - :code:`y != x, x != y`
   * - :cpp:expr:`self < r`
     - :py:meth:`!__lt__`
     - :cpp:expr:`x < y`
     - :code:`x < y, y > x`
   * - :cpp:expr:`l < self`
     - :py:meth:`!__gt__`
     - :cpp:expr:`y < x`
     - :code:`y > x, x < y`
   * - :cpp:expr:`self > r`
     - :py:meth:`!__gt__`
     - :cpp:expr:`x > y`
     - :code:`x > y, y < x`
   * - :cpp:expr:`l > self`
     - :py:meth:`!__lt__`
     - :cpp:expr:`y > x`
     - :code:`y < x, x > y`
   * - :cpp:expr:`self <= r`
     - :py:meth:`!__le__`
     - :cpp:expr:`x <= y`
     - :code:`x <= y, y >= x`
   * - :cpp:expr:`l <= self`
     - :py:meth:`!__ge__`
     - :cpp:expr:`y <= x`
     - :code:`y >= x, x <= y`
   * - :cpp:expr:`self >= r`
     - :py:meth:`!__ge__`
     - :cpp:expr:`x >= y`
     - :code:`x >= y, y <= x`
   * - :cpp:expr:`l >= self`
     - :py:meth:`!__le__`
     - :cpp:expr:`y >= x`
     - :code:`y <= x, x >= y`


.. _v2.operators.self_t-spec-ops:

:cpp:class:`!self_ns::self_t` クラスの非メンバ演算子
""""""""""""""""""""""""""""""""""""""""""""""""""""

`ここ <http://docs.python.jp/2/reference/datamodel.html#numeric-types>`_\で述べられているように、以下の名前が「:code:`__r`」で始まる演算は左オペランドが与えられた演算をサポートしない場合のみ呼び出される。

.. list-table::
   :header-rows: 1

   * - C++ の式
     - Python のメソッド名
     - C++ の実装
   * - :cpp:expr:`self + r`
     - :py:meth:`!__add__`
     - :cpp:expr:`x + y`
   * - :cpp:expr:`l + self`
     - :py:meth:`!__radd__`
     - :cpp:expr:`y + x`
   * - :cpp:expr:`self - r`
     - :py:meth:`!__sub__`
     - :cpp:expr:`x - y`
   * - :cpp:expr:`l - self`
     - :py:meth:`!__rsub__`
     - :cpp:expr:`y - x`
   * - :cpp:expr:`self * r`
     - :py:meth:`!__mul__`
     - :cpp:expr:`x * y`
   * - :cpp:expr:`l * self`
     - :py:meth:`!__rmul__`
     - :cpp:expr:`y * x`
   * - :cpp:expr:`self / r`
     - :py:meth:`!__div__`
     - :cpp:expr:`x / y`
   * - :cpp:expr:`l / self`
     - :py:meth:`!__rdiv__`
     - :cpp:expr:`y / x`
   * - :cpp:expr:`self % r`
     - :py:meth:`!__mod__`
     - :cpp:expr:`x % y`
   * - :cpp:expr:`l % self`
     - :py:meth:`!__rmod__`
     - :cpp:expr:`y % x`
   * - :cpp:expr:`self >> r`
     - :py:meth:`!__rshift__`
     - :cpp:expr:`x >> y`
   * - :cpp:expr:`l >> self`
     - :py:meth:`!__rrshift__`
     - :cpp:expr:`y >> x`
   * - :cpp:expr:`self << r`
     - :py:meth:`!__lshift__`
     - :cpp:expr:`x << y`
   * - :cpp:expr:`l << self`
     - :py:meth:`!__rlshift__`
     - :cpp:expr:`y << x`
   * - :cpp:expr:`self & r`
     - :py:meth:`!__and__`
     - :cpp:expr:`x & y`
   * - :cpp:expr:`l & self`
     - :py:meth:`!__rand__`
     - :cpp:expr:`y & x`
   * - :cpp:expr:`self ^ r`
     - :py:meth:`!__xor__`
     - :cpp:expr:`x ^ y`
   * - :cpp:expr:`l ^ self`
     - :py:meth:`!__rxor__`
     - :cpp:expr:`y ^ x`
   * - :cpp:expr:`self | r`
     - :py:meth:`!__or__`
     - :cpp:expr:`x | y`
   * - :cpp:expr:`l | self`
     - :py:meth:`!__ror__`
     - :cpp:expr:`y | x`
   * - :cpp:expr:`pow(self, r)`
     - :py:meth:`!__pow__`
     - :cpp:expr:`pow(x, y)`
   * - :cpp:expr:`pow(l, self)`
     - :py:meth:`!__rpow__`
     - :cpp:expr:`pow(y, x)`


.. _v2.operators.self_t-spec-value-unary-ops:

:cpp:class:`!self_ns::self_t` クラスの単項演算子
""""""""""""""""""""""""""""""""""""""""""""""""

.. list-table::
   :header-rows: 1

   * - C++ の式
     - Python のメソッド名
     - C++ の実装
   * - :cpp:expr:`-self`
     - :code:`__neg__`
     - :cpp:expr:`-x`
   * - :cpp:expr:`+self`
     - :code:`__pos__`
     - :cpp:expr:`+x`
   * - :cpp:expr:`~self`
     - :code:`__invert__`
     - :cpp:expr:`~x`
   * - :cpp:expr:`not self` または :cpp:expr:`!self`
     - :code:`__nonzero__`
     - :cpp:expr:`!!x`


.. _v2.operators.self_t-spec-value-ops:

:cpp:class:`!self_ns::self_t` クラスの値演算
""""""""""""""""""""""""""""""""""""""""""""

.. list-table::
   :header-rows: 1

   * - C++ の式
     - Python のメソッド
     - C++ の実装\ [#]_
   * - :cpp:expr:`int_(self)`
     - :py:meth:`!__int__`
     - :cpp:expr:`long(x)`
   * - :cpp:expr:`long_`
     - :py:meth:`!__long__`
     - :cpp:expr:`PyLong_FromLong(x)`
   * - :cpp:expr:`float_`
     - :py:meth:`!__float__`
     - :cpp:expr:`double(x)`
   * - :cpp:expr:`complex_`
     - :py:meth:`!__complex__`
     - :cpp:expr:`std::complex<double>(x)`
   * - :cpp:expr:`str`
     - :py:meth:`!__str__`
     - :cpp:expr:`lexical_cast<std::string>(x)`
   * - :cpp:expr:`repr`
     - :py:meth:`!__repr__`
     - :cpp:expr:`lexical_cast<std::string>(x)`


.. _v2.operators.other-spec:

:cpp:class:`!other` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class T> other

   :cpp:class:`!other<T>` のインスタンスは :cpp:var:`self` とともに演算子式中で使用し、結果は同じ式の :cpp:class:`!other<T>` を :cpp:type:`!T` オブジェクトで置き換えたものと等価である。:cpp:type:`!T` オブジェクトの構築が高価で避けたい場合、コンストラクタが利用できない場合、または単純にコードを明確にする場合に :cpp:class:`!other<T>` を使用するとよい。


.. _v2.operators.other-spec-synopsis:

:cpp:class:`!other` クラステンプレートの概要
""""""""""""""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python
   template <class T>
   struct other
   {
   };
   }


.. _v2.operators.operator_-spec:

:cpp:class:`!detail::operator_` クラステンプレート
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <unspecified> detail::operator_

   :cpp:struct:`!detail::operator_<>` のインスタンス化は、:cpp:var:`self` を含む演算子式の戻り値型として使用する。これは実装の詳細として考えるべきであり、:code:`self` 式の結果がどのように :cpp:func:`class_\<>::def()` 呼び出しとマッチするか見るためとしてのみ、ここに記載する。


.. _v2.operators.operator_-spec-synopsis:

:cpp:class:`!detail::operator_` クラステンプレートの概要
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

::

   namespace boost { namespace python { namespace detail
   {
     template <unspecified>
     struct operator_
     {
     };
   }}}


.. _v2.operators.objects:

オブジェクト
------------

.. _v2.operators.self-spec:

self
~~~~

.. cpp:var:: self_ns::self_t self = self_ns::self

   ::

      namespace boost { namespace python
      {
        using self_ns::self;
      }}


.. _v2.operators.examples:

例\ [#]_
--------

::

   #include <boost/python/module.hpp>
   #include <boost/python/class.hpp>
   #include <boost/python/operators.hpp>
   #include <boost/operators.hpp>

   struct number
      : boost::integer_arithmetic<number>
   {
       explicit number(long x_) : x(x_) {}
       operator long() const { return x; }

       template <class T>
       number& operator+=(T const& rhs)
       { x += rhs; return *this; }

       template <class T>
       number& operator-=(T const& rhs)
       { x -= rhs; return *this; }
    
       template <class T>
       number& operator*=(T const& rhs)
       { x *= rhs; return *this; }
    
       template <class T>
       number& operator/=(T const& rhs)
       { x /= rhs; return *this; }
    
       template <class T>
       number& operator%=(T const& rhs)
       { x %= rhs; return *this; }

       long x;
   };

   using namespace boost::python;
   BOOST_PYTHON_MODULE(demo)
   {
      class_<number>("number", init<long>())
         // self との組み合わせ
         .def(self += self)
         .def(self + self)
         .def(self -= self)
         .def(self - self)
         .def(self *= self)
         .def(self * self)
         .def(self /= self)
         .def(self / self)
         .def(self %= self)
         .def(self % self)

         // Python の int への変換
         .def(int_(self))

         // long との組み合わせ
         .def(self += long())
         .def(self + long())
         .def(long() + self)
         .def(self -= long())
         .def(self - long())
         .def(long() - self)
         .def(self *= long())
         .def(self * long())
         .def(long() * self)
         .def(self /= long())
         .def(self / long())
         .def(long() / self)
         .def(self %= long())
         .def(self % long())
         .def(long() % self)
         ;
   }


.. [#] `boost::lexical_cast <http://www.boost.org/libs/conversion/lexical_cast.htm>`_

.. [#] `boost::integer_arithmetic <http://www.boost.org/libs/utility/operators.htm#grpd_oprs>`_
