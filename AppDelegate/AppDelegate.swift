//
//  AppDelegate.swift
//  WWTBM
//
//  Created by Илья Рехтин on 09.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var timesOfOpenApp = 0
    let careteker = GameCaretaker(key: .questions)

    /// метод сохраняет в userdefuls свойство хранящее количество запуска программы
    private func saveTimesOfOpenApp() {
        UserDefaults.standard.set(timesOfOpenApp, forKey: "timesOpenApp")
    }
    
    /// получаем данные о количествах запуска программы
    private func getNumberTimesOfOpenApp() -> Int {
       return UserDefaults.standard.integer(forKey: "timesOpenApp") + 1
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.timesOfOpenApp = getNumberTimesOfOpenApp()
        ///если первый запуск загружаем в userdefuls стандартный список вопросов
        if self.timesOfOpenApp == 1 {
            careteker.saveData(data: DataManager.data.questions)
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        /// при закрытии программы сохраняем данные о запуске приложения
        saveTimesOfOpenApp()
    }


}

