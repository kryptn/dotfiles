
# magic trackpad 2

get the driver here

https://github.com/RicardoEPRodrigues/magicmouse-hid

`/etc/modprobe.d/hid-magicmouse.conf`

```
options hid-magicmouse \
            scroll_acceleration=1 \
            stop_scroll_while_moving=1 \
            scroll_speed=3 \
            middle_click_3finger=1 \
            scroll_delay_pos_x=300 \
            scroll_delay_pos_y=250
```