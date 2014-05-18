From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH] osd: speedup startup by finishing pending removals in background
Date: Sun, 18 May 2014 09:54:45 -0300
Message-ID: <oregzrxn56.fsf@free.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:45693 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaERNDE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 May 2014 09:03:04 -0400
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id s4ID31vc030229
	for <ceph-devel@vger.kernel.org>; Sun, 18 May 2014 13:03:02 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch applies on top of the one I just posted, Subject =E2=80=9Cos=
d: avoid
flushing every TEMP removal to speedup startup=E2=80=9D.

When PG removals are underway and the OSD is restarted, or when
multiple removals are scheduled manually with ceph_filestore_dump
premove, the OSD may take a long time to process all pending removals
before it will join the cluster.

This patch introduces an option that enables the OSD to join the
cluster first, performing the removals in background while actively
participating in the cluster, as the OSD would if it hadn't been
restarted.

In hindsight, I suppose it might have been wiser to add a data member t=
o
DeletingStateRef to hold the coll_t, instead of having to search for it
again, but this patch is what I tested, and it's likely good enough for
now.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/common/config_opts.h |   10 ++++++
 src/osd/OSD.cc           |   75 ++++++++++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index 2c65e6c..9baa356 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -583,6 +583,16 @@ OPTION(osd_client_op_priority, OPT_U32, 63)
 OPTION(osd_recovery_op_priority, OPT_U32, 10)
 OPTION(osd_recovery_op_warn_multiple, OPT_U32, 16)
=20
+// Removal of PGs is done in background, but if the osd is restarted,
+// it will finish all pending removals before joining the cluster.
+// This can take a while.  If this option is set to true, then pending
+// removals will be performed in background, while the osd runs
+// normally.  This is a bit dangerous if the OSD gets a new copy of
+// the PG before the pending removal is completed: attributes stored
+// in the leveldb may be lost when removal cleans up an object's
+// attributes AFTER the new object is backfilled.
+OPTION(osd_startup_finish_remove_in_background, OPT_BOOL, false)
+
 // Max time to wait between notifying mon of shutdown and shutting dow=
n
 OPTION(osd_mon_shutdown_timeout, OPT_DOUBLE, 5)
=20
diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 504cb71..a6d58c1 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -1924,6 +1924,15 @@ OSD::res_result OSD::_try_resurrect_pg(
   if (!df)
     return RES_NONE; // good to go
=20
+  // If we're background deleting a pg scheduled for removal in an
+  // earlier session, this will be NULL.  We can't resurrect this one,
+  // nor should we create a new PG with the same pgid, so we'll fail
+  // this assert and let the user restart the osd without
+  // osd_startup_finish_remove_in_background, so that removal is
+  // completed before the osd gets a chance to try to create or
+  // resurrect the PG.
+  assert(df->old_pg_state);
+
   df->old_pg_state->lock();
   OSDMapRef create_map =3D df->old_pg_state->get_osdmap();
   df->old_pg_state->unlock();
@@ -2048,6 +2057,7 @@ void OSD::load_pgs()
=20
   set<spg_t> head_pgs;
   map<spg_t, interval_set<snapid_t> > pgs;
+  map<uint64_t, spg_t> *bgremove =3D NULL;
   bool flush =3D false;
   for (vector<coll_t>::iterator it =3D ls.begin();
        it !=3D ls.end();
@@ -2056,14 +2066,30 @@ void OSD::load_pgs()
     snapid_t snap;
     uint64_t seq;
=20
-    if (it->is_temp(pgid) ||
-	it->is_removal(&seq, &pgid)) {
-      dout(10) << "load_pgs " << *it << " clearing temp" << dendl;
+    if (it->is_temp(pgid)) {
+      dout(10) << "load_pgs " << *it << " clearing temp " << dendl;
       recursive_remove_collection(store, *it, false);
       flush =3D true;
       continue;
     }
=20
+    if (it->is_removal(&seq, &pgid)) {
+      if (cct->_conf->osd_startup_finish_remove_in_background) {
+	dout(10) << "load_pgs " << *it
+		 << " delaying pending removal" << dendl;
+	if (seq >=3D next_removal_seq)
+	  next_removal_seq =3D seq + 1;
+	if (!bgremove)
+	  bgremove =3D new map<uint64_t, spg_t>();
+	(*bgremove)[seq] =3D pgid;
+      } else {
+	dout(10) << "load_pgs " << *it << " clearing pending removal " << den=
dl;
+	recursive_remove_collection(store, *it, false);
+	flush =3D true;
+      }
+      continue;
+    }
+
     if (it->is_pg(pgid, snap)) {
       if (snap !=3D CEPH_NOSNAP) {
 	dout(10) << "load_pgs skipping snapped dir " << *it
@@ -2081,6 +2107,18 @@ void OSD::load_pgs()
   if (flush)
     store->sync_and_flush();
=20
+  if (bgremove) {
+    for (map<uint64_t, spg_t>::iterator it =3D bgremove->begin();
+	 it !=3D bgremove->end(); it++) {
+      dout(10) << "load_pgs FORREMOVAL_" << it->first << "_" << it->se=
cond
+	       << " scheduling background removal " << dendl;
+      DeletingStateRef deleting =3D service.deleting_pgs.lookup_or_cre=
ate
+	(it->second, make_pair(it->second, PGRef(0)));
+      remove_wq.queue(make_pair(PGRef(0), deleting));
+    }
+    delete bgremove;
+  }
+
   bool has_upgraded =3D false;
   for (map<spg_t, interval_set<snapid_t> >::iterator i =3D pgs.begin()=
;
        i !=3D pgs.end();
@@ -3520,6 +3558,37 @@ void OSD::RemoveWQ::_process(
   ThreadPool::TPHandle &handle)
 {
   PGRef pg(item.first);
+
+  if (!pg) {
+    // this is for background live removal of pending FORREMOVAL pgs,
+    // remaining from earlier OSD sessions.  This only happens if
+    // osd_startup_finish_remove_in_background is enabled.
+    if (!item.second->start_clearing())
+      return;
+
+    if (!item.second->start_deleting())
+      return;
+
+    vector<coll_t> ls;
+    int r =3D store->list_collections(ls);
+    assert (!(r < 0));
+
+    for (vector<coll_t>::iterator it =3D ls.begin();
+	 it !=3D ls.end();
+	 ++it) {
+      spg_t pgid;
+      uint64_t seq;
+
+      if (it->is_removal(&seq, &pgid) && pgid =3D=3D item.second->pgid=
) {
+	recursive_remove_collection(store, *it, false);
+	break;
+      }
+    }
+
+    item.second->finish_deleting();
+    return;
+  }
+
   SnapMapper &mapper =3D pg->snap_mapper;
   OSDriver &driver =3D pg->osdriver;
   coll_t coll =3D coll_t(pg->info.pgid);


--=20
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
=46ree Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
