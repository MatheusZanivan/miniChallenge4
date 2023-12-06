//
//  CameraViewModel.swift
//  MiniChallenge4
//
//  Created by Well on 05/12/23.
//

import Foundation

class CameraViewModel: ObservableObject {
    func getSheetInfo(sheetInfo: String) -> String {
        return sheetInfo != "exhaust" ? sheetInfo : String()
    }
}
