### render

最终的渲染模板流程。
该流程会排除coc options.viewExclude所配置的路径。

产生结果：res.html(模板渲染结果)。若没有相应的模板文件被找到，流向下一个流程。