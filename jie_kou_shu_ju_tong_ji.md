# 接口数据统计

   ```
   const stage = coc(app);
   
   stage.before('response', (req, res, next) => {
     console.log(res.apiInfo);
   });
   ```
   
   通过在before('response')设置过滤器，拿取apiInfo来展示接口请求情况。
   每个接口信息包含：headers(接口响应headers), consumeTime(耗时), resBody(原始接口响应体), query, body, method, api等信息。
  