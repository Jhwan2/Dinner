//
//  HomeSteps.swift
//  Dinner
//
//  Created by 주환 on 3/19/24.
//

import RxFlow
import UIKit

enum HomeSteps: Step {
    case homeIsRequired
    case deliveryIsRequired
    case leftoverIsRequired
    case historyIsRequired
}
