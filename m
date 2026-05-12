Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC793CC334
	for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778602652; cv=none; b=N9EvBldzJSGRWB0JS4luH5nhI0J8bhwOw/eCjqJbHyu0PSMARzYKZbR3nbPD3Lm84GD8E0qJ3JSn8vlqfy833J7V0+Vv7NEOa78Fn5sYuRjg6eazFmpA35BPlq19gymgF0STxLfOPuJWvu0W+NZ9lDjiz2ha3IerdN0Cp6FxsiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778602652; c=relaxed/simple;
	bh=lFAv7wXTb+PAYMWPw56j9I2OjPMCNEcjcW0Pzu1K6lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2ebf5InCLfHnIcZulzwleOhCBrvCZm5LZSB/qIsBTSHuZpwRDr15vZ0uRSGhxHLNoMCszoSL3TJvjSKAQIrbCk77OMJdLJvua7Q7jb7DQBt98gpwKWcAzD+nZr3Z0730KxWcokOW9Ma/nU06E7o0Za3iDqG/q0d0Wn1WaRfkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=BJB1F6zs; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="BJB1F6zs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1778602640; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=lFAv7wXTb+PAYMWPw56j9I2OjPMCNEcjcW0Pzu1K6lM=;
 b=BJB1F6zsV/NkpzNSlTLopVCvCgij3FnMcZLwhcA5/kZ5LsZ6LS10DlUZYEZyeVcX4v/1Y
 zq2RCMcsySTjqh5ZSGLj8ARtwVciY/YVfQuD56x9VbuQbGSJFdcgdtr2YuKnhvqYaqO4qIv
 RaCV4NKs1QM7zjlX5iZ0rgMROLYGKfWBTv7oaI3okvo8OTuEkO7jjF6a7kXO9c3CIdgurUG
 oBWbzXYZYxp3s7O4rQhqnoqBaL55U2tPNXxKA9LQF0LHd6ciDQI7a226tbyPmLS7+j3LcsV
 EUO0gAIIDMlDvkIM++DtCutKDk++yhwSq6DaM9Bsgz9J06r+rpfO88DWJq1g==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 6B6545FD40;
	Tue, 12 May 2026 18:17:20 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 0B7FB5FC83;
	Tue, 12 May 2026 18:17:19 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Fix potential null-ptr-deref in decode_choose_args()
Date: Tue, 12 May 2026 18:16:40 +0200
Message-ID: <20260512161640.1449577-1-raphael.zimmer@tu-ilmenau.de>
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
not refer to actual buckets and are therefore set to NULL. The received
CRUSH map may optionally contain choose_args that get decoded in
decode_choose_args(). When decoding a crush_choose_arg_map, a series of
choose_args for different buckets is decoded, with the bucket_index
being read from the incoming message. It is only checked that the bucket
index does not exceed max_buckets, but not that it doesn't point to an
index with a NULL bucket. If a (potentially corrupted) message contains
a crush_choose_arg_map including such a bucket_index, a null pointer
dereference may occur in the subsequent processing when attempting to
access the bucket with the given index.

This patch fixes the issue by extending the affected check. Now, it is
only attempted to access the bucket if it is not NULL.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osdmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 0752a3808b91..8b5b0587a0cf 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -388,7 +388,8 @@ static int decode_choose_args(void **p, void *end, struct crush_map *c)
 				goto fail;
 
 			if (arg->ids_size &&
-			    arg->ids_size != c->buckets[bucket_index]->size)
+			    (!c->buckets[bucket_index] ||
+			     arg->ids_size != c->buckets[bucket_index]->size))
 				goto e_inval;
 		}
 
-- 
2.47.3

