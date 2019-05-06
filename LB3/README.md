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

## Absicherung der Container

### cAdvisor
cAdvisor ist ein Überwachungstool von Google, welches selber als Container läuft. In dieser Umgebung überwacht es die zu Verfügung gestellten CPUs und den Zugriff auf den RAM. Ebenfalls wird die Aulastung der Netzwerkkarten angezeigt. 
### Host System
Um den Zugriff auf das System zu beschränken, laufen die Container auf einer speziell dafür errichteten virtuellen Maschine. Diese verfügt nur über einen SSH Zugriff, welches das Angrifsrisiko minimiert. 
Der Zugriff via SSH wurde auf der Maschine auf 2 User minimiert.

### Kommunikation mit dem Docker Deamon
Die Kommunikation mit dem Docker Deamon ist besonders heikel, da dieser über Root Rechte auf den einzelnen Host Systemen verfügt. Deshlab sollte die Verbindung nur über HTTPS mit einem gültigen Zertifikat laufen. 

### Aktuelle Version der Docker Images
Um ständig auf dem neusten Stand der Images zu sein, wird bei dem Image (sofern möglich) die neuste Version angegeben z.B: pihole/pihole:latest  . 
Somit kann gewährleistet werden, dass immer die aktuellste Version des Images verwendet wird. 

### Limitierung der Ressourcen
Da unser Hostsystem nur begrenz Ressourcen hat, wird für jeden Container ein CPU und Memory Limit gesetzt. Somit ist gewährleistet, dass kein Container zu viele Ressourcen benötigt und somit den Host zum abstürzen bringen kann. 

### Benchmark Security Tool
Mit dem Skript Docker Bench Security kann die Sicherheit der Container überprüft werden. 
Das Skript ist als Github Repository verfügbar: https://github.com/docker/docker-bench-security
Sobald das Skript erfolgreich durchgelaufen ist, kann der Report des Skriptes angeschaut werden und die dementsprechenden Sicherheitseinstellungen konfiguriert werden.

## Vergleich Vorwissen - Wissenszuwachs
Da ich im Voraus noch nichts über die Containerisierung wusste, konnte ich ernorm viel lernen. Ebenfalls konnte ich die Software Docker, Packer und Vagrant vertieft anschauen.
Nun kenne ich die Grundlagen deren Software und weiss auch die Funktionsweise der Softwares. 
Da ich nachher in der Openshift Abteilung arbeite, war dies sehr interessant für mich.

## Reflexion
### Reflexion LB3
In der LB3 konnte ich sehr viel lernen. So lernte ich die Funktionsweise von Docker und Docker-Compose. Ebenfalls lernte ich, wie mein ein docker-compose.yml file erstellt und definiert. Die Verknüpfungen von einzelnen Containern sowie auch das Angeben von Volumes war mir völlig neu. 
### Reflexion Modul
In diesem Modul lernte ich sehr viel. Ich lernte die Funktions und Denkensweise von Container. Allgemein könnte man sagen, dass ich das Prinzip IaaC lernte. Auch das automatisierte erstellen von VMs mittels Packer war sehr interessant. Die Funktionsweise von Docker war ebenfalls sehr spannend und lehrreich. 
So lernte ich, wie man Container erstellt, konfiguriert. Die Funktionsweise vom Docker Deamon war mir ebenfalls neu. 
Das Modul bereitete mir sehr viel Spass und ich konnte sehr viel lernen. 