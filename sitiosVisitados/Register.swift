import UIKit
import Alamofire

class Register: UIViewController {
    
    @IBOutlet weak var campoUsuario: UITextField!
    @IBOutlet weak var campoContrasena: UITextField!
    @IBOutlet weak var campoRepetirContrasena: UITextField!
    @IBOutlet weak var campoEmail: UITextField!
    @IBOutlet weak var btnRegistrarse: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "login", sender: nil)
    }
    @IBAction func registrarse(_ sender: Any) {
        camposVacios()
        checkContrasenas()
        contrasenasLength()
        validarEmail()
        registro()
    }
    
    func peticionRegistro()
    {
        request("http://localhost:8888/SitiosVisitados/public/index.php/api/register",
                method: .post,
                parameters: ["nombre":campoUsuario.text!, "email":campoEmail.text!, "contrasena":campoContrasena.text!],
                encoding: URLEncoding.httpBody).responseJSON { (respuesta) in
                    print(respuesta.result.value!)
        }
    }
    
    func registro()
    {
        if btnRegistrarse.isTouchInside && (!(campoUsuario.text?.isEmpty)!) && (!(campoContrasena.text?.isEmpty)!) && (!(campoRepetirContrasena.text?.isEmpty)!) && (!(campoEmail.text?.isEmpty)!)
        {
            peticionRegistro()
            let alert = UIAlertController(title: "Gracias por registrarse \(campoUsuario.text ?? "usuario") ", message:
                "Esperemos que disfrutes de la app", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style:
                .default, handler: { (accion) in
              self.performSegue(withIdentifier: "main", sender: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func checkContrasenas()
    {
        if campoContrasena.text != campoRepetirContrasena.text
        {
            let alert = UIAlertController(title: "Las contraseñas no coinciden", message:
                "Vuelva a intentarlo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: { (accion) in}))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func contrasenasLength()
    {
        if (campoContrasena.text?.count)! < 8
        {
            let alert = UIAlertController(title: "La contraseña debe tener mínimo 8 carácteres", message:
                "Vuelva a intentarlo", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style:
                .cancel, handler: { (accion) in}))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func camposVacios()
    {
        if ((campoUsuario.text?.isEmpty)! && (campoEmail.text?.isEmpty)! && (campoContrasena.text?.isEmpty)! && (campoRepetirContrasena.text?.isEmpty)!)
        {
            let alert = UIAlertController(title: "No puede haber campos vacios", message:
                "Vuelva a intentarlo", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style:
                .cancel, handler: { (accion) in}))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func validarEmail()
    {
        if ((!(campoEmail.text?.contains("@"))!))
        {
            let alert = UIAlertController(title: "El email debe contener @", message:
                "Vuelva a intentarlo", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style:
                .cancel, handler: { (accion) in}))
            present(alert, animated: true, completion: nil)
        }
    }
}
