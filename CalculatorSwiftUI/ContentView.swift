//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Michal on 18/05/2022.
//

import SwiftUI
import Foundation


enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case subtract = "-"
    case add = "+"
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
    switch self {
    case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        
    case .clear, .negative, .percent:
        return Color(.lightGray)
    default:
        return .blue
    }
}
    
}

enum Operation {
    case add, subtract, multiplay, divide, equal, none, percent
    
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber: Double = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight , .nine, .multiply],
        [.four, .five , .six, .subtract],
        [.one, .two, .three , .add],
        [.zero, .decimal, .equal, ]
        ]
    
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all
            )
            
            
            VStack {
                Spacer()
                HStack{
                Spacer()
                Text(value).bold().font(.system(size: 72)).foregroundColor(.white)
                }.padding()
            
            
            ForEach( buttons, id: \.self) { row in
                HStack(spacing: 12){
                ForEach( row, id: \.self) { item in
                    Button(action: {
                        self.didTap(button: item)
                    }, label: {
                        Text(item.rawValue).frame(width: self.buttonWidth(item: item), height: self.buttonHeight(item: item)).background(item.buttonColor).foregroundColor(.white).cornerRadius(self.buttonWidth(item: item)/2)
                            .font(.system(size: 40))
                            })
                        }
                    }
                .padding(.bottom, 3)
                }
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero{
            return ((UIScreen.main.bounds.width - (4*12)) / 4 ) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight(item: CalcButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal, .percent:
            if(button == .add) {
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0
                self.value = "0"
            }
            else if(button == .subtract) {
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0
                self.value = "0"

            }
            else if(button == .multiply) {
                self.currentOperation = .multiplay
                self.runningNumber = Double(self.value) ?? 0
                self.value = "0"

            }
            else if(button == .divide) {
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0
                self.value = "0"

            }
            else if(button == .percent) {
                self.currentOperation = .percent
                self.runningNumber = Double(self.value) ?? 0
                let tmpValue = self.runningNumber / 100
                self.value = String(tmpValue)
                self.runningNumber = 0
                
                

            }
            else if(button == .equal) {
                switch self.currentOperation {
                case .add:
                    let tmpValue = Double(self.value)! + self.runningNumber
                    self.value = String(tmpValue)
                    self.runningNumber = 0
                    if value.contains(".0") {
                        self.value = String(Int(tmpValue))

                    }
                case .subtract:
                    let tmpValue = self.runningNumber - Double(self.value)!
                    self.value = String(tmpValue)
                    self.runningNumber = 0
                    if value.contains(".0") {
                        self.value = String(Int(tmpValue))

                    }
                case .multiplay:
                    let tmpValue = Double(self.value)! * self.runningNumber
                    self.value = String(tmpValue)
                    self.runningNumber = 0
                    if value.contains(".0") {
                        self.value = String(Int(tmpValue))

                    }
                case .divide:
                    let tmpValue = self.runningNumber / Double(self.value)!
                    self.value = String(tmpValue)
                    self.runningNumber = 0
                    if value.contains(".0") {
                        self.value = String(Int(tmpValue))

                    }

                default:                    
                    break
                }
                
            }
            break
        case .clear:
            self.value = "0"
            self.runningNumber = 0
        case .decimal:
            if(!value.contains(".")){
            self.value = value.appending(".")
            }
        case .negative:
            if(!value.contains("-")){
                self.value = "-".appending(self.value)
            }
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }else{
            self.value = "\(self.value)\(number)"
            }
        }
    }
}

//TestComment

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
