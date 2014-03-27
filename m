From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 02/33] libceph: do not prefix osd lines with \t in debugfs output
Date: Thu, 27 Mar 2014 20:17:48 +0200
Message-ID: <1395944299-21970-3-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:47340 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbaC0SS3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:29 -0400
Received: by mail-ee0-f43.google.com with SMTP id e53so3225654eek.30
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:28 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id q41sm5983302eez.7.2014.03.27.11.18.26
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:27 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

To save screen space in anticipation of more fields (e.g. primary
affinity).

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/debugfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index d225842c7b41..112d98edb156 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -77,7 +77,7 @@ static int osdmap_show(struct seq_file *s, void *p)
 		int state = map->osd_state[i];
 		char sb[64];
 
-		seq_printf(s, "\tosd%d\t%s\t%3d%%\t(%s)\n",
+		seq_printf(s, "osd%d\t%s\t%3d%%\t(%s)\n",
 			   i, ceph_pr_addr(&addr->in_addr),
 			   ((map->osd_weight[i]*100) >> 16),
 			   ceph_osdmap_state_str(sb, sizeof(sb), state));
-- 
1.7.10.4

