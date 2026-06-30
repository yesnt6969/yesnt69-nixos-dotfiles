# yesnt69-nixos-dotfiles

🇹🇷 TR:
NixOS 26.05 üzerinde Sway WM kurulumu. Duvar kağıdından ilham alan yeşil/koyu temalı

🇬🇧 ENG:
Sway WM installation on NixOS 26.05. Green/dark theme inspired by the wallpaper.

Referans Görüntüler / Referance Images

<p align="center">
  <img src="wallpapers/Ekran-Görüntüsü-1.png" alt="Referans Fotoğraf 1" width="640" height="360">
</p>

<br>
<hr>
<br>

<p align="center">
  <img src="wallpapers/Ekran-Görüntüsü-2.png" alt="Referans Fotoğraf 2" width="640" height="360">
</p>


![NixOS](https://img.shields.io/badge/NixOS-26.05-blue?logo=nixos) ![Sway](https://img.shields.io/badge/WM-Sway-green) ![Wayland](https://img.shields.io/badge/Display-Wayland-orange)


## Bileşenler / Components

| Kategori / Category | Araç / Tool |
|----------|------|
| İşletim Sistemi / Operating System | NixOS 26.05 |
| Pencere Yöneticisi / Window Manager | Sway |
| Durum Çubuğu / Status Bar | Waybar |
| Terminal | Alacritty |
| Uygulama Başlatıcı / Application Launcher | Wofi |
| Giriş Yöneticisi / Display Manager | SDDM |
| Kilit Ekranı / Screen Locker | GtkLock |
| Bildirim / Notification Daemon | Dunst |
| Kabuk / Shell | Fish |
| Ses / Audio | Pipewire + Wireplumber |


## Gerekenler / Requirements

🇹🇷 **Kuruluma başlamadan önce aşağıdakilere sahip olduğunuzdan emin olun:**
* **NixOS Minimal ISO:** Bilgisayarınızı başlatmak için güncel bir NixOS kurulum medyası (USB).
* **İnternet Bağlantısı:** Kurulum esnasında paketlerin indirilebilmesi için aktif bir bağlantı (Kablolu veya Wi-Fi).
* **Depolama:** Bu rehber varsayılan olarak bir **NVMe SSD** (`/dev/nvme0n1`) baz alınarak hazırlanmıştır. Eğer SATA SSD veya HDD kullanıyorsanız disk yollarını (`/dev/sdX` gibi) kendinize göre düzenlemelisiniz.

🇬🇧 **Before starting the installation, make sure you have the following:**
* **NixOS Minimal ISO:** A bootable NixOS installation media (USB).
* **Internet Connection:** An active connection (Ethernet or Wi-Fi) to download packages during setup.
* **Storage:** This guide is written based on an **NVMe SSD** (`/dev/nvme0n1`) by default. If you are using a SATA SSD or HDD, you must adjust the disk paths (e.g., `/dev/sdX`) accordingly.

---

## Donanım ve Sürücü Bilgisi / Hardware & Driver Info

> 💡 **TR:** Bu dal (`nvidia` branch), sistemin harici **NVIDIA RTX 3050** ekran kartı sürücüleri ve yamaları aktif edilerek konfigüre edilmiştir. Sadece dahili AMD Radeon (APU) grafik işlemcisinin aktif olduğu temiz yapılandırma için lütfen `main` dalına göz atın.

> 💡 **ENG:** This branch (`nvidia`) is configured with the dedicated **NVIDIA RTX 3050** graphics card drivers and patches enabled. For the clean configuration where only the internal AMD Radeon (APU) graphics processor is active, please check the `main` branch.

### Test Edilen Sistem Özellikleri / Tested System Specifications

* **İşlemci / CPU:** AMD Ryzen 5 5600H with Radeon Graphics
* **Ekran Kartı / GPU:** NVIDIA GeForce RTX 3050 Laptop GPU (4GB) *(Bu dalda aktiftir / Active on this branch)*
* **Bellek / RAM:** 16 GB DDR4
* **Depolama / Storage:** 512 GB NVMe SSD

---


## Kurulum

### 1. Disk Hazırlığı (NVMe SSD için) / Disk Preparation (for NVMe SSD)
1.1 Sisteminizin disk yapısını görmek için önce bu komutu kullanın. / To view your system's disk structure, first use this command.

```bash
lsblk
```

1.2 Kurulumu yapmak istediğiniz diski "cfdisk" ile bölümlendirin (benim için bu nvme0n1). / Partition the disk where you want to install it using "cfdisk" (for me this is nvme0n1).

⚠️ **UYARI:** "cfdisk" terminal üzerinde grafik arayüzü olan bir programdır. Diski bölümlendirme konusunda şüpheniz varsa lütfen işlem yapmak istediğiniz diski tekrar kontrol etmekten çekinmeyin.

⚠️ **WARNING:** "cfdisk" is a program with a graphical interface in the terminal. If you have any doubts about partitioning the disk, please feel free to double-check the disk you intend to work with.

```bash
mkfs.ext4 /dev/nvme0n1pA 
mkfs.fat -F 32 /dev/nvme0n1pB
mkswap /dev/nvme0n1pC
```

```bash
mount /dev/nvme0n1pA /mnt
mkdir -p /mnt/boot
mount /dev/nvme0n1pB /mnt/boot
swapon /dev/nvme0n1pC
```

⚠️ **UYARI:**  Bölüm harflerini (A,B ve C) diskinize ait gerçek bölüm numaraları ile değiştirmeyi unutmayın!

⚠️ **WARNING:** Do not forget to replace the partition letters (A, B, and C) with your actual partition numbers! 


1.2 Donanım şablonunu ilerleyen adımlar için zorunludur / Hardware config is required for following steps
```bash
nixos-generate-config --root /mnt
```


### 2. NixOS Kurulumu
2.1 Temel kurulum için, bu repoyu geçici olarak indirip configuration.nix dosyasını kopyalayın / For basic setup, temporarily download this repository and copy the configuration.nix file.

```bash
git clone https://github.com/yesnt6969/yesnt69-nixos-dotfiles
cp yesnt69-nixos-dotfiles/dotfiles/nixos/configuration.nix /mnt/etc/nixos/
```


2.2 Konfigürasyon içersindeki "burak" yazan yere kendi kullanıcı adını yaz / Replace "burak" with your username in configuration file 

```bash
nano /mnt/etc/nixos/configuration.nix
```


2.3 Bundan sonraki işlemler Nixos wiki ile aynı / The following steps are the same as with the Nixos wiki.

```bash
nixos-install
```

```bash
reboot
```

⚠️ **UYARI:** Bu komut sadece Nixos kurulumu için gerekli paketlerin kurulumunu yapar. Kurulum sonrası ince ayarlar için, kendi ayarlarınızı getirin yada sıradaki adımları uygulayın.

⚠️ **WARNING:** This command only installs the packages necessary for Nixos installation. For post-installation fine-tuning, bring your own settings or follow the next steps.


### 3. Kurulum sonrası adımları / Post-installation steps

Not: Temiz kurulum önerilir. Daha önceden bulunan kurulumunuzdaki bağımlılık(lar) sorun çıkarabilir.


Not: Konfigürasyonların hepsi [yesnt69-config-files](https://github.com/yesnt6969/yesnt69-config-files) deposuna taşındı.

---

Note: A clean installation is recommended. Existing dependencies in your setup may cause problems.


Note: All configurations have been moved to the [yesnt69-config-files](https://github.com/yesnt6969/yesnt69-config-files) repository.

```bash
git clone https://github.com/yesnt6969/yesnt69-config-files.git
```
```bash
cd yesnt69-config-files
```

  # 3.1 Konfigürasyon dosyaları için dizin oluştur / Create a directory for configuration files.

```bash
mkdir -p ~/.config/{alacritty,dunst,fish,fuzzel,gtklock,nvim,sway,swaylock,waybar,wofi}
```


  # 3.2 Hepsini kopyalamak isterseniz / If you want to copy all of them:
```bash
cp -r alacritty/* ~/.config/alacritty/
cp -r dunst/* ~/.config/dunst/
cp -r fish/* ~/.config/fish/
cp -r fuzzel/* ~/.config/fuzzel/
cp -r gtklock/* ~/.config/gtklock/
cp -r nvim/* ~/.config/nvim/
cp -r sway/* ~/.config/sway/
cp -r swaylock/* ~/.config/swaylock/
cp -r waybar/* ~/.config/waybar/
cp -r wofi/* ~/.config/wofi/
```



### 4. KDE Connect

KDE Connect kurulumda etkin geliyor / KDE Connect comes already activated

## Notlar

- `configuration.nix` içindeki `burak` kullanıcı adını ve `nixus` hostname'ini kendi bilgilerinle değiştir

- Waybar scroll ile parlaklık, tıklayarak ses kontrolü yapılabilir

- GtkLock PAM entegrasyonu `configuration.nix` içinde mevcut

- Güncel .nix konfigürasyonu yedek masaüstü ortamı olarak KDE ile gelmektedir

## Notes 

- Replace the username burak and the hostname nixus in configuration.nix with your own details.

- Waybar allows brightness control via scrolling and audio control via clicking.

- GtkLock PAM integration is available within configuration.nix.

- Current .nix configuration comes with KDE for backup.
