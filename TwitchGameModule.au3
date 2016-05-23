Global $TwitchGameResultsGUI, $MainMenuGUI, $TotalTargetsHit, $TotalTargetsAccuracy, $TotalTargetsMissed, $TotalTargetsShown
Global $Difficulty, $DefaultGameGUI, $Attempt, $DisplayTargetsAccuracy, $DisplayTotalTargetsHit, $DisplayTotalTargetsMissed, $DisplayTotalTargetsShown
Global $TargetImage, $MissImage, $TwitchGameGUI, $RecordsData

Func _TwitchGame()
	$CurrentGUI = "TwitchGame"
	GUIDelete($TwitchGameResultsGUI)
	GUIDelete($MainMenuGUI)
	$TotalTargetsAccuracy = 0
	$TotalTargetsHit = 0
	$TotalTargetsMissed = ""
	$TotalTargetsShown = 0
	$StopGame = 0
	$Attempt = 0

	$TwitchGameGUI = GUICreate("Twitch Game", 700, 600)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_CloseGui")

	_GDIPlus_Startup()

	$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/Grid.png") ;<-- your image
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)

	$iPic = GUICtrlCreatePic("", -60, -230, $iWidth, $iHeight)



	_WinAPI_DeleteObject(GUICtrlSendMsg($iPic, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
	_WinAPI_DeleteObject($hGDIBitmap)



	GUISetState()

	$PenGraphic = _GDIPlus_GraphicsCreateFromHWND($TwitchGameGUI)
	$hPen = _GDIPlus_PenCreate()
	_GDIPlus_GraphicsDrawLine($PenGraphic, 0, 540, 700, 540, $hPen)
	_GDIPlus_PenDispose($hPen)

	GUICtrlCreateLabel("Total Targets", 30, 541, 300, 30)
	GUICtrlSetFont(-1, 15)

	$DisplayTotalTargetsShown = GUICtrlCreateInput("", 15, 565, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0xffffff)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Targets Missed", 191, 541, 300, 30)
	GUICtrlSetFont(-1, 15)

	$DisplayTotalTargetsMissed = GUICtrlCreateInput("", 185, 565, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0xf41a1a)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Targets Hit", 395, 541, 300, 30)
	GUICtrlSetFont(-1, 15)

	$DisplayTotalTargetsHit = GUICtrlCreateInput("", 370, 565, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0x26ff00)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Accuracy", 570, 541, 300, 30)
	GUICtrlSetFont(-1, 15)

	$DisplayTargetsAccuracy = GUICtrlCreateInput("", 540, 565, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0xffffff)
	GUICtrlSetFont(-1, 15)


	SoundPlay(@ScriptDir & "/Sounds/Clock.wav")
	$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/5.png") ;<-- your image
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)


	$5Image = GUICtrlCreatePic("", 300, 200, $iWidth, $iHeight)

	_WinAPI_DeleteObject(GUICtrlSendMsg($5Image, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
	_WinAPI_DeleteObject($hGDIBitmap)

	Sleep(1000)

	GUICtrlDelete($5Image)


	SoundPlay(@ScriptDir & "/Sounds/Clock.wav")
	$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/4.png") ;<-- your image
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)



	$4Image = GUICtrlCreatePic("", 300, 200, $iWidth, $iHeight)

	_WinAPI_DeleteObject(GUICtrlSendMsg($4Image, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
	_WinAPI_DeleteObject($hGDIBitmap)

	Sleep(1000)

	GUICtrlDelete($4Image)

	SoundPlay(@ScriptDir & "/Sounds/Clock.wav")
	$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/3.png") ;<-- your image
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)



	$3Image = GUICtrlCreatePic("", 300, 200, $iWidth, $iHeight)

	_WinAPI_DeleteObject(GUICtrlSendMsg($4Image, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
	_WinAPI_DeleteObject($hGDIBitmap)

	Sleep(1000)

	GUICtrlDelete($3Image)

	SoundPlay(@ScriptDir & "/Sounds/Clock.wav")
	$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/2.png") ;<-- your image
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)



	$2Image = GUICtrlCreatePic("", 300, 200, $iWidth, $iHeight)

	_WinAPI_DeleteObject(GUICtrlSendMsg($4Image, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
	_WinAPI_DeleteObject($hGDIBitmap)

	Sleep(1000)

	GUICtrlDelete($2Image)

	SoundPlay(@ScriptDir & "/Sounds/Clock.wav")
	$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/1.png") ;<-- your image
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)



	$1Image = GUICtrlCreatePic("", 300, 200, $iWidth, $iHeight)

	_WinAPI_DeleteObject(GUICtrlSendMsg($4Image, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
	_WinAPI_DeleteObject($hGDIBitmap)

	Sleep(1000)

	GUICtrlDelete($1Image)

	SoundPlay(@ScriptDir & "/Sounds/Clock.wav")
	$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/0.png") ;<-- your image
	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)



	$0Image = GUICtrlCreatePic("", 300, 200, $iWidth, $iHeight)

	_WinAPI_DeleteObject(GUICtrlSendMsg($4Image, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
	_WinAPI_DeleteObject($hGDIBitmap)

	SoundPlay(@ScriptDir & "/Sounds/Start Round.wav")

	Sleep(1100)


	GUICtrlDelete($0Image)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()

	_PlayTwitchGame()


EndFunc   ;==>_TwitchGame

Func _PlayTwitchGame()


	$RandomX = Random(10, 550, 1)
	$RandomY = Random(10, 460, 1)

	_GDIPlus_Startup()

	$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/LargeTarget.png") ;<-- your image

	If $TotalTargetsMissed >= 6 Then
		AdlibUnRegister("_MissedTwitchGame")
		_TwitchGameResults()
		$StopGame = 1
	EndIf

	If $StopGame = 0 Then

		$iWidth = _GDIPlus_ImageGetWidth($hImage)
		$iHeight = _GDIPlus_ImageGetHeight($hImage)
		$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)

		$TargetImage = GUICtrlCreatePic("", $RandomX, $RandomY, $iWidth, $iHeight)

		_WinAPI_DeleteObject(GUICtrlSendMsg($TargetImage, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
		_WinAPI_DeleteObject($hGDIBitmap)

		_GDIPlus_ImageDispose($hImage)
		_GDIPlus_Shutdown()



		$TargetX = $RandomX
		$TargetY = $RandomY
		$TargetHeight = $iHeight
		$TargetWidth = $iWidth
		If $Difficulty = 1 Then
			AdlibRegister("_MissedTwitchGame", 1800)
		ElseIf $Difficulty = 2 Then
			AdlibRegister("_MissedTwitchGame", 1000)
		ElseIf $Difficulty = 3 Then
			AdlibRegister("_MissedTwitchGame", 800)
		ElseIf $Difficulty = 4 Then
			AdlibRegister("_MissedTwitchGame", 600)
		EndIf
	EndIf

EndFunc   ;==>_PlayTwitchGame

Func _TwitchGameResults()
	$CurrentGUI = "TwitchGameResults"
	GUIDelete($TwitchGameGUI)
	$TwitchGameResultsGUI = GUICreate("Results", 300, 400)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_CloseGUI")



	GUICtrlCreateLabel("Total Targets", 93, 30, 300, 30)
	GUICtrlSetFont(-1, 15)

	$DisplayTotalTargetsMissed = GUICtrlCreateInput($TotalTargetsShown, 75, 70, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0xf41a1a)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Targets Hit", 100, 130, 300, 30)
	GUICtrlSetFont(-1, 15)

	$DisplayTotalTargetsHit = GUICtrlCreateInput($TotalTargetsHit, 75, 170, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0x26ff00)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Accuracy", 110, 230, 300, 30)
	GUICtrlSetFont(-1, 15)

	$DisplayTargetsAccuracy = GUICtrlCreateInput($TotalTargetsAccuracy & "%", 75, 270, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0xffffff)
	GUICtrlSetFont(-1, 15)

	If $TotalTargetsAccuracy < 0 Then
		GUICtrlSetColor($DisplayTargetsAccuracy, 0xf41a1a)
	Else
		GUICtrlSetColor($DisplayTargetsAccuracy, 0x26ff00)
	EndIf

	$RetryTwitchGameButton = GUICtrlCreateButton("Play Again", 10, 320, 120, 70)
	GUICtrlSetOnEvent(-1, "_TwitchGame")
	GUICtrlSetFont(-1, 14)

	$MainMenuButton = GUICtrlCreateButton("Main Menu", 170, 320, 120, 70)
	GUICtrlSetOnEvent(-1, "_CloseGui")
	GUICtrlSetFont(-1, 14)
	GUISetState()

	$RecordsData = IniReadSection(@ScriptDir & "/Data/Records.ini", "Twitch")

	If $TotalTargetsHit > $RecordsData[2][1] Then
		IniWrite(@ScriptDir & "/Data/Records.ini", "Twitch", "1", $TotalTargetsShown)
		IniWrite(@ScriptDir & "/Data/Records.ini", "Twitch", "2", $TotalTargetsHit)
		IniWrite(@ScriptDir & "/Data/Records.ini", "Twitch", "3", $TotalTargetsAccuracy)
		GUISetState(@SW_DISABLE, $TwitchGameResultsGUI)
		MsgBox(0, "Record!", "New best!")
		GUISetState(@SW_ENABLE, $TwitchGameResultsGUI)
		Sleep(100)
		WinActivate($TwitchGameResultsGUI)
	EndIf

EndFunc   ;==>_TwitchGameResults



Func _MissedTwitchGame()
	If $Attempt = 0 Then
		$TotalTargetsMissed += 1
		GUICtrlSetData($DisplayTotalTargetsMissed, $TotalTargetsMissed)
		$TotalTargetsShown += 1
		GUICtrlSetData($DisplayTotalTargetsShown, $TotalTargetsShown)
		$CalculateAccuracy = (($TotalTargetsHit - $TotalTargetsMissed) / $TotalTargetsShown) * 100
		If $CalculateAccuracy = 100 Then
			$TotalTargetsAccuracy = $CalculateAccuracy
			GUICtrlSetData($DisplayTargetsAccuracy, $TotalTargetsAccuracy & "%")
		Else
			$TotalTargetsAccuracy = $CalculateAccuracy
			$TotalTargetsAccuracy = Round($TotalTargetsAccuracy)
			GUICtrlSetData($DisplayTargetsAccuracy, $TotalTargetsAccuracy & "%")
		EndIf
		If $TotalTargetsAccuracy < 0 Then
			GUICtrlSetColor($DisplayTargetsAccuracy, 0xf41a1a)
		Else
			GUICtrlSetColor($DisplayTargetsAccuracy, 0x26ff00)
		EndIf
		GUICtrlDelete($TargetImage)
		GUICtrlDelete($MissImage)
		If $TotalTargetsMissed >= 6 Then
			AdlibUnRegister("_MissedTwitchGame")
			$StopGame = 1
			_TwitchGameResults()
		Else
			_PlayTwitchGame()
		EndIf
	EndIf
EndFunc   ;==>_MissedTwitchGame
