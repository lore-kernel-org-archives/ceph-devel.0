From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 30/33] libceph: add support for primary_temp mappings
Date: Thu, 27 Mar 2014 20:18:16 +0200
Message-ID: <1395944299-21970-31-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:42452 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161AbaC0STe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:34 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so3247221eek.32
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:33 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id p8sm5965332eef.26.2014.03.27.11.19.32
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:33 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Change apply_temp() to override primary in the same way pg_temp
overrides osd set.  primary_temp overrides pg_temp primary too.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 7193b012ee02..ed52b47d0ddb 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1590,7 +1590,7 @@ static int raw_to_up_osds(struct ceph_osdmap *osdmap,
 }
 
 /*
- * Given up set, apply pg_temp mapping.
+ * Given up set, apply pg_temp and primary_temp mappings.
  *
  * Return acting set length.  *primary is set to acting primary osd id,
  * or -1 if acting set is empty.
@@ -1637,6 +1637,11 @@ static int apply_temps(struct ceph_osdmap *osdmap,
 		temp_primary = *primary;
 	}
 
+	/* primary_temp? */
+	pg = __lookup_pg_mapping(&osdmap->primary_temp, pgid);
+	if (pg)
+		temp_primary = pg->primary_temp.osd;
+
 	*primary = temp_primary;
 	return temp_len;
 }
-- 
1.7.10.4

