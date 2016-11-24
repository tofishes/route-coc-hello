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
具体流程的说明请看子章节。