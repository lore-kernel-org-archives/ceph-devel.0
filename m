Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DBA44C64B
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554809; cv=none; b=sathB5Ae2OmWXaQx6J9ORfM+UMYJ/L7ub6yyYlGdiKihF8AcYzH7N51VcubhJNO6QaNkgmTI7JvBNI9vAtOJMr8rXH1QGcXUdumkVatpDd5iQDP/LdCSKRvcVZ5HCyKeQleOonp3bRe94MEahenkI1Opih10BOebIocTD9GMnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554809; c=relaxed/simple;
	bh=yDhiJkw3eRE4JPpFtRCOfhC9gFnls38B6dUHSTIEVEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcbBHurvPc5qgbAvuZiI9aGnV/3iFll9FrPuyEy7E4t6othYlUJrbsUcIg0if71m/dbBtpIZ9IiGKwrwxNn8fGtW3xCP6iOsbaftk8UwiSc541W0kp923kVYP2oY5DKWfn5J1ZovYWHBWYtY7xhAtp4u5C3g8kh2XHJSI0LV3No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bargrove.com; spf=pass smtp.mailfrom=bargrove.com; dkim=pass (1024-bit key) header.d=bargrove.com header.i=@bargrove.com header.b=OVIybrRh; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bargrove.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bargrove.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bargrove.com header.i=@bargrove.com header.b="OVIybrRh"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so400390f8f.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bargrove.com; s=google; t=1786554806; x=1787159606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fg28073ie96TIqcLlG1mXyLAvQpsNfOkYwCQmQbpdmg=;
        b=OVIybrRhPEVBoBQjP3qiV1GKF3XUyN4ZIfyvzqs35P/Y67Jw6CITltvOU6NGC01XTz
         nOul2kl2tybPcgCKg+kYIrYeNGnyBV92MQsoo9O7OErInKpLqJzZiZtZ57y/L75ARBEX
         pG57RDAY+aH7SZbjBr7DTTXJxl3+FpgvF+7uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786554806; x=1787159606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fg28073ie96TIqcLlG1mXyLAvQpsNfOkYwCQmQbpdmg=;
        b=sYwwrcnHI5SVZv1B7vLtHBzCn/5D46W8lpBh6LlCzEhL//BI3ZxCfE0sn2FjkVKqF+
         Y8uJp7UTIuebchxFG5y8fYFvrwiQp/i3Yf7+S5YcqEx7BgOcryBGklH9aNVblWEFTFQq
         tOHJZBM8xXZlfyh87diN7blot0jYGZuabOZUBuH8932P/BId36EsaMoSRU1U5AL4ZL02
         W3fCuh9ZJTj029kodilQPTcFG71YjXh+zCN2lbPCsfgyqW/x39bj2j0NPZ4oq7aMwM5H
         rIMtKIGmh6u9WRnoLr4eNr49TlNvGxFhmecsO/MvpkomDNZ15DFvtL4hsimyqBVvQSyl
         OY4A==
X-Forwarded-Encrypted: i=1; AHgh+RpGcc38wPy52G2kL8NblZXFH1q9X0X2OizjNdsSpICRLMWcC7+/vwlrcql91kPLcoSXlsJHsulx6Hqo@vger.kernel.org
X-Gm-Message-State: AOJu0YyM5ti2HGeEnijZ8s8iFnaBsfE7CVjyqqdY2GN5yo5prY3Cr4H2
	Z+l4lYmFNbWWH6JAfhoBBObkthKZdUPYnpY+5ubngrzmPOeG0jnntg/JI2DjVVcvp5g=
X-Gm-Gg: AR+sD13ANiewQaqCwst5IU/o7DDEQlRQwxtD6famcNkCV0Goj4zt2nOuu8MOwKDtvb8
	gh38ZcWjb/RLuMhp4WUxBf15rnexADulGU+CI5DhpwTR7dSfzp6245dS9WgPULNA2GXIUTjUkBS
	Ocyka06Ojd1WNXNW1U2RIwZUDZDzU5YFLWjbkPSfSiw1qBu4nL00DrEEMhWwwcd2ALDNXqX7A9+
	sq88HPRNxZCe/69/2/muMcuhHEVtOXDsXjBWAqefiU7o+X6/dGKyWx4+/NTXLjcIY4SkSWNUr0/
	n8Eqpj4Dk3FOPzd5pNM/VCGawBNWmssLS+xujs8/Y06ZyF7ULYhOlLsDv9SU7iPkIEcdJ/Bugs9
	FaxLXJgq5qIN7wGq6xkIgeNElY010/OKBY+Sa1457BAkz5tCBLao6w4BU2KnToRIxjqmYVXbbzu
	mwG5zxhLqeNFs0nMzIEwVEk/yFk2445DYsWJtPKVCoTctTsn4pveK61I2RbLUVDm+1W+0GqAH9f
	EJZvyWkQQXpp/o2heKooipXzY0gU5civ7VDlxIrnT/IF3YLqxzO1jPVBQzr+wY/thE=
