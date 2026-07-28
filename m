Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5F414A2B
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228249; cv=none; b=YnJesEpRNj/30Yvl+kJAIodMmRLRyMSs47JgALq/NATcRbj8U90ocRhM93sg7dk2pP/iK1Pr1sDk1pHdYdaP+aSCdfOzfxBkACZq6ybxI2vPHKc5lGqTVD8veltzYtW+FWISzbBXHZCZcs/I8KGyMvqddYR4Tx119Jwu5Z8Ubso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228249; c=relaxed/simple;
	bh=SD7hSPD+ac2juXnqugBhE0435docKhmB5oIfPw1vPjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hkwqgSK7SCKnysUJEY4Smqsxfj3uQVLsLW3tloiWoqhVZtFnhMiqeX+mmhiJBYZ4DIVp3z9riG7xks2lYHF84AMI+dAbjutDZbqDK+m3BpCYJnhZ2SuuLNjsfbul6eYJz5/ZPApBDNl9L9uT6MTvmvu7NDBa9umdAAH+V7/nEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=ISa4YeYc; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="ISa4YeYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1785228244; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=SD7hSPD+ac2juXnqugBhE0435docKhmB5oIfPw1vPjQ=;
 b=ISa4YeYciQbh07xykBLn/+U847JFaWvrX00OIpyBpJrj20azZLC0Y0X/eCUfEpJ6kqapK
 yzvyt6+ikBPuvzTtME132XeifdlhPNXgqXLnCGvFSxHcS+n97pf/q3PhA5xqHCJaiCJFkla
 MjbmDPTgvzQDbRGp6u0a3VqjnLhLh+ATFDQDgSNQ4oTGAIHg5V4HklTMDd2+tma+3FzqRav
 1WAMGrx28bILL5iEhYeFQHVWnJBZniozL5A6fny406oUr6hlj9jBJC1hXY46SEb+ZCB2pk1
 qX2T17WwdnAq3Ut8WxqzhDguALhYUd4PpL15lHQdMUsQKP2GcxDXJ5MeVHVA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 9D0135FC43;
	Tue, 28 Jul 2026 10:44:04 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 85D165FB23;
	Tue, 28 Jul 2026 10:44:04 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v3] libceph: Avoid using invalid osd indices from primary_temp
Date: Tue, 28 Jul 2026 10:43:40 +0200
Message-ID: <20260728084340.45222-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A corrupted osdmap received from a Ceph monitor or OSD may contain osd
indices in its pg_temp, primary_temp, pg_upmap, and pg_upmap_items parts
that don't exist, i.e., that are greater than max_osd or smaller than
CEPH_HOMELESS_OSD (-1). These indices are used to create the up and
acting set in ceph_pg_to_up_acting_osds(), called from calc_target().
While most of these osd indices are checked, the one from primary_temp
is not. Subsequently, this may lead to calc_target() returning this
(potentially invalid) index as target osd for a (linger) request.
Because the osd_state, osd_weight, and osd_addr arrays only contain
max_osd entries (with indices 0 to max_osd -1), this leads to
out-of-bounds accesses when trying to read values from these arrays.

This patch fixes the issue by adding a check to get_temp_osds(), so that
only valid osd indices from primary_temp are used, and it falls back to
using the primary from pg_temp if it is invalid.

Fixes: 63244fa123a7 ("libceph: introduce ceph_osd_request_target, calc_target()")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osdmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index ed58a03b2f5d..5565de128bce 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -2815,9 +2815,10 @@ static void get_temp_osds(struct ceph_osdmap *osdmap,
 		}
 	}
 
-	/* primary_temp? */
+	/* primary_temp? (shouldn't ever be a nonexistent or down OSD) */
 	pg = lookup_pg_mapping(&osdmap->primary_temp, pgid);
-	if (pg)
+	if (pg && !WARN_ON_ONCE(ceph_osd_is_down(osdmap,
+						 pg->primary_temp.osd)))
 		temp->primary = pg->primary_temp.osd;
 }
 
-- 
2.47.3

