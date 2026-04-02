Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075E13D638
	for <ceph-devel@vger.kernel.org>; Thu,  2 Apr 2026 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114198; cv=none; b=EgnLZeYf3NTqq6ODlchI8i3rxTBrnmao+/QXs6WWWvU3JkvhZiQKJdtpgwXvBoEYumzFJZHJujj5hO/gqLV5qWtgY4BDW+r7o5vzMnTyuYrrc3Ll82dJtuBQK5Vp5iE1aKnFwRz66lCkkhou9wDE+FmGgBDLfEYpYb0ubuIg6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114198; c=relaxed/simple;
	bh=COPD8vNk9ty2mRc8xRpKZOZ+v1QTyc2kAKPZbR2U1Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/NyXzuVvs3JnKkhwLeS5s9SXsfsML3+JwsX9puJQHr5nZAiifnpW9jZlMAl6TXJKgKJi1ovPfbbEnko9BNaGQV/XfB9gtNnclThrFDqrLIlJUdPmEAmIb4bCWNj96C8+kf55e6xaPf6pCy/6J/3o2kMxciM4q5SgGJVo7gp8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=N9Nfe12i; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="N9Nfe12i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1775114193; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=COPD8vNk9ty2mRc8xRpKZOZ+v1QTyc2kAKPZbR2U1Ro=;
 b=N9Nfe12iqv9offaAdJmIluUlzMATF+WIWmOtT9WcC7vJGY9jYmFWwUN5ortcqfRXDa4VI
 VNM/M7zuT0lBi4eSuz7GFsFesrlZmPEGsZTxJG35jWYMg4S5v3tW0OH0HuKh9NyxVTGdKEH
 5v32/ojPlGEKX49hm6xbNWstKbhVJMuM15zvPP9yG0563KvvzkpBoXQGvvfgElf5xXmUeaQ
 jXCpqSnXuxxPU3nvGP5cV0s5wSx9/wG6jWW4YfcG3VqWOqlBjDm+zkbICrEQOfZH66KljqP
 457EncBXy+YJ8qRs2mnlVkV2aLLoGhtpiJ2mlaJSREUOP2wCP4aoJpK5/Kyw==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 558AA5FCE3;
	Thu,  2 Apr 2026 09:16:33 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 6B1255FC9D;
	Thu,  2 Apr 2026 09:16:30 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Fix potential out-of-bounds access in crush_decode()
Date: Thu,  2 Apr 2026 09:15:24 +0200
Message-ID: <20260402071524.3766233-1-raphael.zimmer@tu-ilmenau.de>
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
index c89e66d4fcb7..a87268058e61 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -516,6 +516,10 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 		b->id = ceph_decode_32(p);
 		b->type = ceph_decode_16(p);
 		b->alg = ceph_decode_8(p);
+		if (b->alg != alg) {
+			b->alg = 0;
+			goto bad;
+		}
 		b->hash = ceph_decode_8(p);
 		b->weight = ceph_decode_32(p);
 		b->size = ceph_decode_32(p);
-- 
2.47.3

