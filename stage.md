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
上面是各流程的**stageName**，stage提供的过滤器方法即是针对这些stageName使用，默认流程可以使用stage.stageNames获取。

具体流程的说明请看子章节。coc(app)执行之后返回一个stage实例，可使用以下api方法。

Stage提供的api如下：
`stage.before(stageName, (req, res, next) => {})`: 前置过滤器方法。往默认流程插入自定义流程。
`stage.after(stageName, (req, res, next) => {})`: 后置过滤器方法。往默认流程插入自定义流程。
`stage.set(name, value)`: 设置一个属性。
`stage.get(name)`: 获取一个属性。
`stage.handle(req, res, next)`: 流程处理方法，核心方法。本质是一个express middleware。

before|after方法应该是调用者经常使用的方法。每个stage流程会有一些结果产出，可以用after对结果加工处理。
next()是需要被执行的，否则无法流向下一个流程。除非在next()前做了响应(res.send等)。

例子1、记录耗时日志：
```
const stage = coc(app);
stage.before('pageInfo', (req, res, next) => {
  req.startTime = Date.now();
  next();
});
stage.before('render', (req, res, next) => {
  const endTime = Date.now();
  const consume = endTime - req.startTime;
  console.log('consume times: ', consume, 'ms');
  next();
})
```