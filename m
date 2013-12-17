From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH] mds: handle setxattr ceph.parent
Date: Tue, 17 Dec 2013 09:25:39 -0200
Message-ID: <oriounafd8.fsf@livre.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:47242 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab3LQL0V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 06:26:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zheng.z.yan@intel.com>

--=-=-=

This is a (probably half-baked) solution for the problem of cephfs
clusters encountering recovery problems when clients are accessing files
that don't have a parent attribute.  It enables clients to request the
parent attribute to be updated right away, by a simple setxattr call:

# setfattr -n ceph.parent /cephfs/mount/path/name

I had to relax the assert because there's no reason I can think of to
force the object and its parent dirty just to set this internal
bookkeeping xattr.  The operation is not journaled, as it takes effect
immediately.  Although there's no assurance that the operation is
completed before success is returned, my tests indicate that running
rados getxattr right after setfattr already gets an attribute, for
objects that had been created before the introduction of the parent
attribute.

I realize Zheng Yan posted a patch that would mark for update missing or
too-old parent attributes on the fly, when inodes were brought into the
cache, so that the parent attribute would be updated when the inodes
were to be expired from the MDS log.  I had mds running with that patch
for a while, and I even explicitly touched and linked files and dirs
that were missing the parent attribute; many, but not all of the files
and dirs got the attribute, and I'm having some difficulties getting it
to work on the remaining ones, in part because it takes so long to take
effect (as in, perform an operation, then wait for several hours until
the then-current MDS log segment gets expired, then check whether the
attribute was set).  This patch causes the parent attribute to be set
right away.

I'm not sure this immediate behavior would be appropriate for use in
production (as in, I'm not sure creating an inode and trying to set the
parent attribute might cause a failure because the inode object isn't
there yet by the time we try to set an attribute on it), but it should
be ok for retrofitting ancient inode objects so that they don't cause
recovery problems due to the lack of the parent xattr.

BTW, Zheng Yan, thanks for the patch that fixed mds readdir with dirs
ending in remote (hard) links; this one had annoyed me for a long time,
and I was just about to start actually digging into it when I saw the
0.73 announcement that mentioned what appeared to be a fix for the
problem I was running into, and indeed, it was.  I merged it into my
0.72.1 build and it's been working great!


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=mds-ceph-parent-setxattr.patch

mds: handle setxattr ceph.parent

From: Alexandre Oliva <oliva@gnu.org>

Enable clients to setxattr ceph.parent to update the parent xattr.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/mds/CInode.cc |    2 +-
 src/mds/Server.cc |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 1fc57fe..7c692d4 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -1009,7 +1009,7 @@ struct C_Inode_StoredBacktrace : public Context {
 void CInode::store_backtrace(Context *fin)
 {
   dout(10) << "store_backtrace on " << *this << dendl;
-  assert(is_dirty_parent());
+  assert(!fin || is_dirty_parent());
 
   auth_pin(this);
 
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 6bb3aef..2afb6d7 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -3615,6 +3615,11 @@ void Server::handle_set_vxattr(MDRequest *mdr, CInode *cur,
     journal_and_reply(mdr, cur, 0, le, new C_MDS_inode_update_finish(mds, mdr, cur));
     return;
   }
+  else if (name == "ceph.parent" && value == "") {
+    cur->store_backtrace(NULL);
+    reply_request(mdr, 0);
+    return;
+  }
 
   dout(10) << " unknown vxattr " << name << dendl;
   reply_request(mdr, -EINVAL);

--=-=-=


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
