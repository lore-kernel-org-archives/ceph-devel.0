Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537B2FE04E
	for <ceph-devel@vger.kernel.org>; Thu,  9 Apr 2026 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764935; cv=none; b=WgnT+NctpWnvDAAsr/UycU/xbI9YBmMW5wM+7njjVZUNU/lzo84baXyCYuNxMwFB6qnWEFcak78iNMPqg/K0eDWm9f0EnEjBiCjlKSndIs01SDMrcC6qX3FwgvVw/7mcCvgO0O+gLnlJ4dn0HLRlvCYw/J7NGNl3uwNvJ2F3efY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764935; c=relaxed/simple;
	bh=TUamk2c/n4EzSk6tInWpK3UAwk4JT+YoELnhh/bIzL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFnkkz5ifUAb3NXa3u82VRHA3gMO3ItOtbhbuk3Li4F5R1RJUIra0GL3oD2xI0BOFaexnnmuC7dE2ZHiG4DLuRMfY+FdL0sfPA5k8exPBYQGsW52cYZyhmE1CopkhUI0UQhojRd2qSUz9YDZGdLdpKiGFRR1lSiSC97ydAv5s/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=HNC+Q/Z2; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="HNC+Q/Z2"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79ea87af213so21064897b3.0
        for <ceph-devel@vger.kernel.org>; Thu, 09 Apr 2026 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775764932; x=1776369732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8IG2sMAY20mayyZ4amBkcGSEP9gN1FD0ITFCaJNDX6M=;
        b=HNC+Q/Z2zQKvm8jseOFG85f1I4FAE67hlIh1krRKXzHp91XDS3PlYQnNQOVVq9vGab
         LN5GY6cQqYqRMxnu0836ckWVcESJKjT/0Cq51sccqwnE+oQjaBzNNyJ3bu2PJhLx1NxO
         TPGeh7cgSQ4vgwy/I4jI6S2Rt5P3AFmdIX5jQMDX4apjtn/9bTPvM3xpFPZbc4tcRUht
         BY1njeYUHIZ5KY11M0ers9EtLIxUdSysjSVA3iSZBeF+jCY1fpveTXNJFOdYJ5uH337w
         Bay48MaVc0JVUD1zzS5BkXZmgPdBvzvnGuPqT6eobZyMx5v0GrRRlTpoJmHxR+DUdIxh
         FU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764932; x=1776369732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IG2sMAY20mayyZ4amBkcGSEP9gN1FD0ITFCaJNDX6M=;
        b=c1Zd9k5RSQCylQ9rebMDuuhGIZ2X6C9jCFU8Cd2ykmqIiIrfVGqeOa+q4p/I4Weq/A
         ejRReh+BWFq5hd1znItAUtl/aZmKvbUJrzJRnGmooLtjc8NF1JKTEoxiOqWgqDZMc7TV
         GYWMStnixEss2s8NFClJeO5+QVIiqDTTsCGVnGni2tej+PIqO/NLJ30GTFkvrVYM+D7k
         lWUEDMydrO3FsXM/0GBf4qXENyafmyXUszpcVC+QNKRb9T8AfV9E65muGYC05hiKcA7U
         MYVKNU2sNeJYXFN8jDYMFyJSEcOH/yZometyk/XhlekiYXqEoD4T32H9JgMNAbOrJ5Po
         EnSg==
X-Gm-Message-State: AOJu0YyZlsnXv0Ptpo/gDdH0NE4ba2S7A03oDa1dVMCP7JnuY6n17QRh
	tKG2ZoKGvjTxNAXKR9ZbxPlKZWj4ibZOzhAE5tH0Q0toujr4gTQh9qT0Tl2hP8qdsVVfYiGRQlB
	xBiKODik=
