From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] reinstate ceph cluster_snap support
Date: Mon, 03 Nov 2014 17:57:06 -0200
Message-ID: <or4mug12i5.fsf@free.home>
References: <orob8qt7kf.fsf@livre.home>
	<alpine.DEB.2.00.1308231715500.28981@cobra.newdream.net>
	<ortxifi1cs.fsf@livre.home>
	<alpine.DEB.2.00.1308271515500.24783@cobra.newdream.net>
	<orbnp6uofj.fsf@free.home>
	<alpine.DEB.2.00.1410271357160.15740@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:37196 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbaKCT5W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Nov 2014 14:57:22 -0500
In-Reply-To: <alpine.DEB.2.00.1410271357160.15740@cobra.newdream.net> (Sage
	Weil's message of "Mon, 27 Oct 2014 14:00:57 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: sam.just@inktank.com, ceph-devel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Oct 27, 2014, Sage Weil <sage@newdream.net> wrote:

> On Tue, 21 Oct 2014, Alexandre Oliva wrote:

>> I have tested both methods: btrfs snapshotting of store.db (I've
>> manually turned store.db into a btrfs subvolume), and creating a new db
>> with all (prefix,key,value) triples.  I'm undecided about inserting
>> multiple transaction commits for the latter case; the mon mem use grew
>> up a lot as it was, and in a few tests the snapshotting ran twice, but
>> in the end a dump of all the data in the database created by btrfs
>> snapshotting was identical to that created by explicit copying.  So, the
>> former is preferred, since it's so incredibly more efficient.  I also
>> considered hardlinking all files in store.db into a separate tree, but I
>> didn't like the idea of coding that in C+-, :-) and I figured it might
>> not work with other db backends, and maybe even not be guaranteed to
>> work with leveldb.  It's probably not worth much more effort.

> This looks pretty reasonable!

> I think we definitely need to limit the size of the transaction when doin=
g=20
> the snap.  The attached patch seems to try to do it all in one go, which=
=20
> is not going to work for large clusters.  Either re-use an existing=20
> tunable like the sync chunk size or add a new one?

Ok, I changed it so that it reuses the same tunable used for mon sync
transaction sizes.  Tested on top of 0.87 (flawless upgrade, whee!),
with both btrfs snapshots and leveldb copying.  I noticed slight
differences between the databases at each mon with the leveldb copying,
presumably having to do with at least one round of monitor-internal
retrying as the first copy in each mon took too long, but each copy
appeared to be consistent, and their aggregate is presumably usable to
get the cluster rolled back to an earlier consistent state.

I wish there was a better way to avoid the retry; though.  I'm thinking
maybe not performing the copy when the snapshot dir already exists (like
we do for osd snapshots), but I'm not sure this would guarantee a
consistent monitor quorum snapshot.  But then, I'm not sure the current
approach does either.  Plus, if we were to fail because the dir already
existed, we'd need to somehow collect the success/fail status of the
first try so that we don't misreport a failure just because the internal
retry failed, and then, we'd need to distinguish an internal retry that
ought to pass if the first attempt passed from a user-commanded attempt
to created a new snapshot with the same name, which should ideally fail
if any cluster component fails to take the snapshot.  Not that we
currently send any success/failure status back...

Thoughts?


If we stick with re-copying (rather than dropping the request on the
floor if the dir exists), I might improve the overwriting from =E2=80=9Crem=
ove
all entries, then add them all back=E2=80=9D to =E2=80=9Ccompare entries in=
 source and
destination, and copy only those that changed=E2=80=9D.  I have code to do =
just
that, that I could borrow from a leveldbcmp programlet I wrote, but it
would take some significant rewriting to refit it into the KeyValueDB
interface, so I didn't jump through this hoop.  Let me know if it is
desirable, and I'll try to schedule some time to work on it.

Another issue I'm somewhat unhappy about is that, while we perform the
copying (which can take a few tens of seconds), the cluster comes to a
halt because the mons won't make progress.  I wish we could do this
copying in background, but I have no clue as to how to go about making
the operation proceed asynchronously while returning a success at the
end, rather than, say, because we successfully *started* the copying.  I
could use a clue or two to do better than that ;-)


Another nit I'm slightly unhappy about is that the command is still
=E2=80=9Cceph osd cluster_snap <tag>=E2=80=9D, whereas it now snapshots mon=
s too, and it
creates directories named clustersnap_<tag>, without the underscore
separating cluster and snap as in the command.  I'd like to spell them
out the same.  Any preferences?


Here's the patch I've tested, that currently builds upon the other patch
upthread, that reinstates osd snapshotting.



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
 src/mon/Monitor.cc       |   11 ++++
 src/mon/Monitor.h        |    2 +
 src/mon/MonitorDBStore.h |  125 +++++++++++++++++++++++++++++++++++++++++++---
 src/mon/OSDMonitor.cc    |    5 +-
 4 files changed, 135 insertions(+), 8 deletions(-)

diff --git a/src/mon/Monitor.cc b/src/mon/Monitor.cc
index 52df6f0..bbdb5b2 100644
--- a/src/mon/Monitor.cc
+++ b/src/mon/Monitor.cc
@@ -4094,6 +4094,17 @@ void Monitor::scrub_reset()
 
 
 
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
index 91c524a..bc54e27 100644
--- a/src/mon/Monitor.h
+++ b/src/mon/Monitor.h
@@ -836,6 +836,8 @@ public:
 
   void handle_signal(int sig);
 
+  int store_snapshot(const string& name);
+
   int mkfs(bufferlist& osdmapbl);
 
   /**
diff --git a/src/mon/MonitorDBStore.h b/src/mon/MonitorDBStore.h
index a0c82b7..3c170cb 100644
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
@@ -600,9 +608,112 @@ class MonitorDBStore
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
+	  int const txsize = g_conf->mon_sync_max_payload_size;
+	  int left = txsize;
+	  KeyValueDB::Transaction dbt = snapdb->get_transaction();
+	  KeyValueDB::WholeSpaceIterator it = snapdb->get_iterator();
+	  for (it->seek_to_first(); it->valid(); it->next()) {
+	    pair<string,string> k = it->raw_key();
+
+	    int thissize = 10 + k.first.length() + k.second.length();
+	    if (left < thissize) {
+	      r = snapdb->submit_transaction(dbt);
+	      if (r)
+		break;
+	      dbt = snapdb->get_transaction();
+	      if (!dbt)
+		break;
+	      left = txsize;
+	    }
+
+	    dbt->rmkey(k.first, k.second);
+	    left -= thissize;
+	  }
+	  if (!r && dbt) {
+	    it = db->get_snapshot_iterator();
+	    for (it->seek_to_first(); it->valid(); it->next()) {
+	      pair<string,string> k = it->raw_key();
+
+	      int thissize = 10 + k.first.length() + k.second.length() +
+		it->value().length();
+	      if (left < thissize) {
+		r = snapdb->submit_transaction(dbt);
+		if (r)
+		  break;
+		dbt = snapdb->get_transaction();
+		if (!dbt)
+		  break;
+		left = txsize;
+	      }
+
+	      dbt->set(k.first, k.second, it->value());
+	      left -= thissize;
+	    }
+
+	    if (!r && dbt)
+	      r = snapdb->submit_transaction_sync(dbt);
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



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer

--=-=-=--
