# WIFI PINEAPPLE MARK VII - REST CLIENT

- The leading rogue access point and WiFi pentest toolkit for close access operations.
- Passive and active attacks analyze vulnerable and misconfigured devices. 
- https://hak5.org/collections/sale/products/wifi-pineapple

> __Author__::      TW-D
>
> __Version__::     1.3.7
>
> __Copyright__::   Copyright (c) 2024 TW-D
>
> __License__::     Distributes under the same terms as Ruby
>
> __Doc__::         https://hak5.github.io/mk7-docs/docs/rest/rest/
>
> __Requires__::    Ruby >= 2.7.0p0 and WiFi Pineapple Mark VII >= 2.1.0-stable
>  
>
> __Installation (Debian-Based Linux Distributions)__::
>
> * sudo apt-get install build-essential curl g++ ruby ruby-dev
>
> * sudo gem install net-ssh rest-client tty-progressbar

## Description

Library allowing the automation of active or passive attack operations.

__Note :__ *"Issues" and "Pull Request" are welcome.*

## Payloads

In *"./payloads/"* directory, you will find :

| COMMAND and CONTROL | Author | Usage |
| --- | --- | --- |
| Hak5 Key Croc - Real-time recovery of keystrokes from a keyboard | TW-D | (edit) ruby ./hak5_key-croc.rb |
| Maltronics WiFi Deauther - Spam beacon frames | TW-D | (edit) ruby ./maltronics_wifi-deauther.rb |

