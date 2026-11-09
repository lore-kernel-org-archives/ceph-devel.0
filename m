Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794184046;
	b=i/7sHagMazED5BkGH6QRMaNTbhxvpYpGESS5uHuUz34O1GArn/miQkuBCR67od6io35q
	 4a+vKsS2vBp+TI3RXTej1NPNmxHumZkmBU+PDXFzjSt6eGuMBMZVgKob/nta/53h+yJ3Q
	 CwI3eKl2tcKB06FzdDs30jkBJNSiQ7cxJB7hZ0flAlhr4F7eh0zN9g/H39TLx+vaDrTPL
	 8plHDZ9gVs60/yrL/Qr3YF9j3aUdY9vQuT4dlbM2IHPrQuwXICO3EqxOTQRAU5O4DQ30k
	 7xy2M4Ik0zLK+L9/bACXGbwZLlsg6duMWWtSySOS30mucgIA9mmMRRG8gbKwz4/reag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184046;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+axlu6wpXNMTRLubOiQe6i41HcGRKY1Pnf76hg7ssSo=;
	b=yyRZerbpbC+zSNayE28Y5ySGc+Rmu7Zz5U9NFrqHR95DxgoO2C4xZkf7TgZ9aK/DDwlG
	 HOqce8tYoAfn7MqEHIB2yZHS6X2kJm8sjMLUAKJ3NMAn5xYIyZoenRFcB5bV3kzZJ0ram
	 PrSL9yLRj5QEgDSO1vW7z+O5SJDZi7RoPM5Wng4dmxMvQPvuhgsQ4+PrNxzQZQDgSNQme
	 ptoZfaScSfH10RwPl5cSINUvLdmCoOA+xjq0ipRPwKa1iQDxSP4iLhjrYV/cyTILTxEad
	 tELdzidvtHIdXS4FWo3zHOrk+Muc/IeVMgGoNxaL8z7QdBhBO8pvipUQ5yJnbDlzR8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh84Nz5q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8FF606A320;
	Mon,  9 Nov 2026 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh84Nz5q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794184045;
	b=bNNUsnV3lTwnpU0G3hkZ57JTETtqt/7nRSKGHrLCIgxFo5JI4JwGNJl80gYSjxn8YDv/
	 Ikpx3h4pUQHYuZVNKG5eHY5YIUsIVqE/Vf+1zgMyhHxgPBH6Q833t5m4KvM7QGxkNto6/
	 gYHa3APf5cpPKtM/0okA60ToTA0noVwIX5SIWjqVO3x5FbeOdox3W6ppp4l0uVTkFfqe4
	 7q/XrAipCURtWfGZiwEZxM5hg47RF0UCcmigNmgwLWUaUDZ9srkoUIEj+pYiF/UYm6cJ7
	 YptFwLhpVaK0mkij9byPv5Vihmlgy9oABd1oMesLABaVcTz5yinAgZ5pSWkqfUPaBXg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794184045;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+axlu6wpXNMTRLubOiQe6i41HcGRKY1Pnf76hg7ssSo=;
	b=EsG/c1RrAYNMOMPbjdNEK560U07dOSO8v0M6Y/it253uE71QfIwxIkyj5x/kGJyqilQa
	 2d5pNz69wyB8/DM55GGDO1l0cRXF4VgcHNrzZ/UY72Ul9sILQapsoLUsrjNURUD4txPkw
	 07m3pRTsyjuKV8oRoQ+QRT4f/PLfi2l7oaPF18m0yTzLd6lAlWytT+J51cFDOzO4B/R4w
	 9jHyD6C42C88VjgHap2SiHzLdSmdHddYhNPa3Cg4Caie5lQNi+tlcMQxlyjz4dgJqnu4E
	 gLGhUnYiBERg24iQsjUuTiE7vf4hK9C6j02F8S8UUf4tcP6VdHyj0yQxussPVRDztsA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D723C1F0089F;
	Mon,  9 Nov 2026 00:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184045;
	bh=+axlu6wpXNMTRLubOiQe6i41HcGRKY1Pnf76hg7ssSo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oh84Nz5qXCqMqDgu7DXDoZja+swpWjmbCW4g53jR0JC2XxwmY3GDBxz5ybLxVn518
	 njIy/Csywl3KvMdao9vyRHd2ZFXQpvfq/nMG6RipdkAmSSZiaPqtZTwaDKEx7ykZTE
	 RvcQPjAUdMZw4taeQMo3O7WMtzwWSPyG1nHNZpmobS7rLgnRpSKEPhpjxIoSK2IbU4
	 KaIsrdqKnim1IcVJxI13vyvDWVP1pD+4QXv/pMfYAnPZHro2rVr3T6gmbFoDIMXL2f
	 cdC07yPY3PcbGhR+6DCuXdaomZEHqRoTdP1xdw+hp4UgtxaeYyoSE6nODxi4g0Azxw
	 8rjvm7EQHHXtA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4C91748186;
	Mon,  9 Nov 2026 00:27:24 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Mon, 09 Nov 2026 01:27:18 +0100
