コンセプト
==========

.. contents:: 目次
   :depth: 2
   :local:


.. _concepts.callpolicies:

CallPolicies コンセプト
-----------------------

.. _concepts.callpolicies.introduction:

はじめに
^^^^^^^^

CallPolicies コンセプトのモデルは、Boost.Python が生成した Python の呼び出し可能オブジェクトの振る舞いを、関数やメンバ関数ポインタのようなラップした C++ オブジェクトに対して特殊化するのに使用する。以下の 4 つの振る舞いを提供する。

#. :cpp:func:`!precall` ― ラップしたオブジェクトが呼び出される前の Python 引数タプルの管理
#. :cpp:type:`!result_converter` ― C++ 戻り値の処理
#. :cpp:func:`!postcall` ― ラップしたオブジェクトが呼び出された後の Python 引数タプルと戻り値の管理
#. :cpp:type:`!extract_return_type` ― 与えられたシグニチャ型並びから戻り値の型を抽出するメタ関数


.. _concepts.callpolicies.callpolicies_composition:

CallPolicies の合成
^^^^^^^^^^^^^^^^^^^

ユーザが同じ呼び出し可能オブジェクトで複数の CallPolicies モデルを使用可能にするため、Boost.Python の CallPolicies クラステンプレートは再帰的に合成可能な数珠繋ぎのインターフェイスを提供する。このインターフェイスは省略可能なテンプレート引数 :cpp:type:`!Base` を取り、既定は :cpp:class:`default_call_policies` である。慣習に従って、:cpp:type:`!Base` の :cpp:func:`!precall` 関数はより外側のテンプレートが与えた :cpp:func:`!precall` 関数の\ **後で**\呼び出され、:cpp:type:`!Base` の :cpp:func:`!postcall` 関数はより外側のテンプレートの :cpp:func:`!postcall` 関数より\ **前に**\呼び出される。より外側のテンプレートで :cpp:type:`!result_converter` が与えられた場合、:cpp:type:`!Base` で与えた :cpp:type:`!result_converter` は\ **上書きされる**\。例えば :cpp:struct:`return_internal_reference` を見よ。


.. _concepts.callpolicies.concept_requirements:

コンセプトの要件
^^^^^^^^^^^^^^^^

.. _CallPolicies.CallPolicies-concept:

CallPolicies コンセプト
~~~~~~~~~~~~~~~~~~~~~~~

以下の表で :cpp:var:`!x` は CallPolicies のモデルである型 :cpp:type:`!P` のオブジェクト、:cpp:var:`!a` は Python の引数タプルオブジェクトを指す :c:type:`!PyObject*` 、:cpp:var:`!r` は「予備的な」戻り値オブジェクトを参照する :c:type:`!PyObject*` を表す。

.. list-table::
   :header-rows: 1

   * - 式
     - 型
     - 結果・セマンティクス
   * - :cpp:expr:`x.precall(a)`
     - :cpp:type:`!bool` へ変換可能
     - 失敗時は ``false`` および `PyErr_Occurred <http://docs.python.jp/2/c-api/exceptions.html#PyErr_Occurred>`_\ :code:`() != 0` 、それ以外は ``true``。
   * - :cpp:expr:`P::result_converter`
     - :ref:`ResultConverterGenerator <concepts.resultconverter.resultconvertergenerator_concept>` のモデル</td>
     - 「予備的な」戻り値オブジェクトを生成する MPL の単項\ `メタ関数クラス <http://www.boost.org/libs/mpl/doc/refmanual/metafunction-class.html>`_\。
   * - :cpp:expr:`x.postcall(a, r)`
     - :c:type:`!PyObject*` へ変換可能
     - 失敗時は ``0`` および `PyErr_Occurred <http://docs.python.jp/2/c-api/exceptions.html#PyErr_Occurred>`_\ :code:`() != 0`。例外送出中であっても「参照を保持」しなければならない。言い換えると、:cpp:var:`!r` を返さない場合はその参照カウントを減らさなければならず、別の生存しているオブジェクトを返す場合はその参照カウントを増やさなければならない。
   * - :cpp:expr:`P::extract_return_type`
     - `Metafunction <http://www.boost.org/libs/mpl/doc/refmanual/metafunction.html>`_ のモデル
     - 与えられたシグニチャから戻り値の型を抽出する MPL の単項 `Metafunction <http://www.boost.org/libs/mpl/doc/refmanual/metafunction.html>`_\。既定では :cpp:class:`!mpl::front` から導出する。

