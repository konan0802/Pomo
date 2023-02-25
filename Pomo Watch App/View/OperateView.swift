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
                    Text("< Back").onTapGesture {
                        display.operateViewOn = false
                    }
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
                            Task{
                                await togglAPI.startEvent(taskName: Constants.MTG)
                                display.operateViewOn = false
                            }
                        }
                    Spacer()
                    Image("SBR")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45)
                        .onTapGesture {
                            Task{
                                await togglAPI.startEvent(taskName: Constants.SBR)
                                display.operateViewOn = false
                            }
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
                            Task{
                                await togglAPI.startEvent(taskName: Constants.LBR)
                                display.operateViewOn = false
                            }
                        }
                    Spacer()
                    Image("FIN")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45)
                        .onTapGesture {
                            Task{
                                await togglAPI.stopEvent(timeEntryId: pomoTimer.timeEntryId)
                                display.operateViewOn = false
                            }
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
