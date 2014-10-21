From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Tue, 21 Oct 2014 00:49:52 -0200
Message-ID: <orbnp6uofj.fsf@free.home>
References: <orob8qt7kf.fsf@livre.home>
	<alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net>
	<ortxifi1cs.fsf@livre.home>
	<alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:38269 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbaJUCus (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Oct 2014 22:50:48 -0400
In-Reply-To: <alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net> (Sage
	Weil's message of "Tue, 27 Aug 2013 15:21:52 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: sam.just@inktank.com, ceph-devel@vger.kernel.org

--=-=-=

On Aug 27, 2013, Sage Weil <sage@inktank.com> wrote:

> Finally, eventually we should make this do a checkpoint on the mons too.  
> We can add the osd snapping back in first, but before this can/should 
> really be used the mons need to be snapshotted as well.  Probably that's 
> just adding in a snapshot() method to MonitorStore.h and doing either a 
> leveldb snap or making a full copy of store.db... I forget what leveldb is 
> capable of here.

I suppose it might be a bit too late for Giant, but I finally got 'round
to implementing this.  I attach the patch that implements it, to be
applied on top of the updated version of the patch I posted before, also
attached.

I have a backport to Firefly too, if there's interest.

I have tested both methods: btrfs snapshotting of store.db (I've
manually turned store.db into a btrfs subvolume), and creating a new db
with all (prefix,key,value) triples.  I'm undecided about inserting
multiple transaction commits for the latter case; the mon mem use grew
up a lot as it was, and in a few tests the snapshotting ran twice, but
in the end a dump of all the data in the database created by btrfs
snapshotting was identical to that created by explicit copying.  So, the
former is preferred, since it's so incredibly more efficient.  I also
considered hardlinking all files in store.db into a separate tree, but I
didn't like the idea of coding that in C+-, :-) and I figured it might
not work with other db backends, and maybe even not be guaranteed to
work with leveldb.  It's probably not worth much more effort.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=mon-cluster-snap.patch

mon: take mon snapshots

From: Alexandre Oliva <oliva@gnu.org>

Extend the machinery that takes osd snapshots to take mon snapshots
too.  Taking a btrfs snapshot of store.db is the preferred method, but
if that fails, the database is copied one tuple at a time.  Unlike osd
snapshots, existing mon snapshots are clobbered by the new snapshots,
mainly because a mon may attempt to take the same snapshot multiple
times, especially if a first attempt takes very long.  It shouldn't be
a problem: the most important property is that the osd snapshots are
taken before the updated osdmap is integrated, whereas the mon
snapshots are taken after that, so that osd snapshots happen-before
mon ones, otherwise in case of rollback osds might have an osdmap that
mons don't know about.

There's no guarantee that all monitors will be completely up to date
at the time the snapshot is taken.  It might be that monitors that
were lagging behind take the snapshot at a later time, and before they
get all the monitor state of the quorum set at the time of the
snapshot.  So, when rolling back the entire cluster (which would have
to be done by hand, as there's no command to do that for mons), it is
advisable to roll back and bring up all monitors, so that it's likely
that more than one monitor has the complete monitor state to propagate
to others.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/mon/Monitor.cc       |   11 +++++
 src/mon/Monitor.h        |    2 +
 src/mon/MonitorDBStore.h |   97 +++++++++++++++++++++++++++++++++++++++++++---
 src/mon/OSDMonitor.cc    |    5 ++
 4 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/src/mon/Monitor.cc b/src/mon/Monitor.cc
index 1536b2e..dacda09 100644
--- a/src/mon/Monitor.cc
+++ b/src/mon/Monitor.cc
@@ -4025,6 +4025,17 @@ void Monitor::scrub_reset()
 
 
 
+int Monitor::store_snapshot(const string& name) {
+  while (paxos->is_writing() || paxos->is_writing_previous()) {
+    lock.Unlock();
+    store->flush();
+    lock.Lock();
+  }
+
+  return store->snapshot(name);
+}
+
+
 /************ TICK ***************/
 
 class C_Mon_Tick : public Context {
diff --git a/src/mon/Monitor.h b/src/mon/Monitor.h
index 63423f2..6a0bef5 100644
--- a/src/mon/Monitor.h
+++ b/src/mon/Monitor.h
@@ -835,6 +835,8 @@ public:
 
   void handle_signal(int sig);
 
+  int store_snapshot(const string& name);
+
   int mkfs(bufferlist& osdmapbl);
 
   /**
diff --git a/src/mon/MonitorDBStore.h b/src/mon/MonitorDBStore.h
index a0c82b7..bbe0011 100644
--- a/src/mon/MonitorDBStore.h
+++ b/src/mon/MonitorDBStore.h
@@ -27,6 +27,16 @@
 #include "common/Finisher.h"
 #include "common/errno.h"
 
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+
+#ifndef __CYGWIN__
+#include "os/btrfs_ioctl.h"
+#endif
+
 class MonitorDBStore
 {
   boost::scoped_ptr<KeyValueDB> db;
@@ -587,12 +597,10 @@ class MonitorDBStore
     return db->get_estimated_size(extras);
   }
 
-  MonitorDBStore(const string& path)
-    : db(0),
-      do_dump(false),
-      dump_fd(-1),
-      io_work(g_ceph_context, "monstore"),
-      is_open(false) {
+  static string store_path(const string *pathp = NULL,
+			   const string& name = "store.db") {
+    string path = pathp ? *pathp : g_conf->mon_data;
+
     string::const_reverse_iterator rit;
     int pos = 0;
     for (rit = path.rbegin(); rit != path.rend(); ++rit, ++pos) {
@@ -600,9 +608,84 @@ class MonitorDBStore
 	break;
     }
     ostringstream os;
-    os << path.substr(0, path.size() - pos) << "/store.db";
+    os << path.substr(0, path.size() - pos) << "/" << name;
     string full_path = os.str();
 
+    return full_path;
+  }
+
+  int snapshot(const string& name) {
+    int r = -ENOTSUP;
+
+#ifdef BTRFS_IOC_SNAP_CREATE
+    {
+      string snap = store_path(0, name);
+      string store = store_path();
+
+      int mondirfd = ::open(g_conf->mon_data.c_str(), 0);
+      int storefd = ::open(store.c_str(), O_RDONLY);
+
+      if (storefd >= 0 && mondirfd >= 0) {
+	struct btrfs_ioctl_vol_args vol_args;
+	memset(&vol_args, 0, sizeof(vol_args));
+
+	vol_args.fd = storefd;
+	strcpy(vol_args.name, name.c_str());
+	(void) ::ioctl(mondirfd, BTRFS_IOC_SNAP_DESTROY, &vol_args);
+	r = ::ioctl(mondirfd, BTRFS_IOC_SNAP_CREATE, &vol_args);
+      }
+
+      ::close(storefd);
+      ::close(mondirfd);
+    }
+#endif
+
+    if (r) {
+      string snap = store_path (0, name);
+      KeyValueDB* snapdb = KeyValueDB::create(g_ceph_context,
+					      g_conf->mon_keyvaluedb,
+					      snap);
+      if (!snapdb)
+	r = -errno;
+      else {
+	snapdb->init();
+	ostringstream os;
+	r = snapdb->create_and_open(os);
+	if (!r) {
+	  KeyValueDB::Transaction dbt = snapdb->get_transaction();
+	  KeyValueDB::WholeSpaceIterator it = snapdb->get_iterator();
+	  for (it->seek_to_first(); it->valid(); it->next()) {
+	    pair<string,string> k = it->raw_key();
+	    dbt->rmkey(k.first, k.second);
+	  }
+	  r = snapdb->submit_transaction(dbt);
+
+	  if (!r) {
+	    dbt = snapdb->get_transaction();
+	    it = db->get_snapshot_iterator();
+	    for (it->seek_to_first(); it->valid(); it->next()) {
+	      pair<string,string> k = it->raw_key();
+	      dbt->set(k.first, k.second, it->value());
+	    }
+	    r = snapdb->submit_transaction_sync(dbt);
+	  }
+
+	  delete snapdb;
+	}
+      }
+    }
+
+    return r;
+  }
+
+  MonitorDBStore(const string& path)
+    : db(0),
+      do_dump(false),
+      dump_fd(-1),
+      io_work(g_ceph_context, "monstore"),
+      is_open(false) {
+    string full_path = store_path (&path);
+
     KeyValueDB *db_ptr = KeyValueDB::create(g_ceph_context,
 					    g_conf->mon_keyvaluedb,
 					    full_path);
diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
index b237846..068abbe 100644
--- a/src/mon/OSDMonitor.cc
+++ b/src/mon/OSDMonitor.cc
@@ -230,8 +230,11 @@ void OSDMonitor::update_from_paxos(bool *need_bootstrap)
       t->erase("mkfs", "osdmap");
     }
 
-    if (tx_size > g_conf->mon_sync_max_payload_size*2) {
+    if (tx_size > g_conf->mon_sync_max_payload_size*2 ||
+	osdmap.cluster_snapshot_epoch) {
       mon->store->apply_transaction(t);
+      if (osdmap.cluster_snapshot_epoch)
+	mon->store_snapshot("clustersnap_" + osdmap.cluster_snapshot);
       t = MonitorDBStore::TransactionRef();
       tx_size = 0;
     }

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
index d702615..8f468f4 100644
--- a/src/mon/MonCommands.h
+++ b/src/mon/MonCommands.h
@@ -499,8 +499,10 @@ COMMAND("osd set " \
 COMMAND("osd unset " \
 	"name=3Dkey,type=3DCephChoices,strings=3Dpause|noup|nodown|noout|noin|nob=
ackfill|norecover|noscrub|nodeep-scrub|notieragent", \
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
index bfcc09e..b237846 100644
--- a/src/mon/OSDMonitor.cc
+++ b/src/mon/OSDMonitor.cc
@@ -4766,10 +4766,13 @@ bool OSDMonitor::prepare_command_impl(MMonCommand *=
m,
     }
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
index f2f5df5..eb4f246 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -6310,6 +6310,14 @@ void OSD::handle_osd_map(MOSDMap *m)
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
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer

--=-=-=--
