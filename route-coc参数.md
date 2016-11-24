## coc和Stage

在《开始使用》章节，有下面一段代码：
```
const stage = coc(app);
```
调用coc后返回一个stage实例，该实例是一个Stage对象实例。
Stage是流程实现类，非常核心的一个功能类。

### coc参数

coc完整的调用方式是：

```
coc(app, options);
```

调用coc可以传入以下参数，不传则以默认值代替：

```
options =  { 
  routerDir = defaultRouterDir, // 路由目录 
  interceptorDir = defaultInterceptorDir, // 拦截器目录
  viewDir = defaultViewDir, viewExclude = ['**/include/**'], // 排除自动渲染模板的目录
  stages = defaultStages, // 默认stage列表
  mount = '/', // 程序挂载路径，类型符合express path examples
  apiDataCache = memoryCache, // 接口数据缓存方法，默认存储于内存中
  handleAPI = url => url // api地址预处理方法
}

```