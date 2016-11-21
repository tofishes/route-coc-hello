# v1对比v2
| 项目 | v1 | 对比 | v2 |
| -- | -- | -- | -- |
| 配置 | 路径api.url | -> | api.api |
|  | post参数 router.param | -> | router.body |
|  | - | -> | router.timeout |
|  | - | -> | router.cache [Boolean/Function] |
|  | - | -> | router.type [保留] |
| 参数 | router.query(query, req, res) | ->| router.query(req, res) |
|  | router.param(query, req, res) | ->| router.body(req, res) |
|  | - | ->| 其他配置可为Function类型的，均统一入参req,res. Function内this指向该router引用。router.handle方法除外，依然入参：data, req, res |
| 视图 | {{ app.request }} | -> | {{ request }} |
| 数据 | - | -> | 接口数据均挂在res.apiData下 |
| 流程 | - | -> | stage filter(cocer.before, cocer.after) |
|  | - | -> | res.forward, 服务器内跳转，可保持浏览器地址不变 |
|  | - | -> | interceptor, 拦截器，重要的改变 |


