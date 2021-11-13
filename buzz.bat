@echo on

rem  from  https://github.com/winpython/winpython/releases
rem  get the large '64' file  Winpython64-3.9.8.0.exe => 788MB
rem  ( as it has Qt and more other stuff included for us )
rem https://github.com/winpython/winpython/releases/download/4.6.20211106/Winpython64-3.9.8.0.exe

powershell -Command "Invoke-WebRequest https://github.com/winpython/winpython/releases/download/4.6.20211106/Winpython64-3.9.8.0.exe -OutFile Winpython64-3.9.8.0.exe"

echo %USERNAME%

copy Winpython64-3.9.8.0.exe C:\Users\%USERNAME%\Desktop

rem  this is a '7z SFX' self-extracting .exe
rem  you must start with at least 15GB free on-disk.. the self-extractor blows this ~800mb out to  ~4.3gb on-disk. and more..
rem  copy it to the windows desktop....
rem  then run/extract with ( takes 30 min to extract):
cd C:\Users\%USERNAME%\Desktop
Winpython64-3.9.8.0.exe -y -gm2 
rem  to... folder created:
echo C:\Users\%USERNAME%\Desktop\WPy64-3980\

rem  get git sources for guitool... with your favourite git tool..
rem git -c filter.lfs.smudge= -c filter.lfs.required=false -c diff.mnemonicprefix=false -c core.quotepath=false --no-optional-locks clone --branch master --recursive https://github.com/dronecan/gui_tool.git C:\Users\user\Desktop\gui_tool


rem  In windows explorer browse into the Desktop/WPy64-3980/ folder then double-click the 'WinPython Command Prompt.exe' to open a special cmd.exe dos box.
rem "C:\Users\%USERNAME%\Desktop\WPy64-3980\WinPython Command Prompt.exe"

rem SET PATH=%PATH%;C:\Users\%USERNAME%\Desktop\WPy64-3980\python-3.9.8.amd64\
call C:\Users\%USERNAME%\Desktop\WPy64-3980\scripts\env.bat

rem python setup.py install

rem  assuming the above paths..
rem in the 'WinPython Command Prompt.exe' 'dos window' ttype:
rem C:\Users\%%USERNAME%%\Desktop\WPy64-3980\scripts>
rem cd ..
rem C:\Users\%%USERNAME%%\Desktop\WPy64-3980>
rem cd ..
rem C:\Users\%%USERNAME%%\Desktop>
rem cd gui_tool
rem C:\Users\%%USERNAME%%\Desktop\gui_tool>

cd C:\Users\%USERNAME%\Desktop\gui_tool

rem pip install .
python -m pip uninstall -y uavcan
python -m pip uninstall -y dronecan
python -m pip uninstall -y uavcan_gui_tool
python -m pip uninstall -y dronecan_gui_tool
rem python setup.py install

rem  need at least 6.6:, this gets us 6.8.2  https://github.com/marcelotduarte/cx_Freeze/discussions/949
pip install --upgrade cx_Freeze


rem  potential large packages/candidates to remove ( removing them prevents accidental bundling by cx_freeze)
python -m pip uninstall -y torch
python -m pip uninstall -y jupyter_client
python -m pip uninstall -y IPython
pip uninstall -y pandas
pip uninstall -y qtconsole bqplot voila spyder spyder-kernels 
pip uninstall -y mypy notebook numba pygments pytz scipy sympy numpy
pip uninstall -y xarray umap-learn torchvision streamlit statsmodels sklearn-contrib-lightning shap seaborn scs scikit-optimize scikit-learn scikit-image scikit-fuzzy quantecon qpsolvers qdldl python-picard pynndescent pygbm pyflux plotnine pdvega osqp oct2py numdifftools mlxtend mizani lmfit jupyter imbalanced-learn ibis-framework kvplot holoviews guiqt great-expectations gpytorch fastparquet fastai ecos datashader dask-searchcv dask-ml dask-image dask-glm cvxpy botorch astroml altair altair-transform
pip uninstall -y hvplot holoviews pandas guiqwt altair-widgets

rem todo there's probably more things we can get rid of to make the msi smaller....


pip uninstall -y pyqt5_tools plotly bokeh osgeo numpy pulp spacy pyarrow panel llvmlite astropy babel dash matplotlib blis cartopy pygame nbdtime flask_restx jedi 


pip uninstall -y gdal wordcloud thinc rasterio mpldatacursor mpl-scatter-density

pip uninstall -y pyOpenGL

rem  put back just the needed as found in setup.py's list :
pip install .

rem  finally make the .msi
python setup.py install
python setup.py bdist_msi