| DEFENSE | Author | Usage |
| --- | --- | --- |
| Hak5 Pineapple Spotter | TW-D with special thanks to **[@DrSKiZZ](https://github.com/DrSKiZZ)**, **[@cribb-it](https://github.com/cribb-it)**, **[@barry99705](https://github.com/barry99705)** and **[@dark_pyrro](https://codeberg.org/dark_pyrro)** | (edit) ruby ./hak5-pineapple_spotter.rb |

| DoS | Author | Usage |
| --- | --- | --- |
| Deauthentication of clients available on the access points | TW-D | (edit) ruby ./deauthentication-clients.rb |

| EXPLOITATION | Author | Usage |
| --- | --- | --- |
| Evil WPA Access Point | TW-D | (edit) ruby ./evil-wpa_access-point.rb |
| Fake Access Points | TW-D | (edit) ruby ./fake_access-points.rb |
| Mass Handshakes | TW-D | (edit) ruby ./mass-handshakes.rb |
| Rogue Access Points | TW-D | (edit) ruby ./rogue_access-points.rb |
| Twin Access Points | TW-D | (edit) ruby ./twin_access-points.rb |

| GENERAL | Author | Usage |
| --- | --- | --- |
| System Status, Disk Usage, ... | TW-D | (edit) ruby ./dashboard-stats.rb |
| Networking Interfaces | TW-D | (edit) ruby ./networking-interfaces.rb |
| System Logs | TW-D | (edit) ruby ./system-logs.rb |

| RECON | Author | Usage |
| --- | --- | --- |
| Access Points and Clients on 2.4GHz and 5GHz (with a supported adapter) | TW-D | (edit) ruby ./access-points_clients_5ghz.rb |
| Access Points and Clients | TW-D | (edit) ruby ./access-points_clients.rb |
| MAC Addresses of Access Points | TW-D | (edit) ruby ./access-points_mac-addresses.rb |
| Tagged Parameters of Access Points | TW-D | (edit) ruby ./access-points_tagged-parameters.rb |
| Access Points and Wireless Network Mapping with WiGLE | TW-D | (edit) ruby ./access-points_wigle.rb |
| MAC Addresses of Clients | TW-D | (edit) ruby ./clients_mac-addresses.rb |
| OPEN Access Points | TW-D | (edit) ruby ./open_access-points.rb |
| WEP Access Points | TW-D | (edit) ruby ./wep_access-points.rb |
| WPA Access Points | TW-D | (edit) ruby ./wpa_access-points.rb |
| WPA2 Access Points | TW-D | (edit) ruby ./wpa2_access-points.rb |
| WPA3 Access Points | TW-D | (edit) ruby ./wpa3_access-points.rb |

| WARDRIVING | Author | Usage |
| --- | --- | --- |
| Continuous Recon on 2.4GHz and 5GHz (with a supported adapter) | TW-D | (edit) ruby ./continuous-recon_5ghz.rb [CTRL+c] |
| Continuous Recon for Handshakes Capture | TW-D | (edit) ruby ./continuous-recon_handshakes.rb [CTRL+c] |
| Continuous Recon | TW-D | (edit) ruby ./continuous-recon.rb [CTRL+c] |

## Payload skeleton for development

```ruby
#
# Title:            <TITLE>
#
# Description:      <DESCRIPTION>
#
#
# Author:           <AUTHOR>
# Version:          <VERSION>
# Category:         <CATEGORY>
#
# STATUS
# ======================
# <SHORT-DESCRIPTION> ... SETUP
# <SHORT-DESCRIPTION> ... ATTACK
# <SHORT-DESCRIPTION> ... SPECIAL
# <SHORT-DESCRIPTION> ... FINISH
# <SHORT-DESCRIPTION> ... CLEANUP
# <SHORT-DESCRIPTION> ... OFF
#

require_relative('<PATH-TO>/classes/PineappleMK7.rb')

system_authentication = PineappleMK7::System::Authentication.new
system_authentication.host = "<PINEAPPLE-IP-ADDRESS>"
system_authentication.port = 1471
system_authentication.mac = "<PINEAPPLE-MAC-ADDRESS>"
system_authentication.password = "<ROOT-ACCOUNT-PASSWORD>"

if (system_authentication.login)

    led = PineappleMK7::System::LED.new

    # SETUP
    #
    led.setup

    #
    # [...]
    #

    # ATTACK
    #
    led.attack

    #
    # [...]
    #

    # SPECIAL
    #
    led.special

    #
    # [...]
    #

    # FINISH
    #
    led.finish

    #
    # [...]
    #

    # CLEANUP
    #
    led.cleanup

    #
    # [...]
    #

    # OFF
    #
    led.off

end
```

__Note :__ *Don't hesitate to take inspiration from the payloads directory.*

## System modules

### Authentication accessors/method

```ruby
system_authentication = PineappleMK7::System::Authentication.new

system_authentication.host = (string) "<PINEAPPLE-IP-ADDRESS>"
system_authentication.port = (integer) 1471
system_authentication.mac = (string) "<PINEAPPLE-MAC-ADDRESS>"
system_authentication.password = (string) "<ROOT-ACCOUNT-PASSWORD>"

system_authentication.login()
```

### LED methods

```ruby
led = PineappleMK7::System::LED.new

led.setup()
led.failed()
led.attack()
led.special()
led.cleanup()
led.finish()
led.off()
```

## Pineapple Modules

### Dashboard

#### Notifications method

```ruby
dashboard_notifications = PineappleMK7::Modules::Dashboard::Notifications.new

dashboard_notifications.clear()
```

#### Stats method

```ruby
dashboard_stats = PineappleMK7::Modules::Dashboard::Stats.new

dashboard_stats.output()
```

### Logging

#### System method

```ruby
logging_system = PineappleMK7::Modules::Logging::System.new

logging_system.output()
```

### PineAP

#### Clients methods

```ruby
pineap_clients = PineappleMK7::Modules::PineAP::Clients.new

pineap_clients.connected_clients()
pineap_clients.previous_clients()
pineap_clients.kick( (string) mac )
pineap_clients.clear_previous()
```

#### EvilWPA accessors/method

```ruby
evil_wpa = PineappleMK7::Modules::PineAP::EvilWPA.new

evil_wpa.ssid = (string default:'PineAP_WPA')
evil_wpa.bssid = (string default:'00:13:37:BE:EF:00')
evil_wpa.auth = (string default:'psk2+ccmp')
evil_wpa.password = (string default:'pineapplesareyummy')
evil_wpa.hidden = (boolean default:false)
evil_wpa.enabled = (boolean default:false)
evil_wpa.capture_handshakes = (boolean default:false)

evil_wpa.save()
```

#### Filtering methods

```ruby
pineap_filtering = PineappleMK7::Modules::PineAP::Filtering.new

pineap_filtering.client_filter( (string) 'allow' | 'deny' )
pineap_filtering.add_client( (string) mac )
pineap_filtering.clear_clients()
pineap_filtering.ssid_filter( (string) 'allow' | 'deny' )
```

#### Impersonation methods

```ruby
pineap_impersonation = PineappleMK7::Modules::PineAP::Impersonation.new

pineap_impersonation.output()
pineap_impersonation.add_ssid( (string) ssid )
pineap_impersonation.clear_pool()
```

#### OpenAP method

```ruby
open_ap = PineappleMK7::Modules::PineAP::OpenAP.new

open_ap.output()
```

#### Settings accessors/method

```ruby
pineap_settings = PineappleMK7::Modules::PineAP::Settings.new

pineap_settings.enablePineAP = (boolean default:true)
pineap_settings.autostartPineAP = (boolean default:true)
pineap_settings.armedPineAP = (boolean default:false)
pineap_settings.ap_channel = (string default:'11')
pineap_settings.karma = (boolean default:false)
pineap_settings.logging = (boolean default:false)
pineap_settings.connect_notifications = (boolean default:false)
pineap_settings.disconnect_notifications = (boolean default:false)
pineap_settings.capture_ssids = (boolean default:false)
pineap_settings.beacon_responses = (boolean default:false)
pineap_settings.broadcast_ssid_pool = (boolean default:false)
pineap_settings.broadcast_ssid_pool_random = (boolean default:false)
pineap_settings.pineap_mac = (string default:system_authentication.mac)
pineap_settings.target_mac = (string default:'FF:FF:FF:FF:FF:FF')
pineap_settings.beacon_response_interval = (string default:'NORMAL')
pineap_settings.beacon_interval = (string default:'NORMAL')

pineap_settings.save()
```

### Recon

#### Handshakes methods

```ruby
recon_handshakes = PineappleMK7::Modules::Recon::Handshakes.new

recon_handshakes.start( (object) ap )
recon_handshakes.stop()
recon_handshakes.output()
recon_handshakes.download( (object) handshake, (string) destination )
recon_handshakes.clear()
```

#### Scanning methods

```ruby
recon_scanning = PineappleMK7::Modules::Recon::Scanning.new

recon_scanning.start( (integer) scan_time )
recon_scanning.start_continuous( (boolean) autoHandshake )
recon_scanning.stop_continuous()
recon_scanning.output( (integer) scanID )
recon_scanning.tags( (object) ap )
recon_scanning.deauth_ap( (object) ap )
recon_scanning.delete( (integer) scanID )
```

### Settings

#### Networking methods

```ruby
settings_networking = PineappleMK7::Modules::Settings::Networking.new

settings_networking.interfaces()
settings_networking.client_scan( (string) interface )
settings_networking.client_connect( (object) network, (string) interface )
settings_networking.client_disconnect( (string) interface )
settings_networking.recon_interface( (string) interface )
```
