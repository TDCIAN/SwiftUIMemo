//
//  MemoCell.swift
//  SwiftUIMemo
//
//  Created by APPLE on 2021/05/03.
//

import SwiftUI

struct MemoCell: View {
    @ObservedObject var memo: Memo
    @EnvironmentObject var formatter: DateFormatter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.content)
                .font(.body)
                .lineLimit(1) // 한 줄로만 표시, 길면 뒷부분 생략
            
            Text("\(memo.insertDate, formatter: self.formatter)")
                .font(.caption)
                .foregroundColor(Color(UIColor.secondaryLabel))
        }
    }
}

struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoCell(memo: Memo(content: "Test"))
            .environmentObject(DateFormatter.memoDateFormatter)
    }
}
