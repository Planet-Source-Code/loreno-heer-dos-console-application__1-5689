Attribute VB_Name = "Module1"
Option Explicit
Private Declare Function AllocConsole Lib "kernel32" () As Long
Private Declare Function FreeConsole Lib "kernel32" () As Long
Private Declare Function GetStdHandle Lib "kernel32" (ByVal nStdHandle As Long) As Long
Private Declare Function ReadConsole Lib "kernel32" Alias "ReadConsoleA" (ByVal hConsoleInput As Long, ByVal lpBuffer As String, ByVal nNumberOfCharsToRead As Long, lpNumberOfCharsRead As Long, lpReserved As Any) As Long
Private Declare Function SetConsoleMode Lib "kernel32" (ByVal hConsoleOutput As Long, dwMode As Long) As Long
Private Declare Function SetConsoleTextAttribute Lib "kernel32" (ByVal hConsoleOutput As Long, ByVal wAttributes As Long) As Long
Private Declare Function SetConsoleTitle Lib "kernel32" Alias "SetConsoleTitleA" (ByVal lpConsoleTitle As String) As Long
Private Declare Function WriteConsole Lib "kernel32" Alias "WriteConsoleA" (ByVal hConsoleOutput As Long, ByVal lpBuffer As Any, ByVal nNumberOfCharsToWrite As Long, lpNumberOfCharsWritten As Long, lpReserved As Any) As Long
Private Const STD_INPUT_HANDLE = -10&
Private Const STD_OUTPUT_HANDLE = -11&
Private Const STD_ERROR_HANDLE = -12&
Private Const FOREGROUND_RED = &H4
Private Const FOREGROUND_GREEN = &H2
Private Const FOREGROUND_BLUE = &H1
Private Const FOREGROUND_INTENSITY = &H8
Private Const BACKGROUND_RED = &H40
Private Const BACKGROUND_GREEN = &H20
Private Const BACKGROUND_BLUE = &H10
Private Const BACKGROUND_INTENSITY = &H80
Private Const ENABLE_LINE_INPUT = &H2
Private Const ENABLE_ECHO_INPUT = &H4
Private Const ENABLE_MOUSE_INPUT = &H10
Private Const ENABLE_PROCESSED_INPUT = &H1
Private Const ENABLE_WINDOW_INPUT = &H8
Private Const ENABLE_PROCESSED_OUTPUT = &H1
Private Const ENABLE_WRAP_AT_EOL_OUTPUT = &H2
Private hConsoleIn As Long
Private hConsoleOut As Long
Private hConsoleErr As Long
Private Function CGet() As String
Dim sUserInput As String * 256
Call ReadConsole(hConsoleIn, sUserInput, Len(sUserInput), vbNull, vbNull)
CGet = Left$(sUserInput, InStr(sUserInput, Chr$(0)) - 3)
End Function
Private Sub CPrint(Cout As String)
WriteConsole hConsoleOut, Cout, Len(Cout), vbNull, vbNull
End Sub
Sub Main()
Dim UserIn As String
AllocConsole
SetConsoleTitle "VB DOS Console"
hConsoleIn = GetStdHandle(STD_INPUT_HANDLE)
hConsoleOut = GetStdHandle(STD_OUTPUT_HANDLE)
hConsoleErr = GetStdHandle(STD_ERROR_HANDLE)
SetConsoleTextAttribute hConsoleOut, FOREGROUND_RED Or FOREGROUND_GREEN Or FOREGROUND_BLUE Or FOREGROUND_INTENSITY Or BACKGROUND_GREEN
CPrint "VB DOS" & vbCrLf
SetConsoleTextAttribute hConsoleOut, FOREGROUND_RED Or FOREGROUND_GREEN Or FOREGROUND_BLUE
CPrint "Input name: "
UserIn = CGet()
If Not UserIn = "" Then
CPrint "Hi, " & UserIn & "!!" & vbCrLf
Else
CPrint "Hi" & vbCrLf
End If
CPrint "Enter to exit"
Call CGet
FreeConsole
End Sub
