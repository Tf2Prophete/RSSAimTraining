Global $DefaultGameResultsGUI, $MainMenuGUI, $TotalTargetsHit, $TotalTargetsAccuracy, $TotalTargetsMissed, $TotalTargetsShown
Global $Difficulty, $DefaultGameGUI, $Attempt, $DisplayTargetsAccuracy, $DisplayTotalTargetsHit, $DisplayTotalTargetsMissed, $DisplayTotalTargetsShown
Global $TargetImage, $MissImage, $StatusImage, $TotalTimeTaken, $DisplayTotalTimeTaken, $BeatGame, $CalculateDifference = 0, $Minutes = 0, $Seconds = 0
Global $StartTimer, $RecordsData, $FirstRun = 0

Func _DefaultGame()
	$CurrentGUI = "DefaultGame"
	GUIDelete($DefaultGameResultsGUI)
	GUIDelete($MainMenuGUI)
	$TotalTargetsAccuracy = 0
	$TotalTargetsHit = 0
	$TotalTargetsMissed = 0
	$TotalTargetsShown = 0
	$StopGame = 0
	$FirstRun = 0
	$Attempt = 0
	$BeatGame = 0
	$CalculateDifference = 0
	$Minutes = 0
	$Seconds = 0

	$DefaultGameGUI = GUICreate("Default Game", 700, 600)
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

	$PenGraphic = _GDIPlus_GraphicsCreateFromHWND($DefaultGameGUI)
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

	$StartTimer = _Timer_Init()

	_PlayDefaultGame()


EndFunc   ;==>_DefaultGame

Func _PlayDefaultGame()


	$RandomX = Random(10, 550, 1)
	$RandomY = Random(10, 460, 1)

	_GDIPlus_Startup()

	If $TotalTargetsHit < 30 Then

		$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/LargeTarget.png") ;<-- your image

	ElseIf $TotalTargetsHit < 80 And $TotalTargetsHit >= 30 Then

		$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/MediumTarget.png") ;<-- your image

	ElseIf $TotalTargetsHit < 120 And $TotalTargetsHit >= 80 Then

		$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/SmallTarget.png") ;<-- your image

	EndIf

	If $TotalTargetsHit >= 120 Then
		_GDIPlus_Shutdown()
		AdlibUnRegister("_MissedDefaultGame")
		_Timer_KillAllTimers($DefaultGameGUI)
		$StopGame = 1
		$BeatGame = 1
		$TotalTimeTaken = _Timer_Diff($StartTimer)
		$TotalTimeTaken = Round($TotalTimeTaken)
		$CalculateDifference = $TotalTimeTaken - 180000
		While $CalculateDifference < -60000
			$Minutes += 1
			$CalculateDifference += 60000
		WEnd


		While $CalculateDifference < 0
			$Seconds += 1
			$CalculateDifference += 1000
		WEnd

		$TotalTimeTaken = $Minutes & ":" & $Seconds

		_DefaultGameResults()
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
			AdlibRegister("_MissedDefaultGame", 1800)
		ElseIf $Difficulty = 2 Then
			AdlibRegister("_MissedDefaultGame", 1000)
		ElseIf $Difficulty = 3 Then
			AdlibRegister("_MissedDefaultGame", 800)
		ElseIf $Difficulty = 4 Then
			AdlibRegister("_MissedDefaultGame", 600)
		EndIf
	EndIf

EndFunc   ;==>_PlayDefaultGame

Func _DefaultGameResults()
	$StartTimer = ""
	$CheckTime = ""
	$CurrentGUI = "DefaultGameResults"
	GUIDelete($DefaultGameGUI)
	$DefaultGameResultsGUI = GUICreate("Results", 500, 500)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_CloseGui")

	GUICtrlCreateGroup("", 140, 5, 210, 210)

	_GDIPlus_Startup()

	If $BeatGame = 1 Then

		$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/WonGame.png") ;<-- your image

	ElseIf $BeatGame = 0 Then

		$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/LostGame.png") ;<-- your image
		$TotalTimeTaken = "3:00"

	EndIf

	$iWidth = _GDIPlus_ImageGetWidth($hImage)
	$iHeight = _GDIPlus_ImageGetHeight($hImage)
	$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)

	$StatusImage = GUICtrlCreatePic("", 145, 13, $iWidth, $iHeight)

	_WinAPI_DeleteObject(GUICtrlSendMsg($StatusImage, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
	_WinAPI_DeleteObject($hGDIBitmap)

	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()

	GUICtrlCreateLabel("Time Left", 200, 220, 150, 30)
	GUICtrlSetFont(-1, 15)

	$DisplayTotalTimeTaken = GUICtrlCreateInput($TotalTimeTaken, 170, 250, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetFont(-1, 15)

	If $BeatGame = 0 Then
		GUICtrlSetColor($DisplayTotalTimeTaken, 0xf41a1a)
	ElseIf $BeatGame = 1 Then
		GUICtrlSetColor($DisplayTotalTimeTaken, 0x26ff00)
	EndIf

	GUICtrlCreateLabel("Targets Missed", 180, 320, 300, 30)
	GUICtrlSetFont(-1, 15)

	$DisplayTotalTargetsMissed = GUICtrlCreateInput($TotalTargetsMissed, 175, 350, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0xf41a1a)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Targets Hit", 33, 320, 100, 30)
	GUICtrlSetFont(-1, 15)

	$DisplayTotalTargetsHit = GUICtrlCreateInput($TotalTargetsHit, 10, 350, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0x26ff00)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Accuracy", 375, 320, 300, 30)
	GUICtrlSetFont(-1, 15)

	$DisplayTargetsAccuracy = GUICtrlCreateInput($TotalTargetsAccuracy & "%", 340, 350, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0xffffff)
	GUICtrlSetFont(-1, 15)

	If $TotalTargetsAccuracy < 0 Then
		GUICtrlSetColor($DisplayTargetsAccuracy, 0xf41a1a)
	Else
		GUICtrlSetColor($DisplayTargetsAccuracy, 0x26ff00)
	EndIf

	$RetryDefaultGameButton = GUICtrlCreateButton("Play Again", 10, 400, 160, 80)
	GUICtrlSetOnEvent(-1, "_DefaultGame")
	GUICtrlSetFont(-1, 14)

	$MainMenuButton = GUICtrlCreateButton("Main Menu", 330, 400, 160, 80)
	GUICtrlSetOnEvent(-1, "_CloseGui")
	GUICtrlSetFont(-1, 14)
	GUISetState()

	$RecordsData = IniReadSection(@ScriptDir & "/Data/Records.ini", "Classic")

	If $TotalTimeTaken > $RecordsData[1][1] Then
		IniWrite(@ScriptDir & "/Data/Records.ini", "Classic", "1", $TotalTimeTaken)
		IniWrite(@ScriptDir & "/Data/Records.ini", "Classic", "2", $TotalTargetsHit)
		IniWrite(@ScriptDir & "/Data/Records.ini", "Classic", "3", $TotalTargetsMissed)
		IniWrite(@ScriptDir & "/Data/Records.ini", "Classic", "4", $TotalTargetsAccuracy)
		GUISetState(@SW_DISABLE, $DefaultGameResultsGUI)
		MsgBox(0, "Record!", "New best!")
		GUISetState(@SW_ENABLE, $DefaultGameResultsGUI)
		Sleep(100)
		WinActivate($DefaultGameResultsGUI)
	EndIf

EndFunc   ;==>_DefaultGameResults



Func _MissedDefaultGame()
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
		_PlayDefaultGame()
	EndIf
EndFunc   ;==>_MissedDefaultGame
