From: Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH 3/9] ceph: close some holes in struct ceph_mds_request
Date: Fri, 10 Jan 2020 15:56:41 -0500
Message-ID: <20200110205647.311023-4-jlayton@kernel.org>
References: <20200110205647.311023-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgAJU4w (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:56:52 -0500
In-Reply-To: <20200110205647.311023-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, pdonnell@redhat.com

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/mds_client.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index df18a29f9587..27a7446e10d3 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -234,6 +234,7 @@ struct ceph_mds_request {
 	struct rb_node r_node;
 	struct ceph_mds_client *r_mdsc;
 
+	struct kref       r_kref;
 	int r_op;                    /* mds op code */
 
 	/* operation on what? */
@@ -304,7 +305,6 @@ struct ceph_mds_request {
 	int               r_resend_mds; /* mds to resend to next, if any*/
 	u32               r_sent_on_mseq; /* cap mseq request was sent at*/
 
-	struct kref       r_kref;
 	struct list_head  r_wait;
 	struct completion r_completion;
 	struct completion r_safe_completion;
-- 
2.24.1
