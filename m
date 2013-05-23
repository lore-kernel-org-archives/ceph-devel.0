From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 29/30] mds: open inode by ino
Date: Thu, 23 May 2013 16:06:57 +0800
Message-ID: <1369296418-14871-30-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51311 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757248Ab3EWIN0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:26 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

This patch adds "open-by-ino" helper. It utilizes backtrace to find
inode's path and open the inode. The algorithm looks like:

1. Check MDS peers. If any MDS has the inode in its cache, goto step 6.
2. Fetch backtrace. If backtrace was previously fetched and the same
   backtrace again, return -EIO.
3. Traverse the path in backtrace. If the inode is found, goto step 6;
   if non-auth dirfrag is encountered, goto next step. If fail to find
   the inode in its parent dir, goto step 1.
4. Request MDS peers to traverse the path in backtrace. If the inode
   is found, goto step 6. If MDS peer encounters non-auth dirfrag, it
   stops traversing. If any MDS peer fails to find the inode in its
   parent dir, goto step 1.
5. Use the same algorithm to open the inode's parent. Goto step 3 if
   succeeds; goto step 1 if fails.
6. return the inode's auth MDS ID.

The algorithm has two main assumptions:
1. If an inode is in its auth MDS's cache, its on-disk backtrace
   can be out of date.
2. If an inode is not in any MDS's cache, its on-disk backtrace
   must be up to date.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc              | 421 ++++++++++++++++++++++++++++++++++++++++
 src/mds/MDCache.h               |  40 ++++
 src/mds/MDS.cc                  |  15 +-
 src/mds/MDSMap.h                |   7 +
 src/mds/inode_backtrace.h       |   4 +
 src/messages/MMDSOpenIno.h      |  46 +++++
 src/messages/MMDSOpenInoReply.h |  53 +++++
 src/msg/Message.cc              |   9 +
 src/msg/Message.h               |   2 +
 9 files changed, 591 insertions(+), 6 deletions(-)
 create mode 100644 src/messages/MMDSOpenIno.h
 create mode 100644 src/messages/MMDSOpenInoReply.h

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index cd47786..3ed6bd5 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -79,6 +79,9 @@
 #include "messages/MMDSFindIno.h"
 #include "messages/MMDSFindInoReply.h"
 
+#include "messages/MMDSOpenIno.h"
+#include "messages/MMDSOpenInoReply.h"
+
 #include "messages/MClientRequest.h"
 #include "messages/MClientCaps.h"
 #include "messages/MClientSnap.h"
@@ -2725,6 +2728,7 @@ void MDCache::handle_mds_failure(int who)
   }
 
   kick_find_ino_peers(who);
+  kick_open_ino_peers(who);
 
   show_subtrees();  
 }
@@ -7030,6 +7034,13 @@ void MDCache::dispatch(Message *m)
   case MSG_MDS_FINDINOREPLY:
     handle_find_ino_reply(static_cast<MMDSFindInoReply *>(m));
     break;
+
+  case MSG_MDS_OPENINO:
+    handle_open_ino(static_cast<MMDSOpenIno *>(m));
+    break;
+  case MSG_MDS_OPENINOREPLY:
+    handle_open_ino_reply(static_cast<MMDSOpenInoReply *>(m));
+    break;
     
   default:
     dout(7) << "cache unknown message " << m->get_type() << dendl;
@@ -7730,6 +7741,416 @@ void MDCache::make_trace(vector<CDentry*>& trace, CInode *in)
 }
 
 
