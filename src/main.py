import sonoff
import config
import os
from plyer import notification 

s = sonoff.Sonoff(config.username, config.password, config.api_region)

devices = s.get_devices()
if devices:
    # We found a device, lets turn something on
    device_id = devices[0]['deviceid']

    if(devices[0]["params"]['switch'] == 'on'):
        s.switch('off', device_id, None)
        notification.notify(
            title = "Luz Desligada",
            message = "Luz Desligada",          
            app_icon = "light.ico",
            timeout  = 50
        )

    else:
        s.switch('on', device_id, None)

        notification.notify(
            title = "Luz Ligada",
            message = "Luz Ligada",          
            app_icon = "light.ico",
            timeout  = 50
        )