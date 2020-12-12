boost/python/return_opaque_pointer.hpp
======================================

.. contents::
   :depth: 1
   :local:


.. _v2.return_opaque_pointer.classes:

クラス
------

.. _v2.return_opaque_pointer-spec:

:cpp:struct:`!return_opaque_pointer` クラス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: return_opaque_pointer

   :cpp:struct:`!return_opaque_pointer` は、新しい Python オブジェクトに戻り値がコピーされる未定義型へのポインタを返す C++ 関数をラップするのに使用する :ref:`ResultConverterGenerator <concepts.resultconverter.resultconvertergenerator_concept>` のモデルである。

   戻り値のポインタ先の型について :cpp:func:`type_id` 関数の特殊化を定義するには、:cpp:struct:`!return_opaque_pointer` ポリシーを指定することに加え、:c:macro:`BOOST_PYTHON_OPAQUE_SPECIALIZED_TYPE_ID` マクロを使用しなければならない。


.. _v2.return_opaque_pointer.return_opaque_pointer-spec-synopsis:

:cpp:struct:`!return_opaque_pointer` クラスの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       struct return_opaque_pointer
       {
           template <class R> struct apply;
       };
   }}


.. _v2.return_opaque_pointer.return_opaque_pointer-spec-metafunctions:

:cpp:struct:`!return_opaque_pointer` クラスのメタ関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:struct:: template <class T> apply

   .. cpp:type:: detail::opaque_conversion_holder<R> type


.. cpp:namespace-pop::


.. _v2.return_opaque_pointer.examples:

例
--

.. code-block::
   :caption: C++ のモジュール定義

   # include <boost/python/return_opaque_pointer.hpp>
   # include <boost/python/def.hpp>
   # include <boost/python/module.hpp>
   # include <boost/python/return_value_policy.hpp>

   typedef struct opaque_ *opaque;

   opaque the_op   = ((opaque) 0x47110815);

   opaque get () { return the_op; }
   void use (opaque op) {
       if (op != the_op)
           throw std::runtime_error (std::string ("failed"));
   }

   void failuse (opaque op) {
       if (op == the_op)
           throw std::runtime_error (std::string ("success"));
   }

   BOOST_PYTHON_OPAQUE_SPECIALIZED_TYPE_ID(opaque_)

   namespace bpl = boost::python;

   BOOST_PYTHON_MODULE(opaque_ext)
   {
       bpl::def (
           "get", &::get, bpl::return_value_policy<bpl::return_opaque_pointer>());
       bpl::def ("use", &::use);
       bpl::def ("failuse", &::failuse);
   }

.. code-block:: python
   :caption: Python のコード

   """
   >>> from opaque_ext import *
   >>> #
   >>> # 正しい変換のチェック
   >>> use(get())
   >>> failuse(get())
   Traceback (most recent call last):
           ...
   RuntimeError: success
   >>> #
   >>> # 整数から不透明なオブジェクトへの変換が存在しないことのチェック
   >>> use(0)
   Traceback (most recent call last):
           ...
   TypeError: bad argument type for built-in operation
   >>> #
   >>> # 文字列から不透明なオブジェクトへの変換が存在しないことのチェック
   >>> use("")
   Traceback (most recent call last):
           ...
   TypeError: bad argument type for built-in operation
   """
   def run(args = None):
       import sys
       import doctest

       if args is not None:
           sys.argv = args
       return doctest.testmod(sys.modules.get(__name__))
    
   if __name__ == '__main__':
       print "実行中..."
       import sys
       sys.exit(run()[0])


.. seealso:: :cpp:class:`opaque`
