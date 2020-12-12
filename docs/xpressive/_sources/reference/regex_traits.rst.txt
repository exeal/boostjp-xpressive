regex_traits 構造体テンプレート
===============================

.. cpp:struct:: template<typename Char, typename Impl> \
                regex_traits : public Impl


.. cpp:namespace-push:: regex_traits


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/xpressive_fwd.hpp`>

   template<typename Char, typename Impl>
   struct :cpp:struct:`~::boost::xpressive::regex_traits` : public Impl {
     // :ref:`構築、コピー、解体 <regex_traits.construct-copy-destruct>`
     :cpp:func:`~regex_traits::regex_traits`\();
     explicit :cpp:func:`~regex_traits::regex_traits`\(locale_type const &);
   };


説明
----

.. _regex_traits.construct-copy-destruct:

:cpp:struct:`!regex_traits` 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: regex_traits()

.. cpp:function:: explicit regex_traits(locale_type const & loc)


.. cpp:namespace-pop::