CallPolicies のモデルは `CopyConstructible <http://www.boost.org/libs/utility/CopyConstructible.html>`_ であることが要求される。


.. _concepts.dereferenceable:

Dereferenceable コンセプト
--------------------------

.. _concepts.dereferenceable.introduction:

はじめに
^^^^^^^^

Dereferenceable 型のインスタンスは lvalue へアクセスするポインタのように使用できる。


.. _concepts.dereferenceable.concept_requirements:

コンセプトの要件
^^^^^^^^^^^^^^^^

.. _Dereferenceable.Dereferenceable-concept:

Dereferenceable コンセプト
~~~~~~~~~~~~~~~~~~~~~~~~~~

以下の表で :cpp:type:`!T` は Dereferenceable のモデル、:cpp:var:`!x` は型 :cpp:type:`!T` のオブジェクトを表す。またポインタはすべて Dereferenceable とする。

.. list-table::
   :header-rows: 1

   * - 式
     - 結果
     - 操作上のセマンティクス
   * - :cpp:expr:`get_pointer(x)`
     - :cpp:class:`pointee`\ :code:`<>::type*` へ変換可能
     - :cpp:expr:`&*x` かヌルポインタ


.. _concepts.extractor:

Extractor コンセプト
--------------------

.. _concepts.extractor.introduction:

はじめに
^^^^^^^^

Extractor は、Boost.Python が Python オブジェクトから C++ オブジェクトを抽出するのに使用するクラスである。典型的には、「伝統的な」Python 拡張型について ``from_python`` 変換を定義するのに使用する。


.. _concepts.extractor.concept_requirements:

コンセプトの要件
^^^^^^^^^^^^^^^^

.. _Extractor.Extractor-concept:

Extractor コンセプト
~~~~~~~~~~~~~~~~~~~~

以下の表で :cpp:type:`!X` は Extractor のモデル、:cpp:var:`!a` は Python オブジェクト型のインスタンスを表す。

.. list-table::
   :header-rows: 1

   * - 式
     - 型
     - セマンティクス
   * - :cpp:expr:`X::execute(a)`
     - 非 void
     - 抽出する C++ オブジェクトを返す。:cpp:func:`!execute` 関数は多重定義してはならない。
   * - :cpp:expr:`&a.ob_type`
     - `PyTypeObject <http://docs.python.jp/2/c-api/typeobj.html>`_\ :code:`**`
     - :c:type:`!PyObject` とレイアウト互換なオブジェクトの :c:member:`!ob_type` フィールドを指す。


.. _concepts.extractor.notes:

注意事項
~~~~~~~~

簡単に言うと、Extractor の :cpp:func:`!execute` メンバは多重定義のない、Python オブジェクト型を 1 つだけ引数にとる静的関数でなければならない。:c:type:`!PyObject` から公開派生した（かつあいまいでない継承関係にある）型、および :c:type:`!PyObject` とレイアウト互換な :term:`POD` 型もこの Python オブジェクト型に含まれる。


.. _concepts.holdergenerator:

HolderGenerator コンセプト
--------------------------

.. _concepts.holdergenerator.introduction:

はじめに
^^^^^^^^

HolderGenerator はその引数のインスタンスを、ラップした C++ クラスインスタンス内に保持するのに適した型を返す単項メタ関数クラスである。


.. _concepts.holdergenerator.concept-requirements:

コンセンプトの要件
^^^^^^^^^^^^^^^^^^

