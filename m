Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC687370D71
	for <ceph-devel@vger.kernel.org>; Fri, 22 May 2026 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473004; cv=none; b=Y/DjgdrTCVw4apwlR0IozV4ex9sfVnzoFtHnPbLAQbh4PVj6rhM9wZ/HHxMTJV4aZ9ycADekywRBlODwBTlMcOtOimZhN1qnL7X+uQuCzwtBtEIzKb9D5yK4A/91gTEnkn2/nYeO8ctojdxYwWtLcmOZyWXFAdijXyF9UUPwXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473004; c=relaxed/simple;
	bh=vuAaDfjQeHNl6Zj3qXdqkRjeEaOE1QoCrBFPUsVtH7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTjXi/aJPgkW4WN9XOOhISoJl2PUpnkX0ST4iTsAJ65QvSfUdbtcTGO3Eovip4oIqWNCZm1d1wmZcwpP9FP8gyoLVcvD2WeK2AQ9LUhuKXgy/wiE5WxOw/mtWXV+tzkw43xBYlY5eLS8iQQ3CR08VjkluJs/TfZaWS3OU9sk6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONrH+9gV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONrH+9gV"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36a644f34b9so188986a91.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 May 2026 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779473000; x=1780077800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCdmkF6WduLVMBtQaxleAhh6Xnep5Du7Xg157ClvxtA=;
        b=ONrH+9gVOd53kNEn+6UOxGg2PfW4M3g0FbxyOazK1nBufrBj8H0khWORyXELUVVmu3
         hjGQiSnXaokjz2jT1Lq11ztbKy3PCoqMYseP+ZujI1NCBkCoAgj5NpknBC1DVyLVFkfR
         9I2LndHmbPwjxMVZAz3vgq+aatqojciWgQ39buymLlc585Mf14J8yc3UKPxJi4H/jg39
         BR45e5opl21JAHwfuzv0y+GLfih253vJkzuxGBNCU/wSqniParRO8a/bH8zNUsWECRhR
         qT0dw+9h+eCnZrkDKu3sxLkpLo27o1tSDuvQDEUvlyAi4EWYVcnpm4F8av2aCW/TgE+A
         3JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779473000; x=1780077800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCdmkF6WduLVMBtQaxleAhh6Xnep5Du7Xg157ClvxtA=;
        b=L/CI21b2t0x7a4tTgEprBvnfFxnYQMo2/NBWW2hkior79lvNRs6hb4/fyEItcC5bAZ
         ZRxGffpA1dD9kALuLTcaVBhH+lTssorpcCaZJ7qG9tQVUmXHxopOGlSIBrHAaL+xxE9S
         EzLLkxBGGSubNHYuPVIKO73skom/EKpKxoHxXt+kmy8+7X4kmq/gsUxf2MChEMvLFi53
         Q/lKkqP1kEK6tHmDdEXJiY27ohf29mxofMxH7bS0ZO2xxdOfId8nKsmZxLJsfjVYng2w
         WqIYoQzKI+CIOBJXHSZrvRYlpnN3TdXjx8dm2WxbEeD3q+P92jfAUDs97r57w4ybPqMf
         4JpA==
X-Forwarded-Encrypted: i=1; AFNElJ+KZWHWRniGBVq06SyDG0IK8L3g3GIPlgFiXMbTorY4Lj42SNT//htd2a4DcTusnQLep4i57yKgtUK/@vger.kernel.org
X-Gm-Message-State: AOJu0YyjYxzgAiAVN+1a5BcEc5cJ9LqjcF4ORd7HpC5NTVkp/R1fKNlh
	juvduvtE9VPLh4nojMbn0VMNh34l4gJEBO2kqlO3N/e2ejfIbQKW93yG
X-Gm-Gg: Acq92OHV3d/0g7hyTp+VF/oDoQkewK3VC7nSCX8fSIQBsV6qJwx9l4LhpJDH3I0PYHV
	c8vYU3lgyzinF7XWRubamjcngUeZgi9Ghi5BQQWJHBYbuxxmgWkuNqQgBencuY0GUMMP/y+MqDL
	kFz136lI+qGvSuQeqWszbddU+YWwGhIcanhwCXrJ8iGiMPchupopi/eniGwlsjlEJfXe7kT4Fbh
	XdSglEC0JYUhp0Pl/DH3Y5qTrRLxCFS118B06QfoqDjdccbOCHNgZl+X28Mo4+IuFyxd30qHvEF
	hKPR76b/FcqiPu6uMz/1tbdt0C41zUof2W/EjxfeDq6ouMXl9yzCHk+JTBF7gnkfR+g6iMdrbK+
	Z7IeQ7hT1/vwiN6P7SNqWx3Wv/Pz0un+FbbcaGHxqXUoQrdvKSbwc+q6yMYDnKr8d9PSEdKpR6+
	j6uzKLV5nM6UKG6Gi8QXCOk9vqgTE=
