import sonoff
import config
from win10toast import ToastNotifier

s = sonoff.Sonoff(config.username, config.password, config.api_region)
toast = ToastNotifier()

devices = s.get_devices()
if devices:
    # We found a device, lets turn something on
    device_id = devices[0]['deviceid']

    if(devices[0]["params"]['switch'] == 'on'):
        s.switch('off', device_id, None)
        toast.show_toast("Luz Desligada","Luz desligada ",duration=20,icon_path="light.ico")

    else:
        s.switch('on', device_id, None)
        toast.show_toast("Luz Ligada","Luz ligada ",duration=20, icon_path="light.ico")
