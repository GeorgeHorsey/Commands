Rem Batch script to remove any network locations from Windows without needing to Sign out.
@echo off
title Clear Network Drive Creds
net use * /d /y
pause
