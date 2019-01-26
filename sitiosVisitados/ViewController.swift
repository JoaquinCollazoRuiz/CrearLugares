import UIKit
import MapKit
import CoreLocation
import Alamofire

class ViewController: UIViewController{
    @IBOutlet weak var tablaSitios: UITableView!
    var peticion: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tablaSitios.dataSource = self as! UITableViewDataSource
        tablaSitios.delegate = self as! UITableViewDelegate
//        mostrarLugares()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tablaSitios.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    //Ancho de la celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    //Numero de celdas que me muestra la vista
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nombreBD.count
    }
    //En mis variables de mis textos les coloco el texto de mis arrays
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListadoSitios
        cell?.nombreSitio.text = nombreBD[indexPath.row]
        cell?.fechaDesde.text = fechaDesdeBD[indexPath.row]
        cell?.fechaHasta.text = fechaHastaBD[indexPath.row]
        return cell!
    }
    //Me paso la información a una nueva vista dentro de la celda
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.nombre = nombreBD[indexPath.row]
        vc?.descripcion = comentarioBD[indexPath.row]
        vc?.fechaDe = fechaDesdeBD[indexPath.row]
        vc?.FechaHa = fechaHastaBD[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
