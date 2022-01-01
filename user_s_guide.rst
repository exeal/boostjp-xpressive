.. there is not a corresponding file to this

.. cpp:namespace:: boost::xpressive


ユーザーガイド
==============

.. contents::
    :depth: 1
    :local:

本節では xpressive を使ったテキスト処理、パース処理の方法を説明する。xpressive の特定のコンポーネントについて詳細な情報を探している場合は、:doc:`reference/index`\の節を見よ。

.. include:: introduction.rst
.. include:: installation.rst
.. include:: quick_start.rst


正規表現オブジェクトの作成
--------------------------

xpressive を使う場合、最初に行うのが :cpp:struct:`basic_regex\<>` オブジェクトの作成である。本節では静的・動的の 2 つの表現方法による正規表現作成の基本を見ていく。

.. include:: static_regexes.rst
.. include:: dynamic_regexes.rst

.. include:: matching.rst
.. include:: results.rst
.. include:: substitutions.rst
.. include:: tokenization.rst
.. include:: named_captures.rst
.. include:: grammars.rst
.. include:: actions.rst
.. include:: symbols.rst
.. include:: traits.rst
.. include:: tips_n_tricks.rst
.. include:: concepts.rst
.. include:: examples.rst
