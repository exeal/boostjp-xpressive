regex_error 構造体
==================

.. cpp:struct:: regex_error : public std::runtime_error, public exception

   :cpp:struct:`regex_error` クラスは、正規表現を表す文字列を有限状態マシンに変換するときに、エラーを報告するのに送出する例外オブジェクトの型を定義する。


.. cpp:namespace-push:: regex_error


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`>boost/xpressive/regex_error.hpp`>


   struct :cpp:struct:`~::boost::xpressive::regex_error` : public std::runtime_error, public exception {
     // :ref:`構築、コピー、解体 <regex_error.construct-copy-destruct>`
     :cpp:func:`~regex_error::regex_error`\(regex_constants::error_type, char const \* = "");
     :cpp:func:`~regex_error::~regex_error`\();

     // :ref:`公開メンバ関数 <regex_error.public-member-functions>`
     regex_constants::error_type :cpp:func:`code`\() const;
   };


説明
----

.. _regex_error.construct-copy-destruct:

:cpp:struct:`!regex_error` 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: explicit regex_error(regex_constants::error_type code, char const * str = "")

   :cpp:struct:`!regex_error` クラスのオブジェクトを構築する。

   :param code: この :cpp:struct:`!regex_error` が表す :cpp:enum:`!error_type`。
   :param str: この :cpp:struct:`!regex_error` のメッセージ文字列。
   :事後条件: :cpp:expr:`code() == code`


.. cpp:function:: ~regex_error()

   :cpp:struct:`regex_error` クラスのデストラクタ。

   :例外: 例外は送出しない。


.. _regex_error.public-member-functions:

:cpp:struct:`!regex_error` 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: regex_constants::error_type code() const

   :cpp:enum:`!error_type` 値のアクセス子。

   :returns: コンストラクタに渡した :cpp:enum:`!error_type` コード。
   :例外: 例外は送出しない。


.. cpp:namespace-pop::
