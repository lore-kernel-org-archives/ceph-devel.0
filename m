From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: [patch RFC] client: return stripe address replicas
Date: Mon, 7 Nov 2011 12:46:10 -0800 (PST)
Message-ID: <172453601.38993.1320698769959.JavaMail.root@mail-01.cse.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:56869 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab1KGUqK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2011 15:46:10 -0500
Received: from mail-01.cse.ucsc.edu (mail-01.cse.ucsc.edu [128.114.48.32])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTP id 0E7E27744005
	for <ceph-devel@vger.kernel.org>; Mon,  7 Nov 2011 12:46:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

The patch below is a first attempt at updating the libcephfs API to return replica locations. I wanted to get opinions on the interface. The short version of the patch is the API changes:

Client.h: returns vector of entity_addr_t
  -int Client::get_file_stripe_address(int fd, loff_t offset, string& address)
  +int Client::get_file_stripe_address(int fd, loff_t offset, vector<entity_addr_t>& address)

libcephfs.h: returns array of sockaddr_storage
  int ceph_get_file_stripe_address(struct ceph_mount_info *cmount, int fd,
  -				 loff_t offset, char *buf, int buflen);
  +				 loff_t offset, struct sockaddr_storage *addr, int naddr);

Thanks,
Noah

=========================================================

Changes ceph_get_file_stripe_address to return a
vector of entity_addr_t's for the primary and the
replicas. libcephfs is updated to return the
associated sockaddr_storage for each address.
---
 src/client/Client.cc           |   17 +++++++----------
 src/client/Client.h            |    2 +-
 src/include/cephfs/libcephfs.h |    2 +-
 src/libcephfs.cc               |   28 +++++++++++++++-------------
 4 files changed, 24 insertions(+), 25 deletions(-)

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
index 4b2b64f..6a4a20b 100644
--- a/src/include/cephfs/libcephfs.h
+++ b/src/include/cephfs/libcephfs.h
@@ -157,7 +157,7 @@ int ceph_get_file_stripe_unit(struct ceph_mount_info *cmount, int fh);
 int ceph_get_file_pool(struct ceph_mount_info *cmount, int fh);
 int ceph_get_file_replication(struct ceph_mount_info *cmount, int fh);
 int ceph_get_file_stripe_address(struct ceph_mount_info *cmount, int fd,
-				 loff_t offset, char *buf, int buflen);
+				 loff_t offset, struct sockaddr_storage *addr, int naddr);
 
 /* set default layout for new files */
 int ceph_set_default_file_stripe_unit(struct ceph_mount_info *cmount, int stripe);
diff --git a/src/libcephfs.cc b/src/libcephfs.cc
index 153348c..378ce7e 100644
--- a/src/libcephfs.cc
+++ b/src/libcephfs.cc
@@ -584,21 +584,23 @@ extern "C" int ceph_set_default_preferred_pg(struct ceph_mount_info *cmount, int
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
-    return -ERANGE;
-  }
-  len = address.copy(buf, len, 0);
-  buf[len] = '\0'; // write a null char to terminate c-style string
-  return 0;
+    return r;
+
+  for (i = 0; i < (unsigned)naddr && i < address.size(); i++)
+    memcpy(&addr[i], &address[i].ss_addr(), sizeof(*addr));
+
+  return address.size();
 }
 
 extern "C" int ceph_localize_reads(struct ceph_mount_info *cmount, int val)
-- 
1.7.1
