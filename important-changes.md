# 重要变更
* 2017-08-10 v1.2.9
  1. 新增stage: response 作为最终流程。
  2. 新增res.html扩展，是由render stage产生的模板渲染结果。
  3. 增强res.apiInfo数据。通过stage.before('response')添加的过滤器，可以通过res.apiInfo来获取代理接口或路由配置接口的响应信息和响应结果，比如获取response headers。可以直接输出res.apiInfo来查看。
  4. res.forward 能够转到任何外域名网址(http://或https://开头的完整地址)。
  5. 以前配置两个路由：/news/publish 和 /news/:id ，可能会发生冲突，现在不会了：无参路由会优先匹配。