X-Received: by 2002:a05:600c:8b13:b0:496:b3a0:1cfe with SMTP id 5b1f17b1804b1-4997c116e06mr99217415e9.12.1786554805747;
        Wed, 12 Aug 2026 10:13:25 -0700 (PDT)
Received: from roberto-5.lan (host-78-145-240-242.as13285.net. [78.145.240.242])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b3ca6bsm3309685e9.12.2026.08.12.10.13.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 10:13:25 -0700 (PDT)
From: Matthew Brown <matthew@bargrove.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Brown <matthew@bargrove.com>
Subject: [PATCH v2] ceph: fix leaked inode reference on writeback abort at umount
Date: Wed, 12 Aug 2026 18:13:21 +0100
Message-ID: <20260812171321.13112-1-matthew@bargrove.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_dirty_folio() takes a wrbuffer claim on each newly dirtied folio: it
bumps i_wrbuffer_ref (taking an ihold() on the 0->1 transition) and
attaches the snap_context to folio->private.  That claim is released only
by ceph_put_wrbuffer_cap_refs(), which for a submitted write runs from
writepages_finish().

In ceph_submit_write(), if ceph_inc_osd_stopping_blocker() fails -- which
happens during umount -- the request is aborted before submission: the
already-collected folios are only redirtied and unlocked, so
writepages_finish() never runs and the claim is leaked.
redirty_page_for_writepage() -> folio_redirty_for_writepage() ->
filemap_dirty_folio() sets PG_dirty directly and does not go through
->dirty_folio, so ceph_dirty_folio() is not re-entered to rebalance it.
Because every subsequent writeback also fails the osd_stopping_blocker,
i_wrbuffer_ref never returns to 0, the ihold() is never dropped, and the
inode cannot be evicted:

  VFS: Busy inodes after unmount of ceph
  kernel BUG at fs/super.c:650!

Release the orphaned claim in the abort path before redirtying, via
ceph_undo_wrbuffer_claim(): detach the snap_context, drop the wrbuffer
reference (letting i_wrbuffer_ref reach 0 and iput() the inode), and drop
the snap_context reference -- i.e. do what writepages_finish() would have
done for these never-submitted folios.

Only the locked_pages entries are undone; folios still in the fbatch were
never dirty-cleared by this call (folio_clear_dirty_for_io() is the
ownership-transfer point, and a successful move NULLs the fbatch slot), so
they hold no claim this call owns.

Fixes: fd7449d937e7 ("ceph: fix generic/421 test failure")
Signed-off-by: Matthew Brown <matthew@bargrove.com>
---

v2:
 - Reword the commit message: the leak is an orphaned wrbuffer claim on an
   unsubmitted write (writepages_finish() never runs), not
   redirty_page_for_writepage() re-entering ceph_dirty_folio().  Thanks to
   Alex Markuze for the correction.
 - Convert ceph_undo_wrbuffer_claim() to the folio API
   (struct folio * / folio_detach_private()), per Alex Markuze.
 - Spell out the locked_pages/fbatch ownership split in the message, per
   Xiubo Li's comment.

v1: https://lore.kernel.org/all/20260808101425.49616-1-matthew@bargrove.com/
 fs/ceph/addr.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ecf33b6..e9f561b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1426,6 +1426,16 @@ void ceph_shift_unused_folios_left(struct folio_batch *fbatch)
 	fbatch->nr = n;
 }
 
+static void ceph_undo_wrbuffer_claim(struct inode *inode, struct folio *folio)
+{
+	struct ceph_snap_context *snapc = folio_detach_private(folio);
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
 
+			ceph_undo_wrbuffer_claim(inode, page_folio(page));
 			redirty_page_for_writepage(wbc, page);
 			unlock_page(page);
 		}
-- 
2.44.0

