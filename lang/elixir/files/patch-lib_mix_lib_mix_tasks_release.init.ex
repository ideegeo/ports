--- lib/mix/lib/mix/tasks/release.init.ex.orig	2020-05-18 12:00:31 UTC
+++ lib/mix/lib/mix/tasks/release.init.ex
@@ -147,15 +147,17 @@ defmodule Mix.Tasks.Release.Init do
     }
 
     export_release_sys_config () {
-      if grep -q "RUNTIME_CONFIG=true" "$REL_VSN_DIR/sys.config"; then
+      DEFAULT_SYS_CONFIG="${RELEASE_SYS_CONFIG:-"$REL_VSN_DIR/sys"}"
+
+      if grep -q "RUNTIME_CONFIG=true" "$DEFAULT_SYS_CONFIG.config"; then
         RELEASE_SYS_CONFIG="$RELEASE_TMP/$RELEASE_NAME-$RELEASE_VSN-$(date +%Y%m%d%H%M%S)-$(rand).runtime"
 
-        (mkdir -p "$RELEASE_TMP" && cat "$REL_VSN_DIR/sys.config" >"$RELEASE_SYS_CONFIG.config") || (
+        (mkdir -p "$RELEASE_TMP" && cat "$DEFAULT_SYS_CONFIG.config" >"$RELEASE_SYS_CONFIG.config") || (
           echo "ERROR: Cannot start release because it could not write $RELEASE_SYS_CONFIG.config" >&2
           exit 1
         )
       else
-        RELEASE_SYS_CONFIG="$REL_VSN_DIR/sys"
+        RELEASE_SYS_CONFIG="$DEFAULT_SYS_CONFIG"
       fi
 
       export RELEASE_SYS_CONFIG
@@ -284,7 +286,7 @@ defmodule Mix.Tasks.Release.Init do
     if not defined RELEASE_DISTRIBUTION (set RELEASE_DISTRIBUTION=sname)
     if not defined RELEASE_BOOT_SCRIPT (set RELEASE_BOOT_SCRIPT=start)
     if not defined RELEASE_BOOT_SCRIPT_CLEAN (set RELEASE_BOOT_SCRIPT_CLEAN=start_clean)
-    set RELEASE_SYS_CONFIG=!REL_VSN_DIR!\sys
+    if not defined RELEASE_SYS_CONFIG (set RELEASE_SYS_CONFIG=!REL_VSN_DIR!\sys)
 
     if "%~1" == "start" (set "REL_EXEC=elixir" && set "REL_EXTRA=--no-halt" && set "REL_GOTO=start")
     if "%~1" == "start_iex" (set "REL_EXEC=iex" && set "REL_EXTRA=--werl" && set "REL_GOTO=start")
@@ -299,10 +301,11 @@ defmodule Mix.Tasks.Release.Init do
 
     if not "!REL_GOTO!" == "" (
       findstr "RUNTIME_CONFIG=true" "!RELEASE_SYS_CONFIG!.config" >nul 2>&1 && (
+        set DEFAULT_SYS_CONFIG=!RELEASE_SYS_CONFIG!
         for /f "skip=1" %%X in ('wmic os get localdatetime') do if not defined TIMESTAMP set TIMESTAMP=%%X
         set RELEASE_SYS_CONFIG=!RELEASE_TMP!\!RELEASE_NAME!-!RELEASE_VSN!-!TIMESTAMP:~0,11!-!RANDOM!.runtime
         mkdir "!RELEASE_TMP!" >nul 2>&1
-        copy /y "!REL_VSN_DIR!\sys.config" "!RELEASE_SYS_CONFIG!.config" >nul || (
+        copy /y "!DEFAULT_SYS_CONFIG!.config" "!RELEASE_SYS_CONFIG!.config" >nul || (
           echo Cannot start release because it could not write to "!RELEASE_SYS_CONFIG!.config"
           goto end
         )
