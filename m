Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054332B130
	for <ceph-devel@vger.kernel.org>; Sat,  8 Aug 2026 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786184079; cv=none; b=H10fbjS8gfNBHZbQxwlGSlKlnm1Lz//X3PBXcYEukxu5vY+agsMOanggTEpzIzd5JF0RSk7y6VCAtgTKFI3x5PKhgGgqBMZpQ8lgL+31ZLWXg9WBlA16Zi9UH88efPY1mjCwyI4dUaWR2FWOWOnLToUKbo5j3i5Cz3fLuSYNVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786184079; c=relaxed/simple;
	bh=ezVHSw/zd/jzJMkbUtiVL1M284PL194y/noeVMwFtyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFPYZdibmfz+lOeO20uvolRLxMLWvuCgJoBE4lc6KbsMc2G3ImqMGDwf4p0nZUVull+ObOrbgWj9irxyeu+F0g44B5LT2kJ5ssQXtbKiOtfLqklA13tJ/7T8pRnrMwbhg1YK7TKikp1DbgvpkV3Dr9bSI6VZS1ySIshuymFEBTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bargrove.com; spf=pass smtp.mailfrom=bargrove.com; dkim=pass (1024-bit key) header.d=bargrove.com header.i=@bargrove.com header.b=LIWlkPP5; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bargrove.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bargrove.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bargrove.com header.i=@bargrove.com header.b="LIWlkPP5"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-470713a9053so111345f8f.0
        for <ceph-devel@vger.kernel.org>; Sat, 08 Aug 2026 03:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bargrove.com; s=google; t=1786184076; x=1786788876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G33fDI4Q4Iz3fkReYaBTG+WJLJUdk1aUZg4Hq/QjqM4=;
        b=LIWlkPP5V9H9QLB0Fs6Q0og99b1jH61GFuNVCc/oyht/ncVQAKeaSTWPeqfKCsyNOJ
         WaZTc0nTaoxhk/SoI9kZU7uzThzv0871XZLPWNuB8btvlfOCULUBxIN8DndMwHWY4c5m
         gX58S/WBUHhxcrD1LwgVbMAYFQOXPbuN2VOl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786184076; x=1786788876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G33fDI4Q4Iz3fkReYaBTG+WJLJUdk1aUZg4Hq/QjqM4=;
        b=RFEaGp59F0QpHj+CgHjjhR9Y6W3pTVXc17wbBeJXZHP91lXPw3c6iPbPmYnBl86Yzg
         YC7Jh5sSBo2x/mu240JzwDQeiL/4V45k82WzbPd4Pop8fkn2NJJs+ZObJuIWaZNg+2cX
         UPrThItDUqaam5ZoTOcB4Rtxf0pYvSif7yLDNB2mLUXdHvogkjafko3sxnyAFh85EJqu
         UYi73VD05SqUQ/9uMLkGT+jatbDpjTyep0WhIyJtcvjy19xO6uCJABXIbWCrYvjd51xk
         05fMHkHn5idfS2vXKAI9rOZwJYnDctg+lU9b1ZKxvLQ/H6Ya1VNIklS3szKrenpijYZV
         HNyA==
X-Gm-Message-State: AOJu0YwgyH2+G5k9/WNk6L9CyRDwL8jsnW1LesYANyae6vKFhZctn0JA
	d94L0GCzPGojuPIhrdVOVXz6V6kU7XHI8z3fhZVfWukOmMd5c8aCX7/dCW0mZlSFkf4=
X-Gm-Gg: AR+sD12PGQQiabuJQSrg5jld4o9nJ1YM0bifjbQaudukwSEn3Q+emAhfnetAfFLN8of
	1hgWRtSe8DyvqOXTCWNOGgdPVW3azL5VMEo2J1G2buMMRhXCIUSuSxf47wDVQKJ4PHt/fzvvcoQ
	pKBvqBbUxC8cxMKMlB7QvHPqUNb3LO62G38eETpyzkpgrcWtEf9Ra2dG1JOjVK9PhJD27qP7M/L
	fHrN4LWeiKnrtlgmiu76egRLWOzTckOw2qskiPu3FZsf8QL1/SallEVLnD7LIrwGrazUK3eTdwH
	ECsB2rhYvQxtiHVGBLKmY313VyiIJjXuttCM5LHH015Iowfs+UQfPEah7dQdwjkgoxeuj4ogRVg
	QnsKmYx8pnKBlYAhCkdPaw2KcMOpEbvvq3Pa02VSgCVAW0oQrfNGk3LSjUD0lvoXMSV6bAw1Rss
	dvGdMuzR0Fes11B4LuGHBxiPOofN5bRtz9R1OGH54xNiBQNlAR1ib6+PVaj8oaPIBz97YsETDXV
	nijTbcqIN9LeM8PLEVPCFf9Vb2Fr+R5Bp5+Jo2CASR74p3QZiykxCAaLLKO54uKwf4h7r/I7Ehv
	3w==
