Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B821D590
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890788; cv=none; b=PK9Y4h1PcJCZ9o6dTqEQBJc0smKqOf29eJW1CPqJY7zw3EuRVgCUa/8eA+8pf1iSVBPmjeKc1dVvu+8jwj0KXNEhVfSFdNOZOhtJOfhb0vSX0bXwsGXvyBcqrNDj3G2fagjHrCiu8Ww6RNrtSNg4x/WgGdBTRi8Cv944MOJx1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890788; c=relaxed/simple;
	bh=PwTO1N1NTThG0SXU4BQdaYlZCCnquKi2wE+u9lfDLTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzMBHMr3QhfgbJ1gJWVIe4zU+poXavWS3nOV8r5djXwXTeE2EHM8PzKkBsiL7q1I+1srYaoSyclDijIbkqHepm06CFRFBAIbYpzxyWWAzP9hi9/a3quby85abK+AhZWow6rjN9nKXGqnlgyzsCepj/WOEWMe3FJWZWZubtv2CyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=wPN/JGOr; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="wPN/JGOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779890784; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=PwTO1N1NTThG0SXU4BQdaYlZCCnquKi2wE+u9lfDLTU=;
 b=wPN/JGOrQN8008fCseGKYK+H5JuGxoAKo4qaEflQzjcvTYvFnuPZjnAtBUC37ac8GWvio
 wsoCnZtCxXYXoDts8xNPl+RRjX1xossScKks8fqHUQqjQ6h+cDKAe5OFjdDnRAFVgDNj8jP
 jwt2yXWJWrUzov+6rxHVMevQLoU1dQzeBkM9ykEoq64a/H+lvim1sfo5h50WQa+9BUrYbUq
 68Al3W5Q5qdj7n9xAiJRRLdGYt7VQsVIfvfEsyRHkkOXTo5BtWC6OEvSuPTzY6gulkIcHtp
 hP7Wx/qkxIEnVfHtQg9KE/nMgRvBMJsE5OMquVn+STXoPnWcDfdoeT3I/u2w==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 508535FC52;
	Wed, 27 May 2026 16:06:24 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 3BF885FB64;
	Wed, 27 May 2026 16:06:24 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Fix multiplication overflow in decode_new_up_state_weight()
Date: Wed, 27 May 2026 16:06:17 +0200
Message-ID: <20260527140617.3600044-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a message of type CEPH_MSG_OSD_MAP contains a (maliciously) corrupted
osdmap, out-of-bounds memory accesses may occur in
decode_new_up_state_weight(). This happens because the bounds check for
the new_state part is based on calculating its length depending on a len
value read from the incoming message. This calculation may overflow
leading to an incorrect bounds check. Subsequently, out-of-bounds reads
may occur when decoding this part.

This patch switches the multiplication to use check_mul_overflow() to
abort processing the osdmap if an overflow occurred. Therefore,
osdmaps/messages containing large values for len that result in a
multiplication overflow are treated as invalid.

Fixes: 930c53286977 ("libceph: apply new_state before new_up_client on incrementals")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osdmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 076763420b1d..65ae48b9d9a5 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1846,6 +1846,7 @@ static int decode_new_up_state_weight(void **p, void *end, u8 struct_v,
 	void *new_state;
 	void *new_weight_end;
 	u32 len;
+	const u32 new_state_len = sizeof(u32) + (struct_v >= 5 ? sizeof(u32) : sizeof(u8));
 	int ret;
 	int i;
 
@@ -1865,7 +1866,8 @@ static int decode_new_up_state_weight(void **p, void *end, u8 struct_v,
 
 	new_state = *p;
 	ceph_decode_32_safe(p, end, len, e_inval);
-	len *= sizeof(u32) + (struct_v >= 5 ? sizeof(u32) : sizeof(u8));
+	if (check_mul_overflow(len, new_state_len, &len))
+		goto e_inval;
 	ceph_decode_need(p, end, len, e_inval);
 	*p += len;
 
-- 
2.47.3

