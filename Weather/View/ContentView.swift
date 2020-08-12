//
//  ContentView.swift
//  Weather
//
//  Created by Nirakar Sapkota on 8/11/20.
//  Copyright © 2020 Nirakar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var network = NetworkManager()
    
    var body: some View {
        NavigationView {
            ZStack{
                List(network.data) { item in
                    HStack(spacing: 30) {
                        Text(getDate(time: item.time))
                            .multilineTextAlignment(.leading)
                       Spacer()
                        Text(String(item.temperature) + " F").font(.title).multilineTextAlignment(.trailing)
                    }.padding(5)
                }

            }
            .navigationBarTitle("Temperature in NYC")
            .navigationBarItems(trailing:
                Button("Refresh") {
                    self.network.fetchData();
                }
            )
        }
        .onAppear(){
            self.network.fetchData();
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


func getDate(time: Int) -> String {
    var date = NSDate(timeIntervalSince1970: TimeInterval(time)).toString(dateFormat: "hh-dd-MM");
    return date;
}


extension NSDate
{
    func toString( dateFormat format  : String ) -> String
    {

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h a ':' MMMM dd"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        let dateString = formatter.string(from: self as Date)
        return dateString
    }

}

