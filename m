Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3B9366072
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779955237; cv=none; b=J1BGew8F/MIrv78vCHEB9VpWNYQ+SJnT4hLFwOdgONj8+BsY6SCgWLNOPEc5HAFK13xnfUnGTig67GSSLCMairIUXFiVsAs3b0XOEc2iaTXBH0uZ+9tqZjcgw/v8iH4PHtaJPT+0iIOj5UDUCTXL1X2Vl1YUEj7BUkBXCOhUHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779955237; c=relaxed/simple;
	bh=vX0UUsLGcXlYdLjCb+xgKHyuLCH7IpszQeeUEHqvnhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i6UEyFVwR9qRxUCW/HNmEPKPcmJZwAf3TXefhP+7eq68iQ8i35KKbHzUKtSAz8dPvRiHR+5+8VQjXKNemG9p5ehHZM9zHqNvUzegwSuMT/TXZNdL44D2P3sC8tujRqyko+sRxNkdcAcJsfoD9fvIJN4T5wxAxRbc8RGZyHpiPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=WN9v8Q3q; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="WN9v8Q3q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779955231; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=vX0UUsLGcXlYdLjCb+xgKHyuLCH7IpszQeeUEHqvnhw=;
 b=WN9v8Q3qDjzKgh6KekBfW6wRAQovLOqPCf3R4ffH742kPRePSvnSIKk6LuZPm1S9aUSju
 eUKI4O3S9Dkc+qdW2V2bZe0hxzXrxaygGqrvgH3G0WgAzYKNuKMPC9mz/3BBf7Jj+XPwJga
 azrwc99uEiSWLOU4u1c30uXDufrC3SoAhEPkWo0e4n7iocYAbe0Xmv176NBQBBXP7pM0RUO
 GIsc2QnvZQg9MBeF7UXvI7fcjCfVWu6OY6cYI/fHt7kaRny3634HB9JIT1tgGP/KA5upqjE
 w3lsMNs+UOgAkf7YBwqss+5EFp1BnvWKmQRNJad6JJbEcPXtsdAvIBQVzDiw==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id B5BC25FCA3;
	Thu, 28 May 2026 10:00:31 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 87E0E5FC52;
	Thu, 28 May 2026 10:00:30 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Reject monmaps advertising zero monitors
Date: Thu, 28 May 2026 10:00:23 +0200
Message-ID: <20260528080023.3634455-1-raphael.zimmer@tu-ilmenau.de>
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
index d2cdc8ee3155..461a9caa7609 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -114,9 +114,13 @@ static struct ceph_monmap *ceph_monmap_decode(void **p, void *end, bool msgr2)
 
 	dout("%s fsid %pU epoch %u num_mon %u\n", __func__, &fsid, epoch,
 	     num_mon);
-	if (num_mon > CEPH_MAX_MON)
+	if (num_mon == 0 || num_mon > CEPH_MAX_MON)
 		goto e_inval;
 
+	if (num_mon == 1 || (num_mon & 1) == 0)
+		pr_notice("received monmap with unusual num_mon %u\n",
+			  num_mon);
+
 	monmap = kmalloc_flex(*monmap, mon_inst, num_mon, GFP_NOIO);
 	if (!monmap) {
 		ret = -ENOMEM;
-- 
2.47.3

