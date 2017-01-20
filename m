From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v1 6/7] ceph: clean out delayed caps when destroying session
Date: Fri, 20 Jan 2017 10:17:37 -0500
Message-ID: <20170120151738.9584-7-jlayton@redhat.com>
References: <20170120151738.9584-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752293AbdATPRn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Jan 2017 10:17:43 -0500
In-Reply-To: <20170120151738.9584-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jspray@redhat.com, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

On last session put, drop any delayed cap messages that haven't
run yet without processing them.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 28c83454e9f6..05ab69763308 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -361,6 +361,23 @@ static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
 /*
  * sessions
  */
+static void
+drop_delayed_caps(struct ceph_mds_session *session)
+{
+	LIST_HEAD(delayed);
+
+	spin_lock(&session->s_cap_lock);
+	list_splice_init(&session->s_delayed_caps, &delayed);
+	spin_unlock(&session->s_cap_lock);
+
+	while (!list_empty(&delayed)) {
+		struct ceph_msg *msg = list_first_entry(&delayed,
+						struct ceph_msg, list_head);
+		list_del_init(&msg->list_head);
+		ceph_msg_put(msg);
+	}
+}
+
 const char *ceph_session_state_name(int s)
 {
 	switch (s) {
@@ -394,6 +411,7 @@ void ceph_put_mds_session(struct ceph_mds_session *s)
 	     atomic_read(&s->s_ref), atomic_read(&s->s_ref)-1);
 	if (atomic_dec_and_test(&s->s_ref)) {
 		WARN_ON_ONCE(cancel_work_sync(&s->s_delayed_caps_work));
+		drop_delayed_caps(s);
 		if (s->s_auth.authorizer)
 			ceph_auth_destroy_authorizer(s->s_auth.authorizer);
 		kfree(s);
-- 
2.9.3

