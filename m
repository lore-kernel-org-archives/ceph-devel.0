From: xiubli@redhat.com
Subject: [PATCH] ceph: check the sesion state and return false in case it is closed
Date: Fri, 17 Jul 2020 09:25:13 -0400
Message-ID: <20200717132513.8845-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24493 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726071AbgGQNZe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jul 2020 09:25:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org, zyan@redhat.com, pdonnell@redhat.com, vshankar@redhat.com, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

If the session is already in closed state, we should skip it.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 887874f8ad2c..2af773168a0a 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4302,6 +4302,7 @@ bool check_session_state(struct ceph_mds_session *s)
 	}
 	if (s->s_state == CEPH_MDS_SESSION_NEW ||
 	    s->s_state == CEPH_MDS_SESSION_RESTARTING ||
+	    s->s_state == CEPH_MDS_SESSION_CLOSED ||
 	    s->s_state == CEPH_MDS_SESSION_REJECTED)
 		/* this mds is failed or recovering, just wait */
 		return false;
-- 
2.27.0.221.ga08a83d.dirty