X-Received: by 2002:a17:90b:2584:b0:369:a719:6747 with SMTP id 98e67ed59e1d1-36a676022aamr2210097a91.3.1779473000192;
        Fri, 22 May 2026 11:03:20 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6ec5a287sm1608403a91.0.2026.05.22.11.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:03:19 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com,
	slava@dubeyko.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] ceph: fix OOB read in ceph_osdc_list_watchers via uncapped outdata_len
Date: Fri, 22 May 2026 14:02:30 -0400
Message-ID: <20260522180231.406895-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The OSD reply header field op->payload_len is wire-controlled and is
copied directly into m->outdata_len[i] without any bounds check:

  m->outdata_len[i] = le32_to_cpu(op->payload_len);

This value propagates unchecked to req->r_ops[0].outdata_len and is
then used to set the decode boundary in ceph_osdc_list_watchers():

  void *const end = p + req->r_ops[0].outdata_len;

The actual data allocation is always exactly one page:
  ceph_alloc_page_vector(1, GFP_NOIO)
  ceph_osd_data_pages_init(..., PAGE_SIZE, ...)

The messenger caps the copy to PAGE_SIZE bytes, but the decode window
end is set from the uncapped wire value. A malicious OSD can send
outdata_len=0x10000, causing _safe decoder boundary checks to pass
while the physical reads cross the slab allocation boundary.

KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
  Read of size 4 at addr ffff88800a229f9e by task insmod/57

  CPU: 0 UID: 0 PID: 57 Comm: insmod Tainted: G           O        7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
  Tainted: [O]=OOT_MODULE
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x4d/0x70
   print_report+0x170/0x4f3
   ? __pfx__raw_spin_lock_irqsave+0x10/0x10
   kasan_report+0xda/0x110
   ? ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
   ? ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
   ? __pfx_ceph_oob2_init+0x10/0x10 [ceph_oob2_poc]
   ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
   do_one_initcall+0x9a/0x3a0
   ? __pfx_do_one_initcall+0x10/0x10
   ? kasan_unpoison+0x44/0x70
   do_init_module+0x27c/0x790
   ? __pfx_do_init_module+0x10/0x10
   ? __kasan_slab_free+0x47/0x70
   ? kfree+0x15f/0x3b0
   load_module+0x4a9a/0x6350
   ? __pfx_load_module+0x10/0x10
   ? security_file_permission+0x24/0x50
   ? kernel_read_file+0x2ed/0x770
   ? init_module_from_file+0x15c/0x180
   init_module_from_file+0x15c/0x180
   ? __pfx_init_module_from_file+0x10/0x10
   ? tick_nohz_handler+0x2a3/0x640
   ? _raw_spin_lock+0x7e/0xd0
   idempotent_init_module+0x21f/0x750
   ? __pfx_idempotent_init_module+0x10/0x10
   ? fdget+0x4e/0x4a0
   ? fdget+0x4e/0x4a0
   __x64_sys_finit_module+0xba/0x120
   do_syscall_64+0xe2/0x570
   ? exc_page_fault+0x66/0xb0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Allocated by task 57:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x7f/0x90
   ceph_oob2_init+0x44/0xff0 [ceph_oob2_poc]
   do_one_initcall+0x9a/0x3a0
   do_init_module+0x27c/0x790
   load_module+0x4a9a/0x6350
   init_module_from_file+0x15c/0x180
   idempotent_init_module+0x21f/0x750
   __x64_sys_finit_module+0xba/0x120
   do_syscall_64+0xe2/0x570
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ffff88800a229000
   which belongs to the cache kmalloc-4k of size 4096
  The buggy address is located 3998 bytes inside of
   allocated 4000-byte region [ffff88800a229000, ffff88800a229fa0)

  Memory state around the buggy address:
   ffff88800a229e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff88800a229f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff88800a229f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
                                 ^
   ffff88800a22a000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffff88800a22a080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ==================================================================

  val=0xccccaaaa (OOB garbage from KASAN redzone)

Fix by capping the decode window end to PAGE_SIZE, matching the
actual allocation size.

Attacker model: a malicious or compromised OSD in a multi-tenant
Ceph deployment can trigger this against any client issuing
CEPH_OSD_OP_LIST_WATCHERS without further privileges beyond OSD
session establishment.

Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 net/ceph/osd_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0148e4c40..a67093cf4 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5091,7 +5091,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	ret = ceph_osdc_wait_request(osdc, req);
 	if (ret >= 0) {
 		void *p = page_address(pages[0]);
-		void *const end = p + req->r_ops[0].outdata_len;
+		void *const end = p + min_t(u32, req->r_ops[0].outdata_len, PAGE_SIZE);
 
 		ret = decode_watchers(&p, end, watchers, num_watchers);
 	}
-- 
2.53.0

