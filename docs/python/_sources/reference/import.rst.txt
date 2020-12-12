boost/python/import.hpp
=======================

.. contents::
   :depth: 1
   :local:


.. _v2.import.introduction:

はじめに
--------

Python のモジュールをインポートする機構をエクスポートする。


.. _v2.import.functions:

関数
----

.. _v2.import.import-spec:

:cpp:func:`!import`
^^^^^^^^^^^^^^^^^^^

.. cpp:function:: object import(str name)

   :効果: 名前 :cpp:var:`!name` のモジュールをインポートする。
   :returns: インポートしたモジュールへの参照を保持する :cpp:class:`object` のインスタンス。


.. _v2.import.examples:

例
--

以下の例は、:cpp:func:`!import` を使用して Python 内の関数にアクセスし、後で C++ から呼び出している。 ::

   #include <iostream>
   #include <string>

   using namespace boost::python;

   void print_python_version()
   { 
     // sys モジュールを読み込む。
     object sys = import("sys");

     // Python のバージョンを抽出する。
     std::string version = extract<std::string>(sys.attr("version"));
     std::cout << version << std::endl;
   }
