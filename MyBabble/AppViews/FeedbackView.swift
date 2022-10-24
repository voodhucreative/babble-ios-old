//
//  FeedbackView.swift
//  SwiftVoiceQuickstart
//
//  Created by Ford Walton on 10/12/2020.
//  Copyright © 2020 Twilio, Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct FeedbackView: View
{
    @State private var rating: Double = 3
    @ObservedObject private var cvm: CallViewModel = AppSession.inCall ?? CallViewModel(inCall: false, listeners: AppSession.getListenerCount())
    
    func submitScore()
    {
        AppSession.rateCall(rating: Int(rating))
        AppSession.activeScreen?.activeScreen = ActiveScreen.call
    }
    
    func closeNoFeedback()
    {
        AppSession.activeScreen?.activeScreen = ActiveScreen.call
        AppSession.inCall?.wasCaller = false
    }
    
    func reportAbuse()
    {
        AppSession.reportCall(status:2)
        AppSession.activeScreen?.activeScreen = ActiveScreen.reported
        //closeNoFeedback()
    }
    
    func flagHelp()
    {
        AppSession.reportCall(status: 1)
        AppSession.activeScreen?.activeScreen = ActiveScreen.reported
        //closeNoFeedback()
    }
    
    func onLoad()
    {
        if (cvm.wasCaller != AppSession.inCall?.wasCaller && AppSession.inCall?.wasCaller != nil)
        {
            cvm.wasCaller = AppSession.inCall!.wasCaller
        }
    }
    
    var body: some View
    {
        NavigationView
        {
            ZStack
            {
                ColorManager.Slate.edgesIgnoringSafeArea(.all)
                    
                VStack()
                {
                    Color.white.frame(width: UIScreen.screenWidth, height: UIDevice.current.hasNotch ? 50 : 0).offset(y: -35)
                    Image("babble-logo-speech").resizable().aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight, alignment: .top)
                        .offset(y: -55 )
                    Caller()
                    Spacer()
                }.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                
                ColorManager.SlateTranslucent.edgesIgnoringSafeArea(.all)
                
                VStack()
                    {
                    
                    Spacer().frame(height: 20)
                    //if(cvm.wasCaller)
                    //{
                        Text("Please rate your call")
                        .foregroundColor(ColorManager.Black)
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        
                        Spacer().frame(height: 20)
                        
                        VStack()
                        {
                            HStack()
                            {
                                Text("Poor")
                                .foregroundColor(ColorManager.Black)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                
                                Spacer()
                                
                                Text("Great")
                                .foregroundColor(ColorManager.Black)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            }.frame(width: UIScreen.screenW70)
                            .offset(y: 10)
                            
                            Slider(value: $rating, in: 1...5, step: 1).frame(width: UIScreen.screenW60, height: 20)
                            
                            HStack()
                            {
                                Text("|")
                                .foregroundColor(ColorManager.Grey)
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                                Spacer()
                                
                                Text("|")
                                .foregroundColor(ColorManager.Grey)
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                                Spacer()
                                
                                Text("|")
                                    .foregroundColor(ColorManager.Grey)
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                                Spacer()
                                
                                Text("|")
                                .foregroundColor(ColorManager.Grey)
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                                Spacer()
                                
                                Text("|")
                                .foregroundColor(ColorManager.Grey)
                                .font(.system(size: 28))
                                .fontWeight(.bold)
                            }.frame(width: UIScreen.screenW60)
                        }
                    //}
                    
                    
                    Spacer().frame(height: 20)
                    
                    VStack()
                    {
                        Button(action: {reportAbuse()} , label: {
                            Text("Report the call")
                                .foregroundColor(ColorManager.White)
                                .font(.system(size: 22))
                        }).frame(width: UIScreen.screenWHalf + UIScreen.screenWQuart, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .background(ColorManager.Black)
                        .cornerRadius(50)
                        
                        
                        //if(!cvm.wasCaller)
                        //{
//                            Spacer().frame(height: 10)
//                            Button(action: {flagHelp()} , label: {
//                                Text("The caller needs help")
//                                    .foregroundColor(ColorManager.White)
//                                    .font(.system(size: 22))
//                            }).frame(width: UIScreen.screenWHalf + UIScreen.screenWQuart, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                            .background(ColorManager.Black)
//                            .cornerRadius(50)
                        //}
                        
                        
                        Spacer().frame(height: 10)
                        
                        //if(cvm.wasCaller)
                        //{
                            Button(action: {submitScore()} , label: {
                                Text("Submit")
                                    .foregroundColor(ColorManager.White)
                                    .font(.system(size: 22))
                            }).frame(width: UIScreen.screenWHalf + UIScreen.screenWQuart, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(ColorManager.DarkOrange)
                            .cornerRadius(50)
                            .padding(.bottom, 10)
                    }.padding(.horizontal, 10)
                        
//                        Button(action: {closeNoFeedback()} , label: {
//                            Text("Close")
//                                .foregroundColor(ColorManager.Grey)
//                                .font(.system(size: 24))
//                        }).frame(width: UIScreen.screenWHalf + UIScreen.screenWQuart, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .cornerRadius(50)
//                    }.frame(width: UIScreen.screenW80)
                }.background(ColorManager.White).cornerRadius(25)
            }
        }.navigationBarTitle("Babble")
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true).frame(height: UIScreen.screenHeight).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).onAppear(perform: {onLoad()})
    }
}
