# QML-Sample

Base on Qt 6.4.0

## Material

工程用Material Style，对于常用原生组件可以通过Material.background等参数配置颜色。

# 组件

## iconfont

应用于KitIcon组件和text属性中，如：

```qml
RoundButton{
    font: $iconfont
    highlighted: true
    text:"\ue6b2"
}
```

示例值对照:

- &#xe6ad; \ue6ad: 叹号
- &#xe6b2; \ue6b2: 问号
- &#xe6bc; \ue6bc: 信息
- &#xeafe; \ueafe: 搜索
- &#xe8bd; \ue8bd: 对号
- &#xe634; \ue634: 叉
- &#xe60e; \ue60e: 关机
- &#xe622; \ue622: 窗口化
- &#xe781; \ue781: 清空
- &#xe77f; \ue77f: left-circle
- &#xe783; \ue783: right-circle

## KitTable

Features:
- 提供便捷的column property配置
- 冻结左栏
- 每行的右键菜单，可差异化
- 左侧checkbox，提供多选
- 左右上下滑动

todo:
- 底层采用ListView， 和TableView的性能差距？