X-Received: by 2002:a05:600c:1c19:b0:499:5a50:b022 with SMTP id 5b1f17b1804b1-4995e07f45bmr124882655e9.3.1786184076384;
        Sat, 08 Aug 2026 03:14:36 -0700 (PDT)
Received: from roberto-5.lan (host-78-145-240-242.as13285.net. [78.145.240.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea2dc4esm124212205e9.13.2026.08.08.03.14.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 03:14:35 -0700 (PDT)
From: matthew@bargrove.com
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Brown <matthew@bargrove.com>
Subject: [PATCH] ceph: fix leaked inode reference on writeback abort at umount
Date: Sat,  8 Aug 2026 11:14:24 +0100
Message-ID: <20260808101425.49616-1-matthew@bargrove.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brown <matthew@bargrove.com>

When ceph_submit_write() fails to take an osd_stopping_blocker -- which
only happens once the filesystem has begun unmounting
(mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHING) -- it redirties and
unlocks the folios it had already pulled out of
ceph_process_folio_batch() via redirty_page_for_writepage(), instead of
submitting them for writeback.

Those folios have already been through folio_clear_dirty_for_io(), so
PG_dirty is clear, but they are still "claimed" by the original
ceph_dirty_folio() call: ci->i_wrbuffer_ref is still counting them,
folio->private still pins a ceph_snap_context, and on the 0 -> 1
i_wrbuffer_ref transition ceph_dirty_folio() took an ihold() on the
inode. None of that has been released, because the folio was never
submitted, so writepages_finish() -- the only place that would release
it -- never runs.

redirty_page_for_writepage() calls folio_mark_dirty(), which invokes
->dirty_folio() again as soon as it observes PG_dirty clear. That
re-enters ceph_dirty_folio() on a folio that is still claimed.
ceph_dirty_folio() cannot distinguish "still claimed, never submitted"
from "genuinely clean again": it increments i_wrbuffer_ref again and
re-attaches a second snap_context reference, but does not take a second
ihold(), because ihold() only fires on the 0 -> 1 transition and
i_wrbuffer_ref is already non-zero.

The result is two i_wrbuffer_ref increments backed by only one ihold().
When the folio is eventually written back successfully on a later,
unrelated writeback pass, writepages_finish() drops exactly one wrbuffer
ref for it, so i_wrbuffer_ref never returns to 0 and the iput() that
should balance the original ihold() never runs. The inode's i_count
stays elevated, evict_inodes() cannot free it, and
generic_shutdown_super() trips:

  VFS: Busy inodes after unmount of ceph (ceph)
  kernel BUG at fs/super.c:650!

(a WARNING rather than a BUG without CONFIG_BUG_ON_DATA_CORRUPTION; on
an affected production node with that config set it is a fatal panic and
a full node reboot).

Fix it by releasing the existing wrbuffer/snap_context claim before
redirtying, mirroring what ceph_invalidate_folio() and
write_folio_nounlock() already do on their own abort paths. This
restores the invariant that ceph_dirty_folio() only ever runs against a
folio that is not already claimed, so it takes exactly one ihold() per
0 -> 1 transition and one matching wrbuffer ref per claimed folio.

Only the locked_pages loop is changed here. The preceding fbatch loop is
deliberately left alone: those entries can include folios that are
legitimately still under a different, in-flight write, where releasing
the claim would be a premature release. The two structurally similar
redirty-after-clear-dirty-for-io sites in ceph_process_folio_batch()
appear to share the same defect class and are left for a follow-up to
keep this fix minimal.

Fixes: fd7449d937e7 ("ceph: fix generic/421 test failure")
Link: https://tracker.ceph.com/issues/79149
Signed-off-by: Matthew Brown <matthew@bargrove.com>
---
Reproduced and verified on a 6.18.40 kernel: forcing the
ceph_submit_write() osd_stopping_blocker-failure branch and unmounting a
CephFS kernel-client mount with dirty pages reliably produces the
"VFS: Busy inodes after unmount of ceph" / fs/super.c:650 splat on the
unpatched kernel, and produces no such splat with this patch applied
(identical kernel, identical trigger). The original failure was captured
in production off-box via the serial console (pstore could not persist
the panic).

 fs/ceph/addr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ecf33b6..97d9ef1 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1426,6 +1426,16 @@ void ceph_shift_unused_folios_left(struct folio_batch *fbatch)
 	fbatch->nr = n;
 }
 
+static void ceph_undo_wrbuffer_claim(struct inode *inode, struct page *page)
+{
+	struct ceph_snap_context *snapc = detach_page_private(page);
+
+	if (!snapc)
+		return;
+	ceph_put_wrbuffer_cap_refs(ceph_inode(inode), 1, snapc);
+	ceph_put_snap_context(snapc);
+}
+
 static
 int ceph_submit_write(struct address_space *mapping,
 			struct writeback_control *wbc,
@@ -1489,6 +1499,7 @@ int ceph_submit_write(struct address_space *mapping,
 			if (!page)
 				continue;
 
+			ceph_undo_wrbuffer_claim(inode, page);
 			redirty_page_for_writepage(wbc, page);
 			unlock_page(page);
 		}
-- 
2.44.0

