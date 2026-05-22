Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3733A70A
	for <ceph-devel@vger.kernel.org>; Fri, 22 May 2026 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464734; cv=none; b=BNvT0C8RDL+rO6MgdLCo8HIr20xb0jm5nwX2ptnlmGO8RCzW8K2GmDtrcFuRPaBIHllR7LVndmMjLwhuWY5++r2XMzAso3q+LaEZdJ/JDWVuQe62wNQ+UEzzEkZuSg9XNE+6nIuH1Rur3lvUHTSyjn7Ic+mQx31UmPBWMAX0TCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464734; c=relaxed/simple;
	bh=TcKlIOu984ZlttycTX9M0kCWDtOg8YYjbqj9X1TY5+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0gLYc33Qi5MmE/Al0+NhfE9NGBWVT71v1zhscqe34Km5HPgosiYWQxf/HQ94eBRkBF9xteiyGM6NHD0PIB8IagdmCuJ+T6v8AkJ0y8gm0hn1zIT8KNfjzQkmD1TpDNM4RRQLnClupucXEQzRuQncjFfY49pUgUd34U3qbq2LWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=XulOSbIL; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="XulOSbIL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779464719; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=TcKlIOu984ZlttycTX9M0kCWDtOg8YYjbqj9X1TY5+k=;
 b=XulOSbILu9jdAOx0g8yuK+QnjWJ6cjcFgVyT/gWnMw8UQ3qOdVhidPDkTvM6jnkB9UI2T
 /XL6yfQiQqw11WAskC+q8izEA5w5RSCAhDwccTG+3msqYgX2ZLYZA3pynAn/O7CCuNq1E5f
 NFVsJ61tPo4MqEr9HmaVXniBI4oMM+3d5vSzegVDCoscH44GdnGVgsULG4Tc92ZtRD33h/v
 tQRfM63aBi9ObknD80eVUYRPfZ8jR/Fi+ruNgM+hmopCJ9PgVkX8AfukRS9Dui1GPsz1Lf7
 +YGBaqQNHN9ocnfgV2qpC+hWu23OEW2xJyS2Nh5XIJ4HJxrYWMGnw4dQdWUA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 5EFBC5FF33;
	Fri, 22 May 2026 17:45:19 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 34AD95FB24;
	Fri, 22 May 2026 17:45:18 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Reject monmaps advertising zero monitors
Date: Fri, 22 May 2026 17:44:20 +0200
Message-ID: <20260522154420.3324836-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A message of type CEPH_MSG_MON_MAP contains a monmap that is sent from a
monitor to the client. This monmap contains information about the
existing monitors in the cluster. Currently, a monmap indicating that
there are zero monitors in the cluster is treated as valid. However, it
is impossible to have zero monitors in the cluster and still receive a
valid monmap from a monitor. Therefore, such a monmap must be corrupted
and should be treated as invalid. Furthermore, a monmap with a monitor
count of zero can subsequently crash the client when attempting to open
a session with a monitor in __open_session(). This happens because the
"BUG_ON(monc->monmap->num_mon < 1)" assertion in pick_new_mon() is
triggered.

This patch extends a check in ceph_monmap_decode() to also reject
arriving mon_maps with num_mon == 0 rather than only with
num_mon > CEPH_MAX_MON.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/mon_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index d2cdc8ee3155..6c5f83379055 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -114,7 +114,7 @@ static struct ceph_monmap *ceph_monmap_decode(void **p, void *end, bool msgr2)
 
 	dout("%s fsid %pU epoch %u num_mon %u\n", __func__, &fsid, epoch,
 	     num_mon);
-	if (num_mon > CEPH_MAX_MON)
+	if (num_mon > CEPH_MAX_MON || num_mon == 0)
 		goto e_inval;
 
 	monmap = kmalloc_flex(*monmap, mon_inst, num_mon, GFP_NOIO);
-- 
2.47.3

