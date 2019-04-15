# M300 LB2 Simon Stumpf



## Ziele

Mittels Packer werden Ubunut VMs unter Virtualbox automatisiert erstellt. Die VMs werden aktualisiert und mit folgenden Software installiert. 
* UFW Firewall 
* Apache2 Reverse Procy


## Voraussetzungen

* PC mit min. 8 GB freiem RAM und ca. 20 GB freiem Harddisk (Ressourcen der VMs können angepasst werden).
* Software Packer
* VirtualBox

-------------------
  
## Konfiguration
### Packer
Mit Vagrant können virtuelle Maschinen vollständig automatisiert erstellt werden. Es werden jegendlich einige Konfigurationsdateien benötigt. All dies wird in diesem Kapitel beschrieben. :
#### Verzeichnisse

Folgende Verzeichnisse werden werden für Packer benötigt:

<tab>    | <tab>
--------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------
**Ordner**   | Verwendung
scripts        | Alle Scripts, welche nach der erfolgreichen Installation des Betriebssystems durchlaufen müssen, müssen in diesem Ordner abgelegt sein.
iso       | Das ISO File wird in dieses Verzeichnis heruntergeladen. Alternativ kann das ISO File auch in dieser Verzeichnis kopiert werden. 
http| Die Datei "preseed.cfg" muss hier abgelegt sein. Diese beinhaltet weitere Konfigurationselemente.

#### Konfigurationsdateien
##### Install.json
Diese Datei beinhaltet alle wichtigen Konfigurationen. Unter dem Abschnitt "boot_command" werden alle Einstellungen definiert, welche dem Ubuntu mitgegeben werden(Keyboardlayout, Zeitzone, User etc.). 
Der Abschnitt "builders" beinhaltet alle weiteren Konfigurationen, wie z.B. die ISO Datei oder der SSH User. 
Unter "vboxmanage" werden alle Einstellungen definiert, welche Virtualbox benötigt (Anzahl CPUs, RAM).k

In diesem File muss im Abschnitt "provisioners" alle Bash Files angegeben werden, welche nach der Installation ausgeführt werden müssen. 
##### Preseed.cfg
Diese Datei beinhaltet sämtliche Konfigurationen, welche für die Ubunut Installation benötit werden. Hier werden zum Beispiel die benötigten Partitionen erstellt. Ebenfalls werden hier noch die User erstellt und auch die zu installierenden Pakete definiert. 
##### Setup.sh
Diese Datei wird nach der Installation des Systems ausgeführt. 
Zuerst wird der User "vagrant" in die Gruppe sudoers hinzugefügt. Danach wird das System aktualisiert und die Firewall Software ufw installiert und konfiguriert. Anschliessend wird der Apache Reverse Proxy installiert und konfiguriert. 
### Virtualbox
Unter Virtualbox müssen keine weiteren Einstellungen getätigt werden. 

## Sicherheit
Wähend der Installation werden mehrere sicherheitsrelevante Einstellungen getätigt. Diese werden hier aufgelistet:
### Firewall
Mit dem Skript "setup.sh wird die Firewall UFW installiert. Anschliessend werden die Ports 22 und 80 (TCP) geöffnet.
### Apache2 Proxy
Zuerst werden die benötigten Pakete installiert und diese auch aktiviert. 
Danach wird das File "001-reverseproxy.conf" erstellt und anschliessend auch mit den Einstellungen befüllt. 
Danach werden die Services noch neu gestartet. 
