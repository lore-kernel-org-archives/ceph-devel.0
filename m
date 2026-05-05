Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1296130B51F
	for <ceph-devel@vger.kernel.org>; Tue,  5 May 2026 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972120; cv=none; b=nZ5GDU+U4C+qZkwbojHwXJgREQnA31uDT4Hmgb5QDk1niB5RzWjHQGd77ypdccOef/E0ZcmDuvxQs9lEkVwGbNW4SbJj0G3osxRLHY9niKRCsE5jfFfPjFZk12HuGo755pIfs9CrtXrFCOiEG5NHuTS9MG/9nCvH05kCyMf1B+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972120; c=relaxed/simple;
	bh=saMbbgsiHorRSNWuz9hD3kDsVGauamRD+VzZPUHVHm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CmCoFKq8jq5iHvTaL6V3RubMyjw1GfOi7xIhCEPnnuMt8dvgd5W/GhJjJLn7sEIIQgbuuDcqoEei6VVxenpLY4KV9lisXj2tJY3C4nvZ/zCErmHh4kqbJRMysGT5P+GqB434CNBxUO+DUccTF3kqqJe2nVfc4pYuw569wUObUbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=ErG0M0+3; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="ErG0M0+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1777972110; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=saMbbgsiHorRSNWuz9hD3kDsVGauamRD+VzZPUHVHm4=;
 b=ErG0M0+3JF0lcpsA+zWil7uPhv61hzJb+AGa/TXNnOy5tjZdQTXSuFLkZ74JngGrRBUkm
 AOTFGxCd2wzDHdmUjDn00eO7f/cicvtIR088/RlPdRke3G6qpR5PUeQuD8zaGy3h9rhO0gJ
 WB8U4xQpTyO/gs3WTwMExSAg7CY/392ZcSU0uLab9ba/Z191TbloEKVIRkymMxBq7jMs1+o
 7KXv69i4EuFcXUHXqlrgiqWbKjeHy7lgk2/BPEJf9Ad0LqiiOh7PHRDjEGk1mpPq2/2fs76
 kI60nGTedrXt51Id6hZkTEfqHXxDSls/B77I2f9Mdq7VYwwr0NcLSgDALo2w==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 146495FE85;
	Tue,  5 May 2026 11:08:30 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id B1D245FA9C;
	Tue,  5 May 2026 11:08:29 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Fix potential out-of-bounds access in osdmap_decode()
Date: Tue,  5 May 2026 11:08:12 +0200
Message-ID: <20260505090812.500588-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When decoding osd_state and osd_weight from an incoming osdmap in
osdmap_decode(), both are decoded for each osd, i.e., map->max_osd
times. The ceph_decode_need() check only accounts for
sizeof(*map->osd_weight) once. This can potentially result in an
out-of-bounds memory access if the incoming message is corrupted such
that the max_osd value exceeds the actual content of the osdmap message.

This patch fixes the issue by changing the corresponding part in the
ceph_decode_need() check to account for
map->max_osd*sizeof(*map->osd_weight).

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 669348d883f0..2095e73ccf6c 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1705,7 +1705,7 @@ static int osdmap_decode(void **p, void *end, bool msgr2,
 	ceph_decode_need(p, end, 3*sizeof(u32) +
 			 map->max_osd*(struct_v >= 5 ? sizeof(u32) :
 						       sizeof(u8)) +
-				       sizeof(*map->osd_weight), e_inval);
+			 map->max_osd*sizeof(*map->osd_weight), e_inval);
 	if (ceph_decode_32(p) != map->max_osd)
 		goto e_inval;
 
-- 
2.47.3

