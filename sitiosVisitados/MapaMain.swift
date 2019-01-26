import UIKit
import MapKit
import Alamofire

class MapaMain: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var peticion: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mostrarLugares()
    }
    override func viewWillAppear(_ animated: Bool) {
        pin()
        mostrarLugares()
        self.view.layoutIfNeeded()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization")
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        pin()
        mostrarLugares()
    }
    
    func pin() {
        for i in 0...coordenadasA.count-1
        {
            let coordenadasOrigen = CLLocationCoordinate2DMake(coordenadasA[i], coordenadasB[i])

            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            _ = MKCoordinateRegion(center: coordenadasOrigen, span: span)

            let anotaciones = MKPointAnnotation()
            anotaciones.coordinate = coordenadasOrigen
            anotaciones.title = "Punto1"
            mapView.addAnnotation(anotaciones)
        }
    }

    func mostrarLugares(){
        
        let url: String = "http://localhost:8888/SitiosVisitados/public/index.php/api/lugares"
        
        let _headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded", "Authorization":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibm9tYnJlIjoiam9hcXVpbiIsImVtYWlsIjoiam9hcXVpbkBnbWFpbC5jb20iLCJjb250cmFzZW5hIjoiMTIzNDU2NzgifQ.LhUKtXqmgpwONS8f15F6RUoJWiap9dBOc9cxYSqvVvQ"]
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.httpBody, headers: _headers).responseJSON{
            response in
            self.peticion = (response.response?.statusCode)!
            var Respuesta = response.result.value as! [String:Any]
            
            print(response.result.value!, response.response?.statusCode ?? 400)
            
            if(response.response?.statusCode != 200)
            {
                print("error")
            }else{
                UserDefaults.standard.set(Respuesta["data"], forKey: "Token")
                print(Respuesta["data"]!)
                
                var sitios = Respuesta["data"] as! [[String:Any]]
                idBD.append(sitios.count)
                var numeroLugares = sitios.count
                print(numeroLugares)
                print("arriba")
                for i in 0...numeroLugares-1
                {
                    print(i)
                    nombreBD.append(sitios[i]["nombre"] as! String)
                    comentarioBD.append(sitios[i]["descripcion"] as! String)
                    fechaDesdeBD.append(sitios[i]["fechaInicio"] as! String)
                    fechaHastaBD.append(sitios[i]["fechaFin"] as! String)
                    coordenadasABD.append(sitios[i]["coordenadasX"] as! Double)
                    coordenadasBBD.append(sitios[i]["coordenadasY"] as! Double)
                    
                    //MARCAR UBICACIÓN
                    let coordenadasOrigen = CLLocationCoordinate2DMake(coordenadasABD[i], coordenadasBBD[i])

                    let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                    _ = MKCoordinateRegion(center: coordenadasOrigen, span: span)

                    let anotaciones = MKPointAnnotation()
                    anotaciones.coordinate = coordenadasOrigen
                    anotaciones.title = nombreBD[i]
                    self.mapView.addAnnotation(anotaciones)
                }
                print(idBD)
                print(nombreBD)
                print(comentarioBD)
                print(fechaDesdeBD)
                print(fechaHastaBD)
                print(coordenadasABD)
                print(coordenadasBBD)
            }
        }
    }
}
