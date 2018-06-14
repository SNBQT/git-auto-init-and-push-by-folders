#!/bin/bash

if [ ! -f .env ]; then
    echo -e '\nerror occurred: not find .env file\nPlease run " cp .env.example .env " and config it first.\n'
    exit 1
fi

# need support Chinese hanzi to pinyin
type pypinyin >/dev/null 2>&1 || { echo >&2 "require pypinyin but it's not installed.  Installing... "; pip install pypinyin; }

for i in $(grep -v '^#' .env | xargs)
do
  echo $i
done
echo ''

export $(grep -v '^#' .env | xargs)

git config --global user.name "$username"
git config --global user.email "$useremail"

# Projects path
rootPath=$PWD/$dirProjects
index=0
folderList=[]

# Each folders
cd $rootPath
for i in $(ls $rootPath)
do
  echo $index $i
  folderList[index]=$i
  index=`expr $index + 1`
done
# if [ 0 == $index ] ; then
if [ 0 == $index ] ; then
    echo -e "\nerror occurred: not find project in $rootPath\n"
    exit 1
fi

# Print folders length
echo folders length: ${#folderList[@]}

# Git Init
for dirName in ${folderList[*]}
do
  echo '
  '
  echo $dirName
  workPath=$rootPath/$dirName 
  projectName=$dirName 
  projectPath=$"`pypinyin -s NORMAL $dirName`"  # support Chinese hanzi to pinyin
  projectPath=${projectPath// /-}  # replace space with -

  data='{"name":"replacement","visibility":"private","namespace_id":namespaceId,"path":"replacepath","visibility":"visibility_level"}' 
  postData=${data//replacement/$projectName} 
  postData=${postData//replacepath/$projectPath} 
  postData=${postData//namespaceId/$grouppathId} 
  postData=${postData//visibility_level/$visibility_level} 
  
  echo $postData
  
  # Gitlab Create Projects
  curl --header "Private-Token: $accesstoken" \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -X POST \
  -d $postData \
  https://$domain/api/v4/projects
  
  # Git repository init & push
  echo $workPath
  cd $workPath
  git pull
  git pull --no-ff origin master
  git init
  git remote remove git-auto-init-and-push-by-folders
  git remote add git-auto-init-and-push-by-folders https://$username:$password@$domain/$grouppath/$projectPath.git
  git pull git-auto-init-and-push-by-folders master
  rm git-auto-init-and-push-by-folders.md
  echo -e "git-auto-init-and-push-by-folders code supported by Ansi Zhang, for more please view https://github.com/SNBQT/git-auto-init-and-push-by-folders \n" >> git-auto-init-and-push-by-folders.md
  echo -e "It last used to this project by $username at `date`\n" >> git-auto-init-and-push-by-folders.md
  git add git-auto-init-and-push-by-folders.md
  git add .
  git commit -m "git-auto-init-and-push by $username"
  git push -u git-auto-init-and-push-by-folders master
  
done

echo -e "\n\n"