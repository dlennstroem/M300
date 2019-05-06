# M300 LB3 Simon Stumpf



## Ziele

Mittels Docker werden mehrere Container erstellt, welche abhängig von einander sind.


## Voraussetzungen

* Maschine mit Linux
* Docker installiert
* Docker-compose installiert

-------------------
  
## Konfiguration
### Packer
Mittels Docker können Container erzeugt und verwaltet werden. Für das Erstellen der Container wird zusätzlich Docker-Compose benötigt. 
#### Benötigte Dateien

Folgende Dateien / Verzeichnisse werden werden für dieses Projekt benötigt benötigt:

| <tab>              | <tab>                                                       |
| ------------------ | ----------------------------------------------------------- |
| **Datei**          | Verwendung                                                  |
| docker-compose.yml | In dieser Datei werden alle Container definiert             |
| Ordner PHP         | Dieser Ordner wird für den Container WEB benötigt           |
| index.php          | Die Datei "index.php" dient als Testdatei für den Webserver |

#### Konfigurationsdatei docker-compose.yml
In dieser Datei werden alle Container definiert
##### Container Pihole
Dieser Container beinhaltet die Applikation Pihole, welcher als lokaler DNS Server dient. 

| <tab>             | <tab>                                                       |
| ----------------- | ----------------------------------------------------------- |
| **Configuration** | Value                                                       |
| Container Name    | pihole                                                      |
| Image             | pihole/pihole:latest                                        |
| Ports             | 53:53/tcp , 53:53/udp , 67:67/udp , 80:80/tcp , 443:443/tcp |
| Volumes           | -                                                           |
| DNS               | 127.0.0.1, 1.1.1.1                                          |

##### Container DB
Dieser Container beinhaltet eine MySQL Datenbank

| <tab>               | <tab>     |
| ------------------- | --------- |
| **Configuration**   | Value     |
| Container Name      | db_mysql  |
| Image               | mysql:5.7 |
| Ports               | 9906:3306 |
| Volumes             | -         |
| MYSQL_ROOT_PASSWORD | 1234      |
| MYSQL_DATABASE      | dbteset   |
| MYSQL_USER          | dbuser    |
| MYSQL_PASSWORD      | 1234      |

##### Container Web
Dieser Container beinhaltet einen Apache2 Webserver

| <tab>             | <tab>                 |
| ----------------- | --------------------- |
| **Configuration** | Value                 |
| container_name    | php_web               |
| Image             | php:7.2.2-apache      |
| Ports             | 8100:80               |
| Volumes           | ./php/:/var/www/html/ |

##### Container phpmyadmin
Dieser Container beinhaltet PHP MyAdmin, welche auf den Contaienr db_mysql verlinkt ist. 

| <tab>             | <tab>                  |
| ----------------- | ---------------------- |
| **Configuration** | Value                  |
| container_name    | phpmyadmin             |
| Image             | phpmyadmin/phpmyadmin. |
| Ports             | 8080:80                |
| Volumes           | -                      |

##### Container cadvisor
Dieser Container beinhaltet das Überwachungstool Cadvisor. 

| <tab>             | <tab>                                                                                      |
| ----------------- | ------------------------------------------------------------------------------------------ |
| **Configuration** | Value                                                                                      |
| container_name    | cadvisor                                                                                   |
| Image             | google/cadvisor:v0.29.0                                                                    |
| Ports             | 8888:8080                                                                                  |
| Volumes           | /:/rootfs:ro ,/var/run:/var/run:rw ,  /sys:/sys:ro , /var/lib/docker/:/var , lib/docker:ro |