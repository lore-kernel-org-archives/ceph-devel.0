From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Preserve dir default_file_layout in encoded inode
Date: Thu, 16 Aug 2012 02:34:57 -0300
Message-ID: <orr4r7tn5q.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:41484 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751457Ab2HPFfJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Aug 2012 01:35:09 -0400
Received: from freie (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q7G5Z4VT018564
	for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 02:35:04 -0300
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie (8.14.5/8.14.5) with ESMTP id q7G5Z3Pf026892
	for <ceph-devel@vger.kernel.org>; Thu, 16 Aug 2012 02:35:03 -0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Store dir layouts not only in the journal, but also in inode
information for the directory, so that they aren't dropped on the
floor when dirs are evicted from the MDS cache and dropped from the
journal.  Also restore dir layouts when fetching dirs back into the
MDS cache.

This is supposed to fix for bug 1435, except that it doesn't look like
a layout change to a directory will trigger a commit of the new layout
if the directory is not otherwise modified before the change is
evicted from the cache and the journal.  This can be sorted out in a
separate patch.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/mds/CDir.cc  |   16 +++++++++++++++-
 src/mds/CInode.h |    9 +++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 6761c6f..df19252 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -1552,8 +1552,16 @@ void CDir::_fetched(bufferlist &bl, const string& want_dn)
 	    << " already exists at " << inopath << "\n";
 	  continue;
 	} else {
+	  ceph_file_layout unset_fl = ceph_file_layout(), *fl;
+
+	  if (inode.is_dir ()
+	      && memcmp (&inode.layout, &unset_fl, sizeof (unset_fl)) != 0)
+	    fl = &inode.layout;
+	  else
+	    fl = NULL;
+
 	  // inode
-	  in = new CInode(cache, true, first, last);
+	  in = new CInode(cache, true, first, last, fl);
 	  in->inode = inode;
 	  
 	  // symlink?
@@ -1845,6 +1853,12 @@ void CDir::_encode_dentry(CDentry *dn, bufferlist& bl,
     
     dout(14) << " pos " << bl.length() << " dn '" << dn->name << "' inode " << *in << dendl;
     
+    ceph_file_layout *fl = in->get_projected_dir_layout ();
+    if (fl)
+      in->inode.layout = *fl;
+    else
+      memset (&in->inode.layout, 0, sizeof (in->inode.layout));
+
     // marker, name, inode, [symlink string]
     bl.append('I');         // inode
     ::encode(in->inode, bl);
diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index 57c76c4..8b42f6f 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -71,6 +71,9 @@ struct default_file_layout {
 
   ceph_file_layout layout;
 
+  default_file_layout() {};
+  default_file_layout(ceph_file_layout l) : layout(l) {};
+
   void encode(bufferlist &bl) const {
     __u8 struct_v = 1;
     ::encode(struct_v, bl);
@@ -458,12 +461,13 @@ private:
 
  public:
   // ---------------------------
-  CInode(MDCache *c, bool auth=true, snapid_t f=2, snapid_t l=CEPH_NOSNAP) : 
+  CInode(MDCache *c, bool auth=true, snapid_t f=2, snapid_t l=CEPH_NOSNAP,
+	 ceph_file_layout *dl = NULL) : 
     mdcache(c),
     snaprealm(0), containing_realm(0),
     first(f), last(l),
     last_journaled(0), //last_open_journaled(0), 
-    default_layout(NULL),
+    default_layout(dl ? new default_file_layout (*dl) : NULL),
     //hack_accessed(true),
     stickydir_ref(0),
     parent(0),
@@ -498,6 +502,7 @@ private:
     g_num_inos++;
     close_dirfrags();
     close_snaprealm();
+    delete default_layout;
   }
   
 
-- 
1.7.7.6


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
