Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BC3B775A
	for <ceph-devel@vger.kernel.org>; Wed,  1 Jul 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921401; cv=none; b=c5afCUnM0+7ERYo3okGPGIZd57jGpQ69WINIbHmI60Cjz+ZrRAH6tOJ0YaEpjf/+C81lJ8VCCiP2nUnZ53nnHRb1lPPgRRQv635osbPBBvNoWal7Zu0Bqvoe3F+ekWDIhyvrU1AWNa1h5h/HTHr74BLM9uciN4/gsZIGszU23TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921401; c=relaxed/simple;
	bh=hjHtRsQbXMiP7PRq1kljbMgL2Fbjp8gba+l8eZeYZXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hzMYb7LSHa/C8Kiy3FrGlHX/JPtrpx6fFIiCjQMVezuoZgOZluQniX+3LUNGtTYdQsKQdAZatb0GJ33UTacgXzRbpNkSbQ4TmnK3gIL4bJ8nRHFFYVyES1sG6tcyhzLw1zRcjzuiTbWrNNEPakRfOrrIHCOFS0erByOJ4emdHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=IwphfnOw; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="IwphfnOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1782921397; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=hjHtRsQbXMiP7PRq1kljbMgL2Fbjp8gba+l8eZeYZXM=;
 b=IwphfnOwRZxggec9xXDlF+TLnAbt72oN9yX3gcxjLxJbREps9OnN5q64bHxe3q9jlzq2R
 w8e0OxTx3esZF27LZ/tg0ixO2MxGKNTOaU7webDDzXLAWGvq6q45or442Nxab2B+t0+Y0y9
 SXGh8AmpaZjk1IVBQ5+sbMjUePvCxadJsvwI9U+huS39N/PSfRI++6JFym+qa6H5Pbh40xl
 nBBELzrGc4a8h/MbEKpnIyJl76wXbwaq0tRWxbDKlfpZ/sTCn6TtmlQ7RFvE++MXw1HOuue
 cMfqLu51dfZVq0J+P5RPA5frzF0jAmb2OPWJ1iunHCv/CzchknxEUkyRoWMA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id E302F5FC43;
	Wed,  1 Jul 2026 17:56:37 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id C46DB5FA0F;
	Wed,  1 Jul 2026 17:56:37 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Assign requests to homeless osd if calculated osd exceeds max_osd
Date: Wed,  1 Jul 2026 17:56:10 +0200
Message-ID: <20260701155610.3133868-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A corrupted osdmap received from a Ceph monitor or OSD may contain
placement groups with osd indices that don't exist, i.e., that are
greater than max_osd or smaller than CEPH_HOMELESS_OSD (-1).
Subsequently, this may lead to calc_target() returning such an index as
target osd for a (linger) request. Because the osd_state, osd_weight,
and osd_addr arrays only contain max_osd entries (with indices 0 to
max_osd -1), this leads to out-of-bounds accesses when trying to read
values from these arrays.

This patch fixes the issue by adding a check to calc_target() assigning
the request to the homeless osd if the target osd index read from the
osdmap falls outside the valid osd index range.

Fixes: 63244fa123a7 ("libceph: introduce ceph_osd_request_target, calc_target()")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osd_client.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a4d3cbfd27a3..3d13226a5d1f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1707,6 +1707,12 @@ static enum calc_target_result calc_target(struct ceph_osd_client *osdc,
 		}
 	}
 
+	if (t->osd != CEPH_HOMELESS_OSD && (u32)t->osd >= osdc->osdmap->max_osd) {
+		t->osd = CEPH_HOMELESS_OSD;
+		ct_res = CALC_TARGET_NEED_RESEND;
+		goto out;
+	}
+
 	if (unpaused || legacy_change || force_resend || split)
 		ct_res = CALC_TARGET_NEED_RESEND;
 	else
-- 
2.47.3

