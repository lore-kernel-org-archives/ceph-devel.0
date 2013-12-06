From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 08/12] ceph: handle session flush message
Date: Fri,  6 Dec 2013 16:46:39 +0800
Message-ID: <1386319603-2610-9-git-send-email-zheng.z.yan@intel.com>
References: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23373 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174Ab3LFIqy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:54 -0500
In-Reply-To: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c         | 19 +++++++++++++++++++
 fs/ceph/strings.c            |  2 ++
 include/linux/ceph/ceph_fs.h |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 46aac75..a8dd8b0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1137,6 +1137,21 @@ static int send_renew_caps(struct ceph_mds_client *mdsc,
 	return 0;
 }
 
+static int send_flushmsg_ack(struct ceph_mds_client *mdsc,
+			     struct ceph_mds_session *session, u64 seq)
+{
+	struct ceph_msg *msg;
+
+	dout("send_flushmsg_ack to mds%d (%s)s seq %lld\n",
+	     session->s_mds, session_state_name(session->s_state), seq);
+	msg = create_session_msg(CEPH_SESSION_FLUSHMSG_ACK, seq);
+	if (!msg)
+		return -ENOMEM;
+	ceph_con_send(&session->s_con, msg);
+	return 0;
+}
+
+
 /*
  * Note new cap ttl, and any transition from stale -> not stale (fresh?).
  *
@@ -2396,6 +2411,10 @@ static void handle_session(struct ceph_mds_session *session,
 		trim_caps(mdsc, session, le32_to_cpu(h->max_caps));
 		break;
 
+	case CEPH_SESSION_FLUSHMSG:
+		send_flushmsg_ack(mdsc, session, seq);
+		break;
+
 	default:
 		pr_err("mdsc_handle_session bad op %d mds%d\n", op, mds);
 		WARN_ON(1);
diff --git a/fs/ceph/strings.c b/fs/ceph/strings.c
index 89fa4a9..4440f447 100644
--- a/fs/ceph/strings.c
+++ b/fs/ceph/strings.c
@@ -41,6 +41,8 @@ const char *ceph_session_op_name(int op)
 	case CEPH_SESSION_RENEWCAPS: return "renewcaps";
 	case CEPH_SESSION_STALE: return "stale";
 	case CEPH_SESSION_RECALL_STATE: return "recall_state";
+	case CEPH_SESSION_FLUSHMSG: return "flushmsg";
+	case CEPH_SESSION_FLUSHMSG_ACK: return "flushmsg_ack";
 	}
 	return "???";
 }
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 2ad7b86..26bb587 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -282,6 +282,8 @@ enum {
 	CEPH_SESSION_RENEWCAPS,
 	CEPH_SESSION_STALE,
 	CEPH_SESSION_RECALL_STATE,
+	CEPH_SESSION_FLUSHMSG,
+	CEPH_SESSION_FLUSHMSG_ACK,
 };
 
 extern const char *ceph_session_op_name(int op);
-- 
1.8.1.4

