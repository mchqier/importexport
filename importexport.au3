#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=C:\Users\user1\Desktop\favicon.ico
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
$Imreact = WinWaitActive("localhost/gfu2014/Import_Controller/ImportForm", "", 3600)
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
	$ChromePID = Run("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
	Sleep(500)
	Send("http://localhost/gfu2014/import?flush=1")
	Sleep(500)
	Send("{Enter}")
	$ImportPage = WinWaitActive("localhost/gfu2014/import?flush=1", "", 30)
	If $ImportPage Then
		$i = 30
		For $i = 29 To 0 Step -1
			Send("{tab}")
			Sleep(250)
		Next
		Sleep(200)
		Send("{enter}")

;~ 		muss in log file schreiben
		$sLogMsg = "Import Procces is started"
		_FileWriteLog($sLogPath, $sLogMsg)



	Else
		If $ImError = 3 Then

;~ 			muss in logfile schreiben
			$sLogMsg = "ImportPage opening  failed 3 times , Script will exit"
			_FileWriteLog($sLogPath, $sLogMsg)

			FileClose($sLogPath)
			Exit
		Else
			ProcessClose($ChromePID)
			$ImError = $ImError + 1

;~ 			muss in log file schreiben
			$sLogMsg = "ImportPage cant open  Script will try again.....Script tries (" & $ImError & ") times"
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

	WinActivate("localhost/gfu2014/Import_Controller/ImportForm")
	Sleep(500)
	Send("^t")
	Sleep(500)
	Send("http://localhost/gfu2014/export?flush=1")
	Sleep(500)
	Send("{Enter}")

	$ExportPage = WinWaitActive("Export GFU-Website", "", 30)
	If $ExportPage Then
		Sleep(500)
		Send("{tab}")
		Sleep(500)
		Send("{enter}")
		Sleep(500)
		Send("{tab}")
		Sleep(500)
		Send("{enter}")

;~ 		muss in log file schreiben
		$sLogMsg = "Export Procces is started"
		_FileWriteLog($sLogPath, $sLogMsg)


	Else
		If $ExError = 3 Then

;~ 			muss in log file schreiben
			$sLogMsg = "ExportPage opening  failed 3 times , Script will exit"
			_FileWriteLog($sLogPath, $sLogMsg)

			FileClose($sLogPath)
			Exit
		Else
			$ExError = $ExError + 1

;~ 		 muss in logfile schreiben
			$sLogMsg = "ExportPage cant open  Script will try again.....Script tries (" & $ExError & ") times"
			_FileWriteLog($sLogPath, $sLogMsg)
			Sleep(500)
			export()
		EndIf
	EndIf
EndFunc   ;==>export



