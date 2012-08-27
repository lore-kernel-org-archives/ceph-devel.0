From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: [PATCH] Add old_inodes to emetablob
Date: Mon, 27 Aug 2012 13:23:07 -0300
Message-ID: <orehmss3ro.fsf@livre.localdomain>
References: <orboos1qyu.fsf@livre.localdomain>
	<Pine.LNX.4.64.1202222159060.27988@cobra.newdream.net>
	<ork43bbbbb.fsf@livre.localdomain>
	<Pine.LNX.4.64.1203031551560.11992@cobra.newdream.net>
	<ora9xsbm9w.fsf@livre.localdomain> <orzk5ra8m9.fsf@livre.localdomain>
	<alpine.DEB.2.00.1208191415240.26858@cobra.newdream.net>
	<alpine.DEB.2.00.1208191422110.26858@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:41032 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751063Ab2H0QXX convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 27 Aug 2012 12:23:23 -0400
In-Reply-To: <alpine.DEB.2.00.1208191422110.26858@cobra.newdream.net> (Sage
	Weil's message of "Sun, 19 Aug 2012 14:22:24 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Aug 19, 2012, Sage Weil <sage@inktank.com> wrote:

> This might do the trick?

> diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc

>           in->old_inodes.swap(old_inodes);
> +         if (!in->old_inodes.empty())
> +           in->first =3D in->old_inodes.rbegin()->first + 1;
>           if (snaps)

At first, it didn't.  I had to install/keep a few additional patches to
avoid =E2=80=9Ccorruption=E2=80=9D of old snapshots.  Later on, I guess=
 all =E2=80=9Cfirst=E2=80=9D
fields in the journal were corrected, and then I didn't get the warning=
s
added by my patches any more.  So it may be that your patch is enough,
after all, but this is the patchset I've used over the past week, with =
a
very little bit of snapshot creation.

Unfortunately, modifying snapshotted directories, particularly mass
removal of subtrees, is still triggering some serious issues in the mds
(crashes, infinite loops, unrecoverable clusters, all sorts of fun
stuff :-), but I'm yet to look into that.


mds: update cached first along with old_inodes

When fetching a directory, make sure first is greater than the fetched
old_inodes.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Suggested-by: Sage Weil <sage@inktank.com>
---
 src/mds/CDir.cc |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 6761c6f..71ef03a 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -1564,6 +1564,11 @@ void CDir::_fetched(bufferlist &bl, const string=
& want_dn)
 	  in->xattrs.swap(xattrs);
 	  in->decode_snap_blob(snapbl);
 	  in->old_inodes.swap(old_inodes);
+	  if (!in->old_inodes.empty()) {
+	    snapid_t newfirst =3D in->old_inodes.rbegin()->first + 1;
+	    if (newfirst > in->first)
+	      in->first =3D newfirst;
+	  }
 	  if (snaps)
 	    in->purge_stale_snap_data(*snaps);
=20
--=20
1.7.7.6


mds: Don't modify already-created old_inode

In cow_old_inode, do not modify an old_inode that was created before.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/mds/CInode.cc |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 53f9e69..d17fd26 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -2030,12 +2030,18 @@ old_inode_t& CInode::cow_old_inode(snapid_t fol=
lows, bool cow_head)
   inode_t *pi =3D cow_head ? get_projected_inode() : get_previous_proj=
ected_inode();
   map<string,bufferptr> *px =3D cow_head ? get_projected_xattrs() : ge=
t_previous_projected_xattrs();
=20
+  bool found =3D old_inodes.find(follows) !=3D old_inodes.end();
   old_inode_t &old =3D old_inodes[follows];
-  old.first =3D first;
-  old.inode =3D *pi;
-  old.xattrs =3D *px;
- =20
-  dout(10) << " " << px->size() << " xattrs cowed, " << *px << dendl;
+
+  if (!found) {
+    old.first =3D first;
+    old.inode =3D *pi;
+    old.xattrs =3D *px;
+
+    dout(10) << " " << px->size() << " xattrs cowed, " << *px << dendl=
;
+  } else
+    dout(0) << "cow_old_inode not modifying existing old_inode " << fi=
rst
+	    << " for " << follows << " on " << *this << dendl;
=20
   old.inode.trim_client_ranges(follows);
=20
--=20
1.7.7.6


mds: warn when first is lower than latest old_inode

Warn in cow_old_inode if first is out of date WRT old_inodes.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/mds/CInode.cc |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index d17fd26..f1be8e4 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -2027,6 +2027,11 @@ old_inode_t& CInode::cow_old_inode(snapid_t foll=
ows, bool cow_head)
 {
   assert(follows >=3D first);
=20
+  if (!old_inodes.empty() && first <=3D old_inodes.rbegin()->first) {
+    dout(0) << "cow_old_inode " << " first " << first << " but already=
 had "
+	    << old_inodes.rbegin()->first << " on " << *this << dendl;
+  }
+
   inode_t *pi =3D cow_head ? get_projected_inode() : get_previous_proj=
ected_inode();
   map<string,bufferptr> *px =3D cow_head ? get_projected_xattrs() : ge=
t_previous_projected_xattrs();
=20
--=20
1.7.7.6



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
