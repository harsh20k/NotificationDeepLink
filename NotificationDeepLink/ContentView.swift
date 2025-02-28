//
//  ContentView.swift
//  NotificationDeepLink
//
//  Created by harsh  on 28/02/25.
//

import SwiftUI

struct ContentView: View {
	@Environment(AppData.self) private var appData
    var body: some View {
		// Bindable Envrionment Values
		@Bindable var appData = appData
		NavigationStack(path: $appData.mainPageNavigationPath) {
			List {
				NavigationLink("View 1", value: "View1")
				NavigationLink("View 2", value: "View2")
				NavigationLink("View 3", value: "View3")
				}
				.navigationTitle(Text("Notification Deep Link"))
				// Navigation Destination Views
				.navigationDestination(for: String.self) { value in
					Text("Hello From \(value)")
						.navigationTitle(value)
				}
			}
			.task {
					/// Notification Permissions
				let _ = try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
			}
		}
}

#Preview {
    ContentView()
}
