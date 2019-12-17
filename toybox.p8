pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--keys

-- https://www.lexaloffle.com/bbs/?tid=3367
-- is_held(k) is true if the key k is held down
-- is_pressed(k) is true if the key has just been pressed by the user
-- is_released(k) is true if the key has just been released by the user
keys={}

function is_held(k,p) return band(keys[k][p], 1) == 1 end
function is_pressed(k,p) return band(keys[k][p], 2) == 2 end
function is_released(k,p) return band(keys[k][p], 4) == 4 end

function upd_key(k,p)
    if keys[k][p] == 0 then
        if btn(k,p) then keys[k][p] = 3 end
    elseif keys[k][p] == 1 then
        if btn(k,p) == false then keys[k][p] = 4 end
    elseif keys[k][p] == 3 then
        if btn(k,p) then keys[k][p] = 1
        else keys[k][p] = 4 end
    elseif keys[k][p] == 4 then
        if btn(k,p) then keys[k][p] = 3
        else keys[k][p] = 0 end
    end
end

function init_keys()
	for a = 0,5 do 
		keys[a] = {}
		for p=0,3 do
			keys[a][p] = 0 
		end
	end
end

function upd_keys()
	for a = 0,5 do
		for p=0,3 do
			upd_key(a,p)
		end
	end
end

function _init()
    init_keys()

    p={}
    p.x=64
    p.y=8
    p.vy=0 --y velocity
    p.yac=1 --y acceleration
    p.jumped=false
    p.jumpreleased=true
    p.update=function()
        if(is_held(5,0) and p.jumpreleased==true and p.jumped==false)then --if P1 jumps
            p.vy-=p.yac
            if(p.vy<-7)then
                p.jumpreleased=false
                p.jumped=true
            end
        elseif(is_released(5,0))then --if P1 jumps
            p.jumped=true
            p.jumpreleased=true
        elseif(is_falling())then
            p.vy+=p.yac
        end

        p.y+=p.vy

        if(not is_falling())then
            p.y=100
            p.vy=0
            p.jumped=false
        end
    end

    p.draw=function()
        rectfill(p.x,p.y,p.x+7,p.y+7,7)
    end

    cam={}
    cam.x=0
    cam.y=0

    cam.update=function()
        
    end
end

function _update60()
    upd_keys()
    p.update()
    cam.update()
end

function _draw()
    cls()
    p.draw()

    line(0,108,128,108,10)
end

function is_falling()
    if(p.y>100)return false

    if(p.jumped==true)return true

    return true
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
