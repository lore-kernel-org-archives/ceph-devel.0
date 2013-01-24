From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 1/2] wireshark: fix guint64 print format handling
Date: Thu, 24 Jan 2013 18:21:20 +0100
Message-ID: <1359048081-17840-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1359048081-17840-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58101 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754298Ab3AXRV0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 Jan 2013 12:21:26 -0500
In-Reply-To: <1359048081-17840-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Use G_GUINT64_FORMAT to handle print format of guint64 correctly.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 wireshark/ceph/packet-ceph.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/wireshark/ceph/packet-ceph.c b/wireshark/ceph/packet-ceph.c
index 08826fb..84bfdd1 100644
--- a/wireshark/ceph/packet-ceph.c
+++ b/wireshark/ceph/packet-ceph.c
@@ -914,7 +914,7 @@ static guint32 dissect_ceph_auth_reply(tvbuff_t *tvb, proto_tree *tree, guint32
 
     PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"protocol: %d",protocol);
     PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"result: %d",result);
-    PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letoh64,"global_id: %lu", global_id);
+    PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letoh64,"global_id: %" G_GUINT64_FORMAT, global_id);
     PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"payload_len: %d",payload_len);
 
     str_len = tvb_get_letohl(tvb,offset+payload_len);
@@ -950,7 +950,7 @@ static guint32 dissect_ceph_mdsmap_node(tvbuff_t *tvb, proto_tree *tree, guint32
 	ceph_sub_item = proto_tree_add_item(tree, hf_ceph_mdsnode, tvb, offset, -1, TRUE );
 	ceph_mdsnode_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
 
-	PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64,"Global ID: %ld",global_id);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64,"Global ID: %" G_GUINT64_FORMAT, global_id);
 	infoversion = *tvb_get_ptr(tvb,offset,sizeof(infoversion));
 	offset++;
 	offset+=sizeof(guint64);
@@ -961,7 +961,7 @@ static guint32 dissect_ceph_mdsmap_node(tvbuff_t *tvb, proto_tree *tree, guint32
     PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"mds: %d",field);
     PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"inc: %d",field);
     PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"state: %d",field);
-    PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64,"state seq: %ld",field64);
+    PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64,"state seq: %" G_GUINT64_FORMAT, field64);
 	offset = dissect_ceph_entity_addr(tvb, ceph_mdsnode_tree, offset);
 	cephtime = (struct ceph_timespec *) tvb_get_ptr(tvb, offset, sizeof(struct ceph_timespec));
 	time = cephtime->tv_sec;
@@ -1031,7 +1031,7 @@ static guint32 dissect_ceph_mds_map(tvbuff_t *tvb, proto_tree *tree, guint32 off
 	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_root: %i",plop);
 	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_session_timeout: %i",plop);
 	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_session_autoclose: %i",plop);
-	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letoh64,"m_maxfile_size: %ld",max_filesize);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letoh64,"m_maxfile_size: %" G_GUINT64_FORMAT, max_filesize);
 	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"m_max_mds: %i",plop);
 	PROTO_ADD_SIMPLE_TEXT(ceph_mdsmap_tree,tvb_get_letohl,"n: %i",len);
 
-- 
1.8.1.1

