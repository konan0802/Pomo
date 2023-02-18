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
            Color.black.ignoresSafeArea()
            VStack {
                HStack{
                    Text("< Back").onTapGesture {display.operateViewOn = false}
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    Image("MTG")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45)
                    Spacer()
                    Image("MTG")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45)
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    Image("MTG")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45)
                    Spacer()
                    Image("MTG")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45)
                    Spacer()
                }
                Spacer()
                
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
