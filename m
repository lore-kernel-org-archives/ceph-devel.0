From: John Spray <john.spray@redhat.com>
Subject: [PATCH 7/7] ceph: include osd epoch barrier in debugfs
Date: Tue,  4 Nov 2014 14:34:29 +0000
Message-ID: <1415111669-26246-8-git-send-email-john.spray@redhat.com>
References: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35570 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbaKDOfS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 09:35:18 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so13779929wgg.18
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 06:35:17 -0800 (PST)
In-Reply-To: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Spray <john.spray@redhat.com>

This is useful in our automated testing, so that
we can verify that the barrier is propagating
correctly between servers and clients.

Signed-off-by: John Spray <john.spray@redhat.com>
---
 fs/ceph/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 5d5a4c8..60db629 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -174,6 +174,9 @@ static int mds_sessions_show(struct seq_file *s, void *ptr)
 	/* The -o name mount argument */
 	seq_printf(s, "name \"%s\"\n", opt->name ? opt->name : "");
 
+	/* The latest OSD epoch barrier known to this client */
+	seq_printf(s, "osd_epoch_barrier \"%d\"\n", mdsc->cap_epoch_barrier);
+
 	/* The list of MDS session rank+state */
 	for (mds = 0; mds < mdsc->max_sessions; mds++) {
 		struct ceph_mds_session *session =
-- 
1.9.3

