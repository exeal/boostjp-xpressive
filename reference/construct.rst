construct 関数テンプレート
==========================

.. cpp:function:: template<typename T, typename... Args> \
		  unspecified construct(Args const&... args)

   指定した型のオブジェクトを構築する遅延関数である。

   :param args: コンストラクタの引数。
   :tparam T: 構築するオブジェクトの型。
   :returns: 評価すると :cpp:expr:`T(xs...)` を返す遅延オブジェクト。:cpp:expr:`xs...` は遅延引数 :cpp:expr:`args...` を評価した結果。
