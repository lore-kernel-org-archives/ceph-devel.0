From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Swift ACL .rlistings support
Date: Tue,  2 Apr 2013 22:07:27 +0800
Message-ID: <1364911647-10771-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:59407 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760984Ab3DBOSY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Apr 2013 10:18:24 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

This patch implements the Swift ACL .rlistings for Radosgw,
it should be seamlessly compatible with earlier version as well
as S3.

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/rgw/rgw_acl.cc       |    3 +++
 src/rgw/rgw_acl.h        |   19 ++++++++++++++-----
 src/rgw/rgw_acl_swift.cc |   14 ++++++++++++++
 src/rgw/rgw_op.cc        |    2 +-
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/src/rgw/rgw_acl.cc b/src/rgw/rgw_acl.cc
index 1a90649..d6255e1 100644
--- a/src/rgw/rgw_acl.cc
+++ b/src/rgw/rgw_acl.cc
@@ -96,6 +96,9 @@ bool RGWAccessControlPolicy::verify_permission(string& uid, int user_perm_mask,
 
   int policy_perm = get_perm(uid, test_perm);
 
+  if (policy_perm & RGW_PERM_READ) {
+    policy_perm |= (test_perm & RGW_PERM_READ_LIST);
+  }
   /* the swift WRITE_OBJS perm is equivalent to the WRITE obj, just
      convert those bits. Note that these bits will only be set on
      buckets, so the swift READ permission on bucket will allow listing
diff --git a/src/rgw/rgw_acl.h b/src/rgw/rgw_acl.h
index c06e9eb..6374413 100644
--- a/src/rgw/rgw_acl.h
+++ b/src/rgw/rgw_acl.h
@@ -15,11 +15,15 @@ using namespace std;
 #define RGW_PERM_WRITE           0x02
 #define RGW_PERM_READ_ACP        0x04
 #define RGW_PERM_WRITE_ACP       0x08
-#define RGW_PERM_READ_OBJS       0x10
-#define RGW_PERM_WRITE_OBJS      0x20
+#define RGW_PERM_READ_OBJS       0x10  // Swift read
+#define RGW_PERM_WRITE_OBJS      0x20  // Swift write
+#define RGW_PERM_READ_LIST       0x40  // Swift .rlistings
 #define RGW_PERM_FULL_CONTROL    ( RGW_PERM_READ | RGW_PERM_WRITE | \
+                                  RGW_PERM_READ_ACP | RGW_PERM_WRITE_ACP | \
+                                  RGW_PERM_READ_LIST )
+#define RGW_PERM_ALL_S3          ( RGW_PERM_READ | RGW_PERM_WRITE | \
                                   RGW_PERM_READ_ACP | RGW_PERM_WRITE_ACP )
-#define RGW_PERM_ALL_S3          RGW_PERM_FULL_CONTROL
+                                 
 
 enum ACLGranteeTypeEnum {
 /* numbers are encoded, should not change */
@@ -47,13 +51,18 @@ public:
   void set_permissions(int perm) { flags = perm; }
 
   void encode(bufferlist& bl) const {
-    ENCODE_START(2, 2, bl);
+    ENCODE_START(3, 2, bl);
     ::encode(flags, bl);
     ENCODE_FINISH(bl);
   }
   void decode(bufferlist::iterator& bl) {
-    DECODE_START_LEGACY_COMPAT_LEN(2, 2, 2, bl);
+    DECODE_START_LEGACY_COMPAT_LEN(3, 2, 2, bl);
     ::decode(flags, bl);
+    if (struct_v <= 2) {
+      ACLGrant grant;
+      grant.set_group(ACL_GROUP_ALL_USERS, RGW_PERM_READ_LIST);
+      acl.add_grant(&grant);
+    }
     DECODE_FINISH(bl);
   }
   void dump(Formatter *f) const;
diff --git a/src/rgw/rgw_acl_swift.cc b/src/rgw/rgw_acl_swift.cc
index b02ce90..af5f804 100644
--- a/src/rgw/rgw_acl_swift.cc
+++ b/src/rgw/rgw_acl_swift.cc
@@ -15,6 +15,7 @@ using namespace std;
 #define SWIFT_PERM_WRITE RGW_PERM_WRITE_OBJS
 
 #define SWIFT_GROUP_ALL_USERS ".r:*"
+#define SWIFT_GROUP_LIST ".rlistings"
 
 static int parse_list(string& uid_list, vector<string>& uids)
 {
@@ -54,6 +55,11 @@ static bool uid_is_public(string& uid)
          sub.compare(".referrer") == 0;
 }
 
+static bool uid_is_list(string& uid)
+{
+  return uid.compare(SWIFT_GROUP_LIST) == 0;
+}
+
 void RGWAccessControlPolicy_SWIFT::add_grants(RGWRados *store, vector<string>& uids, int perm)
 {
   vector<string>::iterator iter;
@@ -64,6 +70,9 @@ void RGWAccessControlPolicy_SWIFT::add_grants(RGWRados *store, vector<string>& u
     if (uid_is_public(uid)) {
       grant.set_group(ACL_GROUP_ALL_USERS, perm);
       acl.add_grant(&grant);
+    } else if ((perm & SWIFT_PERM_READ) && (uid_is_list(uid))) {
+      grant.set_group(ACL_GROUP_ALL_USERS, RGW_PERM_READ_LIST);
+      acl.add_grant(&grant);
     } else if (rgw_get_user_info_by_uid(store, uid, grant_user) < 0) {
       ldout(cct, 10) << "grant user does not exist:" << uid << dendl;
       /* skipping silently */
@@ -116,6 +125,11 @@ void RGWAccessControlPolicy_SWIFT::to_str(string& read, string& write)
       if (grant.get_group() != ACL_GROUP_ALL_USERS)
         continue;
       id = SWIFT_GROUP_ALL_USERS;
+      if (perm & RGW_PERM_READ_LIST) {
+        if (!read.empty())
+          read.append(", ");
+        read.append(SWIFT_GROUP_LIST);
+      }
     }
     if (perm & SWIFT_PERM_READ) {
       if (!read.empty())
diff --git a/src/rgw/rgw_op.cc b/src/rgw/rgw_op.cc
index 43415d4..5c4d95a 100644
--- a/src/rgw/rgw_op.cc
+++ b/src/rgw/rgw_op.cc
@@ -736,7 +736,7 @@ void RGWStatBucket::execute()
 
 int RGWListBucket::verify_permission()
 {
-  if (!verify_bucket_permission(s, RGW_PERM_READ))
+  if (!verify_bucket_permission(s, RGW_PERM_READ | RGW_PERM_READ_LIST))
     return -EACCES;
 
   return 0;
-- 
1.7.9.5


