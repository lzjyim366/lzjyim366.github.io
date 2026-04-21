# 新电脑环境搭建

## 快速安装（推荐）

1. 安装 Node.js（见下方第 1 步）
2. 安装 Hexo CLI（见下方第 2 步）
3. 克隆仓库（见下方第 3 步）
4. 双击 `setup.bat` → 自动检测 Node.js 路径并生成 `config.bat`
5. 双击 `start-blog.bat` 验证是否正常

---

## 手动安装步骤（备用）
主题：git@github.com:finch-xu/hexo-theme-warmpaper.git 
hexo安装：
## 1. 安装 Node.js

前往 https://nodejs.org 下载安装 LTS 版本。

## 2. 安装 Hexo CLI

```cmd
npm install -g hexo-cli
```

## 3. 克隆仓库

```cmd
git clone <仓库地址> LimkoBlog
```

## 4. 安装 Hexo 依赖

```cmd
cd LimkoBlog\my-blog
npm install
```

## 5. 修改 bat 文件路径

打开以下三个文件，把 `NODE_PATH` 改成新电脑上 Node.js 的实际安装路径：
- `start-blog.bat`
- `new-post.bat`

找到 Node.js 路径的方法：
```cmd
where node
```

将结果中的目录路径填入 bat 文件的 `NODE_PATH=` 这一行。

如果 Node.js 是系统安装（非 CodeBuddy 内置），bat 里的 `NODE_PATH` 那两行可以直接删掉，hexo 命令会自动找到。

## 6. 添加环境变量（如需在 cmd 中直接使用 hexo）

```cmd
setx PATH "%PATH%;<Node.js 安装路径>"
```

重新打开 cmd 后生效。

## 7. 安装 Obsidian

前往 https://obsidian.md 下载安装。

打开仓库：`LimkoBlog\my-blog\source`

插件设置：
- 社区插件 → 安装 **Custom Attachment Location**
- 插件设置 → Attachment location 填 `images/${noteFileName}`
- 设置 → 文件与链接 → 关闭「使用 Wiki 链接」
- 设置 → 文件与链接 → 新建链接格式 → 「基于仓库根目录的绝对路径」

## 8. 验证

双击 `start-blog.bat`，浏览器打开 http://localhost:4001 确认正常。
