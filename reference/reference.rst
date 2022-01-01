reference 構造体テンプレート
============================

.. cpp:struct:: template<typename T> reference

   :cpp:struct:`reference\<>` は、xpressive の意味アクションで使用できる参照の遅延ラッパである。

   :tparam T: 参照先の型。


.. cpp:namespace-push:: reference


概要
----

.. parsed-literal::

   // ヘッダ：<:file:`boost/xpressive/regex_actions.hpp`>

   template<typename T>
   struct :cpp:struct:`~boost::xpressive::reference` : public proto::extends< proto::terminal< reference_wrapper< T > >::type, reference< T > >
   {
     // :ref:`構築、コピー、解体 <reference.construct-copy-destruct>`
     explicit :cpp:func:`~reference::reference`\(T &);

     // :ref:`公開メンバ関数 <reference.public-member-functions>`
     T & :cpp:func:`get`\() const;
   };


説明
----

既存のオブジェクトへの遅延参照の作成し、xpressive の意味アクションで読み書きできるようにする方法を示した例である。 ::

   using namespace boost::xpressive;
   std::map<std::string, int> result;
   reference<std::map<std::string, int> > result_ref(result);

   // => で区切られた単語と整数の組にマッチし、
   // 結果を std::map<> に詰め込む
   sregex pair = ( (s1= +_w) >> "=>" >> (s2= +_d) )
       [ result_ref[s1] = as<int>(s2) ];


.. _reference.construct-copy-destruct:

reference 構築、コピー、解体の公開演算
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: explicit reference(T & t)

   :cpp:var:`t` への参照を格納する。

   :param t: オブジェクトへの参照


.. _reference.public-member-functions:

reference の公開メンバ関数
^^^^^^^^^^^^^^^^^^^^^^^^^^

.. cpp:function:: T & get() const

   格納した値にアクセスする。


.. cpp:namespace-pop::