.. _HolderGenerator.HolderGenerator-concept:

HolderGenerator コンセプト
~~~~~~~~~~~~~~~~~~~~~~~~~~

以下の表で :cpp:type:`!G` は HolderGenerator のモデル型、:cpp:class:`!X` はクラス型を表す。

.. list-table::
   :header-rows: 1

   * - 式
     - 要件
   * - :cpp:expr:`G::apply<X>::type`
     - 型 :cpp:class:`!X` のオブジェクトを保持できる :cpp:class:`instance_holder` の具象派生クラス。


.. _concepts.resultconverter:

ResultConverter/ResultConverterGenerator コンセプト
---------------------------------------------------

.. _concepts.resultconverter.introduction:

はじめに
^^^^^^^^

型 :cpp:type:`!T` に対する ResultConverter は、型 :cpp:type:`!T` の C++ 戻り値を ``to_python`` 変換するのにそのインスタンスが使用可能な型である。ResultConverterGenerator は、C++ 関数の戻り値型が与えられたときにその型に対する ResultConverter を返す MPL の単項メタ関数クラスである。Boost.Python における ResultConverter は一般的にライブラリの変換器レジストリを探索して適切な変換器を探すが、レジストリを使用しない変換器もありうる。

.. _concepts.resultconverter.resultconverter_concept_requirem:

コンセプトの要件
^^^^^^^^^^^^^^^^

.. _ResultConverter.ResultConverter-concept:

ResultConverter コンセプト
~~~~~~~~~~~~~~~~~~~~~~~~~~

以下の表で :cpp:type:`!C` は型 :cpp:type:`!R` に対する ResultConverter 、:cpp:var:`!c` は型 :cpp:type:`!C` のオブジェクト、:cpp:var:`!r` は型 :cpp:type:`!R` のオブジェクトを表す。

.. list-table::
   :header-rows: 1

   * - 式
     - 型
     - セマンティクス
   * - :code:`C c;`
     - 
     - :cpp:type:`!C` のオブジェクトを構築する。
   * - :cpp:expr:`c.convertible()`
     - :cpp:type:`!bool` へ変換可能
     - :cpp:type:`!R` の値から Python オブジェクトへの変換が不可能な場合は ``false``。
   * - :cpp:expr:`c(r)`
     - :c:type:`!PyObject*` へ変換可能
     - :cpp:var:`!v` に対応する Python オブジェクトへのポインタ。:cpp:var:`!r` が ``to_python`` 変換不可能な場合は ``0`` で、\ `PyErr_Occurred <http://docs.python.jp/2/c-api/exceptions.html#PyErr_Occurred>`_ は非 ``0`` を返すはずである。
   * - :cpp:expr:`c.get_pytype()`
     - :c:type:`!PyTypeObject const*`
     - 変換の結果に対応する Python の型オブジェクトへのポインタか ``0``。ドキュメンテーションの生成に使用する。``0`` を返した場合はドキュメンテーション内で生成された型は **:cpp:type:`!object`** になる。


.. _concepts.resultconverter.resultconvertergenerator_concept:

ResultConverterGenerator コンセプト
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

以下の表で :cpp:type:`!G` は ResultConverterGenerator 型、:cpp:type:`!R` は C++ 関数の戻り値型。

.. list-table::
   :header-rows: 1

   * - 式
     - 要件
   * - :cpp:expr:`G::apply<R>::type`
     - :cpp:type:`!R` に対する ResultConverter 型。


.. _concepts.objectwrapper:

ObjectWrapper/TypeWrapper コンセプト
------------------------------------

.. _concepts.objectwrapper.introduction:

はじめに
^^^^^^^^

Python オブジェクトを管理するクラスと Python 風の構文をサポートするクラスを表現する、2 つのコンセプトを定義する。


.. _concepts.objectwrapper.objectwrapper_concept_requiremen:

コンセプトの要件
^^^^^^^^^^^^^^^^

.. _ObjectWrapper.ObjectWrapper-concept:

