Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AA3D47B0
	for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037943; cv=none; b=YKlv1H3cQsBT7s/HAwmzKKsBei6TvJD87spBg41dLscmprk0vLztXwhVzBCm03nQbJEeOO5zQRwWrQCxoFP0bNNf0lwoG4xfCvtaNxwtbbyly1F3UDr+0SurnPHo0k1LZDQPZho1/QhVTZsLapHL4xRXsa7HysjkxxEg4HB4gsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037943; c=relaxed/simple;
	bh=4/ZtEsJHoC4I7OKurB3H/l5FTIdK5iZ6oPT2VSHLgB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9wC5a431NyHvi2eoMuj9QkgvloIUGpvlQYadDYoi+zSZThbvRik0iLwyDyUvte1A9DY73QhUPXZpRnI60LkxX5Z3Cn7kXVfdqLUGFUr+XlV0An+Y0gh/FkcmjrkZzGYIvzMGpliIXVP/MdrE9QaNU46Wi3igv5I0XLQ6h6wCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=i1k/C8eK; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="i1k/C8eK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1777037933; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=4/ZtEsJHoC4I7OKurB3H/l5FTIdK5iZ6oPT2VSHLgB8=;
 b=i1k/C8eKhcgGAENc8BDrzxz+QaHVTvNSlsR48S5aOR2GMVcMw/q8ljTbUmiAefHmAiRy0
 s2WtjEbjEqyaFW9WgQcVDMZvF4xDWJKEr0tmNKxzYuTAOwk5cc2ZQPSLx2YVUpxPxojXgiz
 Ld74Mw25Md2OsRwY3YP2yvEYZkGcJHvgBLmRzy/b5hKLoqoe8IArLt5ZsZFFFdF3zbmK7z3
 x9mg55MSw4/l0n8OoB33xzJSCsE2a90NCWnhrqr1e+KQPvKoMC/M9kK+m8UEOHlLqWVa8fk
 8OkJDpLJ3zTObhvqRsnrR4RU3P4wNVA3Uu0TFLyf6LP6TuaGPPYRuzdMuXzg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 6DBFA5FCE3;
	Fri, 24 Apr 2026 15:38:53 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id BCB2B5FC95;
	Fri, 24 Apr 2026 15:38:52 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Fix unnecessarily high ceph_decode_need() for uniform bucket
Date: Fri, 24 Apr 2026 15:37:37 +0200
Message-ID: <20260424133737.921463-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In crush_decode_uniform_bucket(), the item_weight field of the bucket
is set. This is a single field of type u32 since the uniform bucket uses
the same weight for all items. The value in ceph_decode_need() is set to
(1+b->h.size) * sizeof(u32), which is higher than actually needed.

This patch removes the call to ceph_decode_need() with the unnecessarily
high value and switches the subsequent operation from ceph_decode_32()
to ceph_decode_32_safe(), which already includes the correct bounds
check.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osdmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index a87268058e61..669348d883f0 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -72,8 +72,7 @@ static int crush_decode_uniform_bucket(void **p, void *end,
 				       struct crush_bucket_uniform *b)
 {
 	dout("crush_decode_uniform_bucket %p to %p\n", *p, end);
-	ceph_decode_need(p, end, (1+b->h.size) * sizeof(u32), bad);
-	b->item_weight = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, b->item_weight, bad);
 	return 0;
 bad:
 	return -EINVAL;
-- 
2.47.3

