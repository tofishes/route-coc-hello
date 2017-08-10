### requestProxy

请求代理。

以下情况会触发该流程执行：

1. 浏览器端ajax直接请求后端api(未配置router)。
2. router配置设置了proxy=true属性。
3. res.forward('http://other.com')，直接服务器内跳转到一个第三方域名地址。

产生结果：请求的结果将直接响应到浏览器端。终止后面的流程。可用stage.before，不可用stage.after。
