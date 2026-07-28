# Faoxima Stable for 3x-ui v3.5.0

نسخه پایدار فاکسیما با پشتیبانی از 3x-ui نسخه 3.5.0، چند اینباند،
مینی‌اپ، پنل وب، بکاپ خودکار و مدیریت کامل روی Ubuntu.

## نیازمندی‌ها

- Ubuntu 24.04 LTS تازه یا دارای نصب قبلی فاکسیما
- دسترسی `root`
- دامنه متصل‌شده به IP سرور
- باز بودن پورت‌های `80` و `443`
- توکن معتبر ربات تلگرام
- حداقل 2 گیگابایت RAM

## نصب یا آپدیت خودکار با یک دستور

ابتدا وارد کاربر root شوید:

```bash
sudo -i
```

سپس دستور زیر را اجرا کنید:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/mehdixxx-max/foxsimaa/main/install.sh)
```

نصب‌کننده به‌صورت خودکار تشخیص می‌دهد:

- اگر فاکسیما نصب نشده باشد، نصب تازه را شروع می‌کند.
- اگر نصب موجود باشد، پیش از آپدیت بکاپ گرفته و سپس آپدیت امن را اجرا می‌کند.
- فایل ZIP پیش از اجرا با SHA256 بررسی می‌شود.

## نصب تازه اجباری

```bash
sudo -i
bash <(curl -fsSL https://raw.githubusercontent.com/mehdixxx-max/foxsimaa/main/install.sh) --install
```

## آپدیت اجباری نصب موجود

```bash
sudo -i
bash <(curl -fsSL https://raw.githubusercontent.com/mehdixxx-max/foxsimaa/main/install.sh) --update
```

## نمایش منوی نصب

```bash
sudo -i
bash <(curl -fsSL https://raw.githubusercontent.com/mehdixxx-max/foxsimaa/main/install.sh) --menu
```

## منوی مدیریت فاکسیما

پس از نصب، برای نمایش منوی کامل مدیریت اجرا کنید:

```bash
sudo -i
faoxima-vps
```

این منو شامل موارد زیر است:

- نمایش وضعیت و تست سلامت
- ساخت بکاپ
- نمایش فهرست بکاپ‌ها
- بازیابی بکاپ کامل
- واردکردن بکاپ SQL سی‌پنل
- تعمیر دسترسی فایل‌ها
- ثبت مجدد Webhook
- اجرای دستی Cron
- نمایش وضعیت Cron
- مشاهده و چرخش لاگ‌ها
- فعال یا غیرفعال‌کردن ارسال بکاپ دیتابیس به تلگرام
- آپدیت از سورس استخراج‌شده
- حذف با نگهداری بکاپ
- حذف کامل تمام اطلاعات

## دستورات مدیریت

### وضعیت سرویس‌ها

```bash
faoxima-vps status
```

### تست سلامت کامل

این دستور Apache، MySQL، Cron، PHP، دیتابیس، مینی‌اپ، پنل وب و Webhook
تلگرام را بررسی می‌کند:

```bash
faoxima-vps health
```

### ساخت بکاپ فوری

```bash
faoxima-vps backup
```

بکاپ‌ها در مسیر زیر ذخیره می‌شوند:

```text
/var/backups/faoxima
```

### نمایش بکاپ‌های موجود

```bash
faoxima-vps backups
```

### بازیابی بکاپ کامل

ابتدا فهرست بکاپ‌ها را ببینید:

```bash
faoxima-vps backups
```

سپس بکاپ موردنظر را بازیابی کنید:

```bash
faoxima-vps restore /var/backups/faoxima/faoxima_DATE.tar.gz
```

برای تأیید باید عبارت زیر را وارد کنید:

```text
RESTORE
```

### ورود بکاپ SQL سی‌پنل

فایل SQL را در مسیر `/root` آپلود کنید، سپس اجرا کنید:

```bash
faoxima-vps import-sql /root/mtnedgei_mehdi.sql
```

برای تأیید باید عبارت زیر را وارد کنید:

```text
IMPORT
```

مدیر قبل از جایگزینی دیتابیس، یک بکاپ ایمنی می‌گیرد. سپس دیتابیس را
جایگزین کرده، مهاجرت‌های لازم را اجرا و Webhook را ثبت می‌کند.

### تعمیر دسترسی فایل‌ها

```bash
faoxima-vps permissions
```

### ثبت مجدد Webhook تلگرام

```bash
faoxima-vps webhook
```

### ثبت مجدد دکمه Mini App

```bash
faoxima-vps menu-button
```

### اجرای دستی تمام Cronها

```bash
faoxima-vps cron
```

### مشاهده تنظیمات و وضعیت Cron

```bash
faoxima-vps cron-status
```

### مشاهده لاگ‌ها

```bash
faoxima-vps logs
```

### چرخش و فشرده‌سازی فوری لاگ‌ها

```bash
faoxima-vps rotate-logs
```

### فعال یا غیرفعال‌کردن ارسال بکاپ دیتابیس به تلگرام

```bash
faoxima-vps backup-delivery
```

عدد `1` برای فعال‌سازی و عدد `0` برای غیرفعال‌سازی است.

## تست کامل پس از نصب

```bash
bash /var/www/faoxima/ubuntu/self-test.sh live
```

در صورت سلامت کامل باید پیام زیر نمایش داده شود:

```text
[Self-test] PASSED
```

## مسیرهای مهم

```text
Application:  /var/www/faoxima
Configuration: /etc/faoxima-vps.conf
Manager:      /usr/local/sbin/faoxima-vps
Backups:      /var/backups/faoxima
Runtime log:  /var/www/faoxima/logs/runtime.log
PHP log:      /var/www/faoxima/logs/php-error.log
Cron config:  /etc/cron.d/faoxima
```

## حذف فاکسیما

### حذف برنامه و دیتابیس با نگهداری بکاپ‌ها

```bash
faoxima-vps uninstall
```

برای تأیید باید بنویسید:

```text
UNINSTALL
```

### حذف کامل برنامه، دیتابیس، بکاپ‌ها، Cronها و گواهی SSL

هشدار: این دستور تمام اطلاعات فاکسیما را حذف می‌کند.

```bash
faoxima-vps uninstall --purge
```

برای تأیید باید بنویسید:

```text
UNINSTALL
```

## رفع اشکال سریع

اگر ربات پاسخ نداد:

```bash
faoxima-vps health
faoxima-vps webhook
faoxima-vps permissions
systemctl restart apache2 mysql cron
faoxima-vps logs
```

اگر مینی‌اپ باز نشد:

```bash
curl -I https://YOUR-DOMAIN/app/
faoxima-vps menu-button
faoxima-vps health
```

اگر پنل وب باز نشد:

```bash
curl -I https://YOUR-DOMAIN/panel/
apache2ctl configtest
systemctl restart apache2
faoxima-vps logs
```

## امنیت

- فایل `config.php`، بکاپ SQL، توکن ربات و رمز دیتابیس را در GitHub
  قرار ندهید.
- مخزن عمومی فقط باید شامل سورس بدون اطلاعات واقعی، ZIP نهایی،
  `install.sh` و این README باشد.
- در صورت انتشار اتفاقی توکن یا رمز، فوراً آن را تغییر دهید.

## فایل نسخه پایدار

```text
Faoxima-3xui-v3.5.0-UBUNTU-STABLE-MANAGER-FIX17C-FRESH-DB-SAFE.zip
```

SHA256:

```text
6F40BC7FC2B9A4044C2CC340F4098570D2970C57D89FDB103B87289BE1ED30EE
```
