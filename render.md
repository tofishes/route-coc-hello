### render

最终的渲染模板流程。
该流程会排除coc options.viewExclude所配置的路径。

产生结果：渲染模板页面到浏览器。若没有相应的模板文件被找到，回归到express next本身流程。

可用stage.before，不可用stage.after。