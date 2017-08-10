# 利用stage filter扩展router配置项增强功能

  在接口调用的过程中，往往有些参数前端不传递时，可以有个默认值。而利用filter可以很方便扩展router的一个配置项，增加默认值。实现过程如下：
  ```
  stage.after('matchRouter', (req, res, next) => {
    const defaultParam = (req.router || {}).defaultParam;

    // 为配置项增加默认参数的配置
    if (defaultParam) {
      req.param = Object.assign({}, defaultParam, req.param);
      Object.assign(req.query, req.param);
      Object.assign(req.body, req.param);
    }

    next();
  });
  ```
  
  这样，在Router路由配置章节所提及的**routerMeta**，就可以增加一项配置：routerMeta.defaultParam，类型为一个对象，将作为默认参数提供给接口。
  
  同样的做法，可以实现其他个性化用途的配置定制，需熟悉Stage下的每个章节所介绍的过程及产出物。