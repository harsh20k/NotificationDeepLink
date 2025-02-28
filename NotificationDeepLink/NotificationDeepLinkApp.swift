//
//  NotificationDeepLinkApp.swift
//  NotificationDeepLink
//
//  Created by harsh  on 28/02/25.
//

import SwiftUI

@main
struct NotificationDeepLinkApp: App {
	@UIApplicationDelegateAdaptor(AppData.self) private var appData
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(appData)
        }
    }
}

@Observable
class AppData : NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
	var mainPageNavigationPath: [String] = []
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		UNUserNotificationCenter.current().delegate = self
		return true
	}
	
	//willpresent
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
		// Showing alert even when app is active
		
		return [.sound, .banner]
	}
	
	// Handling Notification
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
		//print(response.notification.request.content.userInfo)
		
//		[AnyHashable("Simulator Target Bundle"): com.AnimeAI.NotificationDeepLink, AnyHashable("aps"): {
//			alert =     {
//				body = "Go to View 1";
//				title = "Push Notification's";
//			};
//			badge = 0;
//		}, AnyHashable("pageLink"): View1]
		
		if let pageLink = response.notification.request.content.userInfo["pageLink"] as? String {
			if mainPageNavigationPath.last != pageLink {
				// Optional: Removing all previous pages
				// You can skip this step if you want to maintain previous pages as well
				mainPageNavigationPath = []
				// Pushing our new page
				mainPageNavigationPath.append(pageLink)
			}
		}
		
	}
}
