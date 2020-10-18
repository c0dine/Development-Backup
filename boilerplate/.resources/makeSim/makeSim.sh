TARGET_DIR="$PWD/.theos/_/Library/MobileSubstrate/DynamicLibraries/"
SIMJECT_DIR="/Users/thethreemonkeys/simject/" # Default /opt/simject
PYTHON_COMMAND=$PYTHON_PATH #Change depending on your prefered version of python
echo -e "==> Starting... (TweakName: $TWEAK_NAME)"
echo -e "==> INFO: Target directory: $TARGET_DIR"
echo -e "==> INFO: Simject directory: $SIMJECT_DIR"
rm -f $SIMJECT_DIR$TWEAK_NAME > /dev/null
echo -e "==> STATUS: Removed old dynamic library ($TWEAK_NAME.dylib)"
cp -v $TARGET_DIR$TWEAK_NAME.dylib $SIMJECT_DIR$TWEAK_NAME.dylib > /dev/null
echo -e "==> STATUS: Copied dynamic library to simject directory"
codesign -f -s - $SIMJECT_DIR$TWEAK_NAME.dylib &> /dev/null
echo -e "==> STATUS: CodeSigned the dynamic library"
cp -v $TARGET_DIR$TWEAK_NAME.plist $SIMJECT_DIR$TWEAK_NAME.plist > /dev/null
echo -e "==> STATUS: Copied tweak plist file to simject directory ($TWEAK_NAME.plist)"
resim all > /dev/null
echo -e "==> STATUS: Resimed all active simulators"
echo -e "==> STATUS: Starting the python server now..."
# osascript -e `tell app "Terminal" to do script "$PYTHON_COMMAND\ $PWD/.resources/server/rlogserver.py"` > /dev/null #Working on this thing...
echo -e "==> Finished!"