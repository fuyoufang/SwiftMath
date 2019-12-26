# SwiftMath

在开发的工程中，有需要显示数学公式的需求，例如下面的

![](https://user-gold-cdn.xitu.io/2019/12/25/16f3c1de14b4c85d?w=279&h=102&f=png&s=4771)

![](https://user-gold-cdn.xitu.io/2019/12/25/16f3c1e0d0877c4a?w=321&h=139&f=png&s=7245)

实现上面的显示方式，可以使用三种方式：
### 使用图片
将数学公式在服务器端生成图片，前端使用图片来展示数学公式。

> 使用这种方式前端难以排版，难以控制图片的缩放比例，灵活性低。

### WebView 加载数学公式引擎 —— KaTeX

现在已经有一个非常成熟的排版系统 [LaTeX](https://www.latex-project.org/)，它支持使用文本来表达复杂的数学公式、表格等。如果单纯的显示数学公式的话，可以使用 LaTeX 的子集 [KaTeX](https://katex.org/), 它是一个支持 HTML 的轻量级的数学公式引擎。

我们可以在需要显示数学公式时创建一个 WebView，引入 KaTeX 来渲染数学公式。

> 使用这种方式存在几种问题：
> 1. WebView 加载数学公式的速度非常慢。
> 2. 如果需要在 TableView 的 Cell 中加载数学公式，则可能出现一个页面中需要多个 WebView 的情况，会进一步见面页面刷新的速度。其次 TableView 不能自动推断出 WebView 的高度，从而难以控制 Cell 的高度。

### iosMath + YYText 的组合
[iosMath](https://github.com/kostub/iosMath) 是一个专门用于显示数学公式的框架，但是它不支持将其他文字和数学公式一起显示。所以我们只能从一段文字当中提取表达数学公式的部分，将其丢给 iosMath 显示，其他的内容还需要其他控件来展示。

所以我们还需要使用 [YYText](https://github.com/ibireme/YYText) ，将 iosMath 框架中的用于显示数学公式的 MTMathUILabel 作为一段 AttachmentString，使其和其他文字进行拼接。

另外还需要考虑在数学公式过长，一个页面显示不全时，需要左右滚动方便用户查看数学公式。所以用于展示信息的 YYLabel 还需要放在一个 UIScrollView 中。

具体的实现方式可以查看 [github](https://github.com/FuYouFang/SwiftMath)。

| 项目截图1 | 项目截图2 | 
| :--: | :--: |
| ![][1] | ![][2] |

[1]:./Images/Math.png
[2]:./Images/iosMath+YYLabel.png

### 参考
[廖雪峰--使用 KaTeX 渲染数学公式](https://www.liaoxuefeng.com/article/1280024328011810) 

