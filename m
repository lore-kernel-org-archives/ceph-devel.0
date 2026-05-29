Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E16324B33
	for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040594; cv=none; b=CgTV+Y/lMkrmBao+g/GQtSZJgkjDeVvJ4TBpkIkua8AKNMbyvV3NYnJTKI+8KPAE+v9XVzGhpJnOJ4iUjFjsckovl26wA4LBeb7cIEuXAdMVZARQoejrxdsg2MK3JZIQyVIvKgly8gnBZU2Jka4GCrd3NcwjOur+QiEwi6KTzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040594; c=relaxed/simple;
	bh=Av4mpSvqwsrH+PO0hfuguG9t/EOK5SHapbCKIedCSjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D2Oqel8QDqAquw1E+pD/Tgq1V2Z4gZSPNXGGDHgXBO3JnkpNzkOGzMZdgkEhHLma2Bdvzn3T2Rf92tSMRW5Qkm/zBYYCiaXfczOlnAQAOizsEmxG9DcjL5+m9GTFcpLZt+wkw0aAAmYFsyeE7q77GlGZ3v0IPWjtBJiAmXadZ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=sST3b5WD; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="sST3b5WD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1780040590; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=Av4mpSvqwsrH+PO0hfuguG9t/EOK5SHapbCKIedCSjk=;
 b=sST3b5WD/NPUeflo4Ultap+KBSE8rXXnb2yJ2l/qCFWgTJeCUn/AkVkEXrNfIu97IAssA
 OYlL+NcU7Lr2V6Assdn6fBEz5dbz4qosP0bOCI7fd+gmXfnLpCKxj0mKEmlBatwd9NE/8nG
 LIG7qdNhH4UMG+8eMHU7drQ3qqblu4/mRklbPnhTUKmXYeIGabnyaAbjN18Gz3N9UBoKmWA
 tlrOkbCsgRbfjN2vsZuOaGbOsaNxs6b/2Th6NsCErpnkbGjGG9Tvg/NozCuVFV18BIhZ32i
 I0rakFsaJzbJrqFSYVPJQ/wnYjMf4lk3r5eccXj7b/Iotlf1IwzqQTH+6oUA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 8DCBB600E5;
	Fri, 29 May 2026 09:43:10 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 6F4435FC31;
	Fri, 29 May 2026 09:43:10 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v3] libceph: Reject monmaps advertising zero monitors
Date: Fri, 29 May 2026 09:42:57 +0200
Message-ID: <20260529074257.3707361-1-raphael.zimmer@tu-ilmenau.de>
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
num_mon > CEPH_MAX_MON. Additionally, a log output is added for unusual
values of num_mon.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/mon_client.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index d2cdc8ee3155..33eb4baa5a10 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -114,9 +114,13 @@ static struct ceph_monmap *ceph_monmap_decode(void **p, void *end, bool msgr2)
 
 	dout("%s fsid %pU epoch %u num_mon %u\n", __func__, &fsid, epoch,
 	     num_mon);
-	if (num_mon > CEPH_MAX_MON)
+	if (num_mon == 0 || num_mon > CEPH_MAX_MON)
 		goto e_inval;
 
+	if (num_mon == 1 || (num_mon & 1) == 0)
+		pr_notice_ratelimited("received monmap with unusual num_mon %u\n",
+				      num_mon);
+
 	monmap = kmalloc_flex(*monmap, mon_inst, num_mon, GFP_NOIO);
 	if (!monmap) {
 		ret = -ENOMEM;
-- 
2.47.3

