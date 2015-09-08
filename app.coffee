# Remove framer cursor
document.body.style.cursor = "auto"

Framer.Defaults.Animation = {
    curve: "ease"
    time: .5
}
#stores variable for x values of each episode
sixValue = 30
sevenValue = 28-418
eightValue = 26-(418*2)
nineValue = 24-(418*3)
tenValue = 22-(418*4)
elevenValue = 20-(418*5)	

back = new Layer
	width: 1440, height: 1024
	image: "images/background@2x.png"

overlay = new Layer
	width: 1440, height: 1024, backgroundColor: "#000", opacity:0

overlay.states.add
	show:{opacity:.7}		

close = new Layer
	width: 63, height: 62
	image: "images/Close@2x.png", x:1208, y:103, opacity: 0

close.states.add
	show: {opacity:1}

modal = new Layer
	width: 417, height: 478, backgroundColor:"#2C2D2D", y:100, opacity: 0
	
scroller = new Layer
	width: 417, height:478, backgroundColor: "transparent", superLayer:modal

scroller.states.add
	expand:{height:700}

	
modal.centerX()

modal.states.add
	show: {opacity:1, y:150, height: 478}
	expand:	{y:100, height: 700}
	

modalwrapper = new Layer
	width: 418, height: 800, superLayer:scroller, backgroundColor:"transparent"

modalwrapper.states.add
	show: {opacity:1}

blockwrapper = new Layer
	x:0, width: 2459, height: 800
	superLayer:scroller, backgroundColor:"transparent"

blockwrapper.states.add
	seven: {x:sevenValue}
	eight: {x:eightValue}
	nine: {x:nineValue}
	ten: {x:tenValue}
	eleven: {x:elevenValue}

top = new Layer
	width: 2459, height: 192, x:30,y:25
	image: "images/top@2x.png", superLayer:modalwrapper

top.states.add
	seven: {x:sevenValue}
	eight: {x:eightValue}
	nine: {x:nineValue}
	ten: {x:tenValue}
	eleven: {x:elevenValue}


bottom = new Layer
	width: 2459, height: 128, x:30,y:244
	image: "images/bottom@2x.png", superLayer: modalwrapper

bottom.states.add
	six: {x:sixValue}
	seven: {x:sevenValue}
	eight: {x:eightValue}
	nine: {x:nineValue}
	ten: {x:tenValue}
	eleven: {x:elevenValue}	
# 	expand: {y:353}
# 	reduce: {y:244}

	
	
viewMore = new Layer
	width: 418, height: 70, y:408
	image: "images/view-more@2x.png", superLayer: modal

viewFewer = new Layer
	width: 418, height: 70
	image: "images/view-fewer@2x.png", opacity:0, superLayer:viewMore	
viewMore.states.add
	expand:{y:632}
	
viewFewer.states.add
	expand:{opacity:1}

isExpand = false
viewMore.on Events.Click, ->
	if (isExpand == false)	
		expand()
		isExpand = true
		makeScroll()
	else
		fold()
		isExpand = false
header = new Layer
	width: 417, height: 72, backgroundColor:'#2C2D2D', superLayer: modal
	
episodes = new Layer
	x:30, y:25, width: 2459, height: 39
	image: "images/episodes@2x.png", superLayer:modal
	
episodes.states.add
	seven: {x:sevenValue}
	eight: {x:eightValue}
	nine: {x:nineValue}
	ten: {x:tenValue}
	eleven: {x:elevenValue}	
	
nav = new Layer
	width: 50, height: 21, x:335, y:28
	image: "images/navigate@2x.png", superLayer: modal
	
leftButton = new Layer
	width: 30, height:30,superLayer:modal, x:328, y:23, backgroundColor:"transparent"

rightButton = new Layer
	width: 30, height:30,superLayer:modal, x:362, y:23,backgroundColor:"transparent"	

title = new Layer
	x:31, y: 24, width: 140, height: 17
	image: "images/title@2x.png", superLayer:modal

