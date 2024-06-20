# ToDo待辦事項
TODO app 使用史蒂芬‧柯維（Stephen Covey）提出的「時間管理矩陣」來為待辦事項做分類。並於每日UTC 00:00 (GMT+8 8:00)通知使用者完成任務度
在Udemy中完成課程。並在課後自己延伸出任務導覽頁面、設定畫面與自動推播功能
https://www.udemy.com/course/flutter-made-easy-zero-to-mastery/

## 成品
* 網站版：https://todo-app-251e7.web.app/
* Android版 Google Play：https://play.google.com/store/apps/details?id=com.huangliner.todo

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

## Api專案的Github
https://github.com/jo60913/Todo-api

## 用法
使用BLoC模式+clean architecture架構開發，flutter_adaptive_scaffold套件做適配。目前成功運行在在Android、網頁上。
目前資料庫存放在Firebase Firestore。Udemy課程是在flutter呼叫cloud_firestore套件來直接存取內容。所以目前待辦事項還是以cloud_firestore來呼叫為主。
只有在設定->推播設定的值是取自後端/get/notification api，更新推播設定時呼叫/update/notification api
* 路由使用go_router套件，路由設定檔案在lib/application/core/routes.dart當中
* 登入與個人資料頁面使用firebase_ui_auth套件的SignInScreen、ProfileScreen產生。所以目前還只有英文內容
* BLoC使用flutter_bloc套件

