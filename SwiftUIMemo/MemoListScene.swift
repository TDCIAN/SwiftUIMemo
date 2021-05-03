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
    
    var body: some View {
        NavigationView {
            List(store.list) { memo in
                VStack(alignment: .leading) {
                    Text(memo.content)
                        .font(.body)
                        .lineLimit(1) // 한 줄로만 표시, 길면 뒷부분 생략
                    
                    Text("\(memo.insertDate, formatter: self.formatter)")
                        .font(.caption)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
            }
            .navigationBarTitle("내 메모")
        }
    }
}

struct MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
            .environmentObject(MemoStore())
            .environmentObject(DateFormatter.memoDateFormatter)
    }
}
