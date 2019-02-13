import UIKit

class ListadoSitios: UITableViewCell {
    
    @IBOutlet weak var nombreSitio: UILabel!
    @IBOutlet weak var fechaDesde: UILabel!
    @IBOutlet weak var fechaHasta: UILabel!
    
    override func awakeFromNib() {super.awakeFromNib()}
    override func setSelected(_ selected: Bool, animated: Bool) {super.setSelected(selected, animated: animated)}
}
