Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860751A681B
	for <ceph-devel@vger.kernel.org>; Tue,  2 Jun 2026 05:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376571; cv=none; b=Po58+7Ntf2AB/7ncQfFYmA1B5cnxkkwD3nWJYvizBHxKPGHvvux+P/ycT/ZhIqrbq+5GMRMW4gC/NVUCCTDKfvnRFY0oUjcQ0NYRhTxPxSsKZ8+qDfX3gXvtqa3jQjQtbq/q0i/wixuaGexAO+LZsfMtrzOjTtyiSNueDnjWVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376571; c=relaxed/simple;
	bh=41U7wn9RtWP2XyfE0+FeYyOtI8DOPShkkEtOdhnWF8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRoGYRxlSseUV6XTkjskA0gmLl+ZXA35SgFFy5OU/mZGAKGtx/nGfNS1N3I7JTPihdOXpHNZ8yIY1cXXnYN67agR1c3GnFceR3VJIlPYmCDCxSQu3pzi4aTw0LF6NpEGb/HCJ9KAxGJ/ZaNSmMkrb3LaOfKh6s2NJAchiGM2CFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qelWv9+v; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qelWv9+v"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36ba9f46338so624121a91.0
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2026 22:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780376570; x=1780981370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tnv0Pq3YcZOXLAz8w0YjhRbon+2FOAN/7Wcqvt1Mghw=;
        b=qelWv9+vcQzjzXuqUU8N/DoJ5J5rhu5TTnROjEBgnePNJbh2BFtMryDjDBzk5mr8BU
         5FbhpRenwONK6tRa0RYcaIxfIOEO1tPpRE9VmAMJV10wLqnkhu1LQWv4VkNjHaxtNfoX
         lk/xKJWHk/5mufbfpRRRkdMxR9jhwDW6jaeXuwYwKIf1EMi7k8Vk257xWGUEV1fdXMhn
         aFOo0cffR28ajgdttlEb68LHO77c6lGtyo6DX96mes5JGoVUwnKJuYFepUXGngqGIpV9
         Ky0SowgElphLMHsFyxWKUJUDdqVaHLWYCLEMecIBNJlGHTfCEnLr1W4mSg8sG+VaK6we
         f0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780376570; x=1780981370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tnv0Pq3YcZOXLAz8w0YjhRbon+2FOAN/7Wcqvt1Mghw=;
        b=PB8c/IM+RnRFKMtx31vXwOVXZ+q0lZAxy2LQ+aMCY1nlOtGz4493ov795syAq6SCfF
         8I71z+tvZsUEYY3Cz71Oer65vRxPtmH4Q0tcfggaBlzTl9ygFCDD3wVzRgb25AOF0DBk
         /LepttNzS/EzCOrWdoVs1ZyIShn+VgqPUoIAhgY5Gi0uD6gt/j1s1BoMbb7KJprkqGLp
         L7HsHlywoOassXhaCWmDpT94PFWt6ixKGlMS2A0VmjH4UDLNrAK5zNwJfXnW2wpHCpBU
         A0KVSMKB0hZUQZHZMk6bKy6tf1O6T5OhsHbGvQfXmsP2ojk7PYHaOP3peLIvX1BuSJmu
         N7MQ==
X-Gm-Message-State: AOJu0YzspRxwvqqGTie/nlsZBXnAc9PnWt9zZ86qJcPMhhIaqKJmGI3S
	uF6pRjJSVFgpiydoMUuleHIlqd96TsNKICf5XMmlMqRqjUJtSuhvZvE1
X-Gm-Gg: Acq92OG1ibIwslFZO8Nc0AO/Z5OsNXp63jfjY7BfixHga8GZvzqlRUx8RCg2fOr703i
	F6WHmEbJzmCGlbqxaHD+H5MBmlm0zTpWL+TGkG22TEmU3L8T4/Iqv4CRjIDwdMMtJGwBSswaQy3
	YqhLa5K6/vIJa7hE4r7x7xG6k1auudSC8GocxBkhHwe6Wzsrva1g06CcPWmvHiaLQPEnya9h09i
	utzxok4hGCKXBXTK+k2s/T+wnmCCBXHaX3ID2lgc6qUFnLtD4IceqhZeqLY/hX5owq/JrX1u7oX
	2ych4Ba0o9QKe0TTu4NVvAgjZFNYFl92HbEpNGnOKbEt8z6IgQqXu8QR3C4TDgR+1XXipQonwCM
	JfI4SvG6p0nfwBiz5iZlHOohpXN85HdOTm0shPtK/upOJvGM+UQhARd+O23+L2YzZ/LPbILv/6x
	9dc3ZnJu7S2RdgN4lQ52qkCXPNZHBz
X-Received: by 2002:a17:90b:3a0c:b0:36b:900a:d29a with SMTP id 98e67ed59e1d1-36c501f6789mr7726095a91.6.1780376569626;
        Mon, 01 Jun 2026 22:02:49 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd91ad221sm1288482a91.5.2026.06.01.22.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 22:02:49 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com,
	Slava.Dubeyko@ibm.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v3] ceph: fix multiple unsafe decodes in decode_locker()
Date: Tue,  2 Jun 2026 01:02:19 -0400
Message-ID: <20260602050219.1043295-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <581a303fac01d2854bc32cf2afff928990026aa0.camel@ibm.com>
References: <581a303fac01d2854bc32cf2afff928990026aa0.camel@ibm.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

decode_locker() in cls_lock_client.c contains three unsafe decode
operations that allow a malicious or compromised OSD to trigger
slab-out-of-bounds reads:

