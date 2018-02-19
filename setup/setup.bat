setlocal

set _path=%~f0

for %%a in ("%_path%") do set "p_dir=%%~dpa"
for %%a in (%p_dir:~0,-1%) do set "p2_dir=%%~dpa"

set PROJECT_PATH=%p2_dir%work

set WP_INIT=yes

docker-compose up --build
