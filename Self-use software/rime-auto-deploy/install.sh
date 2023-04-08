#!/bin/bash

echo "==== Rime 自动配置 ===="
echo "您是否已经安装了 Rime 输入法？(y/n)"

read result
if [ "$result" != "y" ]
then
  echo "(1/4) 是否安装 Rime 输入法？(y/n)"
  read result
  if [ "$result" = "y" ]
  then
    brew install --cask squirrel
  fi
  echo "步骤1：注销并重新登录系统"
  echo "步骤2：在系统面板中将 Rime 输入法设置为默认输入法"
  echo "步骤3：重新运行此程序，跳过安装 Rime 输入法步骤"
else
  echo "是否要继续配置 Rime 输入法？(y/n)"
  read result
  if [ "$result" != "y" ]
  then
    exit 0
  fi

  echo "(2/4) 备份默认配置"
  echo "运行 'mv ~/Library/Rime ~/Library/Rime.old'"
  mv ~/Library/Rime ~/Library/Rime.old
  echo "完成 ✅"
  echo ""
  echo "(3/4) 下载自定义配置"
  echo "下载 default.custom.yaml 文件"
  curl -o ./default.custom.yaml https://raw.githubusercontent.com/ei0ch/Self-use/master/Self-use%20software/rime-auto-deploy/default.custom.yaml
  echo "下载 squirrel.custom.yaml 文件"
  curl -o ./squirrel.custom.yaml https://raw.githubusercontent.com/ei0ch/Self-use/master/Self-use%20software/rime-auto-deploy/squirrel.custom.yaml
  echo "完成 ✅"
  echo ""
  echo "(4/4) 应用自定义配置"
  echo "运行 'cp ./default.custom.yaml ~/Library/Rime/default.custom.yaml'"
  cp ./default.custom.yaml ~/Library/Rime/default.custom.yaml
  echo "运行 'cp ./squirrel.custom.yaml ~/Library/Rime/squirrel.custom.yaml'"
  cp ./squirrel.custom.yaml ~/Library/Rime/squirrel.custom.yaml
  echo "完成 ✅"
  echo ""
  echo "Rime 自动配置完成"
  echo "请在 Rime 设置面板中点击“Deploy”按钮以应用更改。"
fi
