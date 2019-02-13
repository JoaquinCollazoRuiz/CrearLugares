import UIKit
import MapKit
import CoreLocation
import Alamofire

class An_adirSitios: UIViewController, CLLocationManagerDelegate{
    let manager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var añadirTitulo: UITextField!
    @IBOutlet weak var añadirComentarios: UITextField!
    @IBOutlet weak var añadirFechaDesde: UITextField!
    @IBOutlet weak var añadirFechaHasta: UITextField!
    @IBOutlet weak var btnAñadirUbicacion: UIButton!
    var peticion: Int = 0
    var newCoords = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @IBAction func crearUbicacion(_ sender: Any) {
        añadirUbicacion()
//         crearLugar(lugarNombre: añadirTitulo.text!, descripcion: añadirComentarios.text!, fechaInicio: añadirFechaDesde.text!, fechaFin: añadirFechaHasta.text!, coordenadasX: coordenadasA.last!, coordenadasY: coordenadasB.last!)
    }
    
    func crearLugar(lugarNombre:String,descripcion:String, fechaInicio:String,fechaFin:String,coordenadasX:Double,coordenadasY:Double){
        
        let url: String = "http://localhost:8888/SitiosVisitados/public/index.php/api/lugares"
        let parameters: Parameters = ["lugarNombre": lugarNombre, "descripcion": descripcion, "fechaInicio": fechaInicio, "fechaFin": fechaFin,"coordenadasX": coordenadasX, "coordenadasY": coordenadasY]
        let _headers: HTTPHeaders = ["Content-Type":"application/x-www-form-urlencoded", "Authorization":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibm9tYnJlIjoiam9hcXVpbiIsImVtYWlsIjoiam9hcXVpbkBnbWFpbC5jb20iLCJjb250cmFzZW5hIjoiMTIzNDU2NzgiLCJpZF9yb2wiOiIwIn0.9tNQvtcXjAkV006v5TTGi023cbLzCp5o7JJd3MN4zJs"]
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: _headers).responseJSON{
            response in
            self.peticion = (response.response?.statusCode)!
            var Respuesta = response.result.value as! [String:String]
            
            print(response.result.value!, response.response?.statusCode ?? 400)
            
            if(response.response?.statusCode != 200)
            {
                print(Respuesta["message"]!)
                print("error")
            }else{
                UserDefaults.standard.set(Respuesta["data"], forKey: "Token")
                print(Respuesta["message"]!)
                print(Respuesta["data"]!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(action(gestureRecognizer:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
        self.viewDidLoad()
    }
    
    func añadirUbicacion()
    {
        if  btnAñadirUbicacion.isTouchInside && (!(añadirTitulo.text?.isEmpty)!) && (!(añadirComentarios.text?.isEmpty)!) && (!(añadirFechaDesde.text?.isEmpty)!) && (!(añadirFechaHasta.text?.isEmpty)!)
        {
            titulos.append(añadirTitulo.text!)
            comentarios.append(añadirComentarios.text!)
            fechaDesde.append(añadirFechaDesde.text!)
            fechaHasta.append(añadirFechaHasta.text!)
            print(titulos)

            coordenadasA.append(Double(newCoords.latitude))
            coordenadasB.append(Double(newCoords.longitude))
            print(coordenadasA)
            print(coordenadasB)
            
            crearLugar(lugarNombre: añadirTitulo.text!, descripcion: añadirComentarios.text!, fechaInicio: añadirFechaDesde.text!, fechaFin: añadirFechaHasta.text!, coordenadasX: coordenadasA.last!, coordenadasY: coordenadasB.last!)
            
            añadirTitulo.text = ""
            añadirComentarios.text = ""
            añadirFechaDesde.text = ""
            añadirFechaHasta.text = ""
        }
    }
    
    @objc func action(gestureRecognizer: UIGestureRecognizer) {
        
        self.mapView.removeAnnotations(mapView.annotations)
        
        let touchPoint = gestureRecognizer.location(in: mapView)
         newCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoords
        mapView.addAnnotation(annotation)
        print(newCoords)
    }
}
