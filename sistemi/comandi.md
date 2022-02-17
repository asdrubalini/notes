
------------------------------------------------------------------------------------------CONFIG SWITCH--------------------------------------------------------------------------------------

(global) ho nomeswitch   				// da nome switch
(global) enable secret cisco  				// da password cisco al privilage exe. mode
(global) line console 0					// entra line console
	 password cisco					// setta password console
	 login
(global) line vty 0 15					// entra lineee vty da 0 a 15 
	 password cisco					// setta pass cisco alle linee
 	 login
(global) service password-encription    		// cripta password
(global) banner motd #testo#				// banner
(global) int vlan1					// entra nella vlan1 per dare ip alllo sw
	 ip address indirizzoIP + Subnet Mask		// da ip allo sw
	 no shut					// tira su interfaccia
	 ip default-gateway indirizzoIP 		// imposta il default-gateway allo sw
(global) show run					// x vedere le configurazioni del router
(global) show ip interface brief			// fa vedere le interfaccie
(global) wr o copy running-config startup-config	// salva configurazioni
(global) show sta					// x vedere il file salvato delle configurazioni
(global) reload						// torna indietro al vecchio salvataggio
(global) erase startup-config				// torna impostazioni di fabbrica



------------------------------------------------------------------------------------------CONFIG ROUTER--------------------------------------------------------------------------------------

(global) ho nomerouter   				// da nome router
(global) enable secret cisco  				// da password cisco al privilage exe. mode
(global) line console 0					// entra line console
	 password cisco					// setta password console
	 login
(global) line vty 0 15					// entra linee vty da 0 a 15 
	 password cisco					// setta pass cisco alle linee
 	 login
(global) service password-encription    		// cripta password
(global) banner motd #testo#				// banner
(global) ipv6 unicast-routing   			//attiva ipv6 sul router
(global) int g0/0/0   					//entra gigabitEthernet 0/0/0
(global 0/0/0) ipv6 addr 2001:bada:ebe:fede::1/64   	//da ipv6 al router --gateway--
(global 0/0/0) no shut  
(global 0/0/0) ipv6 addr fe80::1 link-local   		//ipv6 link local
(global) show run					// x vedere le configurazioni del router
(global) show ip interface brief			// fa vedere le interfaccie
(global) show ip route					// fa vedere gli indirizzamenti
(global) wr o copy running-config startup-config	// salva configurazioni
(global) show sta					// x vedere il file salvato delle configurazioni
(global) reload						// torna indietro al vecchio salvataggio
(global) erase startup-config				// torna impostazioni di fabbrica 



------------------------------------------------------------------------------------------Route Table----------------------------------------------------------------------------------------

(global) ip route 0.0.0.0 0.0.0.0 g0/0/2		//da qualsiasi rete esterna lo manda al gateway di entrata dello stesso router


Inserire gli indirizzi di rete delle reti connesse al router opposto + aggiungere la rete 0.0.0.0/0 + aggiungere l'indirizzo di rete della rete che connette i due router



----------------------------------------------------------------------------------------SERVER RADIUS----------------------------------------------------------------------------------------

1) attivare servizio AAA nel server desiderato

2) client name: indifferente
   client ip: ip privato del router
   secret: esempio "ciao"
   username: credenziali utente
   password: credenziali utente

3) attivare WPA2 Enterprise nel router wireless, compilo tutti i campi e inserire nel shared secret la stessa parola che ho inserito nella sezione "secret"
   nel server Radius nel servizio AAA

4) Nel laptop, nella sezione Wireless all'interno di "Config", inserire lo stesso SSID inserito nel router wireless, 
   selezionare WPA2 e inserire le credenziali dell'utente precedentemente settati all'interno del server.


-------------------------------------------------------------------------------------------VLAN----------------------------------------------------------------------------------------------

Partire dalla vlan 2, la vlan 1 la si usa per inserire l'ip dello switch per l'accesso remoto

SWITCH

