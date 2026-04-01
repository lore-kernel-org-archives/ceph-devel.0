Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB98441044
	for <ceph-devel@vger.kernel.org>; Wed,  1 Apr 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051636; cv=none; b=uPqWDV6PhUBA3zEvyJFI2GHiMWf10otgeoANUWL/x4nFNFHO8KhL0fpJJeva2K2lSvJgIvHNxfqQvG6bI9/d8ytlBHSbzg3/eFFfR01EYzJAVEWJgw8G5Hqx+Ocz00U53BxLIm1fbI4Cd/3ucQ2h46trtJ6kcuxhccUkHrb85t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051636; c=relaxed/simple;
	bh=PL2deJ1Ioxf9Luq1AwHvWsnnbg0kQ+qiqnqsW/3Qi9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTNTz5AIJG3QcCaigKc4PnN1ObGq0/6ZXGsAJ4TZZVU9WCFkNZt3LfBw98KI6OjXeJ9SEB8zSafc1WboUUQTw1GKuF/FJKG8Evo3VvY567tycIjFndbRS6q+RGhnNJgbHTG8xnF7KWhl5x50Bv2cxPWGzKfIYPSBvsv3LcIgdxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=rfwt7Zf4; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="rfwt7Zf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1775051537; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=PL2deJ1Ioxf9Luq1AwHvWsnnbg0kQ+qiqnqsW/3Qi9g=;
 b=rfwt7Zf49j645zm3ZbRnHrPmMOaLxtVlhxys3R0RWNZ1TSNai7sQZJckowbtRHmLezCWM
 jUjb4pJYOzP7FWx87m+HtIzro57q/qxtgRkFqCuJ2ZiMAFTrUKYwO/pr+tLKU7UovbKmRZL
 PRJB2dkR0YTrBznzbyOYMFQgGkpn9QCpLhglZcGw6xvmCAOgN12VyWA1WmfB/Hh1nBZ1iaa
 WvR9tJ0vXKorJPVFN4SnX2XfvWCOp6dol9Fp5W3xhlDvtliSQPLHRfobT0hvOKXvmcFxqyl
 3tNACWQDCOXMYzpwOZjo7eMuynXCMgCsVvFbePcAggTzV4WRtL/4jIy8DKcw==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 7DF9C5FCE0;
	Wed,  1 Apr 2026 15:52:17 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 0371E5FA9C;
	Wed,  1 Apr 2026 15:52:13 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Fix potential out-of-bounds access in crush_decode()
Date: Wed,  1 Apr 2026 15:51:32 +0200
Message-ID: <20260401135132.3642689-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A message of type CEPH_MSG_OSD_MAP containing a crush map with at least
one bucket has two fields holding the bucket algorithm. If the values
in these two fields differ, an out-of-bounds access can occur. This is
the case because the first algorithm field (alg) is used to allocate
the correct amount of memory for a bucket of this type, while the second
algorithm field inside the bucket (b->alg) is used in the subsequent
processing.

This patch fixes the issue by adding a check that compares alg and
b->alg and aborts the processing in case they differ. Furthermore,
b->alg is set to 0 in this case, because the destruction of the crush
map also uses this field to determine the bucket type, which can again
result in an out-of-bounds access when trying to free the memory pointed
to by the fields of the bucket.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osdmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index c89e66d4fcb7..daae4230bf38 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -516,6 +516,10 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 		b->id = ceph_decode_32(p);
 		b->type = ceph_decode_16(p);
 		b->alg = ceph_decode_8(p);
+		if(b->alg != alg) {
+			b->alg = 0;
+			goto bad;
+		}
 		b->hash = ceph_decode_8(p);
 		b->weight = ceph_decode_32(p);
 		b->size = ceph_decode_32(p);
-- 
2.47.3

