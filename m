From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH RFC 3/6] auth.c: added ceph_entity_name_encode
Date: Tue, 30 Jun 2015 13:27:58 -0700
Message-ID: <6a61ab4e809ccaa6aee711abf727ce0cdda26db8.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbbF3U35 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jun 2015 16:29:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 1EDD3347A62
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 20:29:57 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5UKTrtk018417
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 16:29:56 -0400
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 include/linux/ceph/auth.h |  2 ++
 net/ceph/auth.c           | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/ceph/auth.h b/include/linux/ceph/auth.h
index 260d78b..7687918 100644
--- a/include/linux/ceph/auth.h
+++ b/include/linux/ceph/auth.h
@@ -104,6 +104,8 @@ extern int ceph_handle_auth_reply(struct ceph_auth_client *ac,
 				  void *buf, size_t len,
 				  void *reply_buf, size_t reply_len);
 extern int ceph_entity_name_encode(const char *name, void **p, void *end);
+extern int ceph_entity_name_decode(struct ceph_entity_name *name, void **p,
+				   void *end);
 
 extern int ceph_build_auth(struct ceph_auth_client *ac,
 		    void *msg_buf, size_t msg_len);
diff --git a/net/ceph/auth.c b/net/ceph/auth.c
index 6b923bc..50baee6 100644
--- a/net/ceph/auth.c
+++ b/net/ceph/auth.c
@@ -94,6 +94,17 @@ int ceph_entity_name_encode(const char *name, void **p, void *end)
 	return 0;
 }
 
+int ceph_entity_name_decode(struct ceph_entity_name *name, void **p, void *end)
+{
+	ceph_decode_8_safe(p, end, name->type, bad);
+	ceph_decode_64_safe(p, end, name->num, bad);
+
+	return 0;
+
+bad:
+	return -ERANGE;
+}
+
 /*
  * Initiate protocol negotiation with monitor.  Include entity name
  * and list supported protocols.
-- 
1.9.3

