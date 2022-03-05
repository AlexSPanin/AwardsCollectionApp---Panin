//
//  Box.swift
//  AwardsCollectionApp
//
//  Created by Александр Панин on 05.03.2022.
//

import SwiftUI

struct Box: View {
    
    @State private var angel: Double = 0
    @State private var countRotated: Int = 0
    @State private var isChangeColor: Bool = false {
        didSet {
            if countRotated >= 3 { countRotated = 0
            } else {
                countRotated += 1
            }
        }
    }
    @State private var isMaxScale: Bool = false
    
    
    private let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [setStartColor(),
                                     setEndColor()]),
                            startPoint:  UnitPoint(x: 0, y: 0),
                            endPoint: UnitPoint(x: 1, y: 1)
                    )
                )
                .opacity(setOpacity()).animation(.linear(duration: 4).repeatForever(autoreverses: true))
                .frame(width: width, height: height)
                .rotationEffect(.degrees(angel))
                .onAppear {
                    let animation = Animation.linear(duration: 4).repeatForever(autoreverses: false)
                    return withAnimation(animation) {
                        self.angel += 360
                    }
                }
                .onReceive(timer) { _ in
                    isChangeColor.toggle()
                }
            
            Circle()
                .frame(width: width, height: height)
                .foregroundColor(.white)
                .scaleEffect(isMaxScale ? 0.9 : 0.3)
                .onAppear {
                    let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
                    withAnimation(animation) {
                        self.isMaxScale.toggle()
                    }
                }
        }
    }
    private func setOpacity() -> Double {
        var opacity: Double = 1
        switch countRotated {
        case 0:
            opacity = 1
        case 1:
            opacity = 0.1
        case 2:
            opacity = 1
        default:
            opacity = 0.1
        }
        return opacity
    }
    
    private func setStartColor() -> Color {
        var color: Color = .red
        switch countRotated {
        case 0:
            color = .blue
        case 1:
            color = .blue
        case 2:
            color = .red
        default:
            color = .red
        }
        return color
    }
    
    private func setEndColor() -> Color {
        var color: Color = .red
        switch countRotated {
        case 0:
            color = .green
        case 1:
            color = .green
        case 2:
            color = .yellow
        default:
            color = .yellow
        }
        return color
    }
}

struct Box_Previews: PreviewProvider {
    static var previews: some View {
        Box()
            .frame(width: 200, height: 200)
    }
}