+// -------------------------------------------------------------------------------
+// Open inode by inode number
+
+class C_MDC_OpenInoBacktraceFetched : public Context {
+  MDCache *cache;
+  inodeno_t ino;
+  public:
+  bufferlist bl;
+  C_MDC_OpenInoBacktraceFetched(MDCache *c, inodeno_t i) :
+    cache(c), ino(i) {}
+  void finish(int r) {
+    cache->_open_ino_backtrace_fetched(ino, bl, r);
+  }
+};
+
+struct C_MDC_OpenInoTraverseDir : public Context {
+  MDCache *cache;
+  inodeno_t ino;
+  public:
+  C_MDC_OpenInoTraverseDir(MDCache *c, inodeno_t i) : cache(c), ino(i) {}
+  void finish(int r) {
+    assert(cache->opening_inodes.count(ino));
+    cache->_open_ino_traverse_dir(ino, cache->opening_inodes[ino], r);
+  }
+};
+
+struct C_MDC_OpenInoParentOpened : public Context {
+  MDCache *cache;
+  inodeno_t ino;
+  public:
+  C_MDC_OpenInoParentOpened(MDCache *c, inodeno_t i) : cache(c), ino(i) {}
+  void finish(int r) {
+    cache->_open_ino_parent_opened(ino, r);
+  }
+};
+
+void MDCache::_open_ino_backtrace_fetched(inodeno_t ino, bufferlist& bl, int err)
+{
+  dout(10) << "_open_ino_backtrace_fetched ino " << ino << " errno " << err << dendl;
+
+  assert(opening_inodes.count(ino));
+  open_ino_info_t& info = opening_inodes[ino];
+
+  CInode *in = get_inode(ino);
+  if (in) {
+    dout(10) << " found cached " << *in << dendl;
+    open_ino_finish(ino, info, in->authority().first);
+    return;
+  }
+
+  inode_backtrace_t backtrace;
+  if (err == 0) {
+    ::decode(backtrace, bl);
+    if (backtrace.pool != info.pool) {
+      dout(10) << " old object in pool " << info.pool
+	       << ", retrying pool " << backtrace.pool << dendl;
+      info.pool = backtrace.pool;
+      C_MDC_OpenInoBacktraceFetched *fin = new C_MDC_OpenInoBacktraceFetched(this, ino);
+      fetch_backtrace(ino, info.pool, fin->bl, fin);
+      return;
+    }
+  } else if (err == -ENOENT) {
+    int64_t meta_pool = mds->mdsmap->get_metadata_pool();
+    if (info.pool != meta_pool) {
+      dout(10) << " no object in pool " << info.pool
+	       << ", retrying pool " << meta_pool << dendl;
+      info.pool = meta_pool;
+      C_MDC_OpenInoBacktraceFetched *fin = new C_MDC_OpenInoBacktraceFetched(this, ino);
+      fetch_backtrace(ino, info.pool, fin->bl, fin);
+      return;
+    }
+  }
+
+  if (err == 0) {
+    if (backtrace.ancestors.empty()) {
+      dout(10) << " got empty backtrace " << dendl;
+      err = -EIO;
+    } else if (!info.ancestors.empty() &&
+	       info.ancestors[0] == backtrace.ancestors[0]) {
+      dout(10) << " got same parents " << info.ancestors[0] << " 2 times" << dendl;
+      err = -EINVAL;
+    }
+  }
+  if (err) {
+    dout(10) << " failed to open ino " << ino << dendl;
+    open_ino_finish(ino, info, err);
+    return;
+  }
+
+  dout(10) << " got backtrace " << backtrace << dendl;
+  info.ancestors = backtrace.ancestors;
+
+  _open_ino_traverse_dir(ino, info, 0);
+}
+
+void MDCache::_open_ino_parent_opened(inodeno_t ino, int ret)
+{
+  dout(10) << "_open_ino_parent_opened ino " << ino << " ret " << ret << dendl;
+
+  assert(opening_inodes.count(ino));
+  open_ino_info_t& info = opening_inodes[ino];
+
+  CInode *in = get_inode(ino);
+  if (in) {
+    dout(10) << " found cached " << *in << dendl;
+    open_ino_finish(ino, info, in->authority().first);
+    return;
+  }
+
+  if (ret == mds->get_nodeid()) {
+    _open_ino_traverse_dir(ino, info, 0);
+  } else {
+    if (ret >= 0) {
+      info.check_peers = true;
+      info.auth_hint = ret;
+      info.checked.erase(ret);
+    }
+    do_open_ino(ino, info, ret);
+  }
+}
+
+Context* MDCache::_open_ino_get_waiter(inodeno_t ino, MMDSOpenIno *m)
+{
+  if (m)
+    return new C_MDS_RetryMessage(mds, m);
+  else
+    return new C_MDC_OpenInoTraverseDir(this, ino);
+}
+
+void MDCache::_open_ino_traverse_dir(inodeno_t ino, open_ino_info_t& info, int ret)
+{
+  dout(10) << "_open_ino_trvserse_dir ino " << ino << " ret " << ret << dendl;
+
+  CInode *in = get_inode(ino);
+  if (in) {
+    dout(10) << " found cached " << *in << dendl;
+    open_ino_finish(ino, info, in->authority().first);
+    return;
+  }
+
+  if (ret) {
+    do_open_ino(ino, info, ret);
+    return;
+  }
+
+  if (info.need_discover) {
+    int i = 0;
+    for (; i < (int)info.ancestors.size() - 1; i++)
+      if (get_inode(info.ancestors[i].dirino))
+	break;
+    filepath path(info.ancestors[i].dirino);
+    for (; i >= 0; i--)
+      path.push_dentry(info.ancestors[i].dname);
+    ret = path_traverse(NULL, NULL, _open_ino_get_waiter(ino, NULL), path,
+			NULL, NULL, MDS_TRAVERSE_DISCOVER);
+    if (ret > 0)
+      return;
+    if (ret == 0)
+      ret = -ENOENT;
+  } else {
+    int hint = -1;
+    ret = open_ino_traverse_dir(ino, info.ancestors, NULL, &hint);
+    if (ret > 0)
+      return;
+    info.auth_hint = hint;
+  }
+  do_open_ino(ino, info, ret);
+}
+
+int MDCache::open_ino_traverse_dir(inodeno_t ino, vector<inode_backpointer_t>& ancestors,
+				   MMDSOpenIno *m, int* hint)
+{
+  dout(10) << "open_ino_traverse_dir ino " << ino << " " << ancestors << dendl;
+  int err = 0;
+  for (unsigned i = 0; i < ancestors.size(); i++) {
+    CInode *diri = get_inode(ancestors[i].dirino);
+    if (!diri)
+      continue;
+
+    if (!diri->is_dir()) {
+      dout(10) << " " << *diri << " is not dir" << dendl;
+      if (i == 0)
+	err = -ENOTDIR;
+      break;
+    }
+
+    string &name = ancestors[i].dname;
+    frag_t fg = diri->pick_dirfrag(name);
+    CDir *dir = diri->get_dirfrag(fg);
+    if (!dir && diri->is_auth()) {
+      if (diri->is_frozen()) {
+	dout(10) << " " << *diri << " is frozen, waiting " << dendl;
+	diri->add_waiter(CDir::WAIT_UNFREEZE, _open_ino_get_waiter(ino, m));
+	return 1;
+      }
+      dir = diri->get_or_open_dirfrag(this, fg);
+    }
+    if (dir && dir->is_auth()) {
+      CDentry *dn = dir->lookup(name);
+
+      if (!dn && !dir->is_complete() &&
+	  (!dir->has_bloom() || dir->is_in_bloom(name))) {
+	dout(10) << " fetching incomplete " << *dir << dendl;
+	dir->fetch(_open_ino_get_waiter(ino, m));
+	return 1;
+      }
+
+      dout(10) << " no ino " << (i > 0 ? ancestors[i - 1].dirino : ino)
+	       << " in " << *dir << dendl;
+      if (i == 0)
+	err = -ENOENT;
+    }
+    if (hint && i == 0)
+      *hint = dir ? dir->authority().first : diri->authority().first;
+    break;
+  }
+  return err;
+}
+
+void MDCache::open_ino_finish(inodeno_t ino, open_ino_info_t& info, int err)
+{
+  dout(10) << "open_ino_finish ino " << ino << " errno " << err << dendl;
+
+  finish_contexts(g_ceph_context, info.waiters, err);
+  opening_inodes.erase(ino);
+}
+
+void MDCache::do_open_ino(inodeno_t ino, open_ino_info_t& info, int err)
+{
+  if (err < 0) {
+    info.checked.clear();
+    info.checked.insert(mds->get_nodeid());
+    info.checking = -1;
+    info.need_discover = false;
+    info.check_peers = true;
+    info.fetch_backtrace = true;
+  }
+
+  if (info.check_peers) {
+    info.check_peers = false;
+    info.checking = -1;
+    do_open_ino_peer(ino, info);
+  } else if (info.fetch_backtrace) {
+    info.fetch_backtrace = false;
+    info.checking = mds->get_nodeid();
+    info.check_peers = true;
+    info.checked.clear();
+    info.checked.insert(mds->get_nodeid());
+    C_MDC_OpenInoBacktraceFetched *fin = new C_MDC_OpenInoBacktraceFetched(this, ino);
+    fetch_backtrace(ino, info.pool, fin->bl, fin);
+  } else {
+    assert(!info.ancestors.empty());
+    open_ino(info.ancestors[0].dirino, mds->mdsmap->get_metadata_pool(),
+	     new C_MDC_OpenInoParentOpened(this, ino), info.want_replica);
+  }
+}
+
+void MDCache::do_open_ino_peer(inodeno_t ino, open_ino_info_t& info)
+{
+  set<int> all, active;
+  mds->mdsmap->get_mds_set(all);
+  mds->mdsmap->get_clientreplay_or_active_or_stopping_mds_set(active);
+  if (mds->get_state() == MDSMap::STATE_REJOIN)
+    mds->mdsmap->get_mds_set(active, MDSMap::STATE_REJOIN);
+
+  dout(10) << "do_open_ino_peer " << ino << " active " << active
+	   << " all " << all << " checked " << info.checked << dendl;
+
+  int peer = -1;
+  if (info.auth_hint >= 0) {
+    if (active.count(info.auth_hint)) {
+      peer = info.auth_hint;
+      info.auth_hint = -1;
+    }
+  } else {
+    for (set<int>::iterator p = active.begin(); p != active.end(); ++p)
+      if (*p != mds->get_nodeid() && info.checked.count(*p) == 0) {
+	peer = *p;
+	break;
+      }
+  }
+  if (peer < 0) {
+    if (all.size() > active.size() && all != info.checked) {
+      dout(10) << " waiting for more peers to be active" << dendl;
+    } else {
+      dout(10) << " all MDS peers have been checked" << ino << dendl;
+      do_open_ino(ino, info, 0);
+    }
+  } else {
+    info.checking = peer;
+    mds->send_message_mds(new MMDSOpenIno(info.tid, ino, info.ancestors), peer);
+  }
+}
+
+void MDCache::handle_open_ino(MMDSOpenIno *m)
+{
+  dout(10) << "handle_open_ino " << *m << dendl;
+
+  MMDSOpenInoReply *reply;
+  CInode *in = get_inode(m->ino);
+  if (in) {
+    dout(10) << " have " << *in << dendl;
+    reply = new MMDSOpenInoReply(m->get_tid(), m->ino, 0);
+    if (in->is_auth()) {
+      touch_inode(in);
+      while (1) {
+	CDentry *pdn = in->get_parent_dn();
+	if (!pdn)
+	  break;
+	CInode *diri = pdn->get_dir()->get_inode();
+	reply->ancestors.push_back(inode_backpointer_t(diri->ino(), pdn->name,
+						       in->inode.version));
+	in = diri;
+      }
+    } else {
+      reply->hint = in->authority().first;
+    }
+  } else {
+    int hint = -1;
+    int ret = open_ino_traverse_dir(m->ino, m->ancestors, m, &hint);
+    if (ret > 0)
+      return;
+    reply = new MMDSOpenInoReply(m->get_tid(), m->ino, hint, ret);
+  }
+  mds->messenger->send_message(reply, m->get_connection());
+  m->put();
+}
+
+void MDCache::handle_open_ino_reply(MMDSOpenInoReply *m)
+{
+  dout(10) << "handle_open_ino_reply " << *m << dendl;
+
+  inodeno_t ino = m->ino;
+  int from = m->get_source().num();
+  if (opening_inodes.count(ino)) {
+    open_ino_info_t& info = opening_inodes[ino];
+
+    if (info.checking == from)
+	info.checking = -1;
+    info.checked.insert(from);
+
+    CInode *in = get_inode(ino);
+    if (in) {
+      dout(10) << " found cached " << *in << dendl;
+      open_ino_finish(ino, info, in->authority().first);
+    } else if (!m->ancestors.empty()) {
+      dout(10) << " found ino " << ino << " on mds." << from << dendl;
+      if (!info.want_replica) {
+	open_ino_finish(ino, info, from);
+	return;
+      }
+
+      info.ancestors = m->ancestors;
+      info.auth_hint = from;
+      info.need_discover = true;
+      _open_ino_traverse_dir(ino, info, 0);
+    } else if (m->error) {
+      dout(10) << " error " << m->error << " from mds." << from << dendl;
+      do_open_ino(ino, info, m->error);
+    } else {
+      if (m->hint >= 0 && m->hint != mds->get_nodeid()) {
+	info.auth_hint = m->hint;
+	info.checked.erase(m->hint);
+      }
+      do_open_ino_peer(ino, info);
+    }
+  }
+  m->put();
+}
+
+void MDCache::kick_open_ino_peers(int who)
+{
+  dout(10) << "kick_open_ino_peers mds." << who << dendl;
+
+  for (map<inodeno_t, open_ino_info_t>::iterator p = opening_inodes.begin();
+       p != opening_inodes.end();
+       ++p) {
+    open_ino_info_t& info = p->second;
+    if (info.checking == who) {
+      dout(10) << "  kicking ino " << p->first << " who was checking mds." << who << dendl;
+      info.checking = -1;
+      do_open_ino_peer(p->first, info);
+    } else if (info.checking == -1) {
+      dout(10) << "  kicking ino " << p->first << " who was waiting" << dendl;
+      do_open_ino_peer(p->first, info);
+    }
+  }
+}
+
+void MDCache::open_ino(inodeno_t ino, int64_t pool, Context* fin, bool want_replica)
+{
+  dout(10) << "open_ino " << ino << " pool " << pool << " want_replica "
+	   << want_replica << dendl;
+
+  if (opening_inodes.count(ino)) {
+    open_ino_info_t& info = opening_inodes[ino];
+    if (want_replica)
+      info.want_replica = true;
+    info.waiters.push_back(fin);
+  } else {
+    open_ino_info_t& info = opening_inodes[ino];
+    info.checked.insert(mds->get_nodeid());
+    info.want_replica = want_replica;
+    info.tid = ++open_ino_last_tid;
+    info.pool = pool >= 0 ? pool : mds->mdsmap->get_first_data_pool();
+    info.waiters.push_back(fin);
+    do_open_ino(ino, info, 0);
+  }
+}
+
 /* ---------------------------- */
 
 /*
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index b9a1ead..cc54376 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -53,6 +53,8 @@ class MDentryUnlink;
 class MLock;
 class MMDSFindIno;
 class MMDSFindInoReply;
+class MMDSOpenIno;
+class MMDSOpenInoReply;
 
 class Message;
 class MClientRequest;
@@ -756,6 +758,44 @@ public:
 				   C_GatherBuilder &gather_bld);
 
   void make_trace(vector<CDentry*>& trace, CInode *in);
+
+protected:
+  struct open_ino_info_t {
+    vector<inode_backpointer_t> ancestors;
+    set<int> checked;
+    int checking;
+    int auth_hint;
+    bool need_discover;
+    bool check_peers;
+    bool fetch_backtrace;
+    bool want_replica;
+    version_t tid;
+    int64_t pool;
+    list<Context*> waiters;
+    open_ino_info_t() : checking(-1), auth_hint(-1), need_discover(false),
+      check_peers(true), fetch_backtrace(true), want_replica(true) {}
+  };
+  tid_t open_ino_last_tid;
+  map<inodeno_t,open_ino_info_t> opening_inodes;
+
+  void _open_ino_backtrace_fetched(inodeno_t ino, bufferlist& bl, int err);
+  void _open_ino_parent_opened(inodeno_t ino, int ret);
+  void _open_ino_traverse_dir(inodeno_t ino, open_ino_info_t& info, int err);
+  Context* _open_ino_get_waiter(inodeno_t ino, MMDSOpenIno *m);
+  int open_ino_traverse_dir(inodeno_t ino, vector<inode_backpointer_t>& ancestors,
+			    MMDSOpenIno *m, int* hint);
+  void open_ino_finish(inodeno_t ino, open_ino_info_t& info, int err);
+  void do_open_ino(inodeno_t ino, open_ino_info_t& info, int err);
+  void do_open_ino_peer(inodeno_t ino, open_ino_info_t& info);
+  void handle_open_ino(MMDSOpenIno *m);
+  void handle_open_ino_reply(MMDSOpenInoReply *m);
+  friend class C_MDC_OpenInoBacktraceFetched;
+  friend class C_MDC_OpenInoTraverseDir;
+  friend class C_MDC_OpenInoParentOpened;
+
+public:
+  void kick_open_ino_peers(int who);
+  void open_ino(inodeno_t ino, int64_t pool, Context *fin, bool want_replia=true);
   
   // -- find_ino_peer --
   struct find_ino_peer_info_t {
diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index 16b857e..a7140c5 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -1011,12 +1011,7 @@ void MDS::handle_mds_map(MMDSMap *m)
     if (g_conf->mds_dump_cache_after_rejoin &&
 	oldmap->is_rejoining() && !mdsmap->is_rejoining()) 
       mdcache->dump_cache();      // for DEBUG only
-  }
-  if (oldmap->is_degraded() && !mdsmap->is_degraded() && state >= MDSMap::STATE_ACTIVE)
-    dout(1) << "cluster recovered." << dendl;
   
-  // did someone go active?
-  if (is_clientreplay() || is_active() || is_stopping()) {
     // ACTIVE|CLIENTREPLAY|REJOIN => we can discover from them.
     set<int> olddis, dis;
     oldmap->get_mds_set(olddis, MDSMap::STATE_ACTIVE);
@@ -1027,9 +1022,17 @@ void MDS::handle_mds_map(MMDSMap *m)
     mdsmap->get_mds_set(dis, MDSMap::STATE_REJOIN);
     for (set<int>::iterator p = dis.begin(); p != dis.end(); ++p) 
       if (*p != whoami &&            // not me
-	  olddis.count(*p) == 0)  // newly so?
+	  olddis.count(*p) == 0) {  // newly so?
 	mdcache->kick_discovers(*p);
+	mdcache->kick_open_ino_peers(*p);
+      }
+  }
+
+  if (oldmap->is_degraded() && !mdsmap->is_degraded() && state >= MDSMap::STATE_ACTIVE)
+    dout(1) << "cluster recovered." << dendl;
 
+  // did someone go active?
+  if (is_clientreplay() || is_active() || is_stopping()) {
     set<int> oldactive, active;
     oldmap->get_mds_set(oldactive, MDSMap::STATE_ACTIVE);
     oldmap->get_mds_set(oldactive, MDSMap::STATE_CLIENTREPLAY);
diff --git a/src/mds/MDSMap.h b/src/mds/MDSMap.h
index c5bc1c3..3e2f67e 100644
--- a/src/mds/MDSMap.h
+++ b/src/mds/MDSMap.h
@@ -308,6 +308,13 @@ public:
       if (p->second.state >= STATE_REPLAY && p->second.state <= STATE_STOPPING)
 	s.insert(p->second.rank);
   }
+  void get_clientreplay_or_active_or_stopping_mds_set(set<int>& s) {
+    for (map<uint64_t,mds_info_t>::const_iterator p = mds_info.begin();
+	 p != mds_info.end();
+	 ++p)
+      if (p->second.state >= STATE_CLIENTREPLAY && p->second.state <= STATE_STOPPING)
+	s.insert(p->second.rank);
+  }
   void get_mds_set(set<int>& s, int state) {
     for (map<uint64_t,mds_info_t>::const_iterator p = mds_info.begin();
 	 p != mds_info.end();
diff --git a/src/mds/inode_backtrace.h b/src/mds/inode_backtrace.h
index d223f72..2d80ae3 100644
--- a/src/mds/inode_backtrace.h
+++ b/src/mds/inode_backtrace.h
@@ -35,6 +35,10 @@ struct inode_backpointer_t {
 };
 WRITE_CLASS_ENCODER(inode_backpointer_t)
 
+inline bool operator==(const inode_backpointer_t& l, const inode_backpointer_t& r) {
+	return l.dirino == r.dirino && l.version == r.version && l.dname == r.dname;
+}
+
 inline ostream& operator<<(ostream& out, const inode_backpointer_t& ib) {
   return out << "<" << ib.dirino << "/" << ib.dname << " v" << ib.version << ">";
 }
diff --git a/src/messages/MMDSOpenIno.h b/src/messages/MMDSOpenIno.h
new file mode 100644
index 0000000..0918e87
--- /dev/null
+++ b/src/messages/MMDSOpenIno.h
@@ -0,0 +1,46 @@
+// -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
+// vim: ts=8 sw=2 smarttab
+/*
+ * Ceph - scalable distributed file system
+ *
+ * Copyright (C) 2011 New Dream Network
+ *
+ * This is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2.1, as published by the Free Software
+ * Foundation.  See file COPYING.
+ *
+ */
+
+#ifndef CEPH_MDSOPENINO_H
+#define CEPH_MDSOPENINO_H
+
+#include "msg/Message.h"
+
+struct MMDSOpenIno : public Message {
+  inodeno_t ino;
+  vector<inode_backpointer_t> ancestors;
+
+  MMDSOpenIno() : Message(MSG_MDS_OPENINO) {}
+  MMDSOpenIno(tid_t t, inodeno_t i, vector<inode_backpointer_t>& a) :
+    Message(MSG_MDS_OPENINO), ino(i), ancestors(a) {
+    header.tid = t;
+  }
+
+  const char *get_type_name() const { return "openino"; }
+  void print(ostream &out) const {
+    out << "openino(" << header.tid << " " << ino << " " << ancestors << ")";
+  }
+
+  void encode_payload(uint64_t features) {
+    ::encode(ino, payload);
+    ::encode(ancestors, payload);
+  }
+  void decode_payload() {
+    bufferlist::iterator p = payload.begin();
+    ::decode(ino, p);
+    ::decode(ancestors, p);
+  }
+};
+
+#endif
diff --git a/src/messages/MMDSOpenInoReply.h b/src/messages/MMDSOpenInoReply.h
new file mode 100644
index 0000000..245027f
--- /dev/null
+++ b/src/messages/MMDSOpenInoReply.h
@@ -0,0 +1,53 @@
+// -*- mode:C++; tab-width:8; c-basic-offset:2; indent-tabs-mode:t -*-
+// vim: ts=8 sw=2 smarttab
+/*
+ * Ceph - scalable distributed file system
+ *
+ * Copyright (C) 2011 New Dream Network
+ *
+ * This is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License version 2.1, as published by the Free Software
+ * Foundation.  See file COPYING.
+ *
+ */
+
+#ifndef CEPH_MDSOPENINOREPLY_H
+#define CEPH_MDSOPENINOREPLY_H
+
+#include "msg/Message.h"
+
+struct MMDSOpenInoReply : public Message {
+  inodeno_t ino;
+  vector<inode_backpointer_t> ancestors;
+  int32_t hint;
+  int32_t error;
+
+  MMDSOpenInoReply() : Message(MSG_MDS_OPENINOREPLY) {}
+  MMDSOpenInoReply(tid_t t, inodeno_t i, int h=-1, int e=0) :
+    Message(MSG_MDS_OPENINOREPLY), ino(i), hint(h), error(e) {
+    header.tid = t;
+  }
+
+  const char *get_type_name() const { return "openinoreply"; }
+  void print(ostream &out) const {
+    out << "openinoreply(" << header.tid << " "
+	<< ino << " " << hint << " " << ancestors << ")";
+  }
+
+  void encode_payload(uint64_t features) {
+    ::encode(ino, payload);
+    ::encode(ancestors, payload);
+    ::encode(hint, payload);
+    ::encode(error, payload);
+  }
+  void decode_payload() {
+    bufferlist::iterator p = payload.begin();
+    ::decode(ino, p);
+    ::decode(ancestors, p);
+    ::decode(hint, p);
+    ::decode(error, p);
+  }
+};
+
+#endif
diff --git a/src/msg/Message.cc b/src/msg/Message.cc
index 77be03a..a6889d3 100644
--- a/src/msg/Message.cc
+++ b/src/msg/Message.cc
@@ -112,6 +112,8 @@ using namespace std;
 #include "messages/MMDSCacheRejoin.h"
 #include "messages/MMDSFindIno.h"
 #include "messages/MMDSFindInoReply.h"