## 操作
* Udemy完課後的app狀況
1.登入畫面使用Firebase Auth UI並設定電話驗證登入 
2. 完成任務分類頁面與新增
3. 完成任務頁面與新增
4. 其他頁面用來練習路由切換用
5. 設定頁面用來測試Firebase Crashlytics 接收到的狀況
![image](https://github.com/jo60913/TODO/blob/main/readmeimage/az_recorder_20240616_114225.gif?raw=true)
* 自己延伸Udemy後的app
1. 登入頁面修改為email登入
2. 新增導覽頁面並顯示每個分類的完成度
3. 設定頁面新增推播，並從api中更新推播設定
4. 任務分類頁面新增刪除並修改為時間管理矩陣 
5. 任務分類按最右邊可以刪除 
6. 任務頁面長按顯示刪除 
7. 新增Fcm推播
![image](https://github.com/jo60913/TODO/blob/main/readmeimage/az_recorder_20240616_090920.gif?raw=true)

## 結構
專案結構
```
.
├── application
│   ├── app
│   │   ├── basic_app.dart      //app主題設定
│   │   └── cubit       //登入頁面 檢查是否有登入過
│   │       ├── auth_cubit.dart
│   │       └── auth_state.dart
│   ├── component
│   │   └── todo_entry_item     //任務頁面中的每個任務item的view
│   │       ├── bloc            //載入每個任務的
│   │       │   ├── todo_entry_item_cubit.dart  
│   │       │   └── todo_entry_item_state.dart
│   │       ├── todo_entry_item.dart
│   │       └── view_state      //載入任務時的Bloc 狀態
│   │           ├── todo_entry_item_error.dart
│   │           ├── todo_entry_item_loaded.dart
│   │           └── todo_entry_item_loading.dart
│   ├── core
│   │   ├── constants.dart         //常數
│   │   ├── firebase_api.dart      //android使用FCM設置
│   │   ├── form_value.dart         //監聽新增任務時的狀態
│   │   ├── go_router_observer.dart     //路由轉換監聽
│   │   ├── page_config.dart    //頁面設置 每個page都會有一個這個來統一紀錄每個頁面跳轉狀態
│   │   └── routes.dart     //路由畫面
│   └── page
│       ├── create_todo_collection_page     //新增任務分類
│       │   ├── bloc       //新增任務分類的Bloc
│       │   │   ├── create_todo_collection_page_cubit.dart
│       │   │   └── create_todo_collection_page_state.dart
│       │   └── create_todo_collection_page.dart    //新增任務分類的頁面
│       ├── create_todo_entry   //任務頁面新增
│       │   ├── bloc        //新增任務時Bloc
│       │   │   ├── create_to_do_entry_page_cubit.dart
│       │   │   └── create_to_do_entry_page_state.dart
│       │   └── create_todo_entry_page.dart //任務頁面新增時的畫面
│       ├── dashboard       //任務導覽頁面
│       │   ├── bloc    //下載任務分類圖表的Bloc
│       │   │   ├── todo_dashboard_cubit.dart
│       │   │   └── todo_dashboard_state.dart
│       │   ├── dashboard.dart
│       │   └── view_states     //下載任務分類圖表的Bloc ＵＩ
│       │       ├── todo_dashboard_error.dart
│       │       ├── todo_dashboard_loaded.dart
│       │       └── todo_dashboard_loading.dart
│       ├── detail      //任務頁面
│       │   ├── bloc        //下載任務時的Bloc
│       │   │   ├── to_do_detail_cubit.dart     
│       │   │   └── to_do_detail_state.dart     
│       │   ├── delete_todo_entry
│       │   │   ├── bloc        //刪除任務用bloc
│       │   │   │   ├── todo_entry_delete_cubit.dart
│       │   │   │   └── todo_entry_delete_state.dart    
│       │   │   └── view_states
│       │   │       └── todo_entry_delete_error.dart
│       │   ├── todo_detail.dart
│       │   └── view_state          //下載任務時Bloc的UI
│       │       ├── todo_detail_error.dart          
│       │       ├── todo_detail_loaded.dart
│       │       └── todo_detail_loading.dart
│       ├── home
│       │   ├── bloc
│       │   │   ├── navigation_todo_cubit.dart
│       │   │   └── navigation_todo_state.dart
│       │   ├── component
│       │   │   └── login_button.dart
│       │   └── home.dart
│       ├── overview    //任務導覽頁面
│       │   ├── bloc
│       │   │   ├── todo_overview_cubit.dart    //任務導覽用Bloc的Cubit
│       │   │   └── todo_overview_cubit_state.dart //任務導覽用Bloc的state
│       │   ├── overview_page.dart  
│       │   └── view_states     //任務導覽在Bloc不同狀態時的UI
│       │       ├── todo_overview_error.dart
│       │       ├── todo_overview_loaded.dart
│       │       └── todo_overview_loading.dart
│       └── setting     //  設定頁面
│           └── setting_page.dart
├── core
│   └── use_case.dart     usercase的父類
├── data
│   ├── data_source
│   │   ├── interface
│   │   │   ├── api_remote_data_source.dart                 api 使用data source 的interface
│   │   │   ├── todo_local_data_source_interface.dart       本地資料庫使用data source interface (已停用)
│   │   │   └── todo_remote_data_source_interface.dart      firestore所使用data source
│   │   ├── local
│   │   │   ├── hive_local_data_source.dart     本地資料庫實現類 todo_local_data_source_interface實現類 (已停用)
│   │   │   └── memory_local_data_source.dart   將資料暫存對象 
│   │   ├── mapper
│   │   │   ├── todo_collection_mapper.dart
│   │   │   └── todo_entry_mapper.dart
│   │   └── remote
│   │       ├── api_remote_data_source.dart     api實際呼叫的地方
│   │       └── firestore_remote_data_source.dart     firestore實際呼叫的地方
│   ├── exception
│   │   └── exception.dart
│   ├── model
│   │   ├── api
│   │   │   ├── api_response.dart   api回傳轉成對象
│   │   │   ├── api_response.g.dart
│   │   │   ├── get_token_response.dart /notification/fcm api 回傳對象
│   │   │   └── get_token_response.g.dart
│   │   ├── todo_collection_model.dart
│   │   ├── todo_collection_model.g.dart
│   │   ├── todo_entry_model.dart
│   │   └── todo_entry_model.g.dart
│   └── repository
│       ├── todo_repository_local.dart      本地資料庫用repository
│       ├── todo_repository_mock.dart       測試用repository  
│       └── todo_repository_remote.dart     使用Firbase Firstore用repository
├── domain
│   ├── entity
│   │   ├── todo_collection.dart
│   │   ├── todo_collection_and_entry.dart
│   │   ├── todo_entry.dart
│   │   └── unique_id.dart
│   ├── failure
│   │   └── failures.dart   //當FireStore 回傳錯誤時使用
│   ├── repository
│   │   └── todo_repository.dart    //Repository interface
│   └── usecase
│       ├── create_fcm_token.dart       //每次登入時更新一次使用者fcm token
│       ├── create_todo_collection.dart //新增任務分類至firestore
│       ├── create_todo_entry.dart      //新增任務至firestore
│       ├── delete_todo_collection.dart //刪除任務分類 會先刪除當中的任務後再刪除分類本身
│       ├── delete_todo_entry.dart      //刪除任務
│       ├── load_fcm_setting.dart       //從api中取得使用者推播設定
│       ├── load_todo_collection_and_entry.dart     //任務導覽用來統計完成率
│       ├── load_todo_collections.dart  //顯示待辦事項的分類
│       ├── load_todo_entry.dart        //顯示分類下的任務
│       ├── load_todo_entry_ids_for_collection.dart     //取得當前任務分類的id，新增任務時使用
│       ├── update_fcm_value.dart       //使用api更新FCM推播設定
│       └── update_todo_entry.dart      //更新任務狀態
├── firebase_options.dart
├── main.dart   程式入口
└── resource
    ├── app_color.dart  存放顏色
    ├── app_color_array.dart     任務分類時新增分類用顏色
    └── app_string.dart 中文字資源

```

## 打包
更改versionCode 在pubspec.yaml 當中version1.0.0+n 修改N的內容即可    
打包aab 在build.gradle中設定好key.properties所以只要打
```
flutter build appbundle
```
指令。aab檔就會出現在 {專案路徑}/Todo/build/app/outputs/bundle/release/app-release.aab

## 使用套件
* go_router 路由
* flutter_adaptive_scaffold 畫面的適配
* flutter_bloc bloc模式使用套件
* json_annotation json與對象轉換
* firebase_ui_auth 登入畫面
* cloud_firestore 連接Firebase Firestore
* firebase_crashlytics Firebase崩潰紀錄
* fl_chart  用來顯示任務總覽頁面的比例圖
* firebase_messaging 推播使用套件
* flutter_launcher_icons 切割app icon使用套件
* dio 連接api使用的網路套件