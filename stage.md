# Stage

Stage是流程实现类，非常核心的一个功能类。它负责执行一些流程定义，coc默认流程如下：
```
[
  "pageInfo",
  "matchRouter",
  "initHttpRequest",
  "requestProxy",
  "handleInterceptor",
  "handleRouter",
  "runTask",
  "getViewPath",
  "render"
]
```
具体流程的说明请看子章节。coc(app)执行之后返回一个stage实例，可使用以下api方法。

Stage提供的api如下：
`before`: [Function]，前置过滤器方法。往默认流程插入自定义流程。
`after`: [Function]，后置过滤器方法。往默认流程插入自定义流程。

before|after方法是