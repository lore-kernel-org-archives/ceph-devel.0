From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] Remove various unused variables
Date: Sat, 17 Sep 2011 16:25:36 +0200
Message-ID: <1316269536-21456-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:51267 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1IQOZk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Sep 2011 10:25:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/client/Client.cc       |    2 --
 src/include/addr_parsing.c |    3 +--
 src/librados.cc            |   12 ------------
 src/osd/OSD.cc             |    2 --
 4 files changed, 1 insertions(+), 18 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 1594dcd..657f22f 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -466,9 +466,7 @@ Inode * Client::add_update_inode(InodeStat *st, utime_t from, int mds)
   } else {
     in = new Inode(cct, st->vino, &st->layout);
     inode_map[st->vino] = in;
-    bool new_root = false;
     if (!root) {
-      new_root = true;
       root = in;
       cwd = root;
       cwd->get();
diff --git a/src/include/addr_parsing.c b/src/include/addr_parsing.c
index ce7fef1..75e2c79 100644
--- a/src/include/addr_parsing.c
+++ b/src/include/addr_parsing.c
@@ -42,14 +42,13 @@ int safe_cat(char **pstr, int *plen, int pos, const char *str2)
 char *resolve_addrs(const char *orig_str)
 {
   char *new_str;
-  char *tok, *p, *port_str, *saveptr = NULL;
+  char *tok, *port_str, *saveptr = NULL;
   int len, pos;
   char *buf = strdup(orig_str);
 
   len = BUF_SIZE;
   new_str = (char *)malloc(len);
 
-  p = new_str;
   pos = 0;
 
   tok = strtok_r(buf, ",", &saveptr);
diff --git a/src/librados.cc b/src/librados.cc
index 14fa2b1..1f31bab 100644
--- a/src/librados.cc
+++ b/src/librados.cc
@@ -1732,8 +1732,6 @@ int librados::RadosClient::operate(IoCtxImpl& io, const object_t& oid,
 int librados::RadosClient::operate_read(IoCtxImpl& io, const object_t& oid,
 					::ObjectOperation *o, bufferlist *pbl)
 {
-  utime_t ut = ceph_clock_now(cct);
-
   /* can't write to a snapshot */
   if (io.snap_seq != CEPH_NOSNAP)
     return -EINVAL;
@@ -2042,8 +2040,6 @@ int librados::RadosClient::tmap_put(IoCtxImpl& io, const object_t& oid, bufferli
 
 int librados::RadosClient::tmap_get(IoCtxImpl& io, const object_t& oid, bufferlist& bl)
 {
-  utime_t ut = ceph_clock_now(cct);
-
   /* can't write to a snapshot */
   if (io.snap_seq != CEPH_NOSNAP)
     return -EROFS;
@@ -2079,8 +2075,6 @@ int librados::RadosClient::exec(IoCtxImpl& io, const object_t& oid,
 				const char *cls, const char *method,
 				bufferlist& inbl, bufferlist& outbl)
 {
-  utime_t ut = ceph_clock_now(cct);
-
   Mutex mylock("RadosClient::exec::mylock");
   Cond cond;
   bool done;
@@ -2420,8 +2414,6 @@ void librados::RadosClient::watch_notify(MWatchNotify *m)
 int librados::RadosClient::watch(IoCtxImpl& io, const object_t& oid, uint64_t ver,
 				 uint64_t *cookie, librados::WatchCtx *ctx)
 {
-  utime_t ut = ceph_clock_now(cct);
-
   ::ObjectOperation rd;
   Mutex mylock("RadosClient::watch::mylock");
   Cond cond;
@@ -2461,8 +2453,6 @@ int librados::RadosClient::watch(IoCtxImpl& io, const object_t& oid, uint64_t ve
 int librados::RadosClient::_notify_ack(IoCtxImpl& io, const object_t& oid,
 				       uint64_t notify_id, uint64_t ver)
 {
-  utime_t ut = ceph_clock_now(cct);
-
   Mutex mylock("RadosClient::watch::mylock");
   Cond cond;
   eversion_t objver;
@@ -2477,7 +2467,6 @@ int librados::RadosClient::_notify_ack(IoCtxImpl& io, const object_t& oid,
 
 int librados::RadosClient::unwatch(IoCtxImpl& io, const object_t& oid, uint64_t cookie)
 {
-  utime_t ut = ceph_clock_now(cct);
   bufferlist inbl, outbl;
 
   Mutex mylock("RadosClient::watch::mylock");
@@ -2508,7 +2497,6 @@ int librados::RadosClient::unwatch(IoCtxImpl& io, const object_t& oid, uint64_t
 
 int librados::RadosClient::notify(IoCtxImpl& io, const object_t& oid, uint64_t ver, bufferlist& bl)
 {
-  utime_t ut = ceph_clock_now(cct);
   bufferlist inbl, outbl;
 
   Mutex mylock("RadosClient::notify::mylock");
diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 17fa3bd..f6628a1 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -1437,8 +1437,6 @@ void OSD::update_heartbeat_peers()
   old_from.swap(heartbeat_from);
   old_con.swap(heartbeat_from_con);
 
-  utime_t now = ceph_clock_now(g_ceph_context);
-
   heartbeat_epoch = osdmap->get_epoch();
 
   // build heartbeat from set
-- 
1.7.5.4

