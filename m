Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF8D579837
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965968; cv=none; b=TdryMnYOjGdDk0q3JlFqe6NYm6YWrH+Kx3pmyb2wMjydQMDTnVJmI4w3QShN5DULuuC5juq8iRTOi3jS0zt4XkaZ5P99nsrAKgWr2Tms/0lR9I8w+xIc8QA7GdPoZp1DdfXiUuvI7psLaG7owJ18rXWaV46K4hPHs1mvuoxV6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965968; c=relaxed/simple;
	bh=x+LLzjhH8hl7blo7zILyibflQw+Sdl3yJUiO0XwREj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dt8+sLRgD9Eu4zPqZ3/TNogu6H3XHXQBEM/G0ux5DSO+b/z4m6mxYt4hqN7/UCkVwjOmYBWNENgTvum6wThB3c6kh+PdnrZLgLEY4hJqGJRQyjWuz4ivANXC/9WkueHaAOXu/ARX6PpOk4xH/abZWb+0SXHz/5L2BQmWdCeTViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=mue70wjq; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="mue70wjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1788965962; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=x+LLzjhH8hl7blo7zILyibflQw+Sdl3yJUiO0XwREj0=;
 b=mue70wjqu6c+rqEwLi5xgrtNxkCZNzgpQw5rvJccr1zW12SthJ2ZIxvmBobjiKwOiNQcL
 3N40u78NpsuEfBKlpsl+eatsBmXtntbmoXmaCsEm59Z0dZ60Y+8WvSrIXJRpZuxsUBPy2wX
 2aPCakgUnxmDPaXSEvx1M7HB+EAZ1BPUXgAiDG9MVN3XFrQqh8N6tujvi377ecHVABeaMAE
 /Hd5hy2Arz8l/NjHVIlWvceCgQVhS8KPLrKyulf/OfGzPowc8k8lh3zKRHuxFgaPI5X15TW
 BvpETbffQeBSViz4x8dLo+2PX6C4qPPLtJOHtfQbyCP3PuTv6Z0KWaRiO8pA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id BC41C5FD41;
	Wed,  9 Sep 2026 16:59:22 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 712565FB4B;
	Wed,  9 Sep 2026 16:59:21 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Fix unsafe decode in ceph_redirect_decode()
Date: Wed,  9 Sep 2026 16:59:13 +0200
Message-ID: <20260909145913.1164255-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_redirect_decode handles unchecked data received over the network
from an OSD. Currently, there is only a bounds check covering the first
three decode operations. After decoding the first len field from the
message, the only remaining check ensures there is enough buffer space
to hold len bytes. However, there is no guarantee that this value is
large enough to hold the subsequently decoded fields. The decoding of
the second len field is missing an explicit bounds check. Consequently,
a corrupted message can trigger an out-of-bounds read.

This patch fixes the issue by switching the decoding from
ceph_decode_32() to the bounds-checked version ceph_decode_32_safe().

Fixes: 205ee1187a67 ("libceph: follow redirect replies from osds")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osd_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ae3c3f046688..95219e16519e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3642,7 +3642,7 @@ static int ceph_redirect_decode(void **p, void *end,
 	if (ret)
 		goto out;
 
-	len = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, len, e_inval);
 	if (len > 0) {
 		pr_warn("ceph_request_redirect::object_name is set\n");
 		goto e_inval;
-- 
2.47.3

