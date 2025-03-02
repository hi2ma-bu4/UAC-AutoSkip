Option Explicit
Dim ws,ts,fs
Dim arg,argc
Dim desktop,nowPath
Dim TaskFolder,RegisteredTask
Dim name,oldShortCut,newShortCut,doShortCut

argc = Wscript.Arguments.Count

if argc = 1 then
	Set ts=CreateObject("Schedule.Service")
	ts.Connect
	Set TaskFolder=ts.GetFolder("\snows")
	On Error Resume Next
	Set RegisteredTask=TaskFolder.GetTask("UAC�X���[")
	if Err.Number <> 0 then
		MsgBox "�A�J�E���g���g��������L���Ă��܂���" & vbCrLf & vbCrLf & "�G���[:" & vbCrLf & Err.Description, vbCritical
		WScript.Quit
	end if
	On Error GoTo 0
	RegisteredTask.Run """" & Wscript.Arguments(0) & """"
elseif argc = 2 then
	arg = Wscript.Arguments(0)
	if Wscript.Arguments(1) = 1 then
		Set ws = CreateObject("WScript.Shell")
		Set fs = CreateObject("Scripting.FileSystemObject")

		if fs.GetExtensionName(arg) <> "lnk" then
			WScript.Quit
		end if

		name = fs.GetBaseName(arg)
		desktop = ws.SpecialFolders("Desktop")
		nowPath = fs.getParentFolderName(WScript.ScriptFullName)

		Set oldShortCut = ws.CreateShortcut(arg)
		Set newShortCut = ws.CreateShortcut("�V���[�g�J�b�g�Q\" & name & ".lnk")
		Set doShortCut = ws.CreateShortcut(desktop & "\" & name & ".lnk")

		newShortCut.TargetPath = oldShortCut.TargetPath

		doShortCut.TargetPath = """" & nowPath & "\doTask.vbs"""
		newShortCut.WorkingDirectory = oldShortCut.WorkingDirectory
		doShortCut.WorkingDirectory = """" & nowPath & """"
		newShortCut.Arguments = oldShortCut.Arguments
		doShortCut.Arguments = """" & name & """"
		doShortCut.IconLocation = oldShortCut.TargetPath & ",0"
		newShortCut.Save
		doShortCut.Save

		Set oldShortCut = Nothing
		Set newShortCut = Nothing
		Set doShortCut = Nothing

		msgbox "�����" & name & "�͍쐬����܂���",64
	else
		msgbox "����2��1�ł͂���܂���I",16
	end if
else
	msgbox "�����̌����Ԉ���Ă��܂��I",16
end if



