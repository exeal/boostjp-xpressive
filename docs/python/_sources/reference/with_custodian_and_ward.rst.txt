boost/python/with_custodian_and_ward.hpp
========================================

.. contents::
   :depth: 1
   :local:


.. _v2.with_custodian_and_ward.introduction:

はじめに
--------

このヘッダは、関数の Python 引数および戻り値オブジェクトの 2 つの間の寿命依存性を確立する機能を提供する。\ **非後見人**\（ward）オブジェクトは\ **管理人**\（custodian）オブジェクトが\ `弱い参照 <http://docs.python.jp/2/library/weakref.html>`_\をサポートしている限り（Boost.Python の拡張クラスはすべて弱い参照をサポートする）管理人オブジェクトが破壊されるまで破壊されない。\ **管理人**\オブジェクトが弱い参照をサポートしておらず :py:const:`!None` でもない場合、適切な例外が投げられる。2 つのクラステンプレート :cpp:struct:`!with_custodian_and_ward` および :cpp:struct:`!with_custodian_and_ward_postcall` の違いはそれらが効果を発揮する場所である。

不注意で懸垂ポインタを作成してしまう可能性を減らすため、既定では寿命の束縛は背後にある C++ オブジェクトが呼び出される\ **前に**\行う。しかしながら結果のオブジェクトは呼び出すまで無効であるので、呼び出し後に寿命の束縛を行う :cpp:struct:`!with_custodian_and_ward_postcall` を提供している。また :cpp:func:`!with_custodian_and_ward<>::precall` の後だが背後にある C++ オブジェクトが実際にポインタを格納するより前に C++ 例外が投げられた場合、管理人オブジェクトと非後見人オブジェクトの寿命は意図的にともに束縛されるため、ラップする関数のセマンティクスに応じて代わりに :cpp:struct:`!with_custodian_and_ward_postcall` を選択するとよい。

関数呼び出し境界を超えて生のポインタの\ **所有権を譲渡する**\関数をラップする場合、これは適したツールでは\ **ない**\ことに注意していただきたい。必要があれば\ :ref:`よくある質問と回答 <faq.how_can_i_wrap_a_function_which0>`\を参照されたい。


.. _v2.with_custodian_and_ward.classes:

クラス
------

.. _v2.with_custodian_and_ward.with_custodian_and_ward-spec:

:cpp:struct:`!with_custodian_and_ward` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <std::size_t custodian, std::size_t ward, class Base = default_call_policies> \
                with_custodian_and_ward : Base

   :tparam custodian: 確立する寿命関係において依存される側を指すテンプレート引数の 1 から始まる添字。メンバ関数をラップする場合、引数 1 は対象オブジェクト（:cpp:expr:`*this`）である。対象の Python オブジェクト型が弱い参照をサポートしない場合、ラップする C++ オブジェクトを呼び出すと Python の :py:exc:`!TypeError` 例外を送出することに注意していただきたい。\ [#]_

                      :要件: :cpp:type:`!std::size_t` 型の正のコンパイル時定数。

   :tparam ward: 確立する寿命関係において依存する側を指すテンプレート引数の 1 から始まる添字。メンバ関数をラップする場合、引数 1 は対象オブジェクト（:cpp:expr:`*this`）である。

                 :要件: :cpp:type:`!std::size_t` 型の正のコンパイル時定数。

   :tparam Base: :ref:`ポリシーの合成 <concepts.callpolicies.callpolicies_composition>`\に使用する。

                 :要件: :ref:`CallPolicies <concepts.callpolicies>` のモデル
                 :既定: :cpp:struct:`default_call_policies`


.. cpp:namespace-push:: with_custodian_and_ward


.. _v2.with_custodian_and_ward.with_custodian_and_ward-spec-synopsis:

:cpp:struct:`!with_custodian_and_ward` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      template <std::size_t custodian, std::size_t ward, class Base = default_call_policies>
      struct with_custodian_and_ward : Base
      {
         static bool precall(PyObject* args);
      };
   }}


.. _v2.with_custodian_and_ward.with_custodian_and_ward-spec-statics:

