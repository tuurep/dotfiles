function on_fullscreen_change(name, value)
    if value == true then
        mp.set_property("background-color", "#000000")
    else
        mp.set_property("background-color", "#0f0f0f")
    end
end

mp.observe_property("fullscreen", "bool", on_fullscreen_change)