playBlock = (image, y) ->
	six = new Layer
		width:358, height: 91, x: 30, y: y, image:image, scale:0, opacity:0, superLayer:blockwrapper
	seven = new Layer
		width:358, height: 91, x: (420), y: y, image:image, scale:0, opacity:0,superLayer:blockwrapper
	eight = new Layer
		width:358, height: 91, x: (420*2), y: y, image:image, scale:0, opacity:0,superLayer:blockwrapper
	nine = new Layer
		width:358, height: 91, x: (420*3), y: y, image:image, scale:0, opacity:0,superLayer:blockwrapper
	ten = new Layer
		width:358, height: 91, x: (420*4), y: y, image:image, scale:0, opacity:0,superLayer:blockwrapper
	eleven = new Layer
		width:358, height: 91, x: (420*5), y: y, image:image, scale:0, opacity:0,superLayer:blockwrapper
	blocks = [six,seven,eight,nine,ten,eleven]
	for b in blocks
		b.states.add
			expand:{scale:1, opacity:1}
	return blocks

blockExpand= (channel) ->
	for c in channel
		c.states.switch("expand")
blockReduce= (channel) ->
	for c in channel
		c.states.switchInstant("default")
blockFold = (channel) ->
	for c in channel
		c.states.switch("default")

			
hbo = new playBlock("images/hbo@2x.png", 240)
netflix = new playBlock("images/netflix@2x.png", 508)
vudu = new playBlock("images/vudu@2x.png", 618)
	
	
cursorChange = (layer) ->
	layer.on Events.MouseOver, ->
		document.body.style.cursor = "pointer"
	layer.on Events.MouseOut, ->
		document.body.style.cursor = "auto"
	
		
nextEp = () ->
	if (top.states.current != "eleven")
		top.states.next(["default","seven","eight","nine","ten","eleven"])
		episodes.states.next(["default","seven","eight","nine","ten","eleven"])
		bottom.states.next(["seven","eight","nine","ten","eleven"])
		blockwrapper.states.next()
		fold()

		
previousEp = () ->
	if (top.states.current != "default")
		top.states.previous(["default","seven","eight","nine","ten","eleven"])
		episodes.states.previous(["default","seven","eight","nine","ten","eleven"])
		bottom.states.previous(["six","seven","eight","nine","ten","eleven"])
		blockwrapper.states.previous()
		fold()
	
jumpEp = (episode) ->
	top.states.switchInstant(episode)
	episodes.states.switchInstant(episode)
	bottom.states.switchInstant(episode)
	blockwrapper.states.switchInstant(episode)	
	
expand = ()->
	modal.states.switch("expand")
	viewMore.states.switch("expand")
	scroller.states.switch("expand")
	viewFewer.states.switchInstant("expand")
	bottom.animate 
		properties:
			y: 353
	blockExpand(hbo)
	blockExpand(netflix)
	blockExpand(vudu)
	isExpand = true
	
fold = () ->
	modal.states.switch("show")
	viewMore.states.switch("default")
	scroller.states.switch("default")
	viewFewer.states.switchInstant("default")
	bottom.animate
		properties:
			y:244
	blockFold(hbo)
	blockFold(netflix)
	blockFold(vudu)	
	isExpand = false
	
rightButton.on Events.Click, ->
	nextEp()
	
leftButton.on Events.Click, ->
	previousEp()	

cursorChange(leftButton)
cursorChange(rightButton)
cursorChange(close)
cursorChange(viewMore)

showModal = (episode) ->
	jumpEp(episode)
	modal.states.switch("show")
	close.states.switch("show")
	overlay.states.switch("show")
	blockReduce(hbo)
	blockReduce(netflix)
	blockReduce(vudu)
	viewMore.states.switchInstant("default")
	bottom.y=244
	scroller.scrollY=0

closeModal = () ->
	modal.states.switch("default")
	close.states.switch("default")
	overlay.states.switch("default")
	isExpand = false
	scroller.scroll = false

close.on Events.Click,(event)->
	event.stopPropagation()
	closeModal()

button = (n,where) ->
	n = new Layer
		width:40, height: 40, x: 1156, y: where, name: n, backgroundColor:"transparent"
	n.on Events.Click, ->
		showModal(n.name)
	cursorChange(n)

elevenButton = new button("eleven", 302)
tenButton = new button("ten", 443)
nineButton = new button("nine",303+(140*2))
eightButton = new button("eight",303+(140*3))
sevenButton = new button("seven",303+(140*4))

makeScroll = () ->
	scroller.scroll = true
	scroller.scrollHorizontal = false
	
	
#test
# showModal("default")


