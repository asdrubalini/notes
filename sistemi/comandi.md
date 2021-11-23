# Switch

```
(global) ho nomeswitch   		// da nome switch
(global) enable secret cisco  		// da password cisco al privilage exe. mode
(global) line console 0			// entra line console
    password cisco			// setta password console
    login
(global) line vty 0 15			// entra lineee vty da 0 a 15
    password cisco			// setta pass cisco alle linee
    login
(global) service password-encription    // cripta password
(global) banner motd #testo#		// banner
(global) int vlan1					// entra nella vlan1 per dare ip alllo sw
    ip address 10.10.10.254 255.255.255.0		// da ip allo sw
    no shut					// tira su interfaccia
(global) ip default-gateway 10.10.10.1 	// imposta il default-gateway allo sw
(global) show run			// x vedere le configurazioni del router
(global) show ip interface brief	// fa vedere le interfaccie
(global) wr o copy running-config startup-config	// salva configurazioni
(global) show sta			// x vedere il file salvato delle configurazioni
(global) reload				// torna indietro al vecchio salvataggio
(global) erase startup-config		// torna impostazioni di fabbrica
```

# Router

```
(global) ho nomerouter   		// da nome router
(global) enable secret cisco  		// da password cisco al privilage exe. mode
(global) line console 0			// entra line console
    password cisco			// setta password console
    login
(global) line vty 0 15			// entra lineee vty da 0 a 15
    password cisco			// setta pass cisco alle linee
    login
(global) service password-encription    // cripta password
(global) banner motd #testo#		// banner
(global) ipv6 unicast-routing   			//attiva ipv6 sul router
(global) int g0/0/0   					//entra gigabit eternet 0/0/0
(global 0/0/0) ipv6 addr 2001:bada:ebe:fede::1/64   	//da ipv6 al router --gateway--
(global 0/0/0) no shut
(global 0/0/0) ipv6 addr fe80::1 link-local   		//ipv6 link local
(global) show run			// x vedere le configurazioni del router
(global) show ip interface brief	// fa vedere le interfaccie
(global) wr o copy running-config startup-config	// salva configurazioni
(global) show sta			// x vedere il file salvato delle configurazioni
(global) reload				// torna indietro al vecchio salvataggio
(global) erase startup-config		// torna impostazioni di fabbrica
```

# Routing table

```
(global) ip route 0.0.0.0 0.0.0.0 g0/0/2		//da qualsiasi rete esterna lo manda al gateway di entrata dello stesso router
```

Inserire gli indirizzi di rete delle reti connesse al router opposto + aggiungere la rete 0.0.0.0/0 + aggiungere l'indirizzo di rete della rete che connette i due router

# Server radius

- attivare servizio AAA nel server desiderato
- client name: indifferente
  client ip: ip del router
  secret: esempio "ciao"
  username: credenziali utente
  password: credenziali utente
- attivare WPA2 Enterprise nel router wireless, compilo tutti i campi e inserire nel shared secret la stessa parola che ho inserire nella sezione "secret"
  nel server Radius nel servizio AAA
- Nel laptop, nella sezione Wireless all'interno di "Config", inserire lo stesso SSID inserito nel router wireless,
  selezionare WPA2 e inserire le credenziali dell'utente precedentemente settati all'interno del server.

# VLAN

Per creare una VLAN:

```
configure terminal
vlan <vlan-id>
name <vlan-name>
end
```

Per taggare una porta con una VLAN:

```
configure terminal
interface <interface-id>
switchport mode access
switchport access vlan <vlan-id>
end
exit
```

Per taggare con trunk:

```
configure terminal
interface <interface-id>
switchport mode trunk
end
exit
```

Per impostare la VLAN in una subinterface del router:

```
configure terminal
interface <interface-id>.<subinterface-id>
encapsulation dot1q <vlan-id> native
```

Sicurezza:

```
no ip domain-lookup
security passwords min-length 10
```

Impostare password nella line console:

```
conf t
line con 0
password ciaociaociao
login
end
```

```
conf t
line vty 0 4
exec-timeout 4201
login
end
```

```
enable password @Cons1234!
```

```
banner motd #se entri ti denuncio#
```

```
service password-encryption
```

Utente con password:

```
username NETadmin secret mypassword
username NETadmin privilege 15 secret S3cr3tP4ssw0rd
```

```
hostname router-brutto
ip domain-name router-brutto

crypto key generate rsa
ip ssh version 2
line vty 0 4
transport input ssh
```

Disabilitare porte non utilizzare:

```
interface range Gi0/1-24
shutdown
```
