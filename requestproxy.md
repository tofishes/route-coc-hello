### requestProxy

请求代理。针对ajax直接请求api(未配置router)，和router设置了proxy属性情况下的处理。

产生结果：请求的结果将直接响应到浏览器端。终止后面的流程。可用stage.before，不可用stage.after。
