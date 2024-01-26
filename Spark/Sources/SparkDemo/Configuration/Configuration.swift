//
//  Configuration.swift
//  SparkDemo
//
//  Created by robin.lemaire on 31/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

public enum Configuration: CaseIterable {

    // MARK: - Properties

    public static var rootViewController: UIViewController = SparkTabbarController()

    public static func load() {
        ConsoleView.shared.show()
    }
}
