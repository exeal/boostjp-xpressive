boost/python/exec.hpp
=====================

.. contents::
   :depth: 1
   :local:


.. _v2.exec.introduction:

はじめに
--------

Python のインタープリタを C++ コードへ組み込む機構をエクスポートする。


.. _v2.exec.functions:

関数
----

.. _v2.exec.eval-spec:

:cpp:func:`!eval`
^^^^^^^^^^^^^^^^^

.. cpp:function:: object eval(str expression, object globals = object(), object locals = object())

   :効果: 辞書 :cpp:var:`!globals` および :cpp:var:`!locals` が指定した文脈で Python の式 :cpp:var:`!expression` を評価する。
   :returns: 式の値を保持する :cpp:class:`object` のインスタンス。


.. _v2.exec.exec-spec:

:cpp:func:`!exec`
^^^^^^^^^^^^^^^^^

.. cpp:function:: object exec(str code, object globals = object(), object locals = object())

   :効果: 辞書 :cpp:var:`!globals` および :cpp:var:`!locals` が指定した文脈で Python のソースコード :cpp:var:`!code` を実行する。
   :returns: コードの実行結果を保持する :cpp:class:`object` のインスタンス。


.. _v2.exec.exec_file-spec:

:cpp:func:`!exec_file`
^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: object exec_file(str filename, object globals = object(), object locals = object())

   :効果: 辞書 :cpp:var:`!globals` および :cpp:var:`!locals` が指定した文脈で、:cpp:var:`!filename` で与えた名前のファイルから Python のソースコードを実行する。
   :returns: コードの実行結果を保持する :cpp:class:`object` のインスタンス。


.. _v2.exec.examples:

例
--

以下の例は、:cpp:func:`!import` と :cpp:func:`!exec` を使用して Python で関数を定義し、後で C++ から呼び出している。 ::

   #include <iostream>
   #include <string>

   using namespace boost::python;

   void greet()
   { 
     // main モジュールを得る。
     object main = import("__main__");

    // main モジュールの名前空間を得る。
    object global(main.attr("__dict__"));

    // Python 内で greet 関数を定義する。
    object result = exec(
       "def greet():                   \n"
       "   return 'Hello from Python!' \n",
       global, global);

     // greet 関数への参照を作成する。
     object greet = global["greet"];

     // 呼び出す。
     std::string message = extract<std::string>(greet());
     std::cout << message << std::endl;
   }

文字列に Python のスクリプトを組み込む代わりに、ファイルに格納しておいてもよい。

.. code-block:: python

   def greet():
      return 'Hello from Python!'

代わりにこれを実行する。 ::

   // ...
     // ファイルから greet 関数を読み込む。
     object result = exec_file(script, global, global);
     // ...
   }
