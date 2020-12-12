boost/python/pointee.hpp
========================

.. contents::
   :depth: 1
   :local:


.. _v2.pointee.introduction:

はじめに
--------

:file:`<boost/python/pointee.hpp>` は、ポインタやスマートポインタの型から「ポイントされている」型を抽出する特性\ `メタ関数 <http://www.boost.org/libs/mpl/doc/refmanual/metafunction.html>`_\テンプレート :cpp:class:`!pointee<T>` を導入する。


.. _v2.pointee.classes:

クラス
------

.. _v2.pointee.pointee-spec:

:cpp:class:`!pointee<class T>` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <class T> pointee

   :cpp:struct:`!pointee<T>` は、:cpp:class:`class_\<>` テンプレートでポインタやスマートポインタ型を :cpp:type:`!HeldType` 引数に使用するときに保持する型を推論するのに使用する。


.. _v2.pointee.pointee-spec-synopsis:

:cpp:struct:`!pointee` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      template <class T> struct pointee
      {
         typedef T::element_type type;
      };

      // ポインタに対する特殊化
      template <T> struct pointee<T*>
      {
         typedef T type;
      };
   }


.. _v2.pointee.examples:

例
--

サードパーティ製のスマートポインタ型 :cpp:type:`!smart_pointer<T>` があるとして、:cpp:struct:`pointee<smart_pointer<T> >` を部分特殊化してクラスラッパの :cpp:type:`!HeldType` として使用可能にする。 ::

   #include <boost/python/pointee.hpp>
   #include <boost/python/class.hpp>
   #include <third_party_lib.hpp>

   namespace boost { namespace python
   {
     template <class T> struct pointee<smart_pointer<T> >
     {
        typedef T type;
     };
   }}

   BOOST_PYTHON_MODULE(pointee_demo)
   {
      class_<third_party_class, smart_pointer<third_party_class> >("third_party_class")
         .def(...)
         ...
         ;
   }
