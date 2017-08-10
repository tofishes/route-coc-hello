### response

响应客户端流程。根据之前流程产生的结果选择合适的响应类型到客户端。

响应类型判断顺序如下：
1. 有res.proxyResoponse值，代表是代理请求，把代理的响应流直接发送给客户端。
2. 有res.html值，代表是模板渲染，把res.html内容发送给客户端。
3. 有req.xhr值，代表是ajax请求，把res.apiData作为json发送给客户端。
4. 以上条件都不成立，coc框架流程结束，交给express流程。

流程过滤器可以使用stage.before，不能使用stage.after。