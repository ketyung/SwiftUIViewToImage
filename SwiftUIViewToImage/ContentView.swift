//
//  ContentView.swift
//  SwiftUIViewToImage
//
//  Created by Christopher Chee on 06/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.displayScale) var displayScale
    
    @State private var sheetPresented : Bool = false
    
    @State private var text : String = "Hello World"
    
    var body: some View {
        
        VStack(alignment: .center, spacing:30) {
   
            view()
       
            form()
            
            Button(action: {
                
                withAnimation{
               
                    self.sheetPresented = true
                   
                }
                    
            }){
                Text("Generate & Share")
            }
            
        }
        .sheet(isPresented: $sheetPresented, content: {
                
            if let data = render() {
       
                ShareView(activityItems: [data])
           
            }
            
        })
    }
}

extension ContentView {
    
    private func view () -> some View {
        
        VStack {
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(text)
                    .font(.headline)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.purple, lineWidth: 1)
            )
            
        }
        .padding(2)
    }
    
}

extension ContentView {
    
    private func form() ->some View {
        
        Form{
            
            TextField("Text here...", text : $text)
              
        }
        .frame(width:200, height:100,alignment: .center)
        .cornerRadius(10)
    }
}

extension ContentView {
  
    @MainActor
    private func render() -> UIImage?{
        
        let renderer = ImageRenderer(content: view())

        renderer.scale = displayScale
     
        return renderer.uiImage
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
