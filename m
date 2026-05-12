Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68239D6F1
	for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576099; cv=none; b=Szo6TZgzsPa1fR94PaowSouXGPjPEshu6iMRVGQ2wqV3C/Y6sCf6VePzwf3u+D/WK2Qjg/3+WuKl9CQvxvGPzsl+jqelcMPzD4f53FoZaVakHanRc9riTArB0IB+lM5JH7lIBxA+YZmFTxCfLWDAU4/zkIXv6WToGR7iN58CNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576099; c=relaxed/simple;
	bh=18We1MZfWheMC8ghov8rCMuBJZNbhPPEeDTcUqw4zDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FE5v5ZYEqYz0MfSPdkuu1hNH8mnEQhNmK2iLhQvjXPgj6ANZa8bsjxbYjzrGhIqaXzDb4BNA5ip9mS+PMpT4Z41z+X3ozdj4lrz16OQSdkpf0HJIczkg6/uiuAja6Em6tKfSs1+zAuaWwLSDCIm5W9eZA+JFddChRe9ZXvsrZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=B844TYdL; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="B844TYdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1778576086; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=18We1MZfWheMC8ghov8rCMuBJZNbhPPEeDTcUqw4zDU=;
 b=B844TYdLlvCLrzr0QSN5CBLO9+e0Zz/7QQb+qFTuUGaWVw0nnemZKu5SEF9VDV/+Cv1Cf
 jn8GbERvyGfDAI3OLU/MOPG3TYfaCz9pNTuOxkJf/5IMLocjjQL6/f5bFuPtGbJNr0sKDBn
 IQ7eEnR5R5WysNwKh+C+2zXP7KxWqJ/sGNxDOlCNzy8i4+eBVvsB5ZiXhNwuxX6HPSDBOdN
 KOSeoXjxs3EIZyObmoM4TvNYYFa/RCZztFSB3DwfmM8CRCojCgmpOqceLEnoArvNAjxMoA+
 YpHplKss4Z8VPGRT9z9uc/8s7h11bjc3c5H09gbKGNG3o3BXrpZHD8fVTncg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id B3F4A5FC43;
	Tue, 12 May 2026 10:54:46 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id BCB8C5FA95;
	Tue, 12 May 2026 10:54:45 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Reject message if choose_args_map contains invalid bucket_index
Date: Tue, 12 May 2026 10:54:25 +0200
Message-ID: <20260512085425.1372864-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A message of type CEPH_MSG_OSD_MAP contains an OSD map that itself
contains a CRUSH map. When decoding this CRUSH map in crush_decode(), an
array of max_buckets CRUSH buckets is decoded, where some indices may
not refer to actual buckets and are therefore set to NULL.  The received
CRUSH map may optionally contain choose_args that get decoded in
decode_choose_args(). When decoding a crush_choose_arg_map, a series of
choose_args for different buckets is decoded, with the bucket_index
being read from the incoming message. Currently, it is only checked that
the bucket index does not exceed max_buckets, but not that it doesn't
point to an index with a NULL bucket. If a (potentially corrupted)
message contains a crush_choose_arg_map including such a bucket_index,
a null pointer dereference may occur in the subsequent processing when
attempting to access the bucket with the given index.

This patch fixes the issue by extending the check of the bucket_index to
also reject the message if the index points to a NULL bucket.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osdmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 0752a3808b91..4a807e5faa62 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -379,7 +379,8 @@ static int decode_choose_args(void **p, void *end, struct crush_map *c)
 			u32 bucket_index;
 
 			ceph_decode_32_safe(p, end, bucket_index, e_inval);
-			if (bucket_index >= arg_map->size)
+			if (bucket_index >= arg_map->size ||
+			    !c->buckets[bucket_index])
 				goto e_inval;
 
 			arg = &arg_map->args[bucket_index];
-- 
2.47.3

