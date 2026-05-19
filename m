Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9032B128
	for <ceph-devel@vger.kernel.org>; Tue, 19 May 2026 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188501; cv=none; b=rXLcbcWDKq3a8532iwn1IrbfrXK3k8i0BJNHogYSCkbmVD3Cmax7riEebhkik9zNys5Ei/OKzGhluReuzHUTKC5pLiTmU30aGCTIkpRmNYhLoSDYm9tCgB+jCWe3V9fjAsT/T0hhWgKpOSrvzCrKu7eiBA7EDereU815SdS4Mjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188501; c=relaxed/simple;
	bh=gKdcEzkMvSptC/4TGWbsZZjSsqr6KWphxjn9pD3+qlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vwdxap/j/H3lDt+AYSyjavZvYG7Ay23anoiiZiFiEhiGPG5kcdZzYtKud2bAOZxuGblCqt1e8hd8bc0G0Heb2rheRnFUnGwMDwQ9APirVy/RpIYJ/qmpBcJI6IxaZIAKBd/nXrebQXsplY2StYSPjUUCNS4rrYLqZj6KtRxfQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=GgUsfSFZ; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="GgUsfSFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779188497; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=gKdcEzkMvSptC/4TGWbsZZjSsqr6KWphxjn9pD3+qlM=;
 b=GgUsfSFZoOu1e/bKewIBRTvI6WpZhCkIYnYG3Os60ZSuKMplAcJPfFX5Z0PEEH+l3C3Mv
 zaDYIja9A1V58Bdz4giTTBn4YxIGRjBucmg/n7+GvX8etRgBsbinVPL1+XHj8tSaS+/ZdIK
 vw3aAVk1xXJfs1WHuiB3+YmstadzNk3dNJfpJ0qG24aIQpItm+mB+zhOszlpHmvEZMAwQtw
 n3yI8Oz88iwqcjoHjDH7HAAWuG0+qpSB1Xl5H2pVPvk2KqEU0cvAxWIMinMPGaK+YivIo6g
 hgULpYpNbvHBD5IuEwZysJz/OuV3xf+MZrQTaUvgg3WEbgMoeJ4fmDzITq/w==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 9D9C65FD5B;
	Tue, 19 May 2026 13:01:37 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 849CC5FA3E;
	Tue, 19 May 2026 13:01:37 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v3] libceph: Fix multiplication overflow in __decode_pg_upmap_items()
Date: Tue, 19 May 2026 13:01:30 +0200
Message-ID: <20260519110130.2189287-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A message of type CEPH_MSG_OSD_MAP holds an OSD map, which typically
contains a pg_upmap part at its end. When decoding this part in
__decode_pg_upmap_items(), a len value is decoded from the message to
determine the number of items and the size of the allocation needed for
them. If the len value is greater than or equal to 2^31, an overflow
occurs in the multiplication that is performed to determine the needed
size of the incoming buffer to decode, as well as for the length of the
allocation for the ceph_pg_mapping struct. Subsequently, this results in
out-of-bounds writes (and reads) when decoding the incoming message
fields into the ceph_pg_mapping struct.

This patch fixes the issue by splitting the computation into multiple
parts and storing the results in local variables of type size_t. This
prevents the overflow by performing the multiplication in the
appropriate data type and ensures that the result is calculated only
once.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osdmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 8b5b0587a0cf..076763420b1d 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1615,13 +1615,16 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
 {
 	struct ceph_pg_mapping *pg;
 	u32 len, i;
+	const size_t item_size = 2 * sizeof(u32);
+	size_t payload_len;
 
 	ceph_decode_32_safe(p, end, len, e_inval);
-	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
+	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / item_size)
 		return ERR_PTR(-EINVAL);
 
-	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
-	pg = alloc_pg_mapping(2 * len * sizeof(u32));
+	payload_len = len * item_size;
+	ceph_decode_need(p, end, payload_len, e_inval);
+	pg = alloc_pg_mapping(payload_len);
 	if (!pg)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.47.3