:cpp:struct:`!with_custodian_and_ward` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: bool precall(PyObject* args)

   :要件: `PyTuple_Check <http://docs.python.jp/2/c-api/tuple.html#PyTuple_Check>`_\ :cpp:expr:`(args) != 0`
   :効果: :cpp:var:`!ward` で指定した引数の寿命を :cpp:var:`!custodian` で指定した引数の寿命に依存させる。
   :returns: 失敗時は ``false``\（`PyErr_Occurred <http://docs.python.jp/2/c-api/exceptions.html#PyErr_Occurred>`_\ :code:`() != 0`）。それ以外は ``true``。


.. cpp:namespace-pop::


.. _v2.with_custodian_and_ward.with_custodian_and_ward_postcall-spec:

:cpp:struct:`!with_custodian_and_ward_postcall` クラステンプレート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. contents::
   :depth: 1
   :local:

.. cpp:struct:: template <std::size_t custodian, std::size_t ward, class Base = default_call_policies> \
                with_custodian_and_ward_postcall : Base

   :tparam custodian:
      確立する寿命関係において依存される側を指すテンプレート引数の添字。0 は戻り値、1 は第 1 引数を表す。メンバ関数をラップする場合、1 は対象オブジェクト（:cpp:expr:`*this`）である。対象の Python オブジェクト型が弱い参照をサポートしない場合、ラップする C++ オブジェクトを呼び出すと Python の :py:exc:`!TypeError` 例外を送出することに注意していただきたい。\ [#]_

      :要件: :cpp:type:`!std::size_t` 型の正のコンパイル時定数。

   :tparam ward:
      確立する寿命関係において依存する側を指すテンプレート引数の添字。0 は戻り値、1 は第 1 引数を表す。メンバ関数をラップする場合、引数 1 は対象オブジェクト（:cpp:expr:`*this`）である。

      :要件: :cpp:type:`!std::size_t` 型の正のコンパイル時定数。

   :tparam Base:
      :ref:`ポリシーの合成 <concepts.callpolicies.callpolicies_composition>`\に使用する。

      :要件: :cpp:concept:`CallPolicies` のモデル
      :既定: :cpp:struct:`default_call_policies`


.. cpp:namespace-push:: with_custodian_and_ward_postcall


.. _v2.with_custodian_and_ward.with_custodian_and_ward_postcall-spec-synopsis:

:cpp:struct:`!with_custodian_and_ward_postcall` クラステンプレートの概要
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

::

   namespace boost { namespace python
   {
      template <std::size_t custodian, std::size_t ward, class Base = default_call_policies>
      struct with_custodian_and_ward_postcall : Base
      {
         static PyObject* postcall(PyObject* args, PyObject* result);
      };
   }}


.. _v2.with_custodian_and_ward.with_custodian_and_ward_postcall-spec-statics:

:cpp:struct:`!with_custodian_and_ward_postcall` クラスの静的関数
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. cpp:function:: PyObject* postcall(PyObject* args, PyObject* result)

   :要件: `PyTuple_Check <http://docs.python.jp/2/c-api/tuple.html#PyTuple_Check>`_\ :cpp:expr:`(args) != 0` かつ :cpp:expr:`result != 0`
   :効果: :cpp:var:`!ward` で指定した引数の寿命を :cpp:var:`!custodian` で指定した引数の寿命に依存させる。
   :returns: 失敗時は ``0``\（`PyErr_Occurred <http://docs.python.jp/2/c-api/exceptions.html#PyErr_Occurred>`_\ :code:`() != 0`）。それ以外は ``true``。


.. cpp:namespace-pop::


.. _v2.with_custodian_and_ward.examples:

例
--

以下はライブラリの :cpp:struct:`return_internal_reference` の実装に :cpp:struct:`with_custodian_and_ward_postcall` を使用している例である。 ::

   template <std::size_t owner_arg = 1, class Base = default_call_policies>
   struct return_internal_reference
       : with_custodian_and_ward_postcall<0, owner_arg, Base>
   {
      typedef reference_existing_object result_converter;
   };


.. [#] 訳注　:cpp:var:`!custodian` および :cpp:var:`!ward` テンプレート引数に 0 や引数列の範囲を超える値を指定することはできません。また両者に同じ値を指定することもできません。

.. [#] 訳注　:cpp:var:`!custodian` および :cpp:var:`!ward` テンプレート引数に引数列の範囲を超える値を指定することはできません。また両者に同じ値を指定することもできません。
