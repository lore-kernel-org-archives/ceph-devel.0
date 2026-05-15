Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0541A3F7877
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778832750; cv=none; b=l2w42grAKgMdSDa71VX1+twPwo9ru2GAbNvRQpTJOF5xZnk2r2mHxFq7Md6HO2pwIOxrscDcfcDEcFvI8SpGuZ/8llEdtL8mpV9SElD8ZnaOXQ/dsPCE55Jw7+G5ik4mYzwq9qn3vgHt1LPgeQeSSRqd6mglDFjYdXLhGYESN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778832750; c=relaxed/simple;
	bh=DrDvviWv/BDFBgvGoGUT6b6YAPzK2sH3umIcYfwmXmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/dZKRT89HLhp1teajpY9oQGK1Tb6nelQ5G6K98Xcfpz25NgldV8lLm+Z9EvIjkREOxNWViQ+vg3jLmBO465I7pYhc7NmO+Y1Tjq53ZZIW9doPjoXsWcpmGw47KPMORGTozCXJ4KxEhVBeLwwh/LXqs9xBsTOvHC8uYmhUVeVvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=dIczhfve; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="dIczhfve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1778832746; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=DrDvviWv/BDFBgvGoGUT6b6YAPzK2sH3umIcYfwmXmw=;
 b=dIczhfveSQkmwUmOQU7jJ36cIHyyqtoRhxriY+UQQ/8TkFPf8nArLmEzQikAChUDbzRR/
 bD72+Pwcme1UvgjM1pjOg1NCeEc/yGYO4+p/DcUlJSIJcJReLN+dyXYa/ap2rrjcfzClBUh
 WU1qSFaW8MnZYO8PGKbKqtCtyIugO1G4gjV07GQ1krK3bu49959RlUfnY9VDZkW5AuTMXxE
 2CFnitpUnVNaRh5gr8VKyo0P7FsQ/KX1QNLwHvhMUO/waFfqXHWu7xTYZJwOx2CWSbnv97l
 psRIwCmrL+cU3W09jHtVUwpiPNum4QoinjTE/DrTdsBA9Iy8yLHYHFwUdRYg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id F15B65FC70;
	Fri, 15 May 2026 10:12:25 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id D72025FB21;
	Fri, 15 May 2026 10:12:25 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Fix multiplication overflow in __decode_pg_upmap_items()
Date: Fri, 15 May 2026 10:11:32 +0200
Message-ID: <20260515081132.1570541-1-raphael.zimmer@tu-ilmenau.de>
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

This patch fixes the issue by adding a UL suffix to the literal in the
multiplication to perform it as an unsigned long multiplication.
Furthermore, the result is stored in a local variable to only perform
the multiplication once.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osdmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 8b5b0587a0cf..d416a11ce0ca 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1615,13 +1615,15 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
 {
 	struct ceph_pg_mapping *pg;
 	u32 len, i;
+	size_t payload_len;
 
 	ceph_decode_32_safe(p, end, len, e_inval);
 	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
 		return ERR_PTR(-EINVAL);
 
-	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
-	pg = alloc_pg_mapping(2 * len * sizeof(u32));
+	payload_len = 2UL * len * sizeof(u32);
+	ceph_decode_need(p, end, payload_len, e_inval);
+	pg = alloc_pg_mapping(payload_len);
 	if (!pg)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.47.3

