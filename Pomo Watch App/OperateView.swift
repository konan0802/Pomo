//
//  OperateView.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/05.
//

import SwiftUI

struct OperateView: View {
    
    @ObservedObject var display: Display

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Text("＜")
                    .onTapGesture {
                        display.operateViewOn = false
                    }
                
                Text("OperateView!")
            }
        }
    }
}

/*
struct OperateView_Previews: PreviewProvider {
    static var previews: some View {
        OperateView()
    }
}
*/
