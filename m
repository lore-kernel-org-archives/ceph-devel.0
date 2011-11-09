From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH 1/4] client: return stripe address replicas
Date: Tue,  8 Nov 2011 18:39:18 -0800
Message-ID: <1320806361-1801-2-git-send-email-jayhawk@cs.ucsc.edu>
References: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:44378 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360Ab1KIDBB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 22:01:01 -0500
Received: from piha.cse.ucsc.edu (piha.soe.ucsc.edu [128.114.52.38])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id A1EC7774C005
	for <ceph-devel@vger.kernel.org>; Tue,  8 Nov 2011 18:51:59 -0800 (PST)
In-Reply-To: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

From: Noah Watkins <noahwatkins@gmail.com>

Changes ceph_get_file_stripe_address to return a
vector of entity_addr_t's for the primary and the
replicas. libcephfs is updated to return the
associated sockaddr_storage for each address.

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 src/client/Client.cc           |   17 +++++++----------
 src/client/Client.h            |    2 +-
 src/include/cephfs/libcephfs.h |    4 ++--
 src/libcephfs.cc               |   30 ++++++++++++++++++------------
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 816fe83..1f01b80 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -6829,7 +6829,7 @@ int Client::get_pool_replication(int64_t pool)
   return osdmap->get_pg_pool(pool)->get_size();
 }
 
-int Client::get_file_stripe_address(int fd, loff_t offset, string& address)
+int Client::get_file_stripe_address(int fd, loff_t offset, vector<entity_addr_t>& address)
 {
   Mutex::Locker lock(client_lock);
 
@@ -6848,15 +6848,12 @@ int Client::get_file_stripe_address(int fd, loff_t offset, string& address)
   osdmap->pg_to_acting_osds(pg, osds);
   if (!osds.size())
     return -EINVAL;
-  
-  // now we have the osd(s)
-  entity_addr_t addr = osdmap->get_addr(osds[0]);
-  
-  // now we need to turn it into a string
-  char foo[30];
-  __u8 *quad = (__u8*) &addr.in4_addr().sin_addr;
-  snprintf(foo, sizeof(foo), "%d.%d.%d.%d", (int)quad[0], (int)quad[1], (int)quad[2], (int)quad[3]);
-  address = foo;
+
+  for (unsigned i = 0; i < osds.size(); i++) {
+    entity_addr_t addr = osdmap->get_addr(osds[i]);
+    address.push_back(addr);
+  }
+
   return 0;
 }
 
diff --git a/src/client/Client.h b/src/client/Client.h
index bc98ac5..a30b73c 100644
--- a/src/client/Client.h
+++ b/src/client/Client.h
@@ -607,7 +607,7 @@ public:
 
   // expose file layout
   int describe_layout(int fd, ceph_file_layout* layout);
-  int get_file_stripe_address(int fd, loff_t offset, string& address);
+  int get_file_stripe_address(int fd, loff_t offset, vector<entity_addr_t>& address);
 
   // expose osdmap 
   int get_local_osd();
diff --git a/src/include/cephfs/libcephfs.h b/src/include/cephfs/libcephfs.h
index 4b2b64f..f4d4313 100644
--- a/src/include/cephfs/libcephfs.h
+++ b/src/include/cephfs/libcephfs.h
@@ -156,8 +156,8 @@ int ceph_lsetxattr(struct ceph_mount_info *cmount, const char *path, const char
 int ceph_get_file_stripe_unit(struct ceph_mount_info *cmount, int fh);
 int ceph_get_file_pool(struct ceph_mount_info *cmount, int fh);
 int ceph_get_file_replication(struct ceph_mount_info *cmount, int fh);
-int ceph_get_file_stripe_address(struct ceph_mount_info *cmount, int fd,
-				 loff_t offset, char *buf, int buflen);
+int ceph_get_file_stripe_address(struct ceph_mount_info *cmount, int fd, loff_t offset,
+				 struct sockaddr_storage *addr, int naddr);
 
 /* set default layout for new files */
 int ceph_set_default_file_stripe_unit(struct ceph_mount_info *cmount, int stripe);
diff --git a/src/libcephfs.cc b/src/libcephfs.cc
index 153348c..974fe3a 100644
--- a/src/libcephfs.cc
+++ b/src/libcephfs.cc
@@ -584,21 +584,27 @@ extern "C" int ceph_set_default_preferred_pg(struct ceph_mount_info *cmount, int
 }
 
 extern "C" int ceph_get_file_stripe_address(struct ceph_mount_info *cmount, int fh,
-					    loff_t offset, char *buf, int buflen)
+					    loff_t offset, struct sockaddr_storage *addr, int naddr)
 {
-  string address;
-  int r = cmount->get_client()->get_file_stripe_address(fh, offset, address);
+  vector<entity_addr_t> address;
+  unsigned i;
+  int r;
+
+  if (naddr < 0)
+    return -EINVAL;
+
+  r = cmount->get_client()->get_file_stripe_address(fh, offset, address);
   if (r < 0)
-    return r; 
-  int len = address.size()+1;
-  if (len > buflen) {
-    if (buflen == 0)
-      return len;
+    return r;
+
+  for (i = 0; i < (unsigned)naddr && i < address.size(); i++)
+    memcpy(&addr[i], &address[i].ss_addr(), sizeof(*addr));
+
+  /* naddr == 0: drop through and return actual size */
+  if (naddr && (address.size() > (unsigned)naddr))
     return -ERANGE;
-  }
-  len = address.copy(buf, len, 0);
-  buf[len] = '\0'; // write a null char to terminate c-style string
-  return 0;
+
+  return address.size();
 }
 
 extern "C" int ceph_localize_reads(struct ceph_mount_info *cmount, int val)
-- 
1.7.1

