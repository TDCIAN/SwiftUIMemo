//
//  ComposeScene.swift
//  SwiftUIMemo
//
//  Created by APPLE on 2021/05/04.
//

import SwiftUI

struct ComposeScene: View {
    @EnvironmentObject var keyboard: KeyboardObserver
//    @EnvironmentObject var store: MemoStore
    @EnvironmentObject var store: CoreDataManager
    @State private var content: String = ""
    
    @Binding var showComposer: Bool
    
//    var memo: Memo? = nil
    var memo: MemoEntity? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                TextView(text: $content)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.bottom, keyboard.context.height)
                    .animation(.easeInOut(duration: keyboard.context.animationDuration))
                    .background(Color.yellow)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle(memo != nil ? "메모 편집" : "새 메모", displayMode: .inline)
            .navigationBarItems(leading: DismissButton(show: $showComposer), trailing: SaveButton(show: $showComposer, content: $content, memo: memo))
        }
        .onAppear {
            self.content = self.memo?.content ?? ""
        }
    }
}

fileprivate struct DismissButton: View {
    @Binding var show: Bool
    
    var body: some View {
        Button(action: {
            self.show = false
        }, label: {
            Text("취소")
        })
    }
}

fileprivate struct SaveButton: View {
    @Binding var show: Bool
//    @EnvironmentObject var store: MemoStore
    @EnvironmentObject var store: CoreDataManager
    @Binding var content: String
    
//    var memo: Memo? = nil
    var memo: MemoEntity? = nil
    
    var body: some View {
        Button(action: {
            if let memo = self.memo {
                self.store.update(memo: memo, content: self.content)
            } else {
//                self.store.insert(memo: self.content)
                self.store.addMemo(content: self.content)
            }
            self.show = false
        }, label: {
            Text("저장")
        })
    }
}

struct ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
        ComposeScene(showComposer: .constant(false))
//            .environmentObject(MemoStore())
            .environmentObject(CoreDataManager.shared)
            .environmentObject(KeyboardObserver())
    }
}
