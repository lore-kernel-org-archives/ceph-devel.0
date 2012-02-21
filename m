From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: [PATCH] Add old_inodes to emetablob
Date: Tue, 21 Feb 2012 07:22:01 -0200
Message-ID: <orboos1qyu.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:40549 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755665Ab2BVWH3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Feb 2012 17:07:29 -0500
Received: from freie.oliva.athome.lsd.ic.unicamp.br (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q1MM7Hr4002460
	for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 20:07:23 -0200
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q1L9M2Ck019319
	for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 07:22:02 -0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This was supposed to fix bug 1946, and likely bug 1849 too, but it looks
like something's still missing for a complete fix.  fuse-unmounting
between touching a dir and creating a snapshot seems to help get correct
snapshot timestamp, but touching the dir after remounting and restarting
the mds shortly afterwards very often results in the wrong timestamp for
the snapshot.

8<-----

Add information about old inodes to the mds journal.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/mds/events/EMetaBlob.h |   32 +++++++++++++++++++++++++-------
 src/mds/journal.cc         |    2 ++
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
index e03f147..747bff3 100644
--- a/src/mds/events/EMetaBlob.h
+++ b/src/mds/events/EMetaBlob.h
@@ -68,6 +68,8 @@ public:
     bufferlist snapbl;
     bool dirty;
     struct default_file_layout *dir_layout;
+    typedef map<snapid_t, old_inode_t> old_inodes_t;
+    old_inodes_t *old_inodes;
 
     bufferlist _enc;
 
@@ -77,10 +79,11 @@ public:
     fullbit(const string& d, snapid_t df, snapid_t dl, 
 	    version_t v, inode_t& i, fragtree_t &dft, 
 	    map<string,bufferptr> &xa, const string& sym,
-	    bufferlist &sbl, bool dr, default_file_layout *defl = NULL) :
+	    bufferlist &sbl, bool dr, default_file_layout *defl = NULL,
+	    old_inodes_t *oi = NULL) :
       //dn(d), dnfirst(df), dnlast(dl), dnv(v), 
       //inode(i), dirfragtree(dft), xattrs(xa), symlink(sym), snapbl(sbl), dirty(dr) 
-      dir_layout(NULL), _enc(1024)
+      dir_layout(NULL), old_inodes(NULL), _enc(1024)
     {
       ::encode(d, _enc);
       ::encode(df, _enc);
@@ -98,15 +101,21 @@ public:
 	  ::encode(*defl, _enc);
       }
       ::encode(dr, _enc);      
+      ::encode(oi ? true : false, _enc);
+      if (oi)
+	::encode(*oi, _enc);
     }
-    fullbit(bufferlist::iterator &p) : dir_layout(NULL) { decode(p); }
-    fullbit() : dir_layout(NULL) {}
+    fullbit(bufferlist::iterator &p) : dir_layout(NULL), old_inodes(NULL) {
+      decode(p);
+    }
+    fullbit() : dir_layout(NULL), old_inodes(NULL) {}
     ~fullbit() {
+      delete old_inodes;
       delete dir_layout;
     }
 
     void encode(bufferlist& bl) const {
-      __u8 struct_v = 2;
+      __u8 struct_v = 3;
       ::encode(struct_v, bl);
       assert(_enc.length());
       bl.append(_enc); 
@@ -135,6 +144,14 @@ public:
 	}
       }
       ::decode(dirty, bl);
+      if (struct_v >= 3) {
+	bool old_inodes_present;
+	::decode(old_inodes_present, bl);
+	if (old_inodes_present) {
+	  old_inodes = new old_inodes_t;
+	  ::decode(*old_inodes, bl);
+	}
+      }
     }
 
     void update_inode(MDS *mds, CInode *in);
@@ -562,7 +579,8 @@ private:
 									 *pi, in->dirfragtree,
 									 *in->get_projected_xattrs(),
 									 in->symlink, snapbl,
-									 dirty, default_layout)));
+									 dirty, default_layout,
+									 &in->old_inodes)));
     if (pi)
       lump.get_dfull().back()->inode = *pi;
     return &lump.get_dfull().back()->inode;
@@ -614,7 +632,7 @@ private:
 		       0,
 		       *pi, *pdft, *px,
 		       in->symlink, snapbl,
-		       dirty, default_layout);
+		       dirty, default_layout, &in->old_inodes);
     return &root->inode;
   }
   
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index 5f74bbb..fd45213 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -416,6 +416,8 @@ void EMetaBlob::fullbit::update_inode(MDS *mds, CInode *in)
   } else if (in->inode.is_symlink()) {
     in->symlink = symlink;
   }
+  if (old_inodes)
+    in->old_inodes = *old_inodes;
 }
 
 void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
-- 
1.7.7.6

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
