//
//  CalendarVars.swift
//  sample-app
//
//  Created by Takudzwa Mhonde on 2018-11-04.
//  Copyright © 2018 Takudzwa Mhonde. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current
let day = calendar.component(.day , from: date)
var weekday = calendar.component(.weekday, from: date) - 1
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)
