動作を確認したプラットフォームとコンパイラ
==========================================

.. pull-quote::

   | **David Abrahams**
   | Copyright © 2006 David Abrahams
   | Distributed under the Boost Software License, Version 1.0. (See accompanying file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

動作を確認したプラットフォームとコンパイラ
------------------------------------------

最新の情報は\ `退行ログ <http://boost.sourceforge.net/regression-logs>`_\を確認いただきたい。他でマークされていないログはリリースの状態ではなく、CVS の状態を反映する。

以前のバージョンの Boost.Python は以下のプラットフォームとコンパイラでテストに成功した。

Unix プラットフォーム
   Python `2.2`_ および `2.2.2b1`_
      * `RedHat Linux 7.3 <http://www.redhat.com/>`_\（Intel x86）上の `GCC`_ 2.95.3、2.96、3.0.4、3.1 および 3.2
      * OSF v. 5.1（Dec/Compaq Alpha）上の Tru64 CXX 6.5.1
      * `IRIX 6.5 <http://www.sgi.com/software/irix6.5/>`_\（SGI mips）上の MIPSPro 7.3.1.2m
      * SunOS 5.8 上の `GCC 3.1 <http://gcc.gnu.org/>`_
   Python `2.2.1`_
      * OSF v. 5.1（Dec/Compaq Alpha）上の KCC 3.4d
      * AIX 上の KCC 3.4d
Microsoft Windows XP Professional
   Python `2.2`_ 、\ `2.2.1`_ および `2.2.2b1`_
      * `Microsoft Visual C++ <http://msdn.microsoft.com/visualc/default.asp>`_ 6 、7 および 7.1 ベータ
      * `Microsoft Visual C++ 6 <http://msdn.microsoft.com/visualc/default.asp>`_ で `STLPort 4.5.3`_ を使用
      * `Metrowerks CodeWarrior <http://www.metrowerks.com/MW/Develop/Desktop/Windows/Professional/Default.htm>`_ 7.2 、8.0 、8.2 および 8.3 ベータ
      * `Intel C++ <http://www.intel.com/software/products/compilers/c60/>`_ 5.0 、6.0 および 7.0 ベータ
      * `Intel C++ 5.0 <http://www.intel.com/software/products/compilers/c60/>`_ で `STLPort 4.5.3`_ を使用
      * `Cygwin <http://www.cygwin.com/>`_ `GCC`_ 3.0.4 および 3.2
      * `MinGW-1.1 <http://www.mingw.org/>`_\（`GCC 2.95.3-5 <http://gcc.gnu.org/>`_）
      * `MingGW-2.0 <http://www.mingw.org/>`_\（`GCC 3.2 <http://gcc.gnu.org/>`_）


.. _2.2: http://www.python.org/2.2
.. _2.2.1: http://www.python.org/2.2.1
.. _2.2.2b1: http://www.python.org/2.2.2
.. _GCC: http://gcc.gnu.org/
.. _STLPort 4.5.3: http://www.stlport.org/
