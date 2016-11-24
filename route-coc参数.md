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

app是express app对象，options可以传以下配置，不传则以默认值代替：

```
options =  { 
  routerDir = defaultRouterDir,           // 路由目录 
  interceptorDir = defaultInterceptorDir, // 拦截器目录
  viewDir = defaultViewDir,               // 视图模板目录        
  viewExclude = ['**/include/**'],        // 排除自动渲染模板的目录，采用glob匹配规则
  stages = defaultStages,                 // 默认stage列表 
  mount = '/',                            // 程序挂载路径，默认为根路径，类型符合express path examples
  apiDataCache = memoryCache,             // 接口数据缓存方法，默认存储于内存中
  handleAPI = url => url                  // api地址预处理方法，默认返回自身
}

```

默认值定义为：
```
const pwd = process.cwd(); // 当前运行app.js所在目录
const defaultRouterDir = `${pwd}/routers`; // 同目录下的routers
const defaultInterceptorDir = `${pwd}/interceptors`; // 同上
const defaultViewDir = `${pwd}/views`; // 同上

// 接口数据缓存方法的接口定义，自定义的方法需按以下定义实现(伪代码)：
interface apiDataCache(key, value);
// 设置及获取
get apiDataCache(key);
set apiDataCache(key, value);
```

`viewExclude`参数的含义是排除自动渲染模板的目录，比如默认就是禁止直接访问 /views/include 目录下的模板文件。
PS: 自动渲染模板，是指未配置任何router时，访问 /page/a 时会自动渲染 /views/page/a.swig 模板。