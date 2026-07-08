Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DABE2C15A0
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jul 2026 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489224; cv=none; b=ueDk7ogXPCsl2TW4Z6oIk6fLi/aAM3tEvquzDxkacEY4eEScctHfpPnFz+DcjAwO+revpAqmaWNLxQK5mpwGZ9EM53sXLY6dzujDE8Ift/tejJ8xDY/jGyPX+FO3265K+ZV4Fg26aaQjf+4roo1uSKs3JdN9Gn2hzKIxlqMHFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489224; c=relaxed/simple;
	bh=gIr0SaX2K90EVt0U62Oqc43cEgL46YyDy/5w6EFjS58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOxfrPeEXXnCyTdYw02aR8Tejttxo2pgFDx4lZpocmwKzQHwvRAAevl1YVLSUyb6RaHinBi2GVSXm9ESzlVCz+3ctklhZBnzJLB76l26Ru8akz6AxqlDnBRiue05UqGvrw/uXpvh4ksckipcxqAXzxpDQsJICfHbXP8rfdCMbe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQz1643k; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQz1643k"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-385b78b4f9bso28543a91.2
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 22:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783489221; x=1784094021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=afD53h7FGemsl3jdOrrWX1SceigfQwiiF8iZ9/aRxdw=;
        b=YQz1643kFZ0HRyHi6hSPszRqBMvhb8lVP0dhZRQBOGdFeze/enBTPuzO2pBHXaA+Vr
         gdkE7sMOZgaGVClnfQgkKTlCXl6o6FrxRmLR4H+FrjxqjvEPvLRWx/65mi0l1PXhqp+D
         E2dS6fQvIl3bAwKNV3gJLzIFgYxGaPVl+sq72kVV3qWeNxcPJEkhDLL3U2Ur6exBau/+
         dTZm7Jk8ZgbLeEDyh9SwCqFVJU70y+Daf2QKzMfPTjdwHOugmLFZW4WQ1jKDQFL/Tv6d
         H+AukQkdszPLxym1qVQxNOyxbc3juld0Lz7EDn6iQT3VFL5QS7Ruif0shQnoskJwHpYK
         GHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783489221; x=1784094021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=afD53h7FGemsl3jdOrrWX1SceigfQwiiF8iZ9/aRxdw=;
        b=evrUfWZEksSHrZrOaiw2TBTxn8TBBAcA5WD+IUbcRD7Ne0Yd5mjqTzThKqjgRbXy3H
         a2wwdrxEbWsTkf7ucmsDbKoV6/W/S3oA8f4KGP8BuTgIWwbSO3bhQJE2JkKhTaRiy3Mz
         mCcCrNKtJ1L+g1tHW45pKgIQI+eG6MH6QLyCZS+xUGQjBa4qdOBHM+cpXtY2U2JixDy4
         ULb9bqBZ76juP88PvbpDayfiMpgJTDWWLb82IFiiqjIe0fsEN1ZYyaFJIXRwMKGTjHEo
         jv+ciGqbyt0goCKUUTZfrEJyusbaDtw/qWGBDUljZdV0Qfreuc7+/sj8UqiFgMUQib6a
         uuCQ==
X-Gm-Message-State: AOJu0YxDugA3O1fG1HGll1DLTRpTTtGHf3WMi6K2EFUUzcEP3HWsB1O7
	/bnH8zB6/JzFWvLAqMC/BTGESR3ipazjNsL4zR/mEubmCW4HNOQN8Dnw
X-Gm-Gg: AfdE7cnC/fNTfvyITkrJn78xlUMMwylinShhbQWCTcx297L5JkQFrrI4cQc8w64pI/4
	A6NzeM1zA6NSp44BFYgjOqTAaWhSqqAIEvbXOvGgbCtFLb+Y+rhYkkCbOyPSyf4kiHql6AAjnQ3
	i8nivg303lnQBcDdOTi3Raf8xkPBOWCUAbr4Mm2Wj1vGmZw/5P/QDvCO3bzj3wEr9b/7SCzwzPY
	zw/OfDpk/B+Iqh+eBwRmkCAaAkrkF09vrNJVuW49tleLRFv/j+RoH8hT0emEea1DPnmoxU0OM7r
	2fpuZ8iA3C+CNmc5FYX+aFmH8Lj2ryH3tWxPiH3hPmtr/ivhgBLFDvL7r64Tf0/cISqyh9GGiJw
	1IvKIB4vqH6ebSrczb9srBCvdZUgNmeuUNfTsKBam/q3fJOM/VQxX6BEgn4YZYqfO8KmWBjlk0d
	uWy139rcdqOKaZ7+jI7g==
X-Received: by 2002:a17:90a:c106:b0:37f:f00b:bda6 with SMTP id 98e67ed59e1d1-3893d81c80emr1043876a91.0.1783489220587;
        Tue, 07 Jul 2026 22:40:20 -0700 (PDT)
Received: from kali ([122.162.146.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6080dsm3245416eec.17.2026.07.07.22.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 22:40:19 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH v4] ceph: fix OOB read in decode_watchers() via missing bounds check
Date: Wed,  8 Jul 2026 01:39:41 -0400
Message-ID: <20260708053941.90316-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702114034.917507-12-amarkuze@redhat.com>
References: <20260702114034.917507-12-amarkuze@redhat.com>
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
v4: Rebase against current linux/master and ceph-testing/testing.
    No functional changes from Slava's reviewed v3.
v3: Rename error label e_inval -> bad per Slava Dubeyko's review.
v2: Correct commit message; retracted overstated impact claims,
    verified with follow-up KASAN harness.
---
 net/ceph/osd_client.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c..2cdac81a6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5030,7 +5030,7 @@ static int decode_watchers(void **p, void *end,
 	if (ret)
 		return ret;
 
-	*num_watchers = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, *num_watchers, bad);
 	*watchers = kzalloc_objs(**watchers, *num_watchers, GFP_NOIO);
 	if (!*watchers)
 		return -ENOMEM;
@@ -5044,6 +5044,8 @@ static int decode_watchers(void **p, void *end,
 	}
 
 	return 0;
+bad:
+	return -EINVAL;
 }
 
 /*
-- 
2.53.0