X-Gm-Gg: AeBDiev+qemG4LhNXjZDu8DQTmYC7UuI9OlEKdgyKpqGdvVYzXWcG93BpBETl2QY1WL
	s3K7yWDgl5xT8nsoy6xO4GELCXzKCZNbbg7YPVxtklDBL4NoByjMAL29AXlTr7w6lRSEw9z4WT0
	jZbHnxFkku3TfajdaO+mzynRc1NdMH7/UW+L5GoyOcPI/ucgPIvEq3LZ4av+pkdvyeVmeayXVzV
	twmE2BiqnlhohTas4uzZ5kS5C/BeUsEG0r5dWVZzXuX4bmtrj/kP2r414kOv+Oi5CJIC25sKE02
	s1hVSrlD5D0zalZXvyjzvFio1xpKUj5Xx5ejx62w6+Kv43YKZ5s6Xj7uUUn/iNwQrF2q3u1pqb2
	k8Z7W4SH7iFivByERupoQIr6qZX5J4RggABZj7lciEUuaBJhBC5jji1V9RyLPZhF7OkklbZ5zC9
	8QDlbM0jTMfJH+GfKMYiCshiK7AJnBQenzTDnw/QloLwWJH9JU5b5mXEyhyXqvt9VEGZQw7kb3v
	vb1LQfRa9SBL9CkSW+9Sos618GSA+8=
X-Received: by 2002:a05:690c:7246:b0:7a0:884e:67f8 with SMTP id 00721157ae682-7af78f572f8mr2078207b3.17.1775764932473;
        Thu, 09 Apr 2026 13:02:12 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:594a:e569:c7df:c654])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fdff108sm3545937b3.42.2026.04.09.13.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:02:11 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: fix BUG_ON in __ceph_build_xattrs_blob() due to stale blob size
Date: Thu,  9 Apr 2026 13:01:59 -0700
Message-ID: <20260409200158.318567-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The generic/642 test-case can reproduce the kernel crash:

