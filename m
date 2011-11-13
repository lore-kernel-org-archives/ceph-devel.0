From: Josh Pieper <jjp@pobox.com>
Subject: [PATCH 1/2] Resolve gcc warnings.
Date: Sun, 13 Nov 2011 09:02:25 -0500
Message-ID: <20111113140225.GA19557@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:35699 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564Ab1KMOMQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Nov 2011 09:12:16 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I don't know what the ceph project's opinion towards warning
cleanliness is, but given the paucity of warnings on my ubuntu 11.10
amd64 machine, I'm guessing it is a safe bet to keep things clean.

This series has two patches, one with the fixes that should have no
functional change.  The second, in rgw, I found a few warnings that
pointed to code that looked obviously wrong.  While I've smoke tested
rbd and fuse with these changes, I haven't tested rgw.  Thus the rgw
fixes compile and pass any unit tests that might exist under
'make check', but are otherwise untested.

Regards,
Josh

From 9a60445de09a7c9de096cecb1b63638be52438c2 Mon Sep 17 00:00:00 2001
From: Josh Pieper <jjp@pobox.com>
Date: Fri, 11 Nov 2011 08:19:02 -0500
Subject: [PATCH 1/2] Resolve gcc warnings.

These should have no functional changes:
 * Check errors from functions that currently cannot return any
 * Initialize variables that gcc can't determine will be initialized
   in a following function call
 * Remove unused variables

Signed-off-by: Josh Pieper <jjp@pobox.com>
---
 src/client/fuse_ll.cc      |    6 +++++-
 src/include/encoding.h     |    2 +-
 src/librados.cc            |    2 ++
 src/mount/mount.ceph.c     |    2 --
 src/msg/SimpleMessenger.cc |    2 --
 src/msg/msg_types.cc       |    2 --
 src/os/IndexManager.cc     |    2 +-
 src/osd/PG.cc              |    3 ---
 src/osd/ReplicatedPG.cc    |    2 --
 9 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/src/client/fuse_ll.cc b/src/client/fuse_ll.cc
index 2c766c2..bbfab9d 100644
--- a/src/client/fuse_ll.cc
+++ b/src/client/fuse_ll.cc
@@ -423,7 +423,11 @@ static void ceph_ll_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
   int r;
   r = client->readdir_r_cb(dirp, ceph_ll_add_dirent, &rc);
 
-  fuse_reply_buf(req, rc.buf, rc.pos);
+  if (r == 0) {
+    fuse_reply_buf(req, rc.buf, rc.pos);
+  } else {
+    fuse_reply_err(req, -r);
+  }
   delete[] rc.buf;
 }
 
