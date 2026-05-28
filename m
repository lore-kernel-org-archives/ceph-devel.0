Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C43EDE44
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971379; cv=none; b=R/5jhaQFHWuHSUNGHKs2IxYIuYGQ76IfFt5yunJtvTOk/3YoCEEz6R/Fhuna2AN40gjl1GXnAVlggpREwZnDyyKd6/hTlv9np9ydT5v2nfiIjtyVnKIFvGKGPr25GiMn9zCJlb3cz3Q6+ac+RNTL/sWU0zscuC0YkWeZIcYiaOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971379; c=relaxed/simple;
	bh=35MlVezcupd5yPlUzqBMIYnD/JJzM6+1PLVhgoDe12M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQJuND4Jhihe2u8TK4RUENimt/hkxXYKa3wV7OSkCIW7CI3RS2rysxmap9S3hEy26qmIz7naVVDbCawoC/Hl0Ql7MPKpXwcK/Ik8pHkPiwv/cWzKzC03nPGStikPbAldo9g5y873iVNzyOs7+pc2nHO1BFALeFd/gqOdVz2TwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLRQNVQT; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLRQNVQT"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b9a1896db5so20074465ad.3
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779971377; x=1780576177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaXEq4usvj1KBBTVFhHU4aIk2csiMoZYWm1hpe477sc=;
        b=pLRQNVQTrV/IoyFPETRhbVwpwgegKG8Yzv3iwt4E8lTKUhYpi+Mdd/HR20xTxPLzog
         zJCx7c4Pq79VkvMgE8YKTTW4LOjx1+5T/+kVGxoABvI4uitiY/WV4dSfIKHF21HHdZTA
         1GhGeOkHOQhZkhnYkQ/lk5WTfgbdTYNwnniZSoKROV5foRtyKMcLKA2DRgVg4q6zdRQH
         6XSUPjuVKfabAXZeI5+2V9DsDtZ8AW19+ktnPDr38GOljH4j1vEGrfKG8lmyvxOdiXf2
         13zvPVipbseZ7cs2qiCaW9AV0+M+hJ87UwdYHULK8NSd4olaUSqoFwX0kz5rtOc3qyIK
         967g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779971377; x=1780576177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaXEq4usvj1KBBTVFhHU4aIk2csiMoZYWm1hpe477sc=;
        b=awzlSXVBrV2MwHxQEqVyf+Sh9LaAKd+X00vACdLl2lnLvSuxsGTSkSwPee2VIPmvMs
         Ut3wDibxA8R4Qu7nQKQPPHA8+toBRSUrRnGerOxM7kYCxbK6fpopCQ8ykZWZPKkECTNw
         4DPNzYDKgza607iV5NiSIzdG4fD3/yEG83Cx9YmYT+fuU4sa+jxqrSBj7VrRNq0Ae5bO
         wd3FtOyG9jxNyaV3QghBWz4klQTz+/xf9froMebwfpvt0WSacvuZhV6Hk89s8F0Fq1pA
         d29KNcYr+HvsvoLHeGJjEeldMkCakZ9LP9QVI6z6R4Ooj9Yfkk+xITHPrsOxehnFj3yD
         Lfjg==
X-Gm-Message-State: AOJu0Ywy4wHrrcDWgEP0uIugzzbP9y61otBDeN66MPGHKqj8XU34kk83
	WILwr/8Grqd+WDL+kVEcdscg8TYB8TGmTmrWNyV9J+93zDrwXUGq7UXt0GLgDR7m
X-Gm-Gg: Acq92OHAS8O9omaUuxD1GaxjRJlrs8pvcBEJ59Rch+HZML097dm1SAwUzKRejNRaNrX
	FtuN/VkmnzqYJ00MLyP5yCwxRoyUX+fMBv6m8u1v7CAUpFmZf3ermpicaw52P+asHQs2F41OXoB
	kxAGQWSla0MQIOVvCWHYsGHHajebpzz0x6UHUSARNFJpznCukow0R9kiXLmv9HbbyamdjugZ6rb
	EE+NInPU6/1l8gdOQUsJ7cgrJb/lPCgvR2WR3OEgThTZWDzIPartPAA1/8JyRH8tb6T+0qRAhfD
	SuUMGVqxmy7kQozWRkJzNuIrSkyE28SzgdoCRM2YrKBG4RQzkHJQvP6dJlntPE/Y/SmBUo1VvkN
	AdEwgebm4+Uf4laPV0Jo6dNgoiHt4t62Eg2uSYYMWesSyHaBNdPLRMFfQyTCAFrH+pluHDnukWe
	le9NN5SZ2ZGPITQ2Btl6dfxGgT4AKI
X-Received: by 2002:a05:6a21:3a85:b0:3a3:1814:20a2 with SMTP id adf61e73a8af0-3b328fa5bbemr14257538637.5.1779971377056;
        Thu, 28 May 2026 05:29:37 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202b3867sm14320967a12.11.2026.05.28.05.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:29:36 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com,
	Slava.Dubeyko@ibm.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH v2] ceph: fix OOB read in ceph_osdc_list_watchers via uncapped outdata_len
Date: Thu, 28 May 2026 08:29:11 -0400
Message-ID: <20260528122911.813491-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <71578c12a1b9d37aa2a39c8d1415084e0dea9216.camel@ibm.com>
References: <71578c12a1b9d37aa2a39c8d1415084e0dea9216.camel@ibm.com>
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
   entry_YSCALL_64_after_hwframe+0x77/0x7f

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

Fix by introducing buf_len to hold the allocation size, using it in
both ceph_osd_data_pages_init() and the min_t() decode boundary cap,
so the two are guaranteed to stay in sync if the buffer size changes.

Attacker model: a malicious or compromised OSD in a multi-tenant
Ceph deployment can trigger this against any client issuing
CEPH_OSD_OP_LIST_WATCHERS without further privileges beyond OSD
session establishment.

Fixes: a4ed38d7a180 ("libceph: support for CEPH_OSD_OP_LIST_WATCHERS")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
v2: Introduce buf_len variable instead of hardcoding PAGE_SIZE
    independently in ceph_osd_data_pages_init() and the min_t() cap,
    per Viacheslav Dubeyko's review.
---
 net/ceph/osd_client.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a67093cf4..7545d3608 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5063,6 +5063,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	struct ceph_osd_request *req;
 	struct page **pages;
 	int ret;
+	const size_t buf_len = PAGE_SIZE;
 
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
 	if (!req)
@@ -5081,7 +5082,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	osd_req_op_init(req, 0, CEPH_OSD_OP_LIST_WATCHERS, 0);
 	ceph_osd_data_pages_init(osd_req_op_data(req, 0, list_watchers,
 						 response_data),
-				 pages, PAGE_SIZE, 0, false, true);
+				 pages, buf_len, 0, false, true);
 
 	ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
 	if (ret)
@@ -5091,7 +5092,7 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 	ret = ceph_osdc_wait_request(osdc, req);
 	if (ret >= 0) {
 		void *p = page_address(pages[0]);
-		void *const end = p + min_t(u32, req->r_ops[0].outdata_len, PAGE_SIZE);
+		void *const end = p + min_t(u32, req->r_ops[0].outdata_len, buf_len);
 
 		ret = decode_watchers(&p, end, watchers, num_watchers);
 	}
-- 
2.53.0

