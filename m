From: Florian Haas <florian@hastexo.com>
Subject: [PATCH 1/2] Add OCF-compliant resource agent for Ceph daemons
Date: Thu, 29 Dec 2011 20:58:01 +0100
Message-ID: <1325188682-9518-2-git-send-email-florian@hastexo.com>
References: <1325188682-9518-1-git-send-email-florian@hastexo.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34627 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab1L2T7U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2011 14:59:20 -0500
Received: by eekc4 with SMTP id c4so13165995eek.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Dec 2011 11:59:19 -0800 (PST)
In-Reply-To: <1325188682-9518-1-git-send-email-florian@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Florian Haas <florian@hastexo.com>

Add a wrapper around the ceph init script that makes
MDS, OSD and MON configurable as Open Cluster Framework
(OCF) compliant cluster resources. Allows Ceph
daemons to tie in with cluster resource managers that
support OCF, such as Pacemaker (http://www.clusterlabs.org).

Disabled by default, configure --with-ocf to enable.

Signed-off-by: Florian Haas <florian@hastexo.com>
---
 configure.ac        |    8 ++
 src/Makefile.am     |    4 +-
 src/ocf/Makefile.am |   23 +++++++
 src/ocf/ceph.in     |  177 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 210 insertions(+), 2 deletions(-)
 create mode 100644 src/ocf/Makefile.am
 create mode 100644 src/ocf/ceph.in

diff --git a/configure.ac b/configure.ac
index 60f998c..e334a24 100644
--- a/configure.ac
+++ b/configure.ac
@@ -277,6 +277,12 @@ AM_CONDITIONAL(WITH_LIBATOMIC, [test "$HAVE_ATOMIC_OPS" = "1"])
 #            [],
 #            [with_newsyn=no])
 
+AC_ARG_WITH([ocf],
+            [AS_HELP_STRING([--with-ocf], [build OCF-compliant cluster resource agent])],
+            ,
+            [with_ocf=no])
+AM_CONDITIONAL(WITH_OCF, [ test "$with_ocf" = "yes" ])
+
 # Checks for header files.
 AC_HEADER_DIRENT
 AC_HEADER_STDC
@@ -375,6 +381,8 @@ AM_PATH_PYTHON([2.4],
 AC_CONFIG_HEADERS([src/acconfig.h])
 AC_CONFIG_FILES([Makefile
 	src/Makefile
+	src/ocf/Makefile
+	src/ocf/ceph
 	man/Makefile
 	ceph.spec])
 AC_OUTPUT
diff --git a/src/Makefile.am b/src/Makefile.am
index 748425e..8026e17 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -1,6 +1,6 @@
 AUTOMAKE_OPTIONS = gnu
-SUBDIRS =
-DIST_SUBDIRS = gtest
+SUBDIRS = ocf
+DIST_SUBDIRS = gtest ocf
 CLEANFILES =
 bin_PROGRAMS =
 # like bin_PROGRAMS, but these targets are only built for debug builds
diff --git a/src/ocf/Makefile.am b/src/ocf/Makefile.am
new file mode 100644
index 0000000..9be40ec
--- /dev/null
+++ b/src/ocf/Makefile.am
@@ -0,0 +1,23 @@
+EXTRA_DIST = ceph.in Makefile.in
+
+if WITH_OCF
+# The root of the OCF resource agent hierarchy
+# Per the OCF standard, it's always "lib",
+# not "lib64" (even on 64-bit platforms).
+ocfdir = $(prefix)/lib/ocf
+
+# The ceph provider directory
+radir = $(ocfdir)/resource.d/$(PACKAGE_NAME)
+
+ra_SCRIPTS = ceph
+
+install-data-hook:
+	$(LN_S) ceph $(DESTDIR)$(radir)/osd
+	$(LN_S) ceph $(DESTDIR)$(radir)/mds
+	$(LN_S) ceph $(DESTDIR)$(radir)/mon
+
+uninstall-hook:
+	rm -f $(DESTDIR)$(radir)/osd
+	rm -f $(DESTDIR)$(radir)/mds
+	rm -f $(DESTDIR)$(radir)/mon
+endif
diff --git a/src/ocf/ceph.in b/src/ocf/ceph.in
new file mode 100644
index 0000000..9db1bc9
--- /dev/null
+++ b/src/ocf/ceph.in
@@ -0,0 +1,177 @@
+#!/bin/sh
+
+# Initialization:
+: ${OCF_FUNCTIONS_DIR=${OCF_ROOT}/lib/heartbeat}
+. ${OCF_FUNCTIONS_DIR}/ocf-shellfuncs
+
+# Convenience variables
+# When sysconfdir isn't passed in as a configure flag,
+# it's defined in terms of prefix
+prefix=@prefix@
+CEPH_INIT=@sysconfdir@/init.d/ceph
+
+ceph_meta_data() {
+    local longdesc
+    local shortdesc
+    case $__SCRIPT_NAME in
+	"osd")
+	    longdesc="Wraps the ceph init script to provide an OCF resource agent that manages and monitors the Ceph OSD service."
+	    longdesc="Manages a Ceph OSD instance."
+	    ;;
+	"mds")
+	    longdesc="Wraps the ceph init script to provide an OCF resource agent that manages and monitors the Ceph MDS service."
+	    longdesc="Manages a Ceph MDS instance."
+	    ;;
+	"mon")
+	    longdesc="Wraps the ceph init script to provide an OCF resource agent that manages and monitors the Ceph MON service."
+	    longdesc="Manages a Ceph MON instance."
+	    ;;
+    esac
+    
+cat <<EOF
+<?xml version="1.0"?>
+<!DOCTYPE resource-agent SYSTEM "ra-api-1.dtd">
+<resource-agent name="${__SCRIPT_NAME}" version="0.1">
+  <version>0.1</version>
+  <longdesc lang="en">${longdesc}</longdesc>
+  <shortdesc lang="en">${shortdesc}</shortdesc>
+  <parameters/>
+  <actions>
+    <action name="start"        timeout="20" />
+    <action name="stop"         timeout="20" />
+    <action name="monitor"      timeout="20"
+                                interval="10"/>
+    <action name="meta-data"    timeout="5" />
+    <action name="validate-all"   timeout="20" />
+  </actions>
+</resource-agent>
+EOF
+}
+
+ceph_action() {
+    local init_action
+    init_action="$1"
+
+    case ${__SCRIPT_NAME} in
+	osd|mds|mon)
+	    ocf_run $CEPH_INIT $init_action ${__SCRIPT_NAME}
+	    ;;
+	*)
+	    ocf_run $CEPH_INIT $init_action
+	    ;;
+    esac
+}
+
+ceph_validate_all() {
+    # Do we have the ceph init script?
+    check_binary @sysconfdir@/init.d/ceph
+
+    # Do we have a configuration file?
+    [ -e @sysconfdir@/ceph/ceph.conf ] || exit $OCF_ERR_INSTALLED
+}
+
+ceph_monitor() {
+    local rc
+
+    ceph_action status
+
+    # 0: running, and fully caught up with master
+    # 3: gracefully stopped
+    # any other: error
+    case "$?" in
+        0)
+            rc=$OCF_SUCCESS
+            ocf_log debug "Resource is running"
+            ;;
+        3)
+            rc=$OCF_NOT_RUNNING
+            ocf_log debug "Resource is not running"
+            ;;
+        *)
+            ocf_log err "Resource has failed"
+            rc=$OCF_ERR_GENERIC
+    esac
+
+    return $rc
+}
+
+ceph_start() {
+    # if resource is already running, bail out early
+    if ceph_monitor; then
+        ocf_log info "Resource is already running"
+        return $OCF_SUCCESS
+    fi
+
+    ceph_action start
+
+    while ! ceph_monitor; do
+        ocf_log debug "Resource has not started yet, waiting"
+        sleep 1
+    done
+
+    return $OCF_SUCCESS
+}
+
+ceph_stop() {
+    local rc
+
+    # exit immediately if configuration is not valid
+    ceph_validate_all || exit $?
+
+    ceph_monitor
+    rc=$?
+    case "$rc" in
+        "$OCF_SUCCESS")
+            # Currently running. Normal, expected behavior.
+            ocf_log debug "Resource is currently running"
+            ;;
+        "$OCF_NOT_RUNNING")
+            # Currently not running. Nothing to do.
+            ocf_log info "Resource is already stopped"
+            return $OCF_SUCCESS
+            ;;
+    esac
+
+    ceph_action stop
+
+    while ceph_monitor; do
+        ocf_log debug "Resource has not stopped yet, waiting"
+        sleep 1
+    done
+
+    # only return $OCF_SUCCESS if _everything_ succeeded as expected
+    return $OCF_SUCCESS
+
+}
+
+
+
+# Make sure meta-data and usage always succeed
+case $__OCF_ACTION in
+meta-data)      ceph_meta_data
+                exit $OCF_SUCCESS
+                ;;
+usage|help)     ceph_usage
+                exit $OCF_SUCCESS
+                ;;
+esac
+
+# Anything other than meta-data and usage must pass validation
+ceph_validate_all || exit $?
+
+# Translate each action into the appropriate function call
+case $__OCF_ACTION in
+start)          ceph_start;;
+stop)           ceph_stop;;
+status|monitor) ceph_monitor;;
+reload)         ocf_log info "Reloading..."
+                ceph_start
+                ;;
+validate-all)   ;;
+*)              ceph_usage
+                exit $OCF_ERR_UNIMPLEMENTED
+                ;;
+esac
+rc=$?
+
+exit $rc
-- 
1.7.5.4

