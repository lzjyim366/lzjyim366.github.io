# Hexo 写作教程
## 官方文档
https://hexo.io/docs/writing.html 
## 日常工作流

| 操作 | 方式 |
|------|------|
| 启动博客服务器 | 双击 `start-blog.bat` |
| 新建文章并用 Obsidian 打开 | 双击 `new-post.bat`，输入标题 |
| 粘贴截图 | 在 Obsidian 里直接 `Ctrl+V` |
| 预览 | 浏览器打开 http://localhost:4001 |
| 关闭服务器 | 双击 `stop-blog.bat` |

---

## 环境配置

- Node.js 和 hexo-cli 路径：`C:\Users\<用户名>\.workbuddy\binaries\node\versions\20.18.0`（当前电脑的实际路径已记录在 config.bat 中）
- 已添加到用户 PATH 环境变量，直接在 cmd 中使用 `hexo` 命令即可
- 博客目录：`F:\DF\Fun\LimkoBlog\my-blog`
- 启动服务器：双击 `start-blog.bat`（端口 4001）
- 关闭服务器：双击 `stop-blog.bat`

---

## 新建文章

```bash
hexo new [layout] <title>
```
- `layout` 可省略，默认用 `post`
- 也可在 `_config.yml` 里改默认 layout

---

## 三种 Layout

| Layout | 存放位置 |
|--------|----------|
| `post` | `source/_posts` |
| `page` | `source` |
| `draft` | `source/_drafts` |

在 front-matter 里写 `layout: false` 可跳过主题渲染。

---

## 草稿（Draft）

- 草稿默认**不会**显示在博客上
- 写好后用以下命令发布：
  ```bash
  hexo publish [layout] <title>
  ```
- 预览草稿：运行时加 `--draft` 参数，或在 `_config.yml` 设置 `render_drafts: true`

---

## 文件名格式

在 `_config.yml` 里通过 `new_post_name` 自定义，可用占位符：

| 占位符 | 含义 |
|--------|------|
| `:title` | 标题（小写，空格转连字符） |
| `:year` | 年（4位） |
| `:month` | 月（2位） |
| `:i_month` | 月（不补零） |
| `:day` | 日（2位） |
| `:i_day` | 日（不补零） |

默认：`:year-:month-:day-:title.md`

---

## 模板（Scaffolds）

- 模板文件放在 `scaffolds/` 目录下
- 新建文章时 Hexo 会按 layout 名找对应模板
- 模板里可用 `{{ layout }}`、`{{ title }}`、`{{ date }}` 占位符

---

## 格式支持

- 默认支持 **Markdown** 和 **EJS**
- 安装对应渲染插件后可支持其他格式（如 Pug 等）
- 改文件后缀即可切换渲染器

---

## Tags 和 Categories

在文章顶部的 front-matter（`---` 区域）里添加。

### 基本格式

```yaml
---
title: 我的第一篇文章
date: 2026-04-21
tags:
  - 游戏
  - 攻略
categories:
  - 游戏
---
```

### 两者的区别

**Categories（分类）** — 有层级关系，顺序有意义：
```yaml
categories:
  - 技术      # 父分类
  - 前端      # 子分类（属于"技术"下的"前端"）
```
这样文章归属于 `技术 > 前端`，是一条层级路径。

**Tags（标签）** — 无层级，平级关系，打多个互不影响：
```yaml
tags:
  - JavaScript
  - CSS
  - 教程
```

### 多个独立分类

如果想让文章**同时属于多个独立分类**（而不是层级），用 `[]` 包裹：
```yaml
categories:
  - [技术, 前端]     # 技术 > 前端
  - [生活, 随笔]     # 生活 > 随笔（独立的另一个分类）
```

### 注意
- **只有 `post` 类型**的文章支持 tags 和 categories，`page` 不支持
- 新建文章后直接编辑 `source/_posts/` 下对应的 `.md` 文件修改 front-matter 即可

---

## 图片管理

### 最终方案（已配置完毕）

图片统一存放在 `source/images/文章名/` 下，Hexo 会自动复制到 public。

**目录结构：**
```
my-blog/source/
├── _posts/
│   └── 测试文章.md
└── images/
    └── 测试文章/
        └── photo.jpg   ← Obsidian Ctrl+V 自动存这里
```

**Obsidian 设置：**
- Vault 根目录：`my-blog/source/`
- 设置 → 文件与链接 → 关闭「使用 Wiki 链接」
- 设置 → 文件与链接 → 新建链接格式 → 「基于仓库根目录的绝对路径」
- 社区插件 **Custom Attachment Location** → Attachment location 填 `images/${noteFileName}`

**Hexo 脚本自动修正路径：**

`scripts/fix-image-path.js` 会在渲染时自动把 `images/` 补成 `/images/`，无需手动处理。

文章里引用图片（Obsidian 自动生成，不用手写）：
```markdown
![](images/测试文章/photo.jpg)   ← Obsidian 生成
↓ 脚本自动修正为
![](/images/测试文章/photo.jpg)  ← Hexo 正确识别
```
