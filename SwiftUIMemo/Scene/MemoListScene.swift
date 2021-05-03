//
//  ContentView.swift
//  SwiftUIMemo
//
//  Created by APPLE on 2021/05/03.
//

import SwiftUI

struct MemoListScene: View {
    @EnvironmentObject var store: MemoStore
    @EnvironmentObject var formatter: DateFormatter
    
    @State var showComposer: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.list) { memo in
                    NavigationLink(destination: DetailScene(memo: memo), label: {
                        MemoCell(memo: memo)
                    })
                }
                .onDelete(perform: store.delete)
            }
            .navigationBarTitle("내 메모")
            .navigationBarItems(trailing: ModalButton(show: $showComposer))
            .sheet(isPresented: $showComposer, content: {
                ComposeScene(showComposer: self.$showComposer)
                    .environmentObject(self.store)
                    .environmentObject(KeyboardObserver())
        })
        }
    }
}

fileprivate struct ModalButton: View {
    @Binding var show: Bool
    
    var body: some View {
        Button(action: {
            self.show = true
        }, label: {
            Image(systemName: "plus")
        })
    }
}

struct MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
            .environmentObject(MemoStore())
            .environmentObject(DateFormatter.memoDateFormatter)
    }
}


