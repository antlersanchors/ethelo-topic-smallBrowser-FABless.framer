# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Michael-Owen Liston"
	twitter: ""
	description: ""


# Import file "Ethelo Topic Page Prototypes-Small Browser v2 no artboard" (sizes and positions are scaled 1:3)
sketch = Framer.Importer.load("imported/Ethelo Topic Page Prototypes-Small Browser v2 no artboard@3x")

Utils.globalLayers(sketch)

bg = new BackgroundLayer
	backgroundColor: Color.gray(0.9)

# Janky realignment because layers are mysteriously off
nudge = [
	bottomNavBar
	progressBar
	headerBar
	SYSTEM_topBar
	SYSTEM_bottomBar
	filterTabs
]

for layer in nudge
	layer.props =
		x: -1

scrollableContent.x = -8

bottomNavBar.x = -6

##########################
# MAIN CONTENT SCROLLING #
contentScroll = new ScrollComponent
	width: 1100
	height: 1379
	scrollHorizontal: false
	mouseWheelEnabled: true
	y: 252
	contentInset:
		top: -250

contentScroll.content.draggable.overdragScale = 0.01 
scrollableContent.superLayer = contentScroll.content

######################
# SIDE NAV SCROLLING #
navScroll = new ScrollComponent
	x: -1200
	y: 72
	height: 1734
	width: 1200
	scrollHorizontal: false
	mouseWheelEnabled: true

navScroll.content.draggable.overdrag = false

# We need to move both the side nav and it’s scrollContainer parent?
navScroll.states.add
	open:
		x:0
	closed:
		x: -1200

navScroll.states.animationOptions =
	curve: "ease-in-out"
	time: .5

#################################
# SIDE DRAWER NAVIGATION ACTUAL #
sideNavDrawer.superLayer = navScroll.content
sideNavDrawer.x = -1200
sideNavDrawer.y = 0
sideNavDrawer.visible = true

sideNavDrawer.states.add
	open:
		x: 0
		opacity: 1
	closed:
		x: -1200
		opacity: .7

# BRING ALL THE OTHER THINGS TO THE FRONT
fab_collapsed.parent = null
FAB_Expanded_with_Scrim.parent = null
SYSTEM_topBar.parent = null
headerBar.parent = null
progressBar.parent = null
bottomNavBar.parent = null
accountOrgDecisionsMenu.parent = null
filterTabs.parent = null

navScroll.bringToFront()
SYSTEM_bottomBar.parent = null

####################
# FAB AND FAB MENU #
FAB_Expanded_with_Scrim.states.add
	closed:
		visible: false
		opacity: 0
		scale: .2
	open:
		visible: true
		opacity: 1
		scale: 1

FAB_Expanded_with_Scrim.props =
	originX: 1
	originY: 1

# At the end of a touch event on the collapsed FAB, switch the state o
fab_collapsed.onTouchEnd ->
	FAB_Expanded_with_Scrim.states.switch("open", curve: "ease-in-out", time: .2)
	FAB_Expanded_with_Scrim.onStateWillSwitch ->
		FAB_Expanded_with_Scrim.visible = true

FAB_Expanded_with_Scrim.onTouchEnd ->
	FAB_Expanded_with_Scrim.states.switch("closed", curve: "ease-in-out", time: .2)

FAB_Expanded_with_Scrim.visible = false
fab_collapsed.visible = false

#########################
# ACCOUNT OVERFLOW MENU #
accountOrgDecisionsMenu.x = -1200
accountOrgDecisionsMenu.placeBefore(navScroll)

accountOrgDecisionsMenu.states.add
	closed:
		x: -1200
		opacity: .7
	open:
		x: 0
		opacity: 1

######################
# NAV TABS SCROLLING #
tabsScroll = new ScrollComponent
	width: 934
	height: 127
	scrollVertical: false
	mouseWheelEnabled: true
	y: 1506
	x: 43

horizontalScrollMenu.superLayer = tabsScroll.content
tabsScroll.content.draggable.overdrag = false

################
# CLICK EVENTS #
sideNavOpenButton.onClick ->
		sideNavDrawer.states.switch("open", curve: "ease-in-out", time: .6)
		navScroll.states.switch("open", curve: "ease-in-out", time: .6)

closeSideNavButton.onClick ->
		sideNavDrawer.states.switch("closed", curve: "ease-in-out", time: .4)
		navScroll.states.switch("closed", curve: "ease-in-out", time: .4)

accountOverflowButton.onClick ->
	accountOrgDecisionsMenu.states.switch("open", curve: "ease-in-out", time: .4)

closeAccountMenuButton.onClick ->
	accountOrgDecisionsMenu.states.switch("closed", curve: "ease-in-out", time: .4)