Subject: [PATCH 1/2] ceph: count a dirty folio out wherever it stops being
 dirty
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-ceph-shutdown-dirty-folios-v1-1-34600e8dab20@clyso.com>
References: <20261109-ceph-shutdown-dirty-folios-v1-0-34600e8dab20@clyso.com>
In-Reply-To: <20261109-ceph-shutdown-dirty-folios-v1-0-34600e8dab20@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184042; l=3807;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=INWE3Vox69f5KmDexh7azfR2ub5l95HDLYAiPuZXyAY=;
 b=eMbn3Nlh7jlWsIYwOUjO1Yw2xwCp1n3T5X1NFs7VVn6+/2kKTUtnkd9LmbWvT44WLBbfQqEkD
 9wHwIqCpH0cAHKFfqZNdO5Qp4aqggqnQGbLQlS17ixsBXWRC7GL1s1r
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

ceph_dirty_folio() counts every folio that becomes dirty in
mdsc->dirty_folios, and ceph_kill_sb() waits for that count to reach
zero before it goes on.  writepages_finish() takes a folio out of the
count when it has been written, but two other places that end a
folio's dirty state only put its snap context and Fb cap ref:

 - ceph_invalidate_folio(), which drops a dirty folio when it is
   truncated or invalidated as a whole;
 - write_folio_nounlock(), which writes back a single folio that is
   dirty in an older snap context than the one a new write needs.

Every such folio stays in the count for good, so after e.g. a truncate
of dirty data, umount waits until mount_timeout:

  ceph: [<fsid> <client>]: umount timed out, 0

Take the folio out of the count there too: ceph_invalidate_folio() now
drops it with ceph_folio_drop_dirty(), which does all of it.

Fixes: fd7449d937e7 ("ceph: fix generic/421 test failure")
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/addr.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b0f06d21ca72..2abed478a4ad 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -126,11 +126,14 @@ static struct ceph_snap_context *ceph_folio_detach_snapc(struct folio *folio)
 }
 
 /*
- * Every dirty byte of a lazy I/O folio lies beyond EOF now: there is
- * nothing to write back, and the bytes in front of its dirty range are
- * not this client's to send.  Drop the folio's dirty state, which the
- * caller has already cleared, with the folio locked, and its count in
- * the dirty folios that umount waits for.
+ * Drop the dirty state of a folio that will not be written back, with
+ * the folio locked: its snap context and dirty range, its Fb cap ref and
+ * its count in the dirty folios that umount waits for.  The caller has
+ * cleared the dirty flag already, or is about to (invalidate_folio).
+ *
+ * E.g. every dirty byte of a lazy I/O folio lies beyond EOF now: there
+ * is nothing to write back, and the bytes in front of its dirty range
+ * are not this client's to send.
  */
 static void ceph_folio_drop_dirty(struct inode *inode, struct folio *folio)
 {
@@ -304,8 +307,6 @@ static void ceph_invalidate_folio(struct folio *folio, size_t offset,
 	struct inode *inode = folio->mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_snap_context *snapc;
 	struct ceph_journal_info __ji;
 
 	ceph_blog_enter_gfp(fsc, &__ji, GFP_ATOMIC);
@@ -339,9 +340,12 @@ static void ceph_invalidate_folio(struct folio *folio, size_t offset,
 		boutc(cl, "%llx.%llx idx %lu full dirty page\n",
 		      ceph_vinop(inode), folio->index);
 
-		snapc = ceph_folio_detach_snapc(folio);
-		ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
-		ceph_put_snap_context(snapc);
+		/*
+		 * The folio goes away dirty (a truncate, or a shut down
+		 * mount): it must leave the dirty folios count too, or
+		 * umount waits for it until mount_timeout.
+		 */
+		ceph_folio_drop_dirty(inode, folio);
 	}
 
 	netfs_invalidate_folio(folio, offset, length);
@@ -1211,6 +1215,11 @@ static int write_folio_nounlock(struct folio *folio,
 	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
 	ceph_put_snap_context(snapc);  /* page's reference */
 
+	if (atomic64_dec_return(&fsc->mdsc->dirty_folios) <= 0) {
+		wake_up_all(&fsc->mdsc->flush_end_wq);
+		WARN_ON(atomic64_read(&fsc->mdsc->dirty_folios) < 0);
+	}
+
 	if (atomic_long_dec_return(&fsc->writeback_count) <
 	    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
 		fsc->write_congested = false;

-- 
2.53.0


