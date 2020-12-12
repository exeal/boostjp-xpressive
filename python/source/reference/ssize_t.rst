boost/python/ssize_t.hpp
========================

.. contents::
   :depth: 1
   :local:


.. _v2.ssize_t.introduction:

はじめに
--------

Python 2.5 は新しい型定義 :c:type:`!Py_ssize_t` および 2 つの関連マクロを導入した（\ `PEP353 <http://www.python.org/dev/peps/pep-0353/>`_\）。:file:`<boost/python/ssize_t.hpp>` ヘッダはこれらの定義を :cpp:type:`!ssize_t` 、:cpp:type:`!ssize_t_max` および :cpp:type:`!ssize_t_min` として :cpp:member:`!boost::python` 名前空間にインポートする。後方互換性のために、Python の以前バージョンでは適切な定義を提供する。


.. _v2.ssize_t.typedefs:

型定義
------

.. cpp:type:: Py_ssize_t ssize_t

   可能であれば :c:type:`!Py_ssize_t` を :cpp:member:`!boost::python` 名前空間にインポートする。または後方互換性のために適切な型定義を提供する。 ::

      #if PY_VERSION_HEX >= 0x02050000
      typedef Py_ssize_t ssize_t;
      #else
      typedef int ssize_t;
      #endif


.. _v2.ssize_t.macros:

定数
----

.. cpp:var:: ssize_t const ssize_t_max = PY_SSIZE_T_MAX
             ssize_t const ssize_t_min = PY_SSIZE_T_MIN

   可能であれば :c:macro:`!PY_SSIZE_T_MAX` および :c:macro:`!PY_SSIZE_T_MIN` を :cpp:member:`!boost::python` 名前空間に定数としてインポートする。または後方互換性のために適切な定数を提供する。 ::

      #if PY_VERSION_HEX >= 0x02050000
      ssize_t const ssize_t_max = PY_SSIZE_T_MAX;
      ssize_t const ssize_t_min = PY_SSIZE_T_MIN;
      #else
      ssize_t const ssize_t_max = INT_MAX;
      ssize_t const ssize_t_min = INT_MIN;
      #endif
