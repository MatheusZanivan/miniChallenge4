//
//  ViewExtension.swift
//  MiniChallenge4
//
//  Created by Pedro henrique Dias hemmel de oliveira souza on 08/11/23.
//

import Foundation
import SwiftUI

extension View {
    public func onChange2<V>(of: V, action17: @escaping (_ oldValue: V, _ newValue: V) -> Void, actionLower: @escaping (_ newValue: V) -> Void) -> some View where V : Equatable {
        if #available(iOS 17, *) {
            return self.onChange(of: of, action17)
        } else {
            return self.onChange(of: of, perform: actionLower)
        }
    }
}
