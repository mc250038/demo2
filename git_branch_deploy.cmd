@echo off
REM git_branch_deploy

set td_git_branch=%1
set td_git_dir=%2
set td_target_dir=%3

set /a ERR=0
set /a ERROR_NOT_EXIST=1

cls
echo ============================
echo Executing: git_branch_deploy
echo ============================
echo: 
echo Git Branch......: %td_git_branch% 
echo Git Directory...: %td_git_dir%
echo Target Directory: %td_target_dir%
echo:

:start

if not exist %td_git_dir% (
  set /a ERR^|=%ERROR_NOT_EXIST%
  echo Git Directory %td_git_dir% Does NOT Exist.
)

if not exist %td_target_dir% (
  set /a ERR^|=%ERROR_NOT_EXIST%
  echo Target Directory %td_target_dir% Does NOT Exist.
)

if not exist %td_git_dir%\.git (
  set /a ERR^|=%ERROR_NOT_EXIST%
  echo Git Repo %td_git_dir%\ Does NOT Exist.
)

if not exist %td_git_dir%\.git\refs\heads\%td_git_branch% (
  set /a ERR^|=%ERROR_NOT_EXIST%
  echo Git Branch %td_git_branch% Does NOT Exist.
)

if %ERR% == 0 (
  git --work-tree=%td_target_dir% --git-dir=%td_git_dir%\.git checkout %td_git_branch% -f
)

set ERR=%ERRORLEVEL%

:end
echo:
if %ERR% == 0 (
  echo Done. RC=%ERR%.
) else (
  echo Exiting due to error. RC=%ERR%.
)

set td_git_branch=
set td_git_dir=
set td_target_dir=

exit /B %ERR% 