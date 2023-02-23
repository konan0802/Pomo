//
//  OperateView.swift
//  Pomo Watch App
//
//  Created by 小南佑介 on 2023/02/05.
//

import SwiftUI

struct OperateView: View {
    
    @EnvironmentObject var display: Display
    @EnvironmentObject var pomoTimer: PomoTimer
    
    var togglAPI = TogglAPI()

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
                        .onTapGesture {
                            togglAPI.startEvent(taskName: Constants.MTG)
                        }
                    Spacer()
                    Image("SBR")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45)
                        .onTapGesture {
                            togglAPI.startEvent(taskName: Constants.SBR)
                        }
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    Image("LBR")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45)
                        .onTapGesture {
                            togglAPI.startEvent(taskName: Constants.LBR)
                        }
                    Spacer()
                    Image("FIN")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45)
                        .onTapGesture {
                            togglAPI.stopEvent(timeEntryId: pomoTimer.timeEntryId)
                        }
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