ObjectWrapper コンセプト
~~~~~~~~~~~~~~~~~~~~~~~~

ObjectWrapper コンセプトのモデルは公開アクセス可能な基底クラスとして :cpp:class:`object` を持ち、特殊な構築の振る舞いとメンバ関数（テンプレートメンバ関数であることが多い）による便利な機能を提供する。戻り値の型 :cpp:type:`!R` 自身が :cpp:concept:`TypeWrapper` である場合を除いて、次のメンバ関数呼び出し形式は

.. parsed-literal::

   x.\ :samp:`{some_function}`\(a1, a2,...a\ :samp:`{n}`)

常に以下と同じセマンティクスを持つ。

.. parsed-literal::

   :cpp:class:`extract`\<R>(x.attr("some_function")(:cpp:func:`~object::object`\(a1), :cpp:func:`~object::object`\(a2),...\ :cpp:func:`~object::object`\(a\ :samp:`{n}`)))()

:cpp:type:`!R` が :cpp:concept:`TypeWrapper` である場合、戻り値の型は直接以下により構築する。

.. parsed-literal::

   x.attr("some_function")(:cpp:func:`~object::object`\(a1), :cpp:func:`~object::object`\(a2),...\ :cpp:func:`~object::object`\(a\ :samp:`{n}`)).ptr()

（ただし以下の\ :ref:`concepts.objectwrapper.caveat`\も見よ。）


.. _concepts.objectwrapper.typewrapper_concept_requirements:

TypeWrapper コンセプト
~~~~~~~~~~~~~~~~~~~~~~

TypeWrapper は個々の Python の型 :cpp:type:`!X` と一体となった ObjectWrapper の改良版である。TypeWrapper として :cpp:type:`!T` があるとすると、

.. parsed-literal::

   T(a1, a2,...a\ :samp:`{n}`)

上記の合法なコンストラクタ式は、以下に相当する引数列で :cpp:type:`!X` を呼び出した結果を管理する新しい :cpp:type:`!T` オブジェクトを構築する。

.. parsed-literal::

   :cpp:func:`~object::object`\(a1), :cpp:func:`~object::object`\(a2),...\ :cpp:func:`~object::object`\(a\ :samp:`{n}`)

ラップした C++ 関数の引数、あるいは :cpp:class:`extract\<>` のテンプレート引数として使用した場合、対応する Python 型のインスタンスだけがマッチするとみなされる。


.. _concepts.objectwrapper.caveat:

注意
^^^^

戻り値の型が TypeWrapper である場合の特殊なメンバ関数の呼び出し規則は結論として、返されたオブジェクトが不適切な型の Python オブジェクトを管理している可能がある。これは大抵の場合、深刻な問題とはならない（最悪の場合の結果は、エラーが実行時に検出される場合、つまり他のあらゆる場合よりも少し遅いタイミングだ）。このようなことが起こる例として、:cpp:class:`dict` のメンバ関数 :cpp:func:`~dict::items` が :cpp:class:`list` 型のオブジェクトを返すことに注意していただきたい。今、ユーザがこの :cpp:class:`!dict` の派生クラスを Python 内で定義すると、

.. code-block:: python

   >>> class mydict(dict):
   ...     def items(self):
   ...         return tuple(dict.items(self)) # タプルを返す

:cpp:class:`!mydict` のインスタンスは :cpp:class:`!dict` のインスタンスでもあるため、ラップした C++ 関数の引数として使用すると、:cpp:class:`boost::python::dict` は Python の :cpp:class:`!mydict` 型オブジェクトも受け取る。このオブジェクトに対して :cpp:expr:`items()` を呼び出すと、実際には Python のタプルを保持した :cpp:class:`boost::python::list` のインスタンスが返る。このオブジェクトで続けて :cpp:class:`!list` のメソッド（例えば :cpp:func:`~list::append` 等、変更を伴う操作）を使用すると、同じことを Python で行った場合と同様の例外が送出する。
