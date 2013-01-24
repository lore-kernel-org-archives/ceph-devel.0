From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 2/2] wireshark: fix indention
Date: Thu, 24 Jan 2013 18:21:21 +0100
Message-ID: <1359048081-17840-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1359048081-17840-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58096 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751992Ab3AXRV0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 Jan 2013 12:21:26 -0500
In-Reply-To: <1359048081-17840-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix indention.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 wireshark/ceph/packet-ceph.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/wireshark/ceph/packet-ceph.c b/wireshark/ceph/packet-ceph.c
index 84bfdd1..5d2c702 100644
--- a/wireshark/ceph/packet-ceph.c
+++ b/wireshark/ceph/packet-ceph.c
@@ -906,19 +906,19 @@ static guint32 dissect_ceph_auth_reply(tvbuff_t *tvb, proto_tree *tree, guint32
 	guint64 global_id;
 	proto_item *ceph_sub_item = NULL;
 	proto_item *ceph_item = proto_tree_get_parent(tree);
-    proto_tree *ceph_auth_reply_tree;
+	proto_tree *ceph_auth_reply_tree;
 
-    ceph_auth_reply_tree = proto_item_add_subtree(ceph_item, ett_ceph);
+	ceph_auth_reply_tree = proto_item_add_subtree(ceph_item, ett_ceph);
 	ceph_sub_item = proto_tree_add_item( tree, hf_ceph_auth_reply, tvb, offset, 16, TRUE );
-    ceph_auth_reply_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
+	ceph_auth_reply_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
 
-    PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"protocol: %d",protocol);
-    PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"result: %d",result);
-    PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letoh64,"global_id: %" G_GUINT64_FORMAT, global_id);
-    PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"payload_len: %d",payload_len);
+	PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"protocol: %d",protocol);
+	PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"result: %d",result);
+	PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letoh64,"global_id: %" G_GUINT64_FORMAT, global_id);
+	PROTO_ADD_SIMPLE_TEXT(ceph_auth_reply_tree,tvb_get_letohl,"payload_len: %d",payload_len);
 
-    str_len = tvb_get_letohl(tvb,offset+payload_len);
-    proto_tree_add_text(ceph_auth_reply_tree, tvb, offset+payload_len, str_len,"%s",tvb_get_const_stringz(tvb,offset,&str_len));
+	str_len = tvb_get_letohl(tvb,offset+payload_len);
+	proto_tree_add_text(ceph_auth_reply_tree, tvb, offset+payload_len, str_len,"%s",tvb_get_const_stringz(tvb,offset,&str_len));
 	return offset;
 }
 
@@ -930,11 +930,11 @@ static guint32 dissect_ceph_pgpools(tvbuff_t *tvb, proto_tree *tree, guint32 off
 	ceph_pgpools_tree = proto_item_add_subtree(ceph_item, ett_ceph);
 	ceph_sub_item = proto_tree_add_item(tree, hf_ceph_pgpools, tvb, offset, -1, TRUE );
 	ceph_pgpools_tree = proto_item_add_subtree(ceph_sub_item, ett_ceph);
-    PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl," %d pool(s)",n);
-    for ( i = 0; i<n; i++){
-        PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl,"data_pg_pool: %d",pool);
-        PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl,"cas_pg_pool: %d",pool);
-    }
+	PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl," %d pool(s)",n);
+	for ( i = 0; i<n; i++){
+		PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl,"data_pg_pool: %d",pool);
+		PROTO_ADD_SIMPLE_TEXT(ceph_pgpools_tree,tvb_get_letohl,"cas_pg_pool: %d",pool);
+	}
 	return offset;
 }
 static guint32 dissect_ceph_mdsmap_node(tvbuff_t *tvb, proto_tree *tree, guint32 offset){
@@ -954,14 +954,14 @@ static guint32 dissect_ceph_mdsmap_node(tvbuff_t *tvb, proto_tree *tree, guint32
 	infoversion = *tvb_get_ptr(tvb,offset,sizeof(infoversion));
 	offset++;
 	offset+=sizeof(guint64);
-    proto_tree_add_text(ceph_mdsnode_tree, tvb, offset, sizeof(infoversion), "version: %d", infoversion);
+	proto_tree_add_text(ceph_mdsnode_tree, tvb, offset, sizeof(infoversion), "version: %d", infoversion);
 	PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64,"Name length: %d",field);
-    proto_tree_add_text(ceph_mdsnode_tree, tvb, offset, field,"MDS name: %s",tvb_get_const_stringz(tvb,offset,&field));
-    offset+=field-1;
-    PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"mds: %d",field);
-    PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"inc: %d",field);
-    PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"state: %d",field);
-    PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64,"state seq: %" G_GUINT64_FORMAT, field64);
+	proto_tree_add_text(ceph_mdsnode_tree, tvb, offset, field,"MDS name: %s",tvb_get_const_stringz(tvb,offset,&field));
+	offset+=field-1;
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"mds: %d",field);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"inc: %d",field);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letohl,"state: %d",field);
+	PROTO_ADD_SIMPLE_TEXT(ceph_mdsnode_tree,tvb_get_letoh64,"state seq: %" G_GUINT64_FORMAT, field64);
 	offset = dissect_ceph_entity_addr(tvb, ceph_mdsnode_tree, offset);
 	cephtime = (struct ceph_timespec *) tvb_get_ptr(tvb, offset, sizeof(struct ceph_timespec));
 	time = cephtime->tv_sec;
-- 
1.8.1.1