+#include "messages/MMDSOpenIno.h"
+#include "messages/MMDSOpenInoReply.h"
 
 #include "messages/MDirUpdate.h"
 #include "messages/MDiscover.h"
@@ -533,6 +535,13 @@ Message *decode_message(CephContext *cct, ceph_msg_header& header, ceph_msg_foot
     m = new MMDSFindInoReply;
     break;
 
+  case MSG_MDS_OPENINO:
+    m = new MMDSOpenIno;
+    break;
+  case MSG_MDS_OPENINOREPLY:
+    m = new MMDSOpenInoReply;
+    break;
+
   case MSG_MDS_FRAGMENTNOTIFY:
     m = new MMDSFragmentNotify;
     break;
diff --git a/src/msg/Message.h b/src/msg/Message.h
index 33d26b2..5efb608 100644
--- a/src/msg/Message.h
+++ b/src/msg/Message.h
@@ -124,6 +124,8 @@
 #define MSG_MDS_DENTRYLINK         0x20c
 #define MSG_MDS_FINDINO            0x20d
 #define MSG_MDS_FINDINOREPLY       0x20e
+#define MSG_MDS_OPENINO            0x20f
+#define MSG_MDS_OPENINOREPLY       0x210
 
 #define MSG_MDS_LOCK               0x300
 #define MSG_MDS_INODEFILECAPS      0x301
-- 
1.8.1.4

