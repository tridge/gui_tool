@echo on

rem  from  https://github.com/winpython/winpython/releases
rem  get the large '64' file  Winpython64-3.9.8.0.exe => 788MB
rem  ( as it has Qt and more other stuff included for us )
rem https://github.com/winpython/winpython/releases/download/4.6.20211106/Winpython64-3.9.8.0.exe

rem powershell -Command "Invoke-WebRequest https://github.com/winpython/winpython/releases/download/4.6.20211106/Winpython64-3.9.8.0.exe -OutFile Winpython64-3.9.8.0.exe"

echo %USERNAME%
dir

rem copy Winpython64-3.9.8.0.exe C:\Users\%USERNAME%\Desktop

cd C:\Users\%USERNAME%\Desktop
rem Winpython64-3.9.8.0.exe -y -gm2

echo C:\Users\%USERNAME%\Desktop\WPy64-3980\
dir C:\Users\%USERNAME%\Desktop\WPy64-3980
SET PATH=C:\Users\%USERNAME%\Desktop\WPy64-3980\python-3.9.8.amd64;%PATH%
python --version

call C:\Users\%USERNAME%\Desktop\WPy64-3980\scripts\env.bat
python --version

cd C:\Users\%USERNAME%\Desktop\gui_tool

dir
pip --version
echo "LIST1"
pip list

rem  need at least 6.6:, this gets us 6.8.2  https://github.com/marcelotduarte/cx_Freeze/discussions/949
pip install --upgrade cx_Freeze

python pip_sizes.py

echo "LIST2"
pip list

rem  put back just the needed as found in setup.py's list :
pip install .

echo "LIST3"
pip list
python pip_sizes.py

rem  finally make the .msi
python setup.py install
python setup.py bdist_msi


