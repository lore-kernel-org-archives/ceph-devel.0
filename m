Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8E3E5EC7
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969605; cv=none; b=nUaKOdrrb+wyeUPIkW+J8LXQClUG4BJreo/4Pc3/BI/MKG8IzNg5osfTSt413zFYZhfEoGnb4Uxkql+5mANKJ7XW+CMlnu8cROfSISvj/ZkzSmmzHYIroBppjF0f4ZWz2zG1WsC9tg+8UovRGXiEdA89v2SPOw+NjdDqUBCsm+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969605; c=relaxed/simple;
	bh=htFmoUdtvWDyUgG8uCJCoUFye9ZJ8o4lYS0AS9twxvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk9hZ2o46tPl0ibTqimAt+fLionPhtmXnT8umxIkfETJYdPqkeZ36WL0clC20IjtI3fuUGQCTfpb/RsXhDYjaV/NHxsqQDa3KFTHdYIeObuoA6F6jPNj0df/FyLAx2aK8HPZinQc1qKT9TrvWt9IHqc6Q62Rc35EVVsBXJ8XovY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hW47772w; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW47772w"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-83f8f377876so1074505b3a.2
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779969603; x=1780574403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5vl3C5jPSAv3GytCPh8lvvkDSsugrJeALohk3VsT+s=;
        b=hW47772wN8AK3PT1uNAy3S4iNleMu5A21P/RFK7zghBX6kUFIG1b/s9SlIbIftLO7F
         5exn4l1THxUnlfM8FrdRVonHSbcw/mXeEuDzp+0SwDp4p4H8KgLm1SrRpLx5vtdwqjsn
         2pAPmTLTBlIc0kDOSJxxlgL47wYUFfnPVdigqWdOBnOHSBhN3kYrXI3QzkbpS/1FdhFt
         bbkhQJ6R8dPyTpcQCIPYkZ1XFtLvu0qIR8caR3+z/14w7awqvbTthTTnBxeLSO+yC6Dk
         GhVrri2/duLBZYFdViU3XHbA7yIMsaOgdHvfRWif0U1nRZE2gx3BamFeiCv+5OdMi7pu
         16VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779969603; x=1780574403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5vl3C5jPSAv3GytCPh8lvvkDSsugrJeALohk3VsT+s=;
        b=qxfBgl+lftMlpbZRIltTBoLMdExHmNF47ELEJ4LYOpdxWBv0uCUtQFx1goXk75d4ND
         +ogzZLCJ592X25e8LIMpIofxBTZCDbVBjECn1a39fEqE3vWWzC/yA4qx457nJgIGTJbp
         12HfiQt5vo/NtRzniw95TZtPuKfGlTcAoXJz3l1I1L/fr4hO43hN2FlyVpBRKP2qJkDy
         C9Wn+ArpQUN3JjqnOuN8eyZ3UegP1eX9EcJHNe+idQ/VPzsUamu9RS6ZgSqIMiDXFyMl
         XxJD+xhTRvKqMD+0fF8qERusJ98NMYx0QWHbAP3F2qrb9NTlnRBH6k6n2opU7/2edyrz
         7WmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VPnalh3qQGdWR/43aOK5lJbd1Lp6Y60kMl4Rh0tXfw9PJrkbOq/L8VLI8fD53l6a8hndkFXvrSTdy@vger.kernel.org
X-Gm-Message-State: AOJu0YzOlf/17x6IuQTzAgNc9xYL3laWOCooBH3ABBDRM6PuRmJIobue
	FVeK0kPSlL1F+tTqRS7KQ8jVPNeF2exjv80l9iHMSCEwWnnK8BMiZIA+
X-Gm-Gg: Acq92OG6iRyIr9FMVNoTVkVsdfvKK6X1SzeRV7KR/se26r4k8oxDQ/n/7nN/HG1qXy/
	hr4ylfxXuwhf8yxrj32iSkyt6gnmBEC0c1bgtcqbnT9CFlwNR5BI0v0Xrjn2mkyJUyDVRPPWepx
	A5KhM6tuT7xePJpvKfxC0J00CUCRPqFFnXIsB14L6NZnPhPrbsNzl4GIXHIwjdu3+Npdg/FfOVb
	kvPIyxC87U3nW4Nn2uUnBfAFnRBWcYUSIABSK9s5anjbNBzK3Zlaa5V+Gr5eI1ESElkDxu6Y/Mg
	bQ2QAe+AmT7YUdpUEIsU2hQNGYfBMjtpLDcW5IEvws4jNqqVHOBWkLQZjKUBCNWFOQgtwiM9QyN
	og0UpOXExqb5bL3GD4HYnEzM0T74FLx2CpdGfpYuf7pJbL7K2EYrjPVN4O5SjtxzISKEbZvwEZR
	37aozQ0XV0QxEVvF3pJG9kYNzZs0rn
X-Received: by 2002:a05:6a21:4d8c:b0:3b0:77d6:4b9c with SMTP id adf61e73a8af0-3b3f0fe79d0mr1672819637.6.1779969603200;
        Thu, 28 May 2026 05:00:03 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6ed19c2sm4678126b3a.25.2026.05.28.04.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:00:02 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com,
	slava@dubeyko.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH v3] ceph: fix OOB read in decode_watchers() via missing bounds check
