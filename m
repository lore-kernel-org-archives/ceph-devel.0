From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH] mds: drop unused find_ino_dir
Date: Tue, 17 Dec 2013 09:00:00 -0200
Message-ID: <orppovagjz.fsf@livre.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:47201 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab3LQLBF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 06:01:05 -0500
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id rBHB13tw009954
	for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 11:01:04 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--=-=-=

I was looking at inconsistencies in xattrs in my OSDs, and found out
that only old dirs had the user.ceph.path attribute set.  Trying to
figure out what this was about, I noticed the code that set this
attribute was still present, but it was not called anywhere.  I decided
to clean up the attribute from my cluster, and to wipe out the code that
used to set it.  Here's the resulting patch.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=drop-find-ino-dir.patch

mds: drop unused find_ino_dir

From: Alexandre Oliva <oliva@gnu.org>

Remove all traces of find_ino_dir, it is no longer used.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/mds/MDCache.cc |   51 ---------------------------------------------------
 src/mds/MDCache.h  |    9 ---------
 2 files changed, 60 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index ae59c26..7eba644 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -8502,57 +8502,6 @@ void MDCache::kick_find_ino_peers(int who)
 
 /* ---------------------------- */
 
-struct C_MDS_FindInoDir : public Context {
-  MDCache *mdcache;
-  inodeno_t ino;
-  Context *fin;
-  bufferlist bl;
-  C_MDS_FindInoDir(MDCache *m, inodeno_t i, Context *f) : mdcache(m), ino(i), fin(f) {}
-  void finish(int r) {
-    mdcache->_find_ino_dir(ino, fin, bl, r);
-  }
-};
-
-void MDCache::find_ino_dir(inodeno_t ino, Context *fin)
-{
-  dout(10) << "find_ino_dir " << ino << dendl;
-  assert(!have_inode(ino));
-
-  // get the backtrace from the dir
-  object_t oid = CInode::get_object_name(ino, frag_t(), "");
-  object_locator_t oloc(mds->mdsmap->get_metadata_pool());
-  
-  C_MDS_FindInoDir *c = new C_MDS_FindInoDir(this, ino, fin);
-  mds->objecter->getxattr(oid, oloc, "path", CEPH_NOSNAP, &c->bl, 0, c);
-}
-
-void MDCache::_find_ino_dir(inodeno_t ino, Context *fin, bufferlist& bl, int r)
-{
-  dout(10) << "_find_ino_dir " << ino << " got " << r << " " << bl.length() << " bytes" << dendl;
-  if (r < 0) {
-    fin->complete(r);
-    return;
-  }
-
-  string s(bl.c_str(), bl.length());
-  filepath path(s.c_str());
-  vector<CDentry*> trace;
-
-  dout(10) << "_find_ino_dir traversing to path " << path << dendl;
-
-  C_MDS_FindInoDir *c = new C_MDS_FindInoDir(this, ino, fin);
-  c->bl = bl;
-  r = path_traverse(NULL, NULL, c, path, &trace, NULL, MDS_TRAVERSE_DISCOVER);
-  if (r > 0)
-    return;
-  delete c;  // path_traverse doesn't clean it up for us for r <= 0
-  
-  fin->complete(r);
-}
-
-
-/* ---------------------------- */
-
 int MDCache::get_num_client_requests()
 {
   int count = 0;
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index 87b1098..415b049 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -840,15 +840,6 @@ public:
   void handle_find_ino_reply(MMDSFindInoReply *m);
   void kick_find_ino_peers(int who);
 
-  // -- find_ino_dir --
-  struct find_ino_dir_info_t {
-    inodeno_t ino;
-    Context *fin;
-  };
-
-  void find_ino_dir(inodeno_t ino, Context *c);
-  void _find_ino_dir(inodeno_t ino, Context *c, bufferlist& bl, int r);
-
   // -- anchors --
 public:
   void anchor_create_prep_locks(MDRequest *mdr, CInode *in, set<SimpleLock*>& rdlocks,

--=-=-=


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
