regex_id_filter_predicate 構造体テンプレート
============================================

.. cpp:struct:: template<typename BidiIter> regex_id_filter_predicate

.. cpp:namespace-push:: regex_id_filter_predicate


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/match_results.hpp`>

   template<typename BidiIter>
   struct :cpp:struct:`regex_id_filter_predicate` {
     // :ref:`構築、コピー、解体 <regex_id_filter_predicate.construct-copy-destruct>`
     :cpp:func:`~regex_id_filter_predicate::regex_id_filter_predicate`\(regex_id_type);

     // :ref:`公開メンバ関数 <regex_id_filter_predicate.public-member-functions>`
     bool :cpp:func:`operator()`\(:cpp:struct:`match_results`\< BidiIter > const &) const;
   };


説明
----

.. _regex_id_filter_predicate.construct-copy-destruct:

regex_id_filter_predicate 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: regex_id_filter_predicate(regex_id_type regex_id)


.. _regex_id_filter_predicate.public-member-functions:

regex_id_filter_predicate 公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: bool operator()(match_results< BidiIter > const & res) const

.. cpp:namespace-pop::
