import SwiftUI

struct SheetExhibitionView: View {
    
    @ObservedObject var exhibitionData = ReadJsonData()
    
    private let exhibitionName: String
    init(exhibitionName: String) {
        self.exhibitionName = exhibitionName
    }
    @State var exhibition: Exhibition? = nil
//    private var name: String
//    private var author: String
//    private var description: String
    
    
    
    var body: some View {
        VStack{
            if let exhibition {
                Text(exhibition.name)
                HStack{
                    Text("Autor: \(exhibition.author)")
                }
                Text(exhibition.description)
            }
            Text(exhibitionName)
            Spacer()
            
        }
        .onReceive(exhibitionData.$exhibitions) { exhibitions in
            for exhibition in exhibitions {
                print(exhibition.name.forSorting.split(separator: " ").joined(separator: "_"))
                if exhibition.name.forSorting.split(separator: " ").joined(separator: "_") == exhibitionName {
                    self.exhibition = exhibition
                }
            }
        }
    }
}
