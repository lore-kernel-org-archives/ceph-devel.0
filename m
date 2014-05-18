From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH] mon: allow osds to change their id
Date: Sun, 18 May 2014 09:57:00 -0300
Message-ID: <ora9afxn1f.fsf@free.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:45695 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaERNEt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 May 2014 09:04:49 -0400
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s4ID4lfd030234
	for <ceph-devel@vger.kernel.org>; Sun, 18 May 2014 13:04:48 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

After using the filestore of one osd to initialize another so as to
speed things up, adjusting the osd number in the superblock, I found
out the monitor will silently reject osds that don't have the expected
id: they seem to be just taking long to complete the boot, but nothing
is logged to the monitor logs or in ceph -w output by default.  That's
a problem in itself, which IMHO justifies making the rejection more
verbose.

Anyway, even after modfying the superblock so that, instead of the
original osd's fsid, it had the fsid in the OSD's filesystem, it
*still* wouldn't boot up.  Only after writing this patch did I realize
that there was a mismatch between the fsid file in the osd filesystem
and the fsid expected by the monitors, but that had never been a
problem as long as the superblock had the expected fsid.  (Presumably
I restored the fsid from backups whereas the root of the osd filestore
was created from scratch, and the fsid is never consulted when there
is a superblock available.  I didn't tackle this issue, if it is one.)

What this patch does is to enable an osd to register with the monitors
after changing its fsid, but only when an option to that effect is
enabled.  It remains disabled by default.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/common/config_opts.h |    1 +
 src/mon/OSDMonitor.cc    |   14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index 9baa356..6698362 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -169,6 +169,7 @@ OPTION(mon_pg_warn_max_object_skew, OPT_FLOAT, 10.0) // max skew few average in
 OPTION(mon_pg_warn_min_objects, OPT_INT, 10000)  // do not warn below this object #
 OPTION(mon_pg_warn_min_pool_objects, OPT_INT, 1000)  // do not warn on pools below this object #
 OPTION(mon_cache_target_full_warn_ratio, OPT_FLOAT, .66) // position between pool cache_target_full and max where we start warning
+OPTION(mon_osd_allow_fsid_change, OPT_BOOL, false) // allow osds to change fsid
 OPTION(mon_osd_full_ratio, OPT_FLOAT, .95) // what % full makes an OSD "full"
 OPTION(mon_osd_nearfull_ratio, OPT_FLOAT, .85) // what % full makes an OSD near full
 OPTION(mon_globalid_prealloc, OPT_INT, 100)   // how many globalids to prealloc
diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
index dd027b2..8662add 100644
--- a/src/mon/OSDMonitor.cc
+++ b/src/mon/OSDMonitor.cc
@@ -786,7 +786,8 @@ bool OSDMonitor::check_source(PaxosServiceMessage *m, uuid_d fsid) {
   if (fsid != mon->monmap->fsid) {
     dout(0) << "check_source: on fsid " << fsid
 	    << " != " << mon->monmap->fsid << dendl;
-    return true;
+    if (!g_conf->mon_osd_allow_fsid_change)
+      return true;
   }
   return false;
 }
@@ -1200,11 +1201,12 @@ bool OSDMonitor::preprocess_boot(MOSDBoot *m)
   if (osdmap.exists(from) &&
       !osdmap.get_uuid(from).is_zero() &&
       osdmap.get_uuid(from) != m->sb.osd_fsid) {
-    dout(7) << __func__ << " from " << m->get_orig_source_inst()
+    dout(0) << __func__ << " from " << m->get_orig_source_inst()
             << " clashes with existing osd: different fsid"
             << " (ours: " << osdmap.get_uuid(from)
             << " ; theirs: " << m->sb.osd_fsid << ")" << dendl;
-    goto ignore;
+    if (!g_conf->mon_osd_allow_fsid_change)
+      goto ignore;
   }
 
   if (osdmap.exists(from) &&
@@ -1256,7 +1258,8 @@ bool OSDMonitor::prepare_boot(MOSDBoot *m)
     dout(7) << "prepare_boot was up, first marking down " << osdmap.get_inst(from) << dendl;
     // preprocess should have caught these;  if not, assert.
     assert(osdmap.get_inst(from) != m->get_orig_source_inst());
-    assert(osdmap.get_uuid(from) == m->sb.osd_fsid);
+    assert(osdmap.get_uuid(from) == m->sb.osd_fsid
+	   || g_conf->mon_osd_allow_fsid_change);
     
     if (pending_inc.new_state.count(from) == 0 ||
 	(pending_inc.new_state[from] & CEPH_OSD_UP) == 0) {
@@ -1297,7 +1300,8 @@ bool OSDMonitor::prepare_boot(MOSDBoot *m)
     dout(10) << " setting osd." << from << " uuid to " << m->sb.osd_fsid << dendl;
     if (!osdmap.exists(from) || osdmap.get_uuid(from) != m->sb.osd_fsid) {
       // preprocess should have caught this;  if not, assert.
-      assert(!osdmap.exists(from) || osdmap.get_uuid(from).is_zero());
+      assert(!osdmap.exists(from) || osdmap.get_uuid(from).is_zero()
+	     || g_conf->mon_osd_allow_fsid_change);
       pending_inc.new_uuid[from] = m->sb.osd_fsid;
     }
 

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
