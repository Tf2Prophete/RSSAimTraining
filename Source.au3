#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Images\Icon.ico
#AutoIt3Wrapper_Compression=0
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=R.S.S.
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; *** Start added by AutoIt3Wrapper ***
; *** End added by AutoIt3Wrapper ***
;~ #AutoIt3Wrapper_Icon=Images\Icon.ico


#include <WinAPIConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <GDIPlus.au3>
#include <WinAPIGdi.au3>
#include <Misc.au3>
#include <Timers.au3>
#include "DefaultGameModule.au3"
#include "TwitchGameModule.au3"

#include ".\Skins\Axis.au3"
#include "_UskinLibrary.au3"

_Uskin_LoadDLL()
_USkin_Init(_Axis(True))

Opt("GUIOnEventMode", 1)
Opt("MouseCoordMode", 0)
Opt("MustDeclareVars", 1)

Local $hDLL = DllOpen("user32.dll")

Global $MainMenuGUI, $CurrentGUI, $DefaultGameGUI, $DisplayCountdown, $GameActive = 0
Global $TwitchGameGUI, $TwitchGameResultsGUI, $RetryTwitchGameButton
Global $DefaultGameResultsGUI, $RetryDefaultGameButton, $MainMenuButton, $StopGame = 0
Global $DisplayTotalTargetsShown, $DisplayTotalTargetsMissed, $DisplayTotalTargetsHit, $DisplayTargetsAccuracy
Global $TotalTargetsShown = 0, $TotalTargetsMissed = 0, $TotalTargetsHit = 0, $TotalTargetsAccuracy = 0
Global $PlayClassicGameButton, $PlayTwitchGameButton, $FirstRun = 0
Global $CalculateAccuracy = 0, $AddDecimal = 0, $ExitButton, $Difficulty = 1, $BeatGame = 0
Global $hPen, $PenGraphic, $StartTimer, $CheckTime, $EasyMode, $MediumMode, $HardMode, $ExpertMode
Global $StatusImage, $TotalTimeTaken, $DisplayTotalTimeTaken, $CalculateDifference = 0, $Minutes = 0, $Seconds = 0

Global $hImage, $iHeight, $iWidth, $hGDIBitmap, $iPic, $RandomX, $RandomY, $TargetX, $TargetY, $aPos

Global $5Image, $4Image, $3Image, $2Image, $1Image, $0Image, $TargetImage, $RecordsData

Global $TargetWidth = 40, $TargetHeight = 75, $MissImage, $Attempt = 0, $ShowBests, $BestsGUI

_MainMenu()

Func _MainMenu()
	$RecordsData = IniRead(@ScriptDir & "/Data/Records.ini", "Settings", "1", "NA")
	$Difficulty = $RecordsData

	$CurrentGUI = "MainMenu"

	$MainMenuGUI = GUICreate("R.S.S. Aim Trainer", 300, 500)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

	$PlayClassicGameButton = GUICtrlCreateButton("Classic Game", 48, 40, 200, 60)
	GUICtrlSetOnEvent(-1, "_DefaultGame")
	GUICtrlSetFont(-1, 16)

	$PlayTwitchGameButton = GUICtrlCreateButton("Twitch Game", 48, 140, 200, 60)
	GUICtrlSetOnEvent(-1, "_TwitchGame")
	GUICtrlSetFont(-1, 16)

	GUIStartGroup()
	$EasyMode = GUICtrlCreateRadio("Easy", 15, 220, 100)
	GUICtrlSetOnEvent(-1, "_SelectEasy")
	GUICtrlSetFont(-1, 16)

	$MediumMode = GUICtrlCreateRadio("Medium", 195, 220, 90)
	GUICtrlSetOnEvent(-1, "_SelectMedium")
	GUICtrlSetFont(-1, 16)

	$HardMode = GUICtrlCreateRadio("Hard", 15, 270, 90)
	GUICtrlSetOnEvent(-1, "_SelectHard")
	GUICtrlSetFont(-1, 16)

	$ExpertMode = GUICtrlCreateRadio("Expert", 195, 270, 90)
	GUICtrlSetOnEvent(-1, "_SelectExpert")
	GUICtrlSetFont(-1, 16)

	GUIStartGroup()

	If $Difficulty = 0 Or $Difficulty = 1 Then

		GUICtrlSetState($EasyMode, $GUI_CHECKED)

	ElseIf $Difficulty = 2 Then

		GUICtrlSetState($MediumMode, $GUI_CHECKED)

	ElseIf $Difficulty = 3 Then

		GUICtrlSetState($HardMode, $GUI_CHECKED)

	ElseIf $Difficulty = 4 Then

		GUICtrlSetState($ExpertMode, $GUI_CHECKED)

	EndIf

	$ShowBests = GUICtrlCreateButton("Show Record", 48, 320, 200, 60)
	GUICtrlSetOnEvent(-1, "_BestsGUI")
	GUICtrlSetFont(-1, 16)

	$ExitButton = GUICtrlCreateButton("Quit Game", 48, 420, 200, 60)
	GUICtrlSetOnEvent(-1, "_Exit")
	GUICtrlSetFont(-1, 16)

	GUICtrlCreateLabel("© RS Software", 220, 485, 200)
	GUICtrlSetFont(-1, 9)
	GUICtrlCreateLabel("Version 1.0", 3, 485, 200)
	GUICtrlSetFont(-1, 9)

	GUISetState()
EndFunc   ;==>_MainMenu

Func _BestsGUI()
	$CurrentGUI = "Bests"
	GUIDelete($MainMenuGUI)

	$BestsGUI = GUICreate("Records", 700, 455)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_CloseGUI")

	GUISetState()

	_GDIPlus_Startup()

	$PenGraphic = _GDIPlus_GraphicsCreateFromHWND($BestsGUI)
	$hPen = _GDIPlus_PenCreate()
	_GDIPlus_GraphicsDrawLine($PenGraphic, 340, 0, 340, 455, $hPen)
	_GDIPlus_PenDispose($hPen)

	_GDIPlus_Shutdown()

	$RecordsData = IniReadSection(@ScriptDir & "/Data/Records.ini", "Classic")

	GUICtrlCreateLabel("Classic Game Record", 55, 10, 230, 40)
	GUICtrlSetFont(-1, 16)


	GUICtrlCreateLabel("Time Left", 115, 80, 150, 40)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateInput($RecordsData[1][1], 85, 120, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0x26ff00)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Targets Hit", 110, 180, 150, 40)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateInput($RecordsData[2][1], 85, 220, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0x26ff00)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Targets Missed", 91, 280, 150, 40)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateInput($RecordsData[3][1], 85, 320, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0x26ff00)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Accuracy", 120, 380, 150, 40)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateInput($RecordsData[4][1] & "%", 85, 420, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0x26ff00)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Twitch Game Record", 430, 10, 300, 40)
	GUICtrlSetFont(-1, 16)

	$RecordsData = IniReadSection(@ScriptDir & "/Data/Records.ini", "Twitch")

	GUICtrlCreateLabel("Total Targets", 470, 80, 150, 40)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateInput($RecordsData[1][1], 450, 120, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0x26ff00)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Targets Hit", 475, 230, 150, 40)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateInput($RecordsData[2][1], 450, 270, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0x26ff00)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateLabel("Accuracy", 485, 380, 150, 40)
	GUICtrlSetFont(-1, 15)

	GUICtrlCreateInput($RecordsData[3][1] & "%", 450, 420, 150, 30, BitOR($ES_CENTER, $ES_READONLY))
	GUICtrlSetColor(-1, 0x26ff00)
	GUICtrlSetFont(-1, 15)

EndFunc   ;==>_BestsGUI


Func _SelectEasy()
	$Difficulty = 1
	IniWrite(@ScriptDir & "/Data/Records.ini", "Settings", "1", "1")
EndFunc   ;==>_SelectEasy

Func _SelectMedium()
	$Difficulty = 2
	IniWrite(@ScriptDir & "/Data/Records.ini", "Settings", "1", "2")
EndFunc   ;==>_SelectMedium

Func _SelectHard()
	$Difficulty = 3
	IniWrite(@ScriptDir & "/Data/Records.ini", "Settings", "1", "3")
EndFunc   ;==>_SelectHard

Func _SelectExpert()
	$Difficulty = 4
	IniWrite(@ScriptDir & "/Data/Records.ini", "Settings", "1", "4")
EndFunc   ;==>_SelectExpert


Func _CloseGui()
	If $CurrentGUI = "DefaultGame" Then
		AdlibUnRegister("_MissedDefaultGame")
		$StopGame = 1
		$StartTimer = ""
		$CheckTime = ""
		GUIDelete($DefaultGameGUI)
		_MainMenu()
	EndIf
	If $CurrentGUI = "DefaultGameResults" Then
		AdlibUnRegister("_MissedDefaultGame")
		$StopGame = 1
		$StartTimer = ""
		$CheckTime = ""
		GUIDelete($DefaultGameResultsGUI)
		_MainMenu()
	EndIf
	If $CurrentGUI = "TwitchGame" Then
		AdlibUnRegister("_MissedTwitchGame")
		$StopGame = 1
		GUIDelete($TwitchGameGUI)
		_MainMenu()
	EndIf
	If $CurrentGUI = "TwitchGameResults" Then
		AdlibUnRegister("_MissedTwitchGame")
		$StopGame = 1
		GUIDelete($TwitchGameResultsGUI)
		_MainMenu()
	EndIf
	If $CurrentGUI = "Bests" Then
		GUIDelete($BestsGUI)
		_MainMenu()
	EndIf
EndFunc   ;==>_CloseGui

Func _Exit()
	Exit
EndFunc   ;==>_Exit

While 1
	If $CurrentGUI = "DefaultGame" Then
		$CheckTime = _Timer_Diff($StartTimer)
		If $CheckTime >= 180000 Then
			AdlibUnRegister("_MissedDefaultGame")
			_Timer_KillAllTimers($DefaultGameGUI)
			$StopGame = 1
			$BeatGame = 0
			_DefaultGameResults()
		EndIf
		If WinActive($DefaultGameGUI) Then
			If _IsPressed("01", $hDLL) And $Attempt = 0 Then
				SoundPlay(@ScriptDir & "/Sounds/Shot.wav")
				$aPos = MouseGetPos()
				GUICtrlDelete($MissImage)
				If _WinAPI_PtInRectEx($aPos[0], $aPos[1], $TargetX + 3, $TargetY + 28, $TargetX + $TargetWidth + 3, _
						$TargetY + $TargetHeight + 28) Then
					GUICtrlDelete($TargetImage)
					$Attempt = 1
					$TotalTargetsHit += 1
					GUICtrlSetData($DisplayTotalTargetsHit, $TotalTargetsHit)
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
				Else
					_GDIPlus_Startup()

					$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/Miss.png") ;<-- your image
					$iWidth = _GDIPlus_ImageGetWidth($hImage)
					$iHeight = _GDIPlus_ImageGetHeight($hImage)
					$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)

					$MissImage = GUICtrlCreatePic("", $aPos[0] - 15, $aPos[1] - 40, $iWidth, $iHeight)

					_WinAPI_DeleteObject(GUICtrlSendMsg($MissImage, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
					_WinAPI_DeleteObject($hGDIBitmap)

					_GDIPlus_ImageDispose($hImage)
					_GDIPlus_Shutdown()
					GUICtrlDelete($TargetImage)
					$Attempt = 1
					$TotalTargetsShown += 1
					$TotalTargetsMissed += 1
					GUICtrlSetData($DisplayTotalTargetsMissed, $TotalTargetsMissed)
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
				EndIf
			EndIf
			If $Attempt = 1 Then
				If _IsPressed("01", $hDLL) = 0 Then
					_PlayDefaultGame()
					$Attempt = 0
				EndIf
			EndIf
		EndIf
	EndIf

	If $CurrentGUI = "TwitchGame" Then
		If WinActive($TwitchGameGUI) Then
			If _IsPressed("01", $hDLL) And $Attempt = 0 Then
				SoundPlay(@ScriptDir & "/Sounds/Shot.wav")
				$aPos = MouseGetPos()
				GUICtrlDelete($MissImage)
				If _WinAPI_PtInRectEx($aPos[0], $aPos[1], $TargetX + 3, $TargetY + 28, $TargetX + $TargetWidth + 3, _
						$TargetY + $TargetHeight + 28) Then
					GUICtrlDelete($TargetImage)
					$Attempt = 1
					$TotalTargetsHit += 1
					GUICtrlSetData($DisplayTotalTargetsHit, $TotalTargetsHit)
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
				Else
					_GDIPlus_Startup()

					$hImage = _GDIPlus_ImageLoadFromFile(@ScriptDir & "\Images/Miss.png") ;<-- your image
					$iWidth = _GDIPlus_ImageGetWidth($hImage)
					$iHeight = _GDIPlus_ImageGetHeight($hImage)
					$hGDIBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)

					$MissImage = GUICtrlCreatePic("", $aPos[0] - 15, $aPos[1] - 40, $iWidth, $iHeight)

					_WinAPI_DeleteObject(GUICtrlSendMsg($MissImage, 0x0172, $IMAGE_BITMAP, $hGDIBitmap)) ;$STM_SETIMAGE = 0x0172
					_WinAPI_DeleteObject($hGDIBitmap)

					_GDIPlus_ImageDispose($hImage)
					_GDIPlus_Shutdown()
					GUICtrlDelete($TargetImage)
					$Attempt = 1
					$TotalTargetsShown += 1
					$TotalTargetsMissed += 1
					GUICtrlSetData($DisplayTotalTargetsMissed, $TotalTargetsMissed)
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
				EndIf
			EndIf
			If $Attempt = 1 Then
				If _IsPressed("01", $hDLL) = 0 Then
					_PlayTwitchGame()
					$Attempt = 0
				EndIf
			EndIf
		EndIf
	EndIf
WEnd
