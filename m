Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB03E0C51
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973314; cv=none; b=aRM3TmW9U/w06ccFJATgOyljW4RW4XpMe0fGbBLHZZS+LfmwUljs5KMkNgfL7D36pEy0wL7czabGfCec7kh/FMyfaLPqSxTNC6XkJyeToody7Pjsr+MSfQxAhTp/7VRsIHFt4Lcm4Cy5u5xTHkAqiQTpIsssKFvK5Xpw+elFt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973314; c=relaxed/simple;
	bh=lcDSJ87bV6vJQfy6PinO61G0LDBvkB6EAIMbHfc6P9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5GRmo46S1anC9208vjjM28ihJtDCZGHkzMqfpfXMUchAw/9/RHPK6HuR6y1eWJuiAVnQObz0sJK2RWrdy3xNfMlXhSDUaZltZ+0iRwoP6xKs4I0Bb24dZNahXpoYLRc6ng2uIEUDKQt6gD14lNVTe+V5bHu9iQFyMn585zKhgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRkN5RdC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRkN5RdC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf13af8405so92565ad.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 06:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779973312; x=1780578112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4XT7mBcrAQilbyNGQo5M9t2//fft6f/hb3lp/Dz9ek=;
        b=CRkN5RdCNdBHumB54hS4MbGcndzBsIWtQ/lhFuRvTnylUU1Qzb26uxBYqaNLQdrYxK
         tcZA+MrB999zXJrkk7PfCO9RMu9s0uRMqDlyThW11GDO4wB/3KE3w40C7r5I7JJqcEiq
         XJUFFNDkgczInZ4b5F4BmGXdcooKw2cScDkust8jS+2MEZcE9wMRfErUvHst6eVUOSJ4
         KCTneZ2L+7RTx4LvW9rWJw9ZxcDTuZ9cw6G85l4vFGj9nF+vqfMY2nF8B9asVErmPUG9
         AN1jpix/ESiPmVrEKNA/L3oRzGnJ9S9182ka7u7faq3MteArhbKX3s2JwvCHDo92jSGm
         18zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973312; x=1780578112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4XT7mBcrAQilbyNGQo5M9t2//fft6f/hb3lp/Dz9ek=;
        b=Ns1R6dwuSDoeVMCLth2CPmNg6tThCQkzL3Mv0ZAx6uOAO5XkmMp3ekRx3OfeyRLadl
         tR8ARiNgDRIA5sRtle65k52/t4ZoBb0iZajRkUZh0G22OmfFzlL1EdQJwd23nK75XIZJ
         VAd41Bfu7oWTxuby08HKbbJvlWsgVVsiJzU2lU5edCunGzuSt8V+zdN4g2OT72QLAxpV
         Gm1mFU7op4hxH4naz1jOo6Suo1Cg6YvWgtMYezt+nN68ehdoSaKbvDbhfbVO8p+N2gFn
         akhALW3JbS9KK3J7mUELSHizGHhD8c5vdjCdNuvpGomw4S5jRDaEmdtd9xd+xm4l0kXp
         PMNA==
X-Gm-Message-State: AOJu0Yy1dXL44HVR1Pm/dKZJpN5JfipnF3Ei35SeXcpt6eVik+n1ZyXX
	McNOMraW3V/gjYprz9csAjmqdkUBkGV2oWcsHCZ7eiRvfMTzMgmQPr1k
X-Gm-Gg: Acq92OGe5fq46iuhWTAgI5im5WDqWLnWE6KiQ3LsFKc50JTr1sU4XKttGrFLs4EF/tz
	Px1ci7lj1BOOb0FIMvoBMMeeKDQ8pfbXLtc/N29bRD84pvLOp6P9SIs2i73t+TwVJg+TI8+NzRw
	KCDD1/ndsI5jZdeX1Lg/cIus9g7oFWstxDA+F5M1MTqwX/+BtL6r8Xvkg1fleTBj/aMNjQ5Y9Go
	IE+Gb0kyI2Lf+yUb7WOe9YS9pzD/bagAc1HaZBFF1TSBxG0H5w4GfwJlzezQGisv/uWN4DEspu6
	cr5J6MESvds6E+x93Mfy6MSUkir+GIyFUtA05kgu9YeotS5MWZ4sZK/L7FeM5EDqKgh32c0gwMZ
	c//ZJK9oxqBvhbmBclH1NR71wCR01xZUCkyufVK+I1yOZcPI6tFG5Ey6eG2O1k6E1OIc919enWu
	3Y4+nTOqzw2P1ONjsLu4x263DEjel6kQIWpymL/po=
X-Received: by 2002:a17:903:2392:b0:2be:8d29:d5a7 with SMTP id d9443c01a7336-2bf02eff093mr19004395ad.2.1779973311622;
        Thu, 28 May 2026 06:01:51 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf0534e4c2sm23772905ad.5.2026.05.28.06.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:01:50 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com,
	Slava.Dubeyko@ibm.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] ceph: fix multiple unsafe decodes in decode_locker()
Date: Thu, 28 May 2026 09:01:13 -0400
Message-ID: <20260528130114.830041-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b8ccb15776c8b9770c09b884d1a908d4994ac936.camel@ibm.com>
References: <b8ccb15776c8b9770c09b884d1a908d4994ac936.camel@ibm.com>
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
v2: Move inline comments above ceph_decode_skip_n calls to stay within
    the 80-column limit, and rename label bad -> out_bad, per
    Viacheslav Dubeyko's review.
---
 net/ceph/cls_lock_client.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 78276273c..4f27b3d15 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -259,7 +259,7 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
 	if (ret)
 		return ret;
 
-	ceph_decode_copy(p, &locker->id.name, sizeof(locker->id.name));
+	ceph_decode_copy_safe(p, end, &locker->id.name, sizeof(locker->id.name), out_bad);
 	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
 	if (IS_ERR(s))
 		return PTR_ERR(s);
@@ -270,19 +270,23 @@ static int decode_locker(void **p, void *end, struct ceph_locker *locker)
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

