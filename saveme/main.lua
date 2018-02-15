--project:saveme game

display.setStatusBar(display.HiddenStatusBar)

local centerX = display.contentCenterX
local centerY = display.contentCenterY

-- set up forward references

local startGame
local   gameTitle
local spawnEnemy
local scoreTxt
local  score =0
local  hit
local  boy
local speedBump
local txt
local enemy
--local enemy
-- preload audio

local sndKill = audio.loadSound("boing-1.wav")
local sndBlast = audio.loadSound ( "blast.mp3" ) -- audio file courtesy Mike Koenig
local sndLose = audio.loadSound ( "mu.mp3" )

   
  --create play screen
  local function createPlayScreen()
   local background =display .newImage( "bk.png")

   background.y=200
   background.alpha=0

     boy =display.newImage("7.png")
   boy.x=centerX
   boy.y=display.contentHeight + 60
   boy.alpha=0
   
   
   transition.to(background,{time=2000,alpha=1,y=centerY,x=centerX})
   
   local function showTitle()
   	  gameTitle =display.newImage( "tittle3.png")
   	  gameTitle.x=centerX
   	  gameTitle.y=display.screenOriginY+10
   	 gameTitle.alpha = 0
		gameTitle : scale (4, 4)
	transition.to( gameTitle, {time=500, alpha=1, xScale=1, yScale=1} )
	startGame( )
   end
   
  	transition.to(boy ,{ time=2000,alpha=1, y=centerY,onComplete=showTitle}) 
  
  end
  -----game function
  
   function startGame( )
   
	local text = display.newText( "Tap here to start the Game!", 0, 0, "Helvetica", 24 )
	text.x = centerX
	text.y = display.contentHeight - 30
	text:setTextColor(255, 254, 185)
 
	local function goAway( event )
		display.remove(txt)
display.remove(event.target)
text= nill
display.remove(gameTitle)
spawnEnemy()
	scoreTxt =display.newText( "score  :  0",0,0,"Helvetica",22)
	scoreTxt:setTextColor(255, 0, 0)
	scoreTxt.x =centerX
	scoreTxt.y= 10
	score =0
	end
	
		boy.numHits = 10
		boy.alpha = 1
		speedBump = 0

	text:addEventListener ( "tap", goAway )
   end
    
    function  spawnEnemy( )
    enemy=display.newImage("thir.png")

	-- enemy = display.newImage(enemypics[math.random (1 , 60)])
  	enemy :addEventListener ( "tap",  Smash )
	if math.random(2) == 1 then
	enemy .x = math.random ( -100, -10 )
	else
		enemy  .x = math.random ( display.contentWidth + 10, display.contentWidth + 100 )
	enemy.xScale = -1
	end
		enemy  .y = math.random (display.contentHeight)
	enemy .trans = transition.to ( enemy, { x=centerX, y=centerY,time=3500, onComplete=hit} )
	speedBump = speedBump + 50
   
   end
   
   
   function  Smash( event)
  	local obj = event.target
	display.remove( obj )
	audio.play( sndKill)
	transition.cancel (event .target.trans)
	score =score + 10
	scoreTxt.text ="Score  :  " .. score
	spawnEnemy()
	return true

end



local function  dead()

			boy.numHits = boy.numHits - 2
	boy.alpha = boy.numHits / 10
	if boy.numHits < 2 then
		boy.alpha = 0
		display.remove(scoreTxt)
	timer.performWithDelay ( 500, startGame )
		
	txt =display.newText( "GAME  OVER  !!!!!!",0,0,"Helvetica",28)
	txt:setTextColor(255, 0, 0)
	txt.x =centerX
	txt.y=display.screenOriginY+60
		audio.play ( sndLose )
	else
		local function goAway(obj)
			boy.xScale = 1
			boy.yScale = 1
			boy.alpha = boy.numHits / 10
		end

	transition.to ( boy, { time=200, xScale=1.2, yScale=1.2, alpha=1, onComplete=goAway} )	
	end
end


function  hit (obj)
	display.remove( obj )
	dead()
	audio.play(sndBlast)
	if boy.numHits > 1 then
		spawnEnemy()
	end
end
  
  	 	  	
  	createPlayScreen( )