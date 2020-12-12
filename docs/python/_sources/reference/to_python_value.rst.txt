boost/python/to_python_value.hpp
================================

.. contents::
   :depth: 1
   :local:

.. _v2.to_python_value.classes:

クラス
------

.. _v2.to_python_value:

:cpp:struct:`!to_python_value` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class T> to_python_value

   :cpp:struct:`!to_python_value` は、引数を新しい Python オブジェクトにコピーする :ref:`ResultConverter <ResultConverter.ResultConverter-concept>` モデルである。


.. cpp:namespace-push:: to_python_value


.. _v2.to_python_value.to_python_value-spec-synopsis:

:cpp:struct:`!to_python_value` クラステンプレートの概要\ [#]_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      template <class T>
      struct to_python_value
      {
         typedef typename add_reference<
            typename add_const<T>::type
         >::type argument_type;

         static bool convertible();
         PyObject* operator()(argument_type) const;
      };
   }}


.. _v2.to_python_value.to_python_value-spec-observers:

:cpp:struct:`!to_python_value` クラステンプレートのオブザーバ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: static bool convertible()

   :returns: :cpp:type:`!T` から Python へ値による変換が可能な変換器が登録されていれば ``true``。


.. cpp:function:: PyObject* operator()(argument_type x) const

   :要件: :cpp:expr:`convertible() == true`
   :効果: :cpp:var:`!x` を Python に変換する。
   :returns: :cpp:type:`!T` の変換器が登録されていれば、その結果の Python オブジェクト。それ以外の場合は ``0``。


.. cpp:namespace-pop::


.. [#] 訳注　`boost::add_const <http://www.boost.org/libs/type_traits/doc/html/boost_typetraits/reference/add_const.html>`_ 、`boost::add_reference <http://www.boost.org/libs/type_traits/doc/html/boost_typetraits/reference/add_reference.html>`_
