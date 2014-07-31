From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH] daemons: write pid file even when told not to daemonize
Date: Wed, 30 Jul 2014 23:08:43 -0300
Message-ID: <or4mxyuvo4.fsf@free.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:58492 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbaGaCNV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 22:13:21 -0400
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s6V28xHq020426
	for <ceph-devel@vger.kernel.org>; Thu, 31 Jul 2014 02:09:00 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

systemd wants to run daemons in foreground, but daemons wouldn't write
out the pid file with -f.  Fixed.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/ceph_mon.cc           |    3 +--
 src/common/config.cc      |    2 --
 src/global/global_init.cc |   10 +++++++++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/ceph_mon.cc b/src/ceph_mon.cc
index 4e84b4d..14dd6da 100644
--- a/src/ceph_mon.cc
+++ b/src/ceph_mon.cc
@@ -406,8 +406,7 @@ int main(int argc, const char **argv)
   // screwing us over
   Preforker prefork;
   if (!(flags & CINIT_FLAG_NO_DAEMON_ACTIONS)) {
-    if (g_conf->daemonize) {
-      global_init_prefork(g_ceph_context, 0);
+    if (global_init_prefork(g_ceph_context, 0) >= 0) {
       prefork.prefork();
       if (prefork.is_parent()) {
 	return prefork.parent_wait();
diff --git a/src/common/config.cc b/src/common/config.cc
index 0ee7f58..4e3b6fe 100644
--- a/src/common/config.cc
+++ b/src/common/config.cc
@@ -389,12 +389,10 @@ int md_config_t::parse_argv(std::vector<const char*>& args)
     }
     else if (ceph_argparse_flag(args, i, "--foreground", "-f", (char*)NULL)) {
       set_val_or_die("daemonize", "false");
-      set_val_or_die("pid_file", "");
     }
     else if (ceph_argparse_flag(args, i, "-d", (char*)NULL)) {
       set_val_or_die("daemonize", "false");
       set_val_or_die("log_file", "");
-      set_val_or_die("pid_file", "");
       set_val_or_die("log_to_stderr", "true");
       set_val_or_die("err_to_stderr", "true");
       set_val_or_die("log_to_syslog", "false");
diff --git a/src/global/global_init.cc b/src/global/global_init.cc
index 7b20343..f03677c 100644
--- a/src/global/global_init.cc
+++ b/src/global/global_init.cc
@@ -166,8 +166,16 @@ int global_init_prefork(CephContext *cct, int flags)
   if (g_code_env != CODE_ENVIRONMENT_DAEMON)
     return -1;
   const md_config_t *conf = cct->_conf;
-  if (!conf->daemonize)
+  if (!conf->daemonize) {
+    if (atexit(pidfile_remove_void)) {
+      derr << "global_init_daemonize: failed to set pidfile_remove function "
+	   << "to run at exit." << dendl;
+    }
+
+    pidfile_write(g_conf);
+
     return -1;
+  }
 
   // stop log thread
   g_ceph_context->_log->flush();

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
