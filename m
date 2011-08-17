From: Sage Weil <sage@newdream.net>
Subject: mds locker debugging
Date: Tue, 16 Aug 2011 21:38:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108162137230.24116@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35656 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1HQEln (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Aug 2011 00:41:43 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bchrisman@gmail.com
Cc: ceph-devel@vger.kernel.org

(03:51:58 PM) bchrisman: can we control the mds logging to perhaps only 
output locking requests?
(03:52:05 PM) bchrisman: or rather.. any lock activity?
(03:52:31 PM) bchrisman: trying to debug an issue where it looks like we 
have a bum lock# but putting mds=20 spams our logfiles
(04:01:35 PM) cmccabe: bchrisman: I don't see any configuration setting 
that directly corresponds to that
(04:02:26 PM) bchrisman: I guess I'll check whether lockign has a specific 
debug level, or if 20 is the only way to get it.
(04:03:36 PM) cmccabe: I see some log output in Locker.cc
(04:03:43 PM) cmccabe: perhaps you will want to change the levels of that

This should do the trick.  We do the same for MDLog.cc and MDBalancer.cc 
already.

diff --git a/src/common/config.cc b/src/common/config.cc
index 7649286..6c277fe 100644
--- a/src/common/config.cc
+++ b/src/common/config.cc
@@ -145,6 +145,7 @@ struct config_option config_optionsp[] = {
   OPTION(debug_context, OPT_INT, 0),
   OPTION(debug_mds, OPT_INT, 1),
   OPTION(debug_mds_balancer, OPT_INT, 1),
+  OPTION(debug_mds_locker, OPT_INT, 1),
   OPTION(debug_mds_log, OPT_INT, 1),
   OPTION(debug_mds_log_expire, OPT_INT, 1),
   OPTION(debug_mds_migrator, OPT_INT, 1),
diff --git a/src/common/config.h b/src/common/config.h
index 0fffae8..dc56152 100644
--- a/src/common/config.h
+++ b/src/common/config.h
@@ -198,6 +198,7 @@ public:
   int debug_context;
   int debug_mds;
   int debug_mds_balancer;
+  int debug_mds_locker;
   int debug_mds_log;
   int debug_mds_log_expire;
   int debug_mds_migrator;
diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 4eb3a5a..7d1b5a2 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -57,6 +57,8 @@
 
 #define DOUT_SUBSYS mds
 #undef dout_prefix
+#undef DOUT_COND
+#define DOUT_COND(cct, l) l<=cct->_conf->debug_mds || l <= cct->_conf->debug_mds_locker
 #define dout_prefix _prefix(_dout, mds)
 static ostream& _prefix(std::ostream *_dout, MDS *mds) {
   return *_dout << "mds" << mds->get_nodeid() << ".locker ";