VLAN 2:
(config) vlan 2										//entra dentro alla vlan
(config-vlan) name ...									//rinonima le vlan
(global) do show vlan									//mostra le vlan
(config) int fastEthernet 0/2   oppure    int range fastEthernet 0/2-4			//entra dentro nelle interfaccie delle porte dello switch
(config-if) switchport mode access
(config-if) switchport access vlan 2							//setta la porta dello switch nella vlan in questione
(config-if) switchport mode trunk							//setta la porta dello switch tra 2 dispositivi (switch-switch) per il passaggio delle vlan
(global) show interface trunk								//mostra le interfaccie settate trunk
(global) show interface fastEthernet 0/x						//mostra l'interfaccia in questione


ROUTER

VLAN 2:
(config) interface fastEthernet 0/0.2							//entra dentro alla sotto interfaccia 0.2 del router
(config-subif) encapsulation dot1Q 2							//incapsula con modalità dot1Q numero vlan 2
(config-subif) ip address 192.168.10.9 255.255.255.248					//inserisce ip e subnet mask (default gateway di ogni vlan)
(config-subif) ip helper-add ip_server_DHCP						//server DHCP raggiungibile su tutte le vlan, scrivere in tutte le sotto interfaccie del router
(global) show interface fastEthernet 0/x						//mostra l'interfaccia in questione


--------------------------------------------------------------------------------CONFIG ROUTER SECURITY---------------------------------------------------------------------------------------

(config) ho R1										// rinonima il Router con R1
(config) security passwords min-length numero						// setta un minimo di lettere nelle password del router
(config) login block-for # attempts # within #						// 1°# = secondi di blocco, 2°# = dopo quanti tentativi, 3°# = quale arco di tempo posso fare i tentativi
(config-line) exec-timeout minuti secondi						// Disabilita exec mode dopo un certo tempo di inattività


-------------------------------------------------------------------------------------------SSH----------------------------------------------------------------------------------------------

(config) ho R1										// rinonima il Router con R1
(config) ena secret password								// da password cisco al privilage exe. mode
(config) no ip domain lookup								// disattiva DNS lookup
(config) ip domain name nome.com							// setta il nome di dominio a "nome.com"
(config) crypto key generate rsa general-keys modulus (1024)				// Genera una chiave per criptare il traffico SSH
(config) username credenziali secret credenziali					// setta il username e la password
(config-line) login local								// autentica le linee vty contro il database locale
(config-line) transport input ssh							// Attiva nelle linee vty le sessioni ssh

Prompt dei comandi: ssh -l username indirizzo						// accesso da remoto in ssh verso un dispositivo 


-------------------------------------------------------------------------------------------RIP----------------------------------------------------------------------------------------------

va configurato in tutti i router della rete.

RIPv1

(config) router rip									// serve per entrare nella configurazione del protocollo rip del router
(config-router) network 10.10.10.0 -> per togliere il network: no network 10.10.10.0	// inserisce la rete connessa al router come rotta e in questo caso la rete 10.10.10.0
(config-router) exit									// esce dalla configurazione del protocollo rip del router
(global) show ip route									// mostra le rotte salvate nel router
(global) show ip protocols								// mostra i protocolli attivi nel router
(global) debug ip rip -> x stopparlo: undebug all					// visualizza i messaggi RIP mandati e ricevuti

RIPv2

(config) router rip									// serve per entrare nella configurazione del protocollo rip del router
(config-router) version 2								// specifica l'uso della versione 2 del protocollo rip
(config-router) network 10.10.10.0							// inserisce la rete connessa al router e in questo caso la rete 10.10.10.0
(config-router) exit									// esce dalla configurazione del protocollo rip del router

da RIPv1 a RIPv2

(config-router) version 2								// specifica l'uso della versione 2 del protocollo rip
(config-router) no auto-summary								// toglie la modalità auto-summary all'interno del router
(config-router) no network 10.10.10.0							// toglie la rete salvata all'interno del router (inserita precedentemente) e in questo caso toglie la rete 10.10.10.0
(config-router) network 10.10.10.0							// inserisce la rete connessa al router come rotta e in questo caso la rete 10.10.10.0
