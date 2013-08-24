From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Sat, 24 Aug 2013 11:56:35 -0300
Message-ID: <ortxifi1cs.fsf@livre.home>
References: <orob8qt7kf.fsf@livre.home>
	<alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:45975 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719Ab3HXO4z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Aug 2013 10:56:55 -0400
In-Reply-To: <alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net> (Sage
	Weil's message of "Fri, 23 Aug 2013 17:17:22 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: sam.just@inktank.com, ceph-devel@vger.kernel.org

--=-=-=

On Aug 23, 2013, Sage Weil <sage@inktank.com> wrote:

> FWIW Alexandre, this feature was never really complete.  For it to work, 
> we also need to snapshot the monitors, and roll them back as well.

That depends on what's expected from the feature, actually.

One use is to roll back a single osd, and for that, the feature works
just fine.  Of course, for that one doesn't need the multi-osd snapshots
to be mutually consistent, but it's still convenient to be able to take
a global snapshot with a single command.

Another use is to roll back the entire cluster to an earlier state, and
for that, you *probably* want to roll back the monitors too, although it
doesn't seem like this is strictly necessary, unless some significant
configuration changes occurrend in the cluster since the snapshot was
taken, and you want to roll back those too.

In my experience, rolling back only osds has worked just fine, with the
exception of cases in which the snapshot is much too old, and the mons
have already expired osdmaps after the last one the osd got when the
snapshot was taken.  For this one case, I have a patch that enables the
osd to rejoin the cluster in spite of the expired osdmaps, which has
always worked for me, but I understand there may be exceptional cluster
reconfigurations in which this wouldn't have worked.


As for snapshotting monitors...  I suppose the way to go is to start a
store.db dump in background, instead of taking a btrfs snapshot, since
the store.db is not created as a subvolume.  That said, it would make
some sense to make it so, to make it trivially snapshottable.


Anyway, I found a problem in the earlier patch: when I added a new disk
to my cluster this morning, it tried to iterate over osdmaps that were
not available (e.g. the long-gone osdmap 1), and crashed.

Here's a fixed version, that makes sure we don't start the iteration
before m->get_first().


--=-=-=
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: inline; filename=mon-osd-reinstate-cluster-snap.patch
Content-Transfer-Encoding: quoted-printable

reinstate ceph cluster_snap support

From: Alexandre Oliva <oliva@gnu.org>

This patch brings back and updates (for dumpling) the code originally
introduced to support =E2=80=9Cceph osd cluster_snap <snap>=E2=80=9D, that =
was
disabled and partially removed before cuttlefish.

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
 src/osd/OSD.cc        |   14 ++++++++++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/src/mon/MonCommands.h b/src/mon/MonCommands.h
index 8e9c2bb..225c687 100644
--- a/src/mon/MonCommands.h
+++ b/src/mon/MonCommands.h
@@ -431,8 +431,10 @@ COMMAND("osd set " \
 COMMAND("osd unset " \
 	"name=3Dkey,type=3DCephChoices,strings=3Dpause|noup|nodown|noout|noin|nob=
ackfill|norecover|noscrub|nodeep-scrub", \
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
@@ -3099,10 +3099,13 @@ bool OSDMonitor::prepare_command(MMonCommand *m)
       return prepare_unset_flag(m, CEPH_OSDMAP_NODEEP_SCRUB);
=20
   } else if (prefix =3D=3D "osd cluster_snap") {
-    // ** DISABLE THIS FOR NOW **
-    ss << "cluster snapshot currently disabled (broken implementation)";
-    // ** DISABLE THIS FOR NOW **
-
+    string snap;
+    cmd_getval(g_ceph_context, cmdmap, "snap", snap);
+    pending_inc.cluster_snapshot =3D snap;
+    ss << "creating cluster snap " << snap;
+    getline(ss, rs);
+    wait_for_finished_proposal(new Monitor::C_Command(mon, m, 0, rs, get_l=
ast_committed()));
+    return true;
   } else if (prefix =3D=3D "osd down" ||
 	     prefix =3D=3D "osd out" ||
 	     prefix =3D=3D "osd in" ||
diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 1a77dae..01527a6 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -5022,6 +5022,20 @@ void OSD::handle_osd_map(MOSDMap *m)
     assert(0 =3D=3D "MOSDMap lied about what maps it had?");
   }
=20
+  // check for cluster snapshots
+  for (epoch_t cur =3D MAX(superblock.current_epoch + 1, m->get_first());
+       cur <=3D m->get_last(); cur++) {
+    OSDMapRef newmap =3D get_map(cur);
+    string cluster_snap =3D newmap->get_cluster_snapshot();
+    if (cluster_snap.length() =3D=3D 0)
+      continue;
+
+    dout(0) << "creating cluster snapshot '" << cluster_snap << "'" << den=
dl;
+    int r =3D store->snapshot(cluster_snap);
+    if (r)
+      dout(0) << "failed to create cluster snapshot: " << cpp_strerror(r) =
<< dendl;
+  }
+
   if (superblock.oldest_map) {
     int num =3D 0;
     epoch_t min(

--=-=-=



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
