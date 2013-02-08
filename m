From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 4/6] wireshark: fix some memory leaks
Date: Fri,  8 Feb 2013 17:25:01 +0100
Message-ID: <1360340703-7170-5-git-send-email-danny.al-gaaf@bisect.de>
References: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:39586 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946751Ab3BHQZG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:25:06 -0500
In-Reply-To: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix some memory leaks in packet-ceph.c. Error from cppcheck was:

[wireshark/ceph/packet-ceph.c:215]: (error) Memory leak: plop
[wireshark/ceph/packet-ceph.c:237]: (error) Memory leak: plop
[wireshark/ceph/packet-ceph.c:543]: (error) Memory leak: fsid_dec

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 wireshark/ceph/packet-ceph.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/wireshark/ceph/packet-ceph.c b/wireshark/ceph/packet-ceph.c
index 5d2c702..2a4e31f 100644
--- a/wireshark/ceph/packet-ceph.c
+++ b/wireshark/ceph/packet-ceph.c
@@ -209,8 +209,8 @@ static gint ett_ceph_footer = -1;
 
 const char *ceph_cap_op_name(int op)
 {
-        char* plop = malloc(16*sizeof(char));
-        sprintf(plop,"%i",op);
+        char* plop;
+
         switch (op) {
         case CEPH_CAP_OP_GRANT: return "grant";
         case CEPH_CAP_OP_REVOKE: return "revoke";
@@ -226,13 +226,17 @@ const char *ceph_cap_op_name(int op)
         case CEPH_CAP_OP_RELEASE: return "release";
         case CEPH_CAP_OP_RENEW: return "renew";
         }
+
+        plop = malloc(16*sizeof(char));
+        sprintf(plop,"%i",op);
+
         return plop;
 }
 
 const char *ceph_mds_op_name(int op)
 {
-  char* plop = malloc(16*sizeof(char));
-         sprintf(plop,"%i",op);
+	char* plop;
+
         switch (op) {
         case CEPH_MDS_OP_LOOKUP:  return "lookup";
         case CEPH_MDS_OP_LOOKUPHASH:  return "lookuphash";
@@ -261,6 +265,10 @@ const char *ceph_mds_op_name(int op)
         case CEPH_MDS_OP_SETFILELOCK: return "setfilelock";
         case CEPH_MDS_OP_GETFILELOCK: return "getfilelock";
         }
+
+	plop = malloc(16*sizeof(char));
+        printf(plop,"%i",op);
+
         return plop;
 }
 
@@ -533,13 +541,14 @@ static guint32 dissect_ceph_fsid(tvbuff_t *tvb, proto_tree *tree, guint32 offset
 	fsid_dec = malloc(4*sizeof(guint32));
 	fsid = *(struct ceph_fsid *)tvb_get_ptr(tvb, offset, sizeof(struct ceph_fsid));
 	memcpy(fsid_dec,fsid.fsid,4*sizeof(guint32));
-	proto_tree_add_text(tree, tvb, offset,sizeof(struct ceph_fsid), "fsid: %x-%x-%x-%x",
+	proto_tree_add_text(tree, tvb, offset, sizeof(struct ceph_fsid), "fsid: %x-%x-%x-%x",
 			ntohl(fsid_dec[0]),
 			ntohl(fsid_dec[1]),
 			ntohl(fsid_dec[2]),
 			ntohl(fsid_dec[3])
 			);
 	offset += sizeof(struct ceph_fsid);
+	free (fsid_dec);
 	return offset;
 }
 
-- 
1.8.1.2

