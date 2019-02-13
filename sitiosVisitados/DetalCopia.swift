import UIKit
import MapKit

class DetalCopia: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var fechaDesdelBL: UILabel!
    @IBOutlet weak var fechaHastaLbl: UILabel!
    @IBOutlet weak var mapita: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ponerTextos()
    }
    
    func ponerTextos()
    {
        let indice = nombreDetalle.last
        
        titleLbl.text = nombreBD[indice!]
        descriptionLbl.text = comentarioBD[indice!]
        fechaDesdelBL.text = fechaDesdeBD[indice!]
        fechaHastaLbl.text = fechaHastaBD[indice!]
        
         let coordenadasOrigen2 = CLLocationCoordinate2DMake(coordenadasABD[indice!], coordenadasBBD[indice!])
        
        var center = CLLocationCoordinate2D(latitude: coordenadasABD[indice!], longitude: coordenadasBBD[indice!])
        mapita.centerCoordinate = center
        
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        _ = MKCoordinateRegion(center: coordenadasOrigen2, span: span)
        
        let anotaciones = MKPointAnnotation()
        anotaciones.coordinate = coordenadasOrigen2
        anotaciones.title = nombreBD[indice!]
        self.mapita.addAnnotation(anotaciones)
    }
}
