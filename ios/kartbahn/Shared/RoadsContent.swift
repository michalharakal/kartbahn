//
//  RoadsContent.swift
//  kartbahn
//
//  Created by Michal Harakal on 21.08.21.
//

import Foundation
import SwiftUI
import shared

class SwiftRoadsViewModel: ObservableObject, RandomAccessCollection {
    typealias ArrayType = Array<RoadViewModelData>
    typealias Index = ArrayType.Index
    typealias Element = ArrayType.Element

    internal var storage = ArrayType()

    var startIndex: Index { return storage.startIndex }
    var endIndex: Index { return storage.endIndex }

    subscript(index: Index) -> ArrayType.Element {
        get { return storage[index] }
    }

    func index(after i: Index) -> Index {
        return storage.index(after: i)
    }
}

class RoadsPreviewModel: SwiftRoadsViewModel {
    override init() {
        super.init()

        self.storage = [RoadViewModelData(name: "A1"),
                        RoadViewModelData(name: "A4"),
                        RoadViewModelData(name: "A61"),
                        RoadViewModelData(name: "A555")]
    }
}

class RoadsLiveViewModel: SwiftRoadsViewModel {
    override init() {
        super.init()
        let viewModel = RoadsViewModel.Companion.init().create()
        let roadsStateCommonFlow = viewModel.getCommonFlowFromIos()

        roadsStateCommonFlow.watch { roadState in
            if let roadState = roadState {
                self.objectWillChange.send()
                self.storage = roadState.roads
            }
        }
    }
}
