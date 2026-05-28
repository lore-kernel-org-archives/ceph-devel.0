Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FE378832
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974763; cv=none; b=XwycC0Uos7PN4mf99zMTVZTMm+g/TvN9cZYWLEe4qNesmaRv9/vDB9NC16kldiE2XsDsgnc+B8PT/igTNVG19WXmb2WJZrPf2yS2XPkL24Fl+Td005MDUeY9Lgg+YTT/HAr/GBE97YXEJ8H94LnxXAmhsgRfcq5kKggNet/7VOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974763; c=relaxed/simple;
	bh=QUR06i/oLQGVwvHm5+5o0AEps5inWNG8u6llh7dN7sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVoUUR81jc0R4NztMTZ1d/y/2+Qm0kCLWARfTRRHOCDvfoIjMe2Wv3m4ZUWcrlqixmz936217SrdoqEmLGbHtVzGboZrbYP3ae906GH8VPA/u2MoiAEAm5QdTFGr1maKQ9fVe1yWHtlZ9JDAvw97TyNoaYJsAhJwzBg1XyveX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBNDvI4V; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBNDvI4V"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b9f8c2c950so9296975ad.2
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 06:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779974762; x=1780579562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97b/ycKTWwDTGkqz750uQ/lr8PRa7HdfY9OOwRMtKcU=;
        b=cBNDvI4Vku9FaY2eMyqfilpEjG3e9WSgUIXkIErdKp/QAynmvwqe8PpWn6jHMNj3ST
         R84nkQIR3to7giUUyRqSg/mkngLhZcmpJL4N1XwmkDiZ76c8Mw/oI8e1uZ7jrmHJ6YdE
         CJu+94RHLHcjI5pAjom2aAdxvr99/DUYUDqTppCo6gHpq5tkbmpuzQLZljgd3lpg+EDY
         Hc2dqT62eE9NIWsEgfybtUJliAxwOhwmlQol6ipcbXiX6Tjc33muMyXLkDLljZ1rm3o5
         4UuiW+/aUfcX8MSQ+/cyMEz2UdO/rN+gvLJf21eMTC82ihiFHRoP7MWls4jtD7fE6ePG
         N/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974762; x=1780579562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=97b/ycKTWwDTGkqz750uQ/lr8PRa7HdfY9OOwRMtKcU=;
        b=ijm7uIX8TtLoRd00RmoF8KVlwPYsZkSX7bAzMgOE3kP8dsY4wQul3rxlozMnAa35py
         XH8ngKri8PXKPrHtvEi1ouGLqobCmDoEcSwJkz4u9ZtVwn4ps3AKPZ7wC2B4CCuEA//R
         LcrdTsZkOj7rPfILjQ9m7yJMyNEnN3pk6VJ0nXILGQujzNzbby+zCsTqWiXV54r4sQIk
         dAJ890dnw2oi1oyC1BZYmFkdH6P6s9swsCibicGM/M7k8ZxCwIUmb86khqokJtCLUk6K
         440jBNLGIafWVxL2zd+HJ3s0jPor9lsI2HW4eKLNHF7qBooKZMana21l2UVN0iXJB/Ir
         cUOA==
X-Forwarded-Encrypted: i=1; AFNElJ8d2yxxnkdFK10X7NRiBGUL/K5dBfwmTyH/T3XCB8uoqVxG7fbMtQDFEZyx2+PLxyvrmsV6zGqrqZBG@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGDHtewtOPoM9ippJ88blEhT+FLZ4fWjJ81OnnG4BybaBprLe
	GEOZVzqyYYH5c5M2B1TrbQAZKGGE1C2Y8eE4f26FZ497uG2UNyKp75kM
