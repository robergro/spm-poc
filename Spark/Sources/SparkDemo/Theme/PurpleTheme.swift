//
//  PurpleTheme.swift
//  Spark
//
//  Created by alex.vecherov on 01.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import Spark
import SparkTheme

public struct PurpleTheme: Theme {

    // MARK: - Properties

    public init() {}

    public static let shared = Self()

    public let border: Border = PurpleBorder()
    public let colors: Colors = PurpleColors()
    public let elevation: Elevation = PurpleElevation()
    public let layout: Layout = PurpleLayout()
    public let typography: Typography = PurpleTypography()
    public let dims: Dims = PurpleDims()
}