1. ceph_decode_copy() at the locker_id_t name field has no preceding
   bounds check. With p == end after ceph_start_decoding() accepts
   struct_len=0, this reads sizeof(ceph_entity_name) = 9 bytes past
   the validated buffer boundary.

2. *p += sizeof(struct ceph_timespec) after the locker_info_t header
   is an unchecked pointer advance. A malicious OSD can position p
   past end, causing all subsequent _safe checks to pass against a
   bogus boundary.

3. len = ceph_decode_32(p) has no preceding bounds check, and the
   immediately following *p += len is uncapped. A malicious OSD can
   send len=0xffffffff, advancing p gigabytes past end and escaping
   the decode window entirely.

Fix all three by replacing bare operations with their safe variants:
  ceph_decode_copy   -> ceph_decode_copy_safe
  *p += sizeof(...)  -> ceph_decode_skip_n
  ceph_decode_32(p)  -> ceph_decode_32_safe
  *p += len          -> ceph_decode_skip_n

A new out_bad: label is added to return -EINVAL on any bounds
violation. -EINVAL is appropriate here: the data received from the OSD
is structurally malformed, which is an invalid argument to the decode
contract regardless of whether the caller or the wire is at fault.

KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):

  [   26.183969] ceph_oob4_poc: buf=ffff888009e31000 end=ffff888009e31fa0
  [   26.186087] ceph_oob4_poc: struct_v=1 struct_len=0 p==end: 1
  [   26.186738] ceph_oob4_poc: triggering bare ceph_decode_32 past slab boundary...
  [   26.187679] ==================================================================
  [   26.188236] BUG: KASAN: slab-out-of-bounds in ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
  [   26.188236] Read of size 4 at addr ffff888009e31fa0 by task insmod/59
  [   26.188236] CPU: 0 UID: 0 PID: 59 Comm: insmod Tainted: G           O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
  [   26.188236] Tainted: [O]=OOT_MODULE
  [   26.188236] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  [   26.188236] Call Trace:
  [   26.188236]  <TASK>
  [   26.188236]  dump_stack_lvl+0x4d/0x70
  [   26.188236]  print_report+0x170/0x4f3
  [   26.188236]  kasan_report+0xda/0x110
  [   26.188236]  ceph_oob4_init+0x22b/0xff0 [ceph_oob4_poc]
  [   26.188236]  do_one_initcall+0x9a/0x3a0
  [   26.188236]  do_init_module+0x27c/0x790
  [   26.188236]  load_module+0x4a9a/0x6350
  [   26.188236]  init_module_from_file+0x15c/0x180
  [   26.188236]  idempotent_init_module+0x21f/0x750
  [   26.188236]  __x64_sys_finit_module+0xba/0x120
  [   26.188236]  do_syscall_64+0xe2/0x570
  [   26.188236]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  [   26.188236]  </TASK>
  [   26.188236] The buggy address belongs to the object at ffff888009e31000
  [   26.188236]  which belongs to the cache kmalloc-4k of size 4096
  [   26.188236] The buggy address is located 0 bytes to the right of
  [   26.188236]  allocated 4000-byte region [ffff888009e31000, ffff888009e31fa0)
  [   26.188236]  ffff888009e31f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
  [   26.188236]                                ^
  [   26.188236]  ffff888009e32000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  [   26.188236] ==================================================================
  [   26.255513] ceph_oob4_poc: len=0xcccccccc (OOB garbage from KASAN redzone)

  0xCCCCCCCC is KASAN redzone poison, confirming the read landed in
  the slab redzone immediately past the 4000-byte allocation.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment can trigger this against any kernel client that issues the
lock.get_info class method (e.g. during RBD exclusive lock acquisition)
without any further privileges beyond OSD session establishment.

Fixes: d4ed4a530562 ("libceph: support for lock.lock_info")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v3: Split ceph_decode_copy_safe call to fit 80-column limit,
    per Viacheslav Dubeyko's review of v2.
v2: Move inline comments above ceph_decode_skip_n calls, rename
    label bad -> out_bad, per Viacheslav Dubeyko's review.
---
 net/ceph/cls_lock_client.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 4e6a6d3e4..79a449897 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -259,7 +259,8 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	if (ret)
 		return ret;
 
-	ceph_decode_copy(p, &locker->id.name, sizeof(locker->id.name));
+	ceph_decode_copy_safe(p, end, &locker->id.name,
+			      sizeof(locker->id.name), out_bad);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s))
 		return PTR_ERR(s);
@@ -270,19 +271,23 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	if (ret)
 		return ret;
 
-	*p += sizeof(struct ceph_timespec); /* skip expiration */
+	/* skip expiration */
+	ceph_decode_skip_n(p, end, sizeof(struct ceph_timespec), out_bad);
 
 	ret = ceph_decode_entity_addr(p, end, &locker->info.addr);
 	if (ret)
 		return ret;
 
-	len = ceph_decode_32(p);
-	*p += len; /* skip description */
+	ceph_decode_32_safe(p, end, len, out_bad);
+	/* skip description */
+	ceph_decode_skip_n(p, end, len, out_bad);
 
 	dout("%s %s%llu cookie %s addr %s\n", __func__,
 	     ENTITY_NAME(locker->id.name), locker->id.cookie,
 	     ceph_pr_addr(&locker->info.addr));
 	return 0;
+out_bad:
+	return -EINVAL;
 }
 
 static int decode_lockers(void **p, void *end, u8 *type, char **tag,
-- 
2.53.0

