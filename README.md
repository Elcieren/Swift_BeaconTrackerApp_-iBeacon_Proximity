## Swift_BeaconTrackerApp_iBeacon_Proximity
| Sinyali Alan Cihazdaki Uzaklik Bilgisi | Sinyal Yayan Cihaz |
|---------|---------|
| ![Video 1](https://github.com/user-attachments/assets/789a0034-0dac-4657-919b-b47d8535227f) | ![Video 2](https://github.com/user-attachments/assets/89aa155e-55ca-4644-9779-4d9f41b523ab) |


 <details>
    <summary><h2>Uygulma Amacı</h2></summary>
    Proje Amacı
   Bu uygulamanın amacı, Bluetooth Low Energy (BLE) beacon'larını kullanarak kullanıcının cihazının konumunu tespit etmek ve cihazın beacon'lara olan mesafesine göre kullanıcı arayüzünü dinamik bir şekilde güncellemektir. BLE beacon'ları, düşük enerjiyle çalışan cihazlar olup, genellikle belirli bir alanda mesafe tabanlı konum takibi sağlar. Bu tür cihazlar, özellikle iç mekan konumlandırma ve yakınlık tabanlı uygulamalarda yaygın olarak kullanılır
  </details>  

  <details>
    <summary><h2>Framework İçe Aktarma</h2></summary>
    iOS uygulamaları için kullanıcı arayüzü oluşturma ve yönetme işlemlerini destekleyen framework'tür. Bu uygulamada, temel UI bileşenlerini kullanmak için içe aktarılmıştır.
    import CoreLocation: Kullanıcının cihaz konumu ve beacon gibi yakınlık bilgilerini işlemek için kullanılan framework'tür. Bluetooth tabanlı beacon'ların algılanmasını sağlar
    
    ```
    import UIKit
    import CoreLocation


    ```
  </details> 

  <details>
    <summary><h2>Sınıf Tanımı ve Protokol Uygulaması</h2></summary>
    ViewController: UIViewController sınıfını miras alarak uygulamanın kullanıcı arayüzünü yönetmek için oluşturulmuş özel bir sınıftır.
    CLLocationManagerDelegate: Bu protokol, konum tabanlı olayları ve değişiklikleri dinlemek ve işlemek için gerekli metodları içerir. Örneğin, beacon'ların algılanması gibi işlemler bu protokol üzerinden yapılır

    
    ```
    class ViewController: UIViewController, CLLocationManagerDelegate {
    ```
  </details> 

  <details>
    <summary><h2>Arayüz Bileşenleri ve Değişken Tanımları</h2></summary>
    @IBOutlet var distanceReading: UILabel!: Kullanıcı arayüzündeki bir UILabel bileşenini kodla ilişkilendiren bir bağlantıdır. Bu uygulamada, beacon ile olan mesafe bilgisi burada gösterilir.
    var locationManeger: CLLocationManager?: Cihazın konum ve beacon bilgilerini yönetmek için kullanılan CLLocationManager sınıfına ait bir değişkendir. Opsiyonel olarak tanımlanmıştır çünkü başlangıçta değer atanmamıştır
    
    ```
     @IBOutlet var distanceReading: UILabel!
    var locationManeger: CLLocationManager?



    
    ```
  </details> 


  <details>
    <summary><h2>viewDidLoad Metodu</h2></summary>
    locationManeger = CLLocationManager(): Yeni bir CLLocationManager nesnesi oluşturulur. Bu nesne konum ve beacon yönetimini sağlar.
    locationManeger?.delegate = self: Bu sınıf, CLLocationManager olaylarını dinlemek için kendi kendini temsilci olarak atar.
    locationManeger?.requestAlwaysAuthorization(): Kullanıcıdan, uygulamanın konum servislerini "her zaman" kullanması için izin istenir.
    view.backgroundColor = .gray: Uygulamanın arka plan rengi gri olarak ayarlanır. Bu, başlangıç durumunu ifade eder.
    
    ```
    override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManeger = CLLocationManager()
    locationManeger?.delegate = self
    locationManeger?.requestAlwaysAuthorization()
    
    view.backgroundColor = .gray
    }



    ```
  </details> 

  <details>
    <summary><h2>Yetkilendirme Durumu Kontrolü</h2></summary>
    didChangeAuthorization: Kullanıcının konum izniyle ilgili değişiklikleri işlemek için çağrılır.
    if status == .authorizedAlways: Kullanıcı, uygulamanın her zaman konuma erişmesine izin verdiyse işlemler devam eder.
    CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self): Beacon izleme özelliğinin mevcut olup olmadığını kontrol eder.
    CLLocationManager.isRangingAvailable(): Beacon'ların yakınlık aralığının algılanabilir olup olmadığını kontrol eder.
    startScannning(): Eğer tüm koşullar uygunsa, beacon taraması başlatılır.
    
    ```
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            if CLLocationManager.isRangingAvailable() {
                startScannning()
            }
        }
    }
    }




    ```
  </details> 

  <details>
    <summary><h2>Beacon Tarama Başlatma</summary>
   startScannning: Beacon taramasını başlatmak için kullanılan bir metottur.
   UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5"): Beacon'ları tanımlamak için kullanılan benzersiz bir UUID oluşturulur.
   CLBeaconRegion: Belirli bir beacon bölgesini tanımlayan bir sınıftır. major ve minor değerleri belirli beacon'ları daha spesifik olarak tanımlamak için kullanılır
   locationManeger?.startMonitoring(for: beaconRegion): Belirtilen beacon bölgesi izlenmeye başlanır.
   locationManeger?.startRangingBeacons(in: beaconRegion): İzlenen beacon'ların yakınlık aralıkları hesaplanır
    
    ```
    func startScannning() {
    let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
    let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "Mybeacon")
    locationManeger?.startMonitoring(for: beaconRegion)
    locationManeger?.startRangingBeacons(in: beaconRegion)
    }
    ```
  </details> 


<details>
    <summary><h2>Uygulama Görselleri </h2></summary>
    
    
 <table style="width: 100%;">
    <tr>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Sinyale en yakin Konum Uyarisi</h4>
            <img src="https://github.com/user-attachments/assets/dde9ddcf-86d3-4ed5-89d5-cca873a83407" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Sinyale yakin durum Konum Uyarisi</h4>
            <img src="https://github.com/user-attachments/assets/0ad11829-187e-4bf2-815c-0aaf9e4da31d" style="width: 100%; height: auto;">
        </td>
        <td style="text-align: center; width: 16.67%;">
            <h4 style="font-size: 14px;">Sinyalin uzak durum Konum Uyarisi</h4>
            <img src="https://github.com/user-attachments/assets/5f0678cf-6807-42a4-b393-cf73989ad8d3" style="width: 100%; height: auto;">
        </td>
    </tr>
</table>
  </details> 
