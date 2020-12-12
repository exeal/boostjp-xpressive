boost/python/opaque_pointer_converter.hpp
=========================================

.. contents::
   :depth: 1
   :local:


.. _v2.opaque.classes:

クラス
------

.. _v2.opaque.opaque-spec:

:cpp:struct:`!opaque<Pointee>` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template<class Pointee> opaque

   :cpp:struct:`!opaque<>` は、自身を Python オブジェクトと未定義型へのポインタの双方向変換器として登録する。


.. cpp:namespace-push:: opaque


.. _v2.opaque.opaque-spec-synopsis:

:cpp:struct:`!opaque` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
       template<class Pointee>
       struct opaque
       {
           opaque();
       };
   }}

.. _v2.opaque.opaque-spec-ctors:

:cpp:struct:`!opaque` クラステンプレートのコンストラクタ
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: opaque()

   :効果: * Python オブジェクトから不透明なポインタへの :cpp:struct:`lvalue_from_pytype` 変換器としてインスタンスを登録する。作成される Python オブジェクトは、ラップする不透明なポインタが指す型の後ろに配置される。
          * 不透明なポインタから Python オブジェクトへの :cpp:struct:`to_python_converter` としてインスタンスを登録する。

          他のモジュールで登録されたインスタンスが既にある場合は、多重登録の警告を避けるため、このインスタンスは登録を再試行することはない。

   .. note:: 通常、このクラスのインスタンスは各 :cpp:type:`!Pointee` につき 1 つだけ作成する。


.. cpp:namespace-pop::


.. _v2.opaque.macros:

マクロ
------

.. _v2.opaque.BOOST_PYTHON_OPAQUE_SPECIALIZED_TYPE_ID-spec:

:c:macro:`!BOOST_PYTHON_OPAQUE_SPECIALIZED_TYPE_ID(Pointee)` マクロ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. c:macro:: BOOST_PYTHON_OPAQUE_SPECIALIZED_TYPE_ID(Pointee)

   このマクロは、不完全型であるためインスタンス化が不可能な :cpp:func:`type_id` 関数の特殊化を定義するのに使用しなければならない。

   .. note:: 不透明な変換器を使用する各翻訳単位でこのマクロを呼び出さなければならない。


.. _v2.opaque.seealso:

.. seealso::
   :cpp:struct:`return_opaque_pointer`
