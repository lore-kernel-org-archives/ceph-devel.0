From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH] reinstate ceph cluster_snap support
Date: Thu, 22 Aug 2013 06:10:08 -0300
Message-ID: <orob8qt7kf.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:41798 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab3HVJKi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 05:10:38 -0400
Received: from freie (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id r7M9AZY0022451
	for <ceph-devel@vger.kernel.org>; Thu, 22 Aug 2013 09:10:36 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch brings back and updates (for dumpling) the code originally
introduced to support =E2=80=9Cceph osd cluster_snap <snap>=E2=80=9D, t=
hat was disabled
and partially removed before cuttlefish.

Some minimal testing appears to indicate this even works: the modified
mon actually generated an osdmap with the cluster_snap request, and
starting a modified osd that was down and letting it catch up caused
the osd to take the requested snapshot.  I see no reason why it
wouldn't have taken it if it was up and running, so...  Why was this
feature disabled in the first place?

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/mon/MonCommands.h |    6 ++++--
 src/mon/OSDMonitor.cc |   11 +++++++----
 src/osd/OSD.cc        |   13 +++++++++++++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/src/mon/MonCommands.h b/src/mon/MonCommands.h
index 8e9c2bb..225c687 100644
--- a/src/mon/MonCommands.h
+++ b/src/mon/MonCommands.h
@@ -431,8 +431,10 @@ COMMAND("osd set " \
 COMMAND("osd unset " \
 	"name=3Dkey,type=3DCephChoices,strings=3Dpause|noup|nodown|noout|noin=
|nobackfill|norecover|noscrub|nodeep-scrub", \
 	"unset <key>", "osd", "rw", "cli,rest")
-COMMAND("osd cluster_snap", "take cluster snapshot (disabled)", \
-	"osd", "r", "")
+COMMAND("osd cluster_snap " \
+	"name=3Dsnap,type=3DCephString", \
+	"take cluster snapshot",	\
+	"osd", "r", "cli")
 COMMAND("osd down " \
 	"type=3DCephString,name=3Dids,n=3DN", \
 	"set osd(s) <id> [<id>...] down", "osd", "rw", "cli,rest")
diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
index 07022ae..9bf9511 100644
--- a/src/mon/OSDMonitor.cc
+++ b/src/mon/OSDMonitor.cc
@@ -3099,10 +3099,13 @@ bool OSDMonitor::prepare_command(MMonCommand *m=
)
       return prepare_unset_flag(m, CEPH_OSDMAP_NODEEP_SCRUB);
=20
   } else if (prefix =3D=3D "osd cluster_snap") {
-    // ** DISABLE THIS FOR NOW **
-    ss << "cluster snapshot currently disabled (broken implementation)=
";
-    // ** DISABLE THIS FOR NOW **
-
+    string snap;
+    cmd_getval(g_ceph_context, cmdmap, "snap", snap);
+    pending_inc.cluster_snapshot =3D snap;
+    ss << "creating cluster snap " << snap;
+    getline(ss, rs);
+    wait_for_finished_proposal(new Monitor::C_Command(mon, m, 0, rs, g=
et_last_committed()));
+    return true;
   } else if (prefix =3D=3D "osd down" ||
 	     prefix =3D=3D "osd out" ||
 	     prefix =3D=3D "osd in" ||
diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 1a77dae..e41a6b3 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -5022,6 +5022,19 @@ void OSD::handle_osd_map(MOSDMap *m)
     assert(0 =3D=3D "MOSDMap lied about what maps it had?");
   }
=20
+  // check for cluster snapshots
+  for (epoch_t cur =3D superblock.current_epoch + 1; cur <=3D m->get_l=
ast(); cur++) {
+    OSDMapRef newmap =3D get_map(cur);
+    string cluster_snap =3D newmap->get_cluster_snapshot();
+    if (cluster_snap.length() =3D=3D 0)
+      continue;
+
+    dout(0) << "creating cluster snapshot '" << cluster_snap << "'" <<=
 dendl;
+    int r =3D store->snapshot(cluster_snap);
+    if (r)
+      dout(0) << "failed to create cluster snapshot: " << cpp_strerror=
(r) << dendl;
+  }
+
   if (superblock.oldest_map) {
     int num =3D 0;
     epoch_t min(

--=20
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
=46ree Software Evangelist      Red Hat Brazil Compiler Engineer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
