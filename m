From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 03/33] libceph: dump pg_temp mappings to debugfs
Date: Thu, 27 Mar 2014 20:17:49 +0200
Message-ID: <1395944299-21970-4-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:63327 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbaC0SSb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:31 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so3225579eek.34
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:30 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id m42sm5964265eex.21.2014.03.27.11.18.29
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:29 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dump pg_temp mappings to /sys/kernel/debug/ceph/<client>/osdmap,
one 'pg_temp <pgid> [<osd>, ..., <osd>]' per line, e.g:

    pg_temp 2.6 [2,3,4]

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/debugfs.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 112d98edb156..c45d235e774e 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -82,6 +82,17 @@ static int osdmap_show(struct seq_file *s, void *p)
 			   ((map->osd_weight[i]*100) >> 16),
 			   ceph_osdmap_state_str(sb, sizeof(sb), state));
 	}
+	for (n = rb_first(&map->pg_temp); n; n = rb_next(n)) {
+		struct ceph_pg_mapping *pg =
+			rb_entry(n, struct ceph_pg_mapping, node);
+
+		seq_printf(s, "pg_temp %llu.%x [", pg->pgid.pool,
+			   pg->pgid.seed);
+		for (i = 0; i < pg->len; i++)
+			seq_printf(s, "%s%d", (i == 0 ? "" : ","),
+				   pg->osds[i]);
+		seq_printf(s, "]\n");
+	}
 
 	return 0;
 }
-- 
1.7.10.4

