//
//  SheetDetailArt.swift
//  MiniChallenge4
//
//  Created by Bruno Lafayette on 05/12/23.
//

import SwiftUI

struct SheetDetailArt: View {
    private var title: String
    private var author: String
    private var detail: String
    init(title: String, author: String, detail: String) {
        self.title = title
        self.author = author
        self.detail = detail
    }
    var body: some View {
        VStack{
            Text(title)
            HStack{
                Text("Autor:")
                Text(author)
            }
            Text(detail)
            Spacer()
        }
    }
}
