 
REM ActiveX��ע�����
REM ֵ         ���� 
REM ------------------------------ 
REM 0        �ҵĵ��� 
REM 1        ���� Intranet ���� 
REM 2        �����ε�վ������ 
REM 3        Internet ���� 
REM 4        �����Ƶ�վ������ 
 
REM 1001     ������ǩ���� ActiveX �ؼ� 
REM 1004     ����δǩ���� ActiveX �ؼ� 
REM 1200     ���� ActiveX �ؼ��Ͳ�� 
REM 1201     ��û�б��Ϊ��ȫ�� ActiveX �ؼ����г�ʼ���ͽű����� 
REM 1405     �Ա��Ϊ�ɰ�ȫִ�нű��� ActiveX �ؼ�ִ�нű� 
REM 2201     ActiveX �ؼ��Զ���ʾ
 
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "1001" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "1004" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "1200" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "1201" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "1405" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\1" /v "2201" /t REG_DWORD /d 0 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1001" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1004" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1200" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1201" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "1405" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" /v "2201" /t REG_DWORD /d 0 /f

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1001" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1004" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1200" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1201" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "1405" /t REG_DWORD /d 0 /f
 reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /v "2201" /t REG_DWORD /d 0 /f

rem reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" /v "1001" /t REG_DWORD /d 0 /f
rem reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" /v "1004" /t REG_DWORD /d 0 /f
rem reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" /v "1200" /t REG_DWORD /d 0 /f
rem reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" /v "1201" /t REG_DWORD /d 0 /f
rem reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" /v "1405" /t REG_DWORD /d 0 /f
rem reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\4" /v "2201" /t REG_DWORD /d 0 /f
 
REM ����������ֹ�����ע����� 
REM WshShell.RegWrite("HKCU\\Software\\Microsoft\\Internet Explorer\\New Windows\\PopupMgr","no");
 reg add "HKCU\Software\Microsoft\Internet Explorer\New Windows" /v "PopupMgr" /t REG_SZ /d no /f

Pause

 