import UIKit
import Alamofire

class Login: UIViewController {

    @IBOutlet weak var usuarioCampoLogin: UITextField!
    @IBOutlet weak var contrasenaCampoLogin: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {super.viewDidLoad()}
    
    @IBAction func logearte(_ sender: Any) {
        campoVacio()
        validateEmail()
        contrasenaLength()
        login()
    }
    @IBAction func registerBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "register", sender: nil)
    }
    
    func peticionLogin()
    {
        request("http://localhost:8888/SitiosVisitados/public/index.php/api/login",
                method: .post,
                parameters: ["email":usuarioCampoLogin.text!, "contrasena":contrasenaCampoLogin.text!],
                encoding: URLEncoding.httpBody).responseJSON { (respuesta) in
                    print(respuesta.result.value!)
                    var resPost = respuesta.result.value! as! [String:String]
                    var message = resPost["message"]
                    var data = resPost["data"]
        }
    }
    
    func login()
    {
        if btnLogin.isTouchInside && (!(usuarioCampoLogin.text?.isEmpty)!) && (!(contrasenaCampoLogin.text?.isEmpty)!)
        {
            peticionLogin()
            let alert = UIAlertController(title: "Gracias por iniciar sesión \(usuarioCampoLogin.text ?? "usuario") ", message:
                "Esperemos que disfrutes de la app", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style:
                .default, handler: { (accion) in
                self.performSegue(withIdentifier: "main", sender: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
        else
        {
//            let alert = UIAlertController(title: "No se ha podido iniciar sesion \(usuarioCampoLogin.text ?? "usuario") ", message:
//                "Intentelo de nuevo", preferredStyle: .alert)
//            
//            alert.addAction(UIAlertAction(title: "ok", style:
//                .cancel, handler: { (accion) in
//                    print("a")
//            }))
//            present(alert, animated: true, completion: nil)

        }
    }
    
    func validateEmail()
    {
        if ((!(usuarioCampoLogin.text?.contains("@"))!))
        {
            let alert = UIAlertController(title: "El email debe contener @", message:
                "Vuelva a intentarlo", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style:
                .cancel, handler: { (accion) in}))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func contrasenaLength()
    {
        if (contrasenaCampoLogin.text?.count)! < 8
        {
            let alert = UIAlertController(title: "La contraseña debe tener mínimo 8 carácteres", message:
                "Vuelva a intentarlo", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style:
                .cancel, handler: { (accion) in}))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func campoVacio()
    {
        if ((usuarioCampoLogin.text?.isEmpty)! || (contrasenaCampoLogin.text?.isEmpty)!)
        {
            let alert = UIAlertController(title: "No puede haber campos vacios", message:
                "Vuelva a intentarlo", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style:
                .cancel, handler: { (accion) in}))
            present(alert, animated: true, completion: nil)
        }
    }
}
