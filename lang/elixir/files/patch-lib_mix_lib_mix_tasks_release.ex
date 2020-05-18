--- lib/mix/lib/mix/tasks/release.ex.orig	2020-05-18 12:00:36 UTC
+++ lib/mix/lib/mix/tasks/release.ex
@@ -175,7 +175,7 @@ defmodule Mix.Tasks.Release do
   of crashes. See the generated `releases/RELEASE_VSN/env.sh` file.
 
   The daemon will write all of its standard output to the "tmp/log/"
-  directory in the release root. You can watch the log file by doing 
+  directory in the release root. You can watch the log file by doing
   `tail -f tmp/log/erlang.log.1` or similar. Once files get too large,
   the index suffix will be incremented. A developer can also attach
   to the standard input of the daemon by invoking "to_erl tmp/pipe/"
@@ -276,9 +276,21 @@ defmodule Mix.Tasks.Release do
   some systems, especially so with package managers that try to create fully
   reproducible environments (Nix, Guix).
 
+  Similarly, when creating a stand-alone package and release for Windows, note
+  the Erlang Runtime System has a dependency to some Microsoft libraries
+  (Visual C++ Redistributable Packages for Visual Studio 2013). These libraries
+  are installed (if not present before) when Erlang is installed but it is not
+  part of the standard Windows environment. Deploying a stand-alone release on
+  a computer without these libraries will result in a failure when trying to
+  run the release. One way to solve this is to download and install these
+  Microsoft libraries the first time a release is deployed (the Erlang installer
+  version 10.6 ships with “Microsoft Visual C++ 2013 Redistributable - 12.0.30501”).
+
   Alternatively, you can also bundle the compiled object files in the release,
   as long as they were compiled for the same target. If doing so, you need to
-  update `LD_LIBRARY_PATH` with the paths containing the bundled objects.
+  update `LD_LIBRARY_PATH` environment variable with the paths containing the
+  bundled objects on Unix-like systems or the `PATH` environment variable on
+  Windows systems.
 
   Currently, there is no official way to cross-compile a release from one
   target triple to another, due to the complexities involved in the process.
@@ -392,7 +404,7 @@ defmodule Mix.Tasks.Release do
       the characters in the cookie to the subset returned by `Base.url_encode64/1`.
 
     * `:validate_compile_env` - by default a release will match all runtime
-      configuration against any configuration that was marked as compile time
+      configuration against any configuration that was marked at compile time
       in your application of its dependencies via the `Application.compile_env/3`
       function. If there is a mismatch between those, it means your system is
       misconfigured and unable to boot. You can disable this check by setting
@@ -458,7 +470,7 @@ defmodule Mix.Tasks.Release do
   Often it is necessary to copy extra files to the release root after
   the release is assembled. This can be easily done by placing such
   files in the `rel/overlays` directory. Any file in there is copied
-  as is to the release root. For example, if you have place a
+  as is to the release root. For example, if you have placed a
   "rel/overlays/Dockerfile" file, the "Dockerfile" will be copied as
   is to the release root. If you need to copy files dynamically, see
   the "Steps" section.
@@ -486,7 +498,7 @@ defmodule Mix.Tasks.Release do
   created inside the configured `:path`.
 
   See `Mix.Release` for more documentation on the struct and which
-  fields can be modified. Note that `:steps` field itself can be
+  fields can be modified. Note that the `:steps` field itself can be
   modified and it is updated every time a step is called. Therefore,
   if you need to execute a command before and after assembling the
   release, you only need to declare the first steps in your pipeline
@@ -594,9 +606,16 @@ defmodule Mix.Tasks.Release do
   process) and the new configuration will take place.
 
   You can change the path to the runtime configuration file by setting
-  `:runtime_config_path`. This path is resolved at build time as the
-  given configuration file is always copied to inside the release.
+  `:runtime_config_path` inside each release configuration. This path is
+  resolved at build time as the given configuration file is always copied
+  to inside the release:
 
+      releases: [
+        demo: [
+          runtime_config_path: ...
+        ]
+      ]
+
   Finally, in order for runtime configuration to work properly (as well
   as any other "Config provider" as defined next), it needs to be able
   to persist the newly computed configuration to disk. The computed config
@@ -730,6 +749,9 @@ defmodule Mix.Tasks.Release do
       It can be set to a custom value. The name part must be made only
       of letters, digits, underscores, and hyphens
 
+    * `RELEASE_SYS_CONFIG` - the location of the sys.config file. It can
+      be set to a custom path and it must not include the `.config` extension
+
     * `RELEASE_VM_ARGS` - the location of the vm.args file. It can be set
       to a custom path
 
@@ -882,7 +904,7 @@ defmodule Mix.Tasks.Release do
         end
       end
 
-  If you to perform a hot code upgrade in such application, it would
+  If you were to perform a hot code upgrade in such an application, it would
   crash, because in the initial version the state was just a counter
   but in the new version the state is a tuple. Furthermore, you changed
   the format of the `call` message from `:bump` to  `{:bump, by}` and
@@ -973,13 +995,10 @@ defmodule Mix.Tasks.Release do
   @impl true
   def run(args) do
     Mix.Project.get!()
+    Mix.Task.run("compile", args)
+
     config = Mix.Project.config()
-    Mix.Task.run("loadpaths", args)
 
-    unless "--no-compile" in args do
-      Mix.Project.compile(args, config)
-    end
-
     release =
       case OptionParser.parse!(args, strict: @switches, aliases: @aliases) do
         {overrides, [name]} -> Mix.Release.from_config!(String.to_atom(name), config, overrides)
@@ -1130,7 +1149,7 @@ defmodule Mix.Tasks.Release do
         []
       end
 
-    release = maybe_add_config_reader_provider(release, version_path)
+    release = maybe_add_config_reader_provider(config, release, version_path)
     vm_args_path = Path.join(version_path, "vm.args")
     cookie_path = Path.join(release.path, "releases/COOKIE")
     start_erl_path = Path.join(release.path, "releases/start_erl.data")
@@ -1149,14 +1168,17 @@ defmodule Mix.Tasks.Release do
     end
   end
 
-  defp maybe_add_config_reader_provider(%{options: opts} = release, version_path) do
+  defp maybe_add_config_reader_provider(config, %{options: opts} = release, version_path) do
+    default_path = config[:config_path] |> Path.dirname() |> Path.join("releases.exs")
+
     path =
       cond do
+        # TODO: rename this to releases_config_path when we introduce runtime_config_path
         path = opts[:runtime_config_path] ->
           path
 
-        File.exists?("config/releases.exs") ->
-          "config/releases.exs"
+        File.exists?(default_path) ->
+          default_path
 
         true ->
           nil
@@ -1171,7 +1193,7 @@ defmodule Mix.Tasks.Release do
         update_in(release.config_providers, &[{Config.Reader, init} | &1])
 
       release.config_providers == [] ->
-        skipping("runtime configuration (config/releases.exs not found)")
+        skipping("runtime configuration (#{default_path} not found)")
         release
 
       true ->