X-Gm-Gg: Acq92OEgKY3vR+Gxm7ZdhV6w1L2jhdzjkstcc3OH1gBAm6qKjDKhSddoj4dESq7SK+K
	vMF9jhSjDUYqusQZvLFnNJ9o/NiKKHIIu4DyLVZ1/0SaAPK+A5++Y3DW6q79lKXkaes2XORWRd9
	Q2bnuqnMjA+JOY4oTrFzjcQNwn7aKSUGlTO3BaMbWxUCgz1NWuDAMQV2YVRevCWcsKR9XNgjXqM
	KVBDtugP8IjKR+FUfpQTTp4brHCRux/BM5BSoEbhAsH2svgjbLi2J0GklmEy0wsSlnWlaE+yJtK
	SpiAkRAJWA6l21AGFfQYmcJbykLqdJ8tjuoSRswucy31noye84o5POpyv0OuL/oLNj4yn0fx5mC
	gpDuzmMIVvTGalZmFcBINUiUkjiVpsWY+nEAeF8JnMovnzXnhx3hgmjeuzTMpgOavcu+DFWvnJc
	KwkJE09fSefams405Z5bj7eko2Bgk=
X-Received: by 2002:a17:903:faf:b0:2b9:8f98:3ccc with SMTP id d9443c01a7336-2bf038379a9mr19947455ad.8.1779974761976;
        Thu, 28 May 2026 06:26:01 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56b51aesm234623465ad.19.2026.05.28.06.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:26:01 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com
Cc: Slava.Dubeyko@ibm.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] ceph: fix bare ceph_decode_8 OOB in decode_lockers()
Date: Thu, 28 May 2026 09:25:21 -0400
Message-ID: <20260528132521.843004-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <50dc5a7472fb2d6da4ebb71cc659b03a5df06747.camel@ibm.com>
References: <50dc5a7472fb2d6da4ebb71cc659b03a5df06747.camel@ibm.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

decode_lockers() in cls_lock_client.c contains a bare ceph_decode_8(p)
call after the decode_locker() loop that has no preceding bounds check.

If a malicious or compromised OSD sends a cls_lock_get_info_reply where
num_lockers is crafted such that the decode_locker() loop advances p
exactly to end (or if num_lockers=0 and p is already at end after
ceph_start_decoding() accepts struct_len=0), the subsequent bare
ceph_decode_8(p) reads one byte past the validated buffer boundary.

The result is passed directly into *type, which is subsequently used as
a lock type discriminator by callers. An OSD-controlled one-byte OOB
read at this position gives an attacker influence over the lock type
field with no further preconditions.

The safe variant ceph_decode_8_safe() already exists and is used
consistently throughout the codebase. This site is the only remaining
bare ceph_decode_8() in the decode_lockers() post-loop path.

The goto target is err_free_lockers (not err_inval) because *lockers is
already allocated at this point and must be freed on any decode failure.

v1 of this series fixed the bare ceph_decode_32() before kzalloc_objs()
and added the err_inval label. This v2 addresses the second bare decode
identified by Viacheslav Dubeyko's review.

Regarding the -EINVAL choice (raised in review): -EINVAL is correct for
the err_inval path. The failure is structural malformation of OSD-supplied
data, not a memory shortage. -ENOMEM would misrepresent the failure class
to callers and to stable@ backporters triaging error paths.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment can trigger this against any kernel client that issues the
lock.get_info class method (e.g. during RBD exclusive lock acquisition)
without any further privileges beyond OSD session establishment.

Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v2: Replace bare *type = ceph_decode_8(p) with ceph_decode_8_safe(),
    goto err_free_lockers to correctly free *lockers on failure.
    Address Viacheslav Dubeyko's review question about this site and
    clarify -EINVAL rationale.
---
 net/ceph/cls_lock_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 4f27b3d15..c9183a348 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -314,7 +314,7 @@ static int decode_lockers(void **p, void *end, u8 *type, char **tag,
 			goto err_free_lockers;
 	}
 
-	*type = ceph_decode_8(p);
+	ceph_decode_8_safe(p, end, *type, err_free_lockers);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s)) {
 		ret = PTR_ERR(s);
-- 
2.53.0

