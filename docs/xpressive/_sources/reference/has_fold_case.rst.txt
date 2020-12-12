has_fold_case 構造体テンプレート
================================

.. cpp:struct:: template<typename Traits> has_fold_case : public is_convertible<Traits::version_tag*, regex_traits_version_1_case_fold_tag*>

   ある特性クラスが :cpp:func:`!fold_case` メンバ関数を持つことを示すのに使用する特性。


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/xpressive_fwd.hpp`>

   template<typename Traits>
   struct :cpp:struct:`has_fold_case` : public is_convertible< Traits::version_tag \*, regex_traits_version_1_case_fold_tag \* >
   {
   };

   
