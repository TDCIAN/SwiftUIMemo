//
//  MemoStore.swift
//  SwiftUIMemo
//
//  Created by APPLE on 2021/05/03.
//

import Foundation

class MemoStore: ObservableObject {
    @Published var list: [Memo]
    
    init() {
        list = [
            Memo(content: "Lorem Ipsum 1"),
            Memo(content: "Lorem Ipsum 2"),
            Memo(content: "Lorem Ipsum 3")
        ]
    }
    
    func insert(memo: String) {
        list.insert(Memo(content: memo), at: 0)
    }
    
    func update(memo: Memo?, content: String) {
        guard let memo = memo else { return }
        memo.content = content
    }
    
    func delete(memo: Memo) {
        DispatchQueue.main.async {
            self.list.removeAll() { $0 == memo }
        }        
    }
    
    func delete(set: IndexSet) {
        for index in set {
            self.list.remove(at: index)
        }
    }
}
