# yesnt69-nixos-dotfiles

NixOS 26.05 üzerinde Sway WM kurulumu. Duvar kağıdından ilham alan yeşil/koyu tema, kedi temalı SDDM ekranı ve Windows dual boot destekli



![NixOS](https://img.shields.io/badge/NixOS-26.05-blue?logo=nixos)




![Sway](https://img.shields.io/badge/WM-Sway-green)




![Wayland](https://img.shields.io/badge/Display-Wayland-orange)



## Bileşenler

| Kategori | Araç |
|----------|------|
| İşletim Sistemi | NixOS 26.05 |
| Pencere Yöneticisi | Sway |
| Durum Çubuğu | Waybar |
| Terminal | Alacritty |
| Uygulama Başlatıcı | Wofi |
| Giriş Yöneticisi | SDDM + sddm-astronaut-theme |
| Kilit Ekranı | GtkLock |
| Bildirim | Dunst |
| Kabuk | Fish |
| Ses | Pipewire + Wireplumber |


## Kurulum

### 1. Disk Hazırlığı (NVMe SSD için) / Disk Preparation (for NVMe SSD)

```bash
mkfs.ext4 /dev/nvme0n1pA 
mkfs.fat -F 32 /dev/nvme0n1pB
mkswap /dev/nvme0n1pC

mount /dev/nvme0n1pA /mnt
mkdir -p /mnt/boot
mount /dev/nvme0n1pB /mnt/boot
swapon /dev/nvme0n1pC
```

### 2. NixOS Kurulumu

```bash
nixos-generate-config --root /mnt

# Bu repodaki configuration.nix dosyasını kopyala / Copy configuration.nix file in this repo
cp dotfiles/nixos/configuration.nix /mnt/etc/nixos/

# "burak" yazan yere kendi kullanıcı adını yaz / Replace "burak" with your username 
nano /mnt/etc/nixos/configuration.nix

nixos-install
reboot
```

### 3. Kullanıcı Config Dosyaları / User Config Files

```bash
git clone https://github.com/yesnt6969/yesnt69-nixos-dotfiles
cd yesnt69-nixos-dotfiles

mkdir -p ~/.config/{sway,waybar,alacritty,wofi,gtklock,swaylock}

cp dotfiles/sway/config ~/.config/sway/
cp dotfiles/waybar/config ~/.config/waybar/
cp dotfiles/waybar/style.css ~/.config/waybar/
cp dotfiles/alacritty/alacritty.toml ~/.config/alacritty/
cp dotfiles/wofi/style.css ~/.config/wofi/
cp dotfiles/gtklock/config.ini ~/.config/gtklock/
cp dotfiles/swaylock/config ~/.config/swaylock/
```

### 4. SDDM Tema Kurulumu

Kendi duvar kağıdını `~/kedi.jpg` (çünkü kedileri severim) olarak kaydet, sonra:
Save your wallpaper as `~/kedi.jpg`, (cuz i love cats) next:

```bash
sudo mkdir -p /var/lib/sddm-custom/sddm-astronaut-theme
sudo cp -r /run/current-system/sw/share/sddm/themes/sddm-astronaut-theme/. \
  /var/lib/sddm-custom/sddm-astronaut-theme/
sudo cp ~/kedi.jpg /var/lib/sddm-custom/sddm-astronaut-theme/Backgrounds/kedi.jpg
sudo sed -i \
  's|Background="Backgrounds/astronaut.png"|Background="Backgrounds/kedi.jpg"|' \
  /var/lib/sddm-custom/sddm-astronaut-theme/Themes/astronaut.conf
sudo chmod -R 755 /var/lib/sddm-custom
```

### 5. Windows Dual Boot (Opsiyonel)

Windows EFI partition'ını mount et ve boot dosyalarını kopyala:

```bash
sudo mkdir -p /mnt/winefi
sudo mount /dev/nvme0n1pB /mnt/winefi
sudo cp -r /mnt/winefi/EFI/Microsoft /boot/EFI/
sudo umount /mnt/winefi
```

systemd-boot otomatik olarak Windows'u algılar.

systemd-boot automaticly detect windows. (If you have any idea how it work dualboot on systemd-boot you can skip this step)

### 6. KDE Connect

KDE Connect kurulumda etkin geliyor. Android cihazında KDE Connect uygulamasını yükle, aynı ağda otomatik eşleşir.

## Notlar

- `configuration.nix` içindeki `burak` kullanıcı adını ve `nixus` hostname'ini kendi bilgilerinle değiştir

- SDDM arka planı her `nixos-rebuild switch` sonrası sıfırlanır, 4. adımı tekrar çalıştırmak gerekir

- Waybar scroll ile parlaklık, tıklayarak ses kontrolü yapılabilir

- GtkLock PAM entegrasyonu `configuration.nix` içinde mevcut

## Notes 

- Replace the username burak and the hostname nixus in configuration.nix with your own details.

- The SDDM background resets after every nixos-rebuild switch; you will need to rerun step 4.

- Waybar allows brightness control via scrolling and audio control via clicking.

- GtkLock PAM integration is available within configuration.nix.
