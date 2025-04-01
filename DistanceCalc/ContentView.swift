//
//  ContentView.swift
//  DistanceCalc
//
//  Created by João Víctor Benetti Filipim on 01/04/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var points: [(latitude: Double, longitude: Double)] = []
    @State private var distances: [Double] = []
    
    var body: some View {
        NavigationView{
            VStack {
                TextField("Put the latitude value:", text: $latitude)
                    .padding()
                    .keyboardType(.decimalPad)
                
                TextField("Put the longitude value:", text: $longitude)
                    .padding()
                    .keyboardType(.decimalPad)
                
                Button(action: addPoint) {
                    Text("Add Point")
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(5)
                }
                
                List {
                    ForEach(0..<points.count, id: \.self) { index in
                        Text("Point \(index + 1): \(points[index].latitude), \(points[index].longitude) - Distance: \(distances[index], specifier: "%.2f") km")
                    }
                }
                    .padding(.top)
                
                    Spacer()
            }
            .navigationTitle("Geo Distance App")
            .padding()
        }
    }
    
    func addPoint() {
        guard let lat = Double(latitude), let lon = Double(longitude) else {
                    return
                }
                
                let newPoint = (latitude: lat, longitude: lon)
                points.append(newPoint)
                
                if let firstPoint = points.first {
                    let distance = calculateDistance(from: firstPoint, to: newPoint)
                    distances.append(distance)
                } else {
                    distances.append(0)
                }
                
                latitude = ""
                longitude = ""
            }
            
            func calculateDistance(from point1: (latitude: Double, longitude: Double), to point2: (latitude: Double, longitude: Double)) -> Double {
                let loc1 = CLLocation(latitude: point1.latitude, longitude: point1.longitude)
                let loc2 = CLLocation(latitude: point2.latitude, longitude: point2.longitude)
                return loc1.distance(from: loc2) / 1000 // Convert to kilometers
            }
        }

        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
    }
}

struct View_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
