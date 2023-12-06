import Foundation
import SwiftUI

class ReadJsonData: ObservableObject {
    @Published var exhibitions = [Exhibition]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        if let file = Bundle.main.path(forResource: "exhibitions", ofType: "json") {
            do {
                guard let contentOfFile = try String(contentsOfFile: file).data(using: .utf8) else {
                    print("Could not get contents of file.")
                    return
                }
                exhibitions = try JSONDecoder().decode([Exhibition].self, from: contentOfFile)
            } catch {
                print("Could not decode data.")
            }
        } else {
            print("Could not find file.")
        }
    }
}
