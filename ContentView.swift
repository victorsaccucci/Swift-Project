import SwiftUI
import Foundation
import MapKit

struct Location: Identifiable {
    let id =  UUID()
    let nome: String
    let coordenada: CLLocationCoordinate2D
    let bandeira: String
    let descricao: String
}

struct ContentView: View {
    let locations: [Location] = [
        Location(nome: "Empire State Building",
                 coordenada: CLLocationCoordinate2D(latitude: 40.748817, longitude: -73.985428),
                 bandeira: "https://static.mundoeducacao.uol.com.br/mundoeducacao/2022/05/bandeira-estados-unidos.jpg",
                 descricao: "Um arranha-céu icônico localizado na cidade de Nova York."),
        
        Location(nome: "Torre Eiffel",
                 coordenada: CLLocationCoordinate2D(latitude: 48.8584, longitude: 2.2945),
                 bandeira: "https://static.todamateria.com.br/upload/fr/an/frana_a.jpg",
                 descricao: "Um dos monumentos mais famosos do mundo, situado em Paris, França."),
        
        Location(nome: "Machu Picchu",
                 coordenada: CLLocationCoordinate2D(latitude: -13.1631, longitude: -72.5450),
                 bandeira: "https://s4.static.brasilescola.uol.com.br/be/2022/10/bandeira-do-mexico.jpg",
                 descricao: "Um sítio arqueológico inca no Peru."),
        
        Location(nome: "Pirâmides de Gizé",
                 coordenada: CLLocationCoordinate2D(latitude: 29.9792, longitude: 31.1342),
                 bandeira: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/640px-Flag_of_Egypt.svg.png",
                 descricao: "Uma das sete maravilhas do mundo antigo, localizada no Egito."),
        
        Location(nome: "Opera House de Sydney",
                 coordenada: CLLocationCoordinate2D(latitude: -33.8568, longitude: 151.2153),
                 bandeira: "https://s2.static.brasilescola.uol.com.br/be/2022/10/bandeira-da-australia.jpg",
                 descricao: "Um dos edifícios mais famosos da Austrália, localizado em Sydney.")
    ]
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -13.1631, longitude: -72.5450),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    @State private var localNome = "Local"
    
    var body: some View {
        ZStack {
            Map(position: $position){
                ForEach(locations) { location in
                    Marker(location.nome, coordinate: location.coordenada)
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                Rectangle()
                    .fill(Color.white.opacity(0.6))
                    .frame(height: 160)
                    .ignoresSafeArea()
                    .overlay(Text("World Map").font(.headline).padding(.bottom, 90))
                    .overlay(Text(localNome).font(.subheadline).padding(.bottom, 20))
                
                Spacer()
                ScrollView(.horizontal) {
                    HStack() {
                        ForEach(locations) { location in
                            VStack {
                                ZStack{
                                    AsyncImage(url: URL(string: location.bandeira)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 200, height: 120)
                                            .cornerRadius(10)
                                            .padding(10)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .onTapGesture {
                                        
                                        localNome = location.nome
                                        
                                        position = MapCameraPosition.region(
                                            MKCoordinateRegion(
                                                center: location.coordenada,
                                                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                                            )
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
