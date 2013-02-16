From: Alexandre Oliva <oliva@gnu.org>
Subject: mds crashes upon access to some snapshotted files
Date: Sat, 16 Feb 2013 10:56:38 -0200
Message-ID: <ortxpcs9h5.fsf@livre.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:59116 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068Ab3BPM5D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 07:57:03 -0500
Received: from freie (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r1GCv0vG007511
	for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 12:57:01 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--=-=-=

I suppose this might be the result of some filesystem corruption, but I
have some files in my ceph tree that, when accessed, crash the mds.

The files are in subdirectories of dirs snapshotted numerous times, some
very recently, some long ago.  All but the most recent snapshots have
been removed, though.  Anyway, I'm not accessing them through the
snapshot (i.e., not as subdir/.snap/_snapname_inode/filename, but as
subdir/filename).

I've had this problem for quite a long time, and I couldn't quite figure
out what's special about the files, the directories holding them, or
what.  I suspect some corruption from old releases of ceph, that might
or might not still be possible to create with a newer release.

Anyway, long ago I found out this patch would work around the problem,
enabling me to access the files just fine, apparently without any other
bad consequences.

Does it make sense to put it in the upcoming stable release?

Any ideas of what to do to find out why I need this patch, and/or what I
could do to not need this patch any more?

Thanks,


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=mds-snap-missing-oldparent.patch

mds: don't crash when missing oldparent

From: Alexandre Oliva <oliva@gnu.org>

If we can't find oldparent, skip creating the snapshot.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/mds/snap.cc |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mds/snap.cc b/src/mds/snap.cc
index fa434b7..5c104db 100644
--- a/src/mds/snap.cc
+++ b/src/mds/snap.cc
@@ -170,7 +170,8 @@ void SnapRealm::build_snap_set(set<snapid_t> &s,
        p != srnode.past_parents.end() && p->first >= first && p->second.first <= last;
        p++) {
     CInode *oldparent = mdcache->get_inode(p->second.ino);
-    assert(oldparent);  // call open_parents first!
+    if (!oldparent)
+      continue;
     assert(oldparent->snaprealm);
     oldparent->snaprealm->build_snap_set(s, max_seq, max_last_created, max_last_destroyed,
 					 MAX(first, p->second.first),

--=-=-=


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