Date: Thu, 28 May 2026 07:59:16 -0400
Message-ID: <20260528115916.796696-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <fb2206a9cc8519e54d269b6e5aa772edddfe6fec.camel@ibm.com>
References: <fb2206a9cc8519e54d269b6e5aa772edddfe6fec.camel@ibm.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_start_decoding() validates that struct_len bytes remain in the
buffer after the encoding header, but accepts struct_len=0 as valid:
ceph_decode_need(p, end, 0, bad) always passes. When a malicious or
compromised OSD sends an obj_list_watch_response_t reply with
struct_len=0, ceph_start_decoding() returns success with p == end,
leaving zero bytes guaranteed for subsequent reads.

The immediately following ceph_decode_32(p) in decode_watchers() has
no preceding bounds check. With p == end this is a 4-byte read past
the validated buffer boundary. The garbage value is then passed
directly to kzalloc_objs() as the watcher count.

The sibling function decode_watcher() already uses the safe variants
(ceph_decode_copy_safe, ceph_decode_64_safe, ceph_decode_skip_32)
after its own ceph_start_decoding() call. decode_watchers() is the
only site that uses the bare variant, confirming an oversight.

Fix by replacing ceph_decode_32(p) with ceph_decode_32_safe(p, end,
*num_watchers, bad), consistent with the established pattern.

KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):

  [   72.047085] ceph_oob_poc: buf=ffff8880085936c8 end=ffff8880085936ce
  [   72.048685] ceph_oob_poc: ceph_start_decoding OK: struct_v=1
  struct_len=0 p==end: 1
  [   72.049477] ceph_oob_poc: triggering OOB read past slab boundary...
  [   72.050699] ==================================================
  [   72.051427] BUG: KASAN: slab-out-of-bounds in
  ceph_oob_init+0x128/0xff0 [ceph_oob_poc]
  [   72.051427] Read of size 4 at addr ffff8880085936ce by task insmod/61
  [   72.051427] CPU: 0 UID: 0 PID: 61 Comm: insmod Tainted: G O
  [   72.051427]  7.0.0-rc7-g9c2abf69da83-dirty #14 PREEMPT(lazy)
  [   72.051427] Call Trace:
  [   72.051427]  dump_stack_lvl+0x4d/0x70
  [   72.051427]  print_report+0x170/0x4f3
  [   72.051427]  kasan_report+0xda/0x110
  [   72.051427]  kasan_check_range+0x125/0x200
  [   72.051427]  ceph_oob_init+0x128/0xff0 [ceph_oob_poc]
  [   72.051427]  do_one_initcall+0x9a/0x310
  [   72.051427]  do_init_module+0x186/0x410
  [   72.051427]  load_module+0x2ba7/0x2e50
  [   72.051427]  init_module_from_file+0x15c/0x180
  [   72.051427]  idempotent_init_module+0x19f/0x430
  [   72.051427]  __x64_sys_finit_module+0x78/0xc0
  [   72.051427]  do_syscall_64+0xe2/0x570
  [   72.051427]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  [   72.051427] The buggy address belongs to the object at ffff8880085936c8
  [   72.051427]  which belongs to the cache kmalloc-8 of size 8
  [   72.051427] The buggy address is located 0 bytes to the right of
  [   72.051427]  allocated 6-byte region [ffff8880085936c8, ffff8880085936ce)
  [   72.051427] Memory state around the buggy address:
  [   72.051427] >ffff888008593680: fc fc fc fc fc fc fc fc fc 06 fc fc fc fc fc fc
  [   72.051427]                                               ^
  [   72.051427] ==================================================
  [   72.129720] ceph_oob_poc: num_watchers=3435973836 (OOB garbage)

0xCCCCCCCC (3435973836) is KASAN redzone poison, confirming the read
landed in the slab redzone immediately past the 6-byte allocation.

Attacker model: a malicious or compromised OSD in a multi-tenant Ceph
deployment (e.g. cloud) can trigger this against any kernel client
that calls CEPH_OSD_OP_LIST_WATCHERS, without any further privileges
beyond OSD session establishment.

Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Cc: stable@vger.kernel.org
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v3: Rename error label e_inval -> bad per Slava Dubeyko's review.
v2: Correct commit message. v1 overstated the impact:
  - "unbounded alloc": retracted. kzalloc_objs() uses size_mul()
    internally which returns SIZE_MAX on overflow, causing kmalloc
    to return NULL. The large garbage value from the OOB read will
    simply fail allocation with -ENOMEM.
  - "decode_watcher() writing attacker-controlled data into it":
    retracted. ceph_start_decoding() calls ceph_decode_need() for
    its 6-byte header, which catches p==end and returns -ERANGE
    before any copy occurs. Verified with a follow-up KASAN harness.
  The fix itself is unchanged.
---
 net/ceph/osd_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a67093cf4..9058de08e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5030,7 +5030,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	ceph_decode_32_safe(p, end, *num_watchers, e_inval);
+	ceph_decode_32_safe(p, end, *num_watchers, bad);
 	*watchers = kzalloc_objs(**watchers, *num_watchers, GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5045,7 +5045,7 @@ static int decode_watchers(void **p, void *end,
 
 	return 0;
 
-e_inval:
+bad:
 	return -EINVAL;
 }
 
-- 
2.53.0

