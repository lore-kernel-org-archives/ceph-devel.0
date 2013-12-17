From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Tue, 17 Dec 2013 10:14:27 -0200
Message-ID: <or7gb3ad3w.fsf@livre.home>
References: <orob8qt7kf.fsf@livre.home>
	<alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net>
	<ortxifi1cs.fsf@livre.home>
	<alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:47294 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3LQMPF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 07:15:05 -0500
In-Reply-To: <alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net> (Sage
	Weil's message of "Tue, 27 Aug 2013 15:21:52 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: sam.just@inktank.com, ceph-devel@vger.kernel.org

--=-=-=

On Aug 27, 2013, Sage Weil <sage@inktank.com> wrote:

> Hi,
> On Sat, 24 Aug 2013, Alexandre Oliva wrote:
>> On Aug 23, 2013, Sage Weil <sage@inktank.com> wrote:
>> 
>> > FWIW Alexandre, this feature was never really complete.  For it to work, 
>> > we also need to snapshot the monitors, and roll them back as well.
>> 
>> That depends on what's expected from the feature, actually.
>> 
>> One use is to roll back a single osd, and for that, the feature works
>> just fine.  Of course, for that one doesn't need the multi-osd snapshots
>> to be mutually consistent, but it's still convenient to be able to take
>> a global snapshot with a single command.

> In principle, we can add this back in.  I think it needs a few changes, 
> though.

> First, FileStore::snapshot() needs to pause and drain the workqueue before 
> taking the snapshot, similar to what is done with the sync sequence.  
> Otherwise it isn't a transactionally consistent snapshot and may tear some 
> update.  Because it is draining the work queue, it *might* also need to 
> drop some locks, but I'm hopeful that that isn't necessary.

Hmm...  I don't quite get this.  The Filestore implementation of
snapshot already performs a sync_and_flush before calling the backend's
create_checkpoint.  Shouldn't that be enough?  FWIW, the code I brought
in from argonaut didn't do any such thing; it did drop locks, but that
doesn't seem to be necessary any more:

  // flush here so that the peering code can re-read any pg data off
  // disk that it needs to... say for backlog generation.  (hmm, is
  // this really needed?)
  osd_lock.Unlock();
  if (cluster_snap.length()) {
    dout(0) << "creating cluster snapshot '" << cluster_snap << "'" << dendl;
    int r = store->snapshot(cluster_snap);
    if (r)
      dout(0) << "failed to create cluster snapshot: " << cpp_strerror(r) << de
  } else {
    store->flush();
  }
  osd_lock.Lock();

> Second, the call in handle_osd_map() should probably go in the loop a bit 
> further down that is consuming maps.  It probably won't matter most of the 
> time, but I'm paranoid about corner conditions.  It also avoids iterating 
> over the new OSDMaps multiple times in the common case where there is no 
> cluster_snap (a minor win).

I've just moved the cluster creation down to the loop I think you're
speaking of above.  Here's the revised patch, so far untested, just for
reference so that you don't have to refer to the archives to locate the
earlier patch and make sense of the comments in this old thread.

> Finally, eventually we should make this do a checkpoint on the mons too.  
> We can add the osd snapping back in first, but before this can/should 
> really be used the mons need to be snapshotted as well.  Probably that's 
> just adding in a snapshot() method to MonitorStore.h and doing either a 
> leveldb snap or making a full copy of store.db... I forget what leveldb is 
> capable of here.

I haven't looked into this yet.



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
 src/osd/OSD.cc        |    8 ++++++++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/src/mon/MonCommands.h b/src/mon/MonCommands.h
index 5a6ca6a..8977f29 100644
--- a/src/mon/MonCommands.h
+++ b/src/mon/MonCommands.h
@@ -445,8 +445,10 @@ COMMAND("osd set " \
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
index 07775fc..9a46978 100644
--- a/src/mon/OSDMonitor.cc
+++ b/src/mon/OSDMonitor.cc
@@ -3428,10 +3428,13 @@ bool OSDMonitor::prepare_command(MMonCommand *m)
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
index 8da4d96..b5720f7 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -5169,6 +5169,14 @@ void OSD::handle_osd_map(MOSDMap *m)
       }
     }
=20=20=20=20=20
+    string cluster_snap =3D newmap->get_cluster_snapshot();
+    if (cluster_snap.length()) {
+      dout(0) << "creating cluster snapshot '" << cluster_snap << "'" << d=
endl;
+      int r =3D store->snapshot(cluster_snap);
+      if (r)
+	dout(0) << "failed to create cluster snapshot: " << cpp_strerror(r) << de=
ndl;
+    }
+
     osdmap =3D newmap;
=20
     superblock.current_epoch =3D cur;

--=-=-=



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
