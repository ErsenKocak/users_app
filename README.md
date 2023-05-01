# Flutter Users App


Flutter-User Application.

## Genel Bilgilendirme
 - Uygulama Google Flutter Framework'ü kullanılarak geliştirilmiştir.
 - Emulator(IOS,Android), Gerçek Android Cihaz veGerçek Cihaz IOS olarak test edilmiştir



## Kullanılan Kütüphaneler


- [Bloc(State Management](https://pub.dev/packages/flutter_bloc)
- [Get It(Dependency Injection)](https://pub.dev/packages/get_it)
- [Logger](https://pub.dev/packages/logger)
- [Dio(Network Transactions)](https://pub.dev/packages/dio)



## Tasarım yaklaşımı

- Kullanılan Widget'ların parçalanması ve gerekli yerlerde tekrar kullanılmasını amaçlayan Atomic Design yaklaşımı referans alınmıştır.
Amaç; Kod Okunabilirliği, Widgeti'ların tekrar tekrar kullanılabilme opsiyonu ve dinamikleştirmek.Atomic Design için örnek döküman;
- [Atomic Design](https://itnext.io/atomic-design-with-flutter-11f6fcb62017)
- Kullanılan Widget'lar UI bazlı veya Uygulama geneli olma durumuna göre View dosyasının altında veya Core Katmanına eklendi

## Kullanılan Mimari

- Katmanlı mimari alt yapısı kullanılarak her katmanın kendi işini yapması amacıyla, kod okunabilirliği açısından ve sonra ki süreçte yapılan uygulamanın değişime direnç göstermemesi amacıyla BLoc Design Pattern kullanımıştır(Alternatif; Repository Pattern, MVVM)
- Katmanlar; 
  - Model(Model class'ların tutulduğu katmandır.Kullanılan dataların referans modelleri saklanır.)
  - View(UI elemanlarının tutulduğu katmandır ve sadece UI ile ilgili elemanlar tutulmalıdır)
  - Cubit(Business kodunun yazıldığı UI ve Service katmanı arasında ki iş akışını sağlayan katmandır.)
  - Service(Dış Servislere HTTP protokolü üzeriden bağlanılan katmandır.)
  - Core(Uygulama özelinde olmayan ve her hangi bir projede kullanılabilmesi amaçlanan uygulama geneli yapıları tutar,Uygulama bağımsızdır(Örn; Helpers, Constants ve Uygulama dışı kullanılabilecek uygulamaya bağımlı olmayan widgetların tutulduğu katmandır))

  İş akışı;
   View --> Cubit --> Services (Model ve Core katmanı ilgili iş akışına göre ilgili katmanda kullanılmaktadır.)
  ya da
   View <-- Cubit <-- Services (Model ve Core katmanı ilgili iş akışına göre ilgili katmanda kullanılmaktadır.)















