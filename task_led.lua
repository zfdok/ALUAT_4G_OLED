module(..., package.seeall)
require "utils"
require "pm"
require "pins"

local alert_led = pins.setup(11, 0)
local alert_beep = pins.setup(9, 0)

function red_led_while_alert_on()
    sys.taskInit(function()
        if _G.already_beep == 0 then
            _G.already_beep = 1
            print("_G.period * 60 / 2 -2", _G.period * 60 / 2 - 2)
            for i = 1, _G.period * 60 / 2 - 2 do
                if _G.stop_beep == 0 then
                    print("=========================:", i)
                    alert_led(1)
                    alert_beep(1)
                    sys.wait(500)
                    alert_led(0)
                    alert_beep(0)
                    sys.wait(1500)
                else
                    sys.wait(100)
                end
            end
            _G.already_beep = 0
            _G.stop_beep = 0
        end
    end)
end

sys.taskInit(function()

end)

sys.subscribe("ALERT_ON", red_led_while_alert_on)

