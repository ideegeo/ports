--- ui/views/widget/desktop_aura/desktop_window_tree_host_platform.h.orig	2019-03-17 17:59:02 UTC
+++ ui/views/widget/desktop_aura/desktop_window_tree_host_platform.h
@@ -119,7 +119,7 @@ class VIEWS_EXPORT DesktopWindowTreeHostPlatform
 
   bool is_active_ = false;
 
-#if defined(OS_LINUX)
+#if defined(OS_LINUX) || defined(OS_BSD)
   // A handler for events intended for non client area.
   std::unique_ptr<WindowEventFilter> non_client_window_event_filter_;
 #endif
