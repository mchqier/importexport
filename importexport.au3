#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=C:\Users\user1\Desktop\favicon.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ScreenCapture.au3>
#include <GDIPlus.au3>
#include <WinAPISys.au3>

Global $ImError = 0
Global $ExError = 0
Import()
$Imreact = WinWaitActive("localhost/gfu2014/Import_Controller/ImportForm", "")
If $Imreact Then
	Sleep(1000)
	export()
Else

;~ 	mus in log file schreiben

	Exit
EndIf
Exit


Func Import()

;~ 	muss in log file schreiben

	$chromePID = Run("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
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

	Else
		If $ImError = 3 Then

;~ 			muss in logfile schreiben

			Exit
		Else
			ProcessClose($chromePID)
			$ImError = $ImError + 1

;~ 			muss in log file schreiben

			Sleep(500)
			Import()
		EndIf
	EndIf
EndFunc   ;==>Import




Func export()

;~ 	mus in log file schreiben

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

	Else
		If $ExError = 4 Then

;~ 			muss in log file schreiben

			Exit
		Else
			$ExError = $ExError + 1

;~ 		 muss in logfile schreiben

			Sleep(500)
			export()
		EndIf
	EndIf
EndFunc   ;==>export