[40243.605254] ------------[ cut here ]------------
[40243.605956] kernel BUG at fs/ceph/xattr.c:918!
[40243.607142] Oops: invalid opcode: 0000 [#1] SMP PTI
[40243.608067] CPU: 7 UID: 0 PID: 498762 Comm: kworker/7:1 Not tainted 7.0.0-rc7+ #3 PREEMPT(full)
[40243.609700] Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[40243.611820] Workqueue: ceph-msgr ceph_con_workfn
[40243.612715] RIP: 0010:__ceph_build_xattrs_blob+0x1b8/0x1e0
[40243.613731] Code: 0f 84 82 fe ff ff e9 cf 8e 56 ff 48 8d 65 e8 31 c0 5b 41 5c 41 5d 5d 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 cc cc cc cc <0f> 0b 4c 8b 62 08 41 8b 85 24 07 00 00 49 83 c4 04 41 89 44 24 fc
[40243.616888] RSP: 0018:ffffcc80c4d4b688 EFLAGS: 00010287
[40243.617773] RAX: 0000000000010026 RBX: 0000000000000001 RCX: 0000000000000000
[40243.618928] RDX: ffff8a773798dee0 RSI: 0000000000000000 RDI: 0000000000000000
[40243.620158] RBP: ffffcc80c4d4b6a0 R08: 0000000000000000 R09: 0000000000000000
[40243.621573] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a75f3b58000
[40243.622907] R13: ffff8a75f3b58000 R14: 0000000000000080 R15: 000000000000bffd
[40243.624054] FS:  0000000000000000(0000) GS:ffff8a787d1b4000(0000) knlGS:0000000000000000
[40243.625331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[40243.626269] CR2: 000072f390b623c0 CR3: 000000011c02a003 CR4: 0000000000372ef0
[40243.627408] Call Trace:
[40243.627839]  <TASK>
[40243.628188]  __prep_cap+0x3fd/0x4a0
[40243.628789]  ? do_raw_spin_unlock+0x4e/0xe0
[40243.629474]  ceph_check_caps+0x46a/0xc80
[40243.630094]  ? __lock_acquire+0x4a2/0x2650
[40243.630773]  ? find_held_lock+0x31/0x90
[40243.631347]  ? handle_cap_grant+0x79f/0x1060
[40243.632068]  ? lock_release+0xd9/0x300
[40243.632696]  ? __mutex_unlock_slowpath+0x3e/0x340
[40243.633429]  ? lock_release+0xd9/0x300
[40243.634052]  handle_cap_grant+0xcf6/0x1060
[40243.634745]  ceph_handle_caps+0x122b/0x2110
[40243.635415]  mds_dispatch+0x5bd/0x2160
[40243.636034]  ? ceph_con_process_message+0x65/0x190
[40243.636828]  ? lock_release+0xd9/0x300
[40243.637431]  ceph_con_process_message+0x7a/0x190
[40243.638184]  ? kfree+0x311/0x4f0
[40243.638749]  ? kfree+0x311/0x4f0
[40243.639268]  process_message+0x16/0x1a0
[40243.639915]  ? sg_free_table+0x39/0x90
[40243.640572]  ceph_con_v2_try_read+0xf58/0x2120
[40243.641255]  ? lock_acquire+0xc8/0x300
[40243.641863]  ceph_con_workfn+0x151/0x820
[40243.642493]  process_one_work+0x22f/0x630
[40243.643093]  ? process_one_work+0x254/0x630
[40243.643770]  worker_thread+0x1e2/0x400
[40243.644332]  ? __pfx_worker_thread+0x10/0x10
[40243.645020]  kthread+0x109/0x140
[40243.645560]  ? __pfx_kthread+0x10/0x10
[40243.646125]  ret_from_fork+0x3f8/0x480
[40243.646752]  ? __pfx_kthread+0x10/0x10
[40243.647316]  ? __pfx_kthread+0x10/0x10
[40243.647919]  ret_from_fork_asm+0x1a/0x30
[40243.648556]  </TASK>
[40243.648902] Modules linked in: overlay hctr2 libpolyval chacha libchacha adiantum libnh libpoly1305 essiv intel_rapl_msr intel_rapl_common intel_uncore_frequency_common skx_edac_common nfit kvm_intel kvm irqbypass joydev ghash_clmulni_intel aesni_intel rapl input_leds mac_hid psmouse vga16fb serio_raw vgastate floppy i2c_piix4 pata_acpi bochs qemu_fw_cfg i2c_smbus sch_fq_codel rbd dm_crypt msr parport_pc ppdev lp parport efi_pstore
[40243.654766] ---[ end trace 0000000000000000 ]---

Commit d93231a6bc8a ("ceph: prevent a client from exceeding the MDS
maximum xattr size") moved the required_blob_size computation to before
the __build_xattrs() call, introducing a race.

__build_xattrs() releases and reacquires i_ceph_lock during execution.
In that window, handle_cap_grant() may update i_xattrs.blob with a
newer MDS-provided blob and bump i_xattrs.version.  When
__build_xattrs() detects that index_version < version, it destroys and
rebuilds the entire xattr rb-tree from the new blob, potentially
increasing count, names_size, and vals_size.

The prealloc_blob size check that follows still uses the stale
required_blob_size computed before the rebuild, so it passes even when
prealloc_blob is too small for the now-larger tree. After __set_xattr()
adds one more xattr on top, __ceph_build_xattrs_blob() is called from
the cap flush path and hits:

    BUG_ON(need > ci->i_xattrs.prealloc_blob->alloc_len);

Fix this by recomputing required_blob_size after __build_xattrs()
returns, using the current tree state. Also re-validate against
m_max_xattr_size to fall back to the sync path if the rebuilt tree now
exceeds the MDS limit.

Fixes: d93231a6bc8a ("ceph: prevent a client from exceeding the MDS maximum xattr size")
Link: https://tracker.ceph.com/issues/55725
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/xattr.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 5f87f62091a1..31de29629ba8 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1254,6 +1254,22 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 	      ceph_vinop(inode), name, ceph_cap_string(issued));
 	__build_xattrs(inode);
 
+	/*
+	 * __build_xattrs() may have released and reacquired i_ceph_lock,
+	 * during which handle_cap_grant() could have replaced i_xattrs.blob
+	 * with a newer MDS-provided blob and bumped i_xattrs.version. If that
+	 * caused __build_xattrs() to rebuild the rb-tree from the new blob,
+	 * count/names_size/vals_size may now be larger than when
+	 * required_blob_size was computed above. Recompute it here so the
+	 * prealloc_blob size check below reflects the current tree state.
+	 */
+	required_blob_size = __get_required_blob_size(ci, name_len, val_len);
+	if (required_blob_size > mdsc->mdsmap->m_max_xattr_size) {
+		doutc(cl, "sync (size too large): %d > %llu\n",
+		      required_blob_size, mdsc->mdsmap->m_max_xattr_size);
+		goto do_sync;
+	}
+
 	if (!ci->i_xattrs.prealloc_blob ||
 	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
 		struct ceph_buffer *blob;
-- 
2.53.0

