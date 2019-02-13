import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var DetailTitulo: UILabel!
    @IBOutlet weak var DetailDescripcion: UILabel!
    @IBOutlet weak var DetailFechaDesde: UILabel!
    @IBOutlet weak var DetailFechaHasta: UILabel!
    @IBOutlet weak var mapaDetail: MKMapView!
    var peticion: Int = 0
    let locationManager = CLLocationManager()
    
    var nombre = ""
    var descripcion = ""
    var fechaDe = ""
    var FechaHa = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        DetailTitulo.text = nombre
        DetailDescripcion.text = descripcion
        DetailFechaDesde.text = fechaDe
        DetailFechaHasta.text = FechaHa
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization")
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        obtenerCoordenadas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        obtenerCoordenadas()
        self.view.layoutIfNeeded()
        self.viewDidLoad()
    }
    func obtenerCoordenadas()
    {
        let nombreSitio = nombreBD.firstIndex(of: nombre)
        print(nombreSitio as Any)
        
        //MARCAR UBICACIÓN
        let coordenadasOrigen = CLLocationCoordinate2DMake(coordenadasABD[nombreSitio!], coordenadasBBD[nombreSitio!])
        //Centrar el punto en el medio de tu vista
        var center = CLLocationCoordinate2D(latitude: coordenadasABD[nombreSitio!], longitude: coordenadasBBD[nombreSitio!])
        mapaDetail.centerCoordinate = center
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        _ = MKCoordinateRegion(center: coordenadasOrigen, span: span)
        
        let anotaciones = MKPointAnnotation()
        anotaciones.coordinate = coordenadasOrigen
        anotaciones.title = nombreBD[nombreSitio!]
        self.mapaDetail.addAnnotation(anotaciones)
        
    }
    func setCenter(_ coordinate: CLLocationCoordinate2D,animated: Bool){}
    
}
