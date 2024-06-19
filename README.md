# todo
TODO app 使用史蒂芬‧柯維（Stephen Covey）提出的「時間管理矩陣」來為待辦事項做分類。並於每日UTC 00:00 (GMT+8 8:00)通知使用者完成任務度
在Udemy中完成課程。並在課後自己延伸出任務導覽頁面、設定畫面與自動推播功能
https://www.udemy.com/course/flutter-made-easy-zero-to-mastery/

## 成品
* 網站版：https://todo-app-251e7.web.app/

## 功能
* 任務導覽：顯示使用者當前任務完成度，與各分類的完成度
* 任務分類：顯示我有任務分類，點擊任務分類可以查看該分類內有完成與未完成的待辦事項。任務分類主要以「時間管理矩陣」做為基礎。
* 設定：目前只有推播功能的開啟與關閉。開啟後UTC 00:00時間會收到目前所有任務的完成度，或提醒使用者新增任務。

## 安裝
將專案使用git clone下載即可
```
git clone https://github.com/jo60913/TODO
```

## 設置
Flutter 版本為3.16.8
Dart 版本為3.2.5

## Build and Run
在Android studio IDE下 直接點擊Run

## 用法
使用BLoC模式+clean architecture架構開發，flutter_adaptive_scaffold套件做適配。目前成功運行在在Android、網頁上。
目前資料庫存放在Firebase Firestore。Udemy課程是在flutter呼叫cloud_firestore套件來直接存取內容。所以目前待辦事項還是以cloud_firestore來呼叫為主。
只有在設定->推播設定的值是取自後端/get/notification api，更新推播設定時呼叫/update/notification api
* 路由使用go_router套件，路由設定檔案在lib/application/core/routes.dart當中
* 登入與個人資料頁面使用firebase_ui_auth套件的SignInScreen、ProfileScreen產生。所以目前還只有英文內容
* BLoC使用flutter_bloc套件

## 操作
* Udemy完課後的app狀況  
![image](https://github.com/jo60913/TODO/blob/main/readmeimage/az_recorder_20240616_114225.gif?raw=true)
* 自己延伸Udemy後的app  
![image](https://github.com/jo60913/TODO/blob/main/readmeimage/az_recorder_20240616_090920.gif?raw=true)

## 打包
更改versionCode 在pubspec.yaml 當中version1.0.0+n 修改N的內容即可
打包aab 在build.gradle中設定好key.properties所以只要打flutter build appbundle指令。aab檔就會出現在
{專案路徑}/Todo/build/app/outputs/bundle/release/app-release.aab