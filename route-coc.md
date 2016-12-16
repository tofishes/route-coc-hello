## coc

在《开始使用》章节，有下面一段代码：
```
const stage = coc(app);
```
调用coc后返回一个stage实例，该实例是一个Stage对象实例。
Stage是流程实现类，非常核心的一个功能类(详见《Stage》章节)。

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
  interceptXhr = false,                   // 是否拦截ajax请求，默认不拦截
  viewDir = defaultViewDir,               // 视图模板目录        
  viewExclude = ['**/include/**'],        // 排除自动渲染模板的目录，采用glob匹配规则
  stages = defaultStages,                 // 默认stage列表 
  mount = '/',                            // 程序挂载路径，默认为根路径，类型符合express path examples
  apiDataCache = memoryCache,             // 接口数据缓存方法，默认存储于内存中
  apiDataName,                            // 接口数据名方法，默认为获取api地址最后一个/后面的单词名
  handleAPI = url => url                  // router.api地址预处理方法，默认返回自身
}

```

目录默认值定义为：
```
const pwd = process.cwd(); // 当前运行app.js所在目录
const defaultRouterDir = `${pwd}/routers`; // 同目录下的routers
const defaultInterceptorDir = `${pwd}/interceptors`; // 同上
const defaultViewDir = `${pwd}/views`; // 同上
```


`interceptXhr`指拦截器配置是否对ajax请求有效，默认不拦截。

`viewExclude`参数的含义是排除自动渲染模板的目录，
比如默认就是禁止直接访问 /views/include 目录下的模板文件。
PS: 自动渲染模板，是指未配置任何router时，访问 /page/a 时会自动渲染 /views/page/a.swig 模板。

`stages`配置一般不用动，高级定制才需要，确保已经深刻理解route-coc的工作机制。

`mount`路径配置，指使用coc处理哪些路径下的请求，本质是 express app.use(mount, ()=>{})中的mount。<br>
 具体路径规则请查看 http://expressjs.com/en/4x/api.html#path-examples

`apiDataCache`接口数据缓存方法的接口定义，自定义的方法需按以下定义实现(伪代码)：
```
interface apiDataCache(key, value);
// 设置及获取
get apiDataCache(key);
set apiDataCache(key, value);
```

`apiDataName`接口数据名生成方法，当未配置routerMeta.name时，将使用该生成方法得到一个数据存储名，即res.apiData[name]中的name。因此，合理设置apiDataName可以简化routerMeta.name配置。apiDataName默认是以下方法实现：
```
// 入参为routerMeta.api地址字符串，this指向当前routerMeta对象
function apiDataName(api) {
  return api.substr(api.lastIndexOf('/') + 1);
}
```

`handleAPI`是对router.api地址的处理。