diff --git a/src/include/encoding.h b/src/include/encoding.h
index bbbac8f..67150d5 100644
--- a/src/include/encoding.h
+++ b/src/include/encoding.h
@@ -525,7 +525,7 @@ inline void decode(std::multimap<T,U>& m, bufferlist::iterator& p)
   decode(n, p);
   m.clear();
   while (n--) {
-    typename std::pair<T,U> tu;
+    typename std::pair<T,U> tu = std::pair<T,U>();
     decode(tu.first, p);
     typename std::multimap<T,U>::iterator it = m.insert(tu);
     decode(it->second, p);
diff --git a/src/librados.cc b/src/librados.cc
index 713ba50..aa746c2 100644
--- a/src/librados.cc
+++ b/src/librados.cc
@@ -4006,6 +4006,8 @@ extern "C" int rados_objects_list_next(rados_list_ctx_t listctx, const char **en
 
   if (h->list.empty()) {
     ret = lh->ctx->client->list(lh->lc, RADOS_LIST_MAX_ENTRIES);
+    if (ret < 0)
+      return ret;
     if (h->list.empty())
       return -ENOENT;
   }
diff --git a/src/mount/mount.ceph.c b/src/mount/mount.ceph.c
index e7a247d..46dd2e2 100755
--- a/src/mount/mount.ceph.c
+++ b/src/mount/mount.ceph.c
@@ -86,7 +86,6 @@ static char *parse_options(const char *data, int *filesys_flags)
 	int word_len;
 	int skip;
 	int pos = 0;
-	char *newdata = 0;
 	char secret[MAX_SECRET_LEN];
 	char *saw_name = NULL;
 	char *saw_secret = NULL;
@@ -99,7 +98,6 @@ static char *parse_options(const char *data, int *filesys_flags)
 		if(*data == 0)
 			break;
 		next_keyword = strchr(data,',');
-		newdata = 0;
 	
 		/* temporarily null terminate end of keyword=value pair */
 		if(next_keyword)
diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
index d96a460..82ab3f3 100644
--- a/src/msg/SimpleMessenger.cc
+++ b/src/msg/SimpleMessenger.cc
@@ -700,7 +700,6 @@ int SimpleMessenger::Pipe::accept()
   // this should roughly mirror pseudocode at
   //  http://ceph.newdream.net/wiki/Messaging_protocol
   int reply_tag = 0;
-  bool replace = false;
   uint64_t existing_seq = -1;
   while (1) {
     rc = tcp_read(msgr->cct, sd, (char*)&connect, sizeof(connect), msgr->timeout);
@@ -893,7 +892,6 @@ int SimpleMessenger::Pipe::accept()
   }
   
  replace:
-  replace = true;
   if (connect.features & CEPH_FEATURE_RECONNECT_SEQ) {
     reply_tag = CEPH_MSGR_TAG_SEQ;
     existing_seq = existing->in_seq;
diff --git a/src/msg/msg_types.cc b/src/msg/msg_types.cc
index 7e361d5..1fb645f 100644
--- a/src/msg/msg_types.cc
+++ b/src/msg/msg_types.cc
@@ -11,11 +11,9 @@ bool entity_addr_t::parse(const char *s, const char **end)
 
   const char *start = s;
   bool brackets = false;
-  bool ipv6 = false;
   if (*start == '[') {
     start++;
     brackets = true;
-    ipv6 = true;
   }
   
   // inet_pton() requires a null terminated input, so let's fill two
diff --git a/src/os/IndexManager.cc b/src/os/IndexManager.cc
index 50d53ff..0fab6fe 100644
--- a/src/os/IndexManager.cc
+++ b/src/os/IndexManager.cc
@@ -83,7 +83,7 @@ int IndexManager::build_index(coll_t c, const char *path, Index *index) {
   int r;
   if (g_conf->filestore_update_collections) {
     // Need to check the collection generation
-    uint32_t version;
+    uint32_t version = 0;
     r = get_version(path, &version);
     if (r < 0)
       return r;
diff --git a/src/osd/PG.cc b/src/osd/PG.cc
index 87c3047..384a5eb 100644
--- a/src/osd/PG.cc
+++ b/src/osd/PG.cc
@@ -4870,7 +4870,6 @@ PG::PriorSet::PriorSet(const OSDMap &osdmap,
     // interesting), or lost (down, but we won't wait for it).
     bool any_up_now = false;    // any candidates up now
     bool any_down_now = false;  // any candidates down now (that might have useful data)
-    bool any_lost_now = false;  // any candidates lost now (that we will ignore)
 
     // consider ACTING osds
     for (unsigned i=0; i<interval.acting.size(); i++) {
@@ -4887,11 +4886,9 @@ PG::PriorSet::PriorSet(const OSDMap &osdmap,
       } else if (!pinfo) {
 	dout(10) << "build_prior  prior osd." << o << " no longer exists" << dendl;
 	down.insert(o);
-	any_lost_now = true;
       } else if (pinfo->lost_at > interval.first) {
 	dout(10) << "build_prior  prior osd." << o << " is down, but lost_at " << pinfo->lost_at << dendl;
 	down.insert(o);
-	any_lost_now = true;
       } else {
 	dout(10) << "build_prior  prior osd." << o << " is down" << dendl;
 	down.insert(o);
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index abd6d42..595df56 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -2440,7 +2440,6 @@ void ReplicatedPG::do_osd_op_effects(OpContext *ctx)
 	  osd->client_messenger->send_message(notify_msg, s->con);
 	} else {
 	  // unconnected
-	  utime_t now = ceph_clock_now(g_ceph_context);
 	  entity_name_t name = i->first;
 	  notif->add_watcher(name, Watch::WATCHER_PENDING);
 	}
@@ -4576,7 +4575,6 @@ void ReplicatedPG::mark_all_unfound_lost(int what)
   C_PG_MarkUnfoundLost *c = new C_PG_MarkUnfoundLost(this);
 
   utime_t mtime = ceph_clock_now(g_ceph_context);
-  eversion_t old_last_update = info.last_update;
   info.last_update.epoch = get_osdmap()->get_epoch();
   map<hobject_t, Missing::item>::iterator m = missing.missing.begin();
   map<hobject_t, Missing::item>::iterator mend = missing.missing.end();
-- 
1.7.5.4

