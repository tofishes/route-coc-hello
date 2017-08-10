### 接口数据缓存

若某个api返回相对固定的数据结构，例如分类信息，省市区信息，可以设置router.cache|router.api.cache为true，这样可以将这些数据第一次请求之后缓存起来，不用每次都请求接口。

coc options可以设置缓存方法apiDataCache，默认缓存到内存中。