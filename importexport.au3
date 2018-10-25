#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=C:\Users\user1\Desktop\favicon.ico
#AutoIt3Wrapper_Outfile=\\nas00\disk\temp\mothnna\importexport.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ScreenCapture.au3>
#include <GDIPlus.au3>
#include <WinAPISys.au3>
#include <File.au3>

Global $ImError = 0
Global $ExError = 0
$sLogPath = FileOpen(@ScriptDir & "\Importexport.log", 1)
$sLogMsg = "ImportExport Script Started"
_FileWriteLog($sLogPath, $sLogMsg)
Import()

$Imreact = WinWait("localhost/gfu2014/Import_Controller/ImportForm", "", 7200)
If $Imreact Then
	Sleep(1000)
	export()
Else

;~ 	mus in log file schreiben
	$sLogMsg = "Import Page returned null , Script will exit"
	_FileWriteLog($sLogPath, $sLogMsg)
	FileClose($sLogPath)
	Exit
EndIf
$sLogMsg = "ImportExport Script is Finished"
_FileWriteLog($sLogPath, $sLogMsg)
FileClose($sLogPath)
Exit


Func Import()

;~ 	muss in log file schreiben
	$sLogMsg = "Import function is called"
	_FileWriteLog($sLogPath, $sLogMsg)


	$importUrl = "http://localhost/gfu2014/import?flush=1"
	Run("cmd /c start http://localhost/gfu2014/import?flush=1", "", @SW_HIDE)
	Sleep(3000)

	Local $hWnd = WinWait("localhost/gfu2014/import?flush=1","",30)



	If $hWnd Then
		$i = 30
		For $i = 29 To 0 Step -1
			ControlSend($hWnd, "", "", "{tab}")
			Sleep(250)
		Next
		Sleep(200)
		ControlSend($hWnd, "", "", "{Enter}")

;~ 		muss in log file schreiben
		$sLogMsg = "Import Procces is started"
		_FileWriteLog($sLogPath, $sLogMsg)

		ControlFocus($hWnd,"",1)

	Else
		If $ImError = 3 Then

;~ 			muss in logfile schreiben
			$sLogMsg = "Script Failed to open ImportPage 3 times , It will exit"
			_FileWriteLog($sLogPath, $sLogMsg)

			FileClose($sLogPath)
			Exit
		Else
			ProcessClose($hWnd)
			$ImError = $ImError + 1

;~ 			muss in log file schreiben
			$sLogMsg = "Script can´t open ImportPage IT will try again.....(" & $ImError & ".) times"
			_FileWriteLog($sLogPath, $sLogMsg)
			Sleep(500)
			Import()
		EndIf
	EndIf
EndFunc   ;==>Import




Func export()

;~ 	mus in log file schreiben
	$sLogMsg = "Export Function is called"
	_FileWriteLog($sLogPath, $sLogMsg)


	Run("cmd /c start http://localhost/gfu2014/export?flush=1", "", @SW_HIDE)
	Sleep(3000)

	Local $hWnd = WinWait("Export GFU-Website","",30)

;~ 	$hWnd=WinActivate("localhost/gfu2014/Import_Controller/ImportForm")
;~ 	Sleep(500)
;~ 	ControlSend($hWnd, "", "", "^t")
;~ 	Sleep(500)

;~ 	ControlSend($hWnd, "", "", "http://localhost/gfu2014/export?flush=1")
;~ 	Sleep(500)
;~ 	ControlSend($hWnd, "", "", "{Enter}")
;~


	If $hWnd Then
		Sleep(500)
		ControlSend($hWnd, "", "", "{tab}")
		Sleep(500)
		ControlSend($hWnd, "", "", "{Enter}")
		Sleep(500)
		ControlSend($hWnd, "", "", "{tab}")
		Sleep(500)
		ControlSend($hWnd, "", "", "{Enter}")

;~ 		muss in log file schreiben
		$sLogMsg = "Export Procces is started"
		FileOpen(@DesktopDir & "\Exportstarted", 1)

		_FileWriteLog($sLogPath, $sLogMsg)


	Else
		If $ExError = 3 Then

;~ 			muss in log file schreiben
			$sLogMsg = "Script Failed to open ExportPage 3 times , It will exit"
			_FileWriteLog($sLogPath, $sLogMsg)

			FileClose($sLogPath)
			Exit
		Else
			$ExError = $ExError + 1

;~ 		 muss in logfile schreiben
			$sLogMsg = "Script can´t open ExportPage It will try again...... (" & $ExError & ".) times"
			_FileWriteLog($sLogPath, $sLogMsg)
			Sleep(500)
			export()
		EndIf
	EndIf
EndFunc   ;==>export



