Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6CF4ACC74
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366504; cv=none; b=E2HRO95kNhGGG8Rnqz63pltMvhzwiUADnyS6YuzrQPPI8SK2Nt5Jna1/V/4sf3Rm08sKAm7t9rZCczn5eTy0k/Oo+h5ZjAnoNxurbmVWhUoCwWO9sRponvuLQHhA1eax0HKsC2zHAK1ubvW5B3zTBjMt65lT+Z9PfnvVk/8Co00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366504; c=relaxed/simple;
	bh=GvgR63ejW64Lz+7KkoaqB6+/di+yvIjarnF8nYpv43s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZRbccPe2Le8PMOx4sHiFpkJry0OyHaE7w68gCiJ5Zyir7KI+iPYa6LtH+XJbgsRk9e2POvKgohEPHREfOSGbd5GGiiJbOcZC3sa2jjRtIfLg3qnjh27o776eswig501tguTuEBsEshGmfectu/jvQPhZqyI9Hxgl5GWFyyiuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTZ5dyne; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tEEFwQyp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTZ5dyne";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tEEFwQyp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788366498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BoZ5hKvGz1JEPLwAa9BLIg/k576HAXn0R9TGEdMvK8o=;
	b=cTZ5dyneoKh6h8obRByR3x4TV7Dqk737ZE6YJJ+TkcWpzLF+MEnvhnwN2uIbeLU0NUtklO
	IGqf3ywNzxjvI1wttAJ+6TyrloROYgK+3F0UikEZgIucaXAkYmBnK2O/Rud+OqDdhxpTtG
	tS13BnKrTjJtQqQWc5AKhvzTuwiWxSU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-A2QaN8sfMziPFOuN824WDQ-1; Wed, 02 Sep 2026 12:28:17 -0400
X-MC-Unique: A2QaN8sfMziPFOuN824WDQ-1
X-Mimecast-MFC-AGG-ID: A2QaN8sfMziPFOuN824WDQ_1788366496
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1f548718d0so140598566b.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788366496; x=1788971296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BoZ5hKvGz1JEPLwAa9BLIg/k576HAXn0R9TGEdMvK8o=;
        b=tEEFwQypjRh9yaqjbGJBwZLDKI1pKDjLX/EwJWOf4BDwrVwZO/b/Pr8TOH+acRQtX7
         /RBYKudas4Evg552qhHDqfkxwiKlhlW5F2ZfNHr0uIRKv8whHy63l4az85hAroI0ouFF
         FGnU0mwT8HBSkIipGYN26MfH4ZjNnnFpX8GFT2edYM/Cba+c8YZUfCUEx7pa+l4GJFO0
         2k54zceIxRDNQ97kJPoqA0xqDcwRWmdLHkgVHVfaQSxm/JClENAdyhZohtzuIt0Lve6N
         jTKCWrgowZVdXVib/KBATJKYEiLdDqfPv+/YJ9ht7aIiaFIlNEFc5Hgq/NvgNTl8qUp3
         Pjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366496; x=1788971296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BoZ5hKvGz1JEPLwAa9BLIg/k576HAXn0R9TGEdMvK8o=;
        b=WnqiWkQkSvaiZJ5MKai33elt6VgWPrVcDo+d3oFCa5RQ2+t58GJB0xO7RRGJRB3xAa
         o0jzmYHMNV2HUGznipJZ3q4ckHbHEuZHKDhOGG4IHjGFaaRR9hLMYI1xSQxygH779bxS
         5cXcluoPPqEB3F2964kIaAXVEg/WpA/iibLOM/tWgrQJxWsL0NmWem0U1WDPgeeMJXMk
         bTTk6DBoZXGgnEhlqLyXDYJpCtnUPU6TgVI95Q4+C1P6ew62Yiyubw7Wg7+W8g8NaYxy
         WIW/gq4eTnF9iPm6DW0mw+c2raJsT1DlZUCfHb5b1Q6JX0qa0uXAdveu5kGLuEq3h+et
         OUog==
X-Gm-Message-State: AFuF++k9PVWplQXbe0v5brKNsoeAnuUcMs5TeC/IjdyRfByEwhGJzlLq
	o9/kNUqUyQOh9xCKVEXmTddQj/xOfWaanBg6EsZqdNXTFH1kp68Gpv02PNVRdQrMni7A/ma80e6
	sTrN1Qw0pBXexLSmY68DMo4M8hrsGoPWV9ggmVD7QgE9CSphF54AC6IrhHgJt5SH5Blv+JYUhJr
	6G0wO6b+0Fm4U+U3QQuc0C4NCepoRDP4FbN0bynQ2j2RsXUk2BtA==
X-Gm-Gg: AYBFou3oHjrM4KXXAZ3xFDfpxkU+Bo907Cwg/CBg8UtZvKbNkkok84+7xnib268A3Li
	OBcK+E6hwCR3+uli7ESaDBsyDXDfhm1DjTBo0yfdNKBNL2847/36aM2QY7QFqPbDLuYUYF0/sNz
	pFFBUzDYpQ1i9ZI/x07s7cJwK6i99MIpHT6amrT7k2NF4UHFlMRuDasn93QxPfagsq3GpOxvSDQ
	9FY8OHSBnAtDMdxSUTywRhe3ErIRlMDIO9/TPV+vPtKdON/ZDcL3LKFOGxOoAJa0RSA6hOD2xC3
	5R/1I414GA5znLxAiDIW0UQg1D2YTluqDd4ohxQHVs8n9bidt7xyA88OXOE5cEjHUoPLzkxS39T
	vDuMn6DlFYdBbyfzfbLtWK3FHI8VQOVzubZNcDa5Q8GJjfpznRPZRS9+iM4B9E1e+v50NfIzSSS
	d84GrvlqtoAkV2wg==
X-Received: by 2002:a17:906:7308:b0:c24:82b9:361c with SMTP id a640c23a62f3a-c25d55bb016mr355019766b.17.1788366494907;
        Wed, 02 Sep 2026 09:28:14 -0700 (PDT)
X-Received: by 2002:a17:906:7308:b0:c24:82b9:361c with SMTP id a640c23a62f3a-c25d55bb016mr355014466b.17.1788366493646;
        Wed, 02 Sep 2026 09:28:13 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002e558sm160524866b.21.2026.09.02.09.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:28:13 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>
Subject: [PATCH v4 12/14] ceph: convert VFS data I/O paths to bout
Date: Wed,  2 Sep 2026 16:27:58 +0000
Message-Id: <20260902162800.3197342-13-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902162800.3197342-1-amarkuze@redhat.com>
References: <20260902162800.3197342-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dout()/doutc() with bout()/boutc() in addr.c (readpage,
writepage, direct-IO) and file.c (open, read_iter, write_iter,
fsync, fallocate).

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/addr.c | 198 +++++++++++++++++++++++-------------
 fs/ceph/file.c | 271 +++++++++++++++++++++++++++++++++----------------
 2 files changed, 312 insertions(+), 157 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 534a7a377b2f..2a3b60828561 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -81,15 +81,21 @@ struct ceph_snap_context *ceph_folio_snap_context(const struct folio *folio)
 static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
 	struct inode *inode = mapping->host;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc;
+	struct ceph_journal_info __ji;
+
+	/* May run under page-table locks; only reuse an existing BLOG ctx. */
+	ceph_blog_enter_gfp(fsc, &__ji, GFP_ATOMIC);
 
 	if (folio_test_dirty(folio)) {
-		doutc(cl, "%llx.%llx %p idx %lu -- already dirty\n",
+		boutc(cl, "%llx.%llx %p idx %lu -- already dirty\n",
 		      ceph_vinop(inode), folio, folio->index);
 		VM_BUG_ON_FOLIO(!folio_test_private(folio), folio);
+		ceph_blog_exit(&__ji);
 		return false;
 	}
 
@@ -114,7 +120,7 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 	if (ci->i_wrbuffer_ref == 0)
 		ihold(inode);
 	++ci->i_wrbuffer_ref;
-	doutc(cl, "%llx.%llx %p idx %lu head %d/%d -> %d/%d "
+	boutc(cl, "%llx.%llx %p idx %lu head %d/%d -> %d/%d "
 	      "snapc %p seq %lld (%d snaps)\n",
 	      ceph_vinop(inode), folio, folio->index,
 	      ci->i_wrbuffer_ref-1, ci->i_wrbuffer_ref_head-1,
@@ -129,6 +135,7 @@ static bool ceph_dirty_folio(struct address_space *mapping, struct folio *folio)
 	VM_WARN_ON_FOLIO(folio->private, folio);
 	folio_attach_private(folio, snapc);
 
+	ceph_blog_exit(&__ji);
 	return ceph_fscache_dirty_folio(mapping, folio);
 }
 
@@ -141,20 +148,25 @@ static void ceph_invalidate_folio(struct folio *folio, size_t offset,
 				size_t length)
 {
 	struct inode *inode = folio->mapping->host;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter_gfp(fsc, &__ji, GFP_ATOMIC);
 
 
 	if (offset != 0 || length != folio_size(folio)) {
-		doutc(cl, "%llx.%llx idx %lu partial dirty page %zu~%zu\n",
+		boutc(cl, "%llx.%llx idx %lu partial dirty page %zu~%zu\n",
 		      ceph_vinop(inode), folio->index, offset, length);
+		ceph_blog_exit(&__ji);
 		return;
 	}
 
 	WARN_ON(!folio_test_locked(folio));
 	if (folio_test_private(folio)) {
-		doutc(cl, "%llx.%llx idx %lu full dirty page\n",
+		boutc(cl, "%llx.%llx idx %lu full dirty page\n",
 		      ceph_vinop(inode), folio->index);
 
 		snapc = folio_detach_private(folio);
@@ -163,6 +175,7 @@ static void ceph_invalidate_folio(struct folio *folio, size_t offset,
 	}
 
 	netfs_invalidate_folio(folio, offset, length);
+	ceph_blog_exit(&__ji);
 }
 
 static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
@@ -218,11 +231,14 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	struct ceph_osd_req_op *op = &req->r_ops[0];
 	int err = req->r_result;
 	bool sparse = (op->op == CEPH_OSD_OP_SPARSE_READ);
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter_gfp(fsc, &__ji, GFP_ATOMIC);
 
 	ceph_update_read_metrics(&fsc->mdsc->metric, req->r_start_latency,
 				 req->r_end_latency, osd_data->length, err);
 
-	doutc(cl, "result %d subreq->len=%zu i_size=%lld\n", req->r_result,
+	boutc(cl, "result %d subreq->len=%zu i_size=%lld\n", req->r_result,
 	      subreq->len, i_size_read(req->r_inode));
 
 	/* no object means success but no data */
@@ -274,6 +290,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
 	netfs_read_subreq_terminated(subreq);
 	iput(req->r_inode);
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
+	ceph_blog_exit(&__ji);
 }
 
 #ifdef CONFIG_CEPH_FS_INLINE_DATA
@@ -408,7 +425,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 			goto out;
 	}
 
-	doutc(cl, "%llx.%llx pos=%llu orig_len=%zu len=%llu\n",
+	boutc(cl, "%llx.%llx pos=%llu orig_len=%zu len=%llu\n",
 	      ceph_vinop(inode), subreq->start, subreq->len, len);
 
 	/*
@@ -433,7 +450,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 
 		err = iov_iter_get_pages_alloc2(&subreq->io_iter, &pages, len, &page_off);
 		if (err < 0) {
-			doutc(cl, "%llx.%llx failed to allocate pages, %d\n",
+			boutc(cl, "%llx.%llx failed to allocate pages, %d\n",
 			      ceph_vinop(inode), err);
 			goto out;
 		}
@@ -465,7 +482,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 		subreq->error = err;
 		netfs_read_subreq_terminated(subreq);
 	}
-	doutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
+	boutc(cl, "%llx.%llx result %d\n", ceph_vinop(inode), err);
 }
 
 static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
@@ -507,12 +524,12 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	 */
 	ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
 	if (ret < 0) {
-		doutc(cl, "%llx.%llx, error getting cap\n", ceph_vinop(inode));
+		boutc(cl, "%llx.%llx, error getting cap\n", ceph_vinop(inode));
 		goto out;
 	}
 
 	if (!(got & want)) {
-		doutc(cl, "%llx.%llx, no cache cap\n", ceph_vinop(inode));
+		boutc(cl, "%llx.%llx, no cache cap\n", ceph_vinop(inode));
 		ret = -EACCES;
 		goto out;
 	}
@@ -651,7 +668,7 @@ get_oldest_context(struct inode *inode, struct ceph_writeback_ctl *ctl,
 
 	spin_lock(&ci->i_ceph_lock);
 	list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
-		doutc(cl, " capsnap %p snapc %p has %d dirty pages\n",
+		boutc(cl, " capsnap %p snapc %p has %d dirty pages\n",
 		      capsnap, capsnap->context, capsnap->dirty_pages);
 		if (!capsnap->dirty_pages)
 			continue;
@@ -684,7 +701,7 @@ get_oldest_context(struct inode *inode, struct ceph_writeback_ctl *ctl,
 	}
 	if (!snapc && ci->i_wrbuffer_ref_head) {
 		snapc = ceph_get_snap_context(ci->i_head_snapc);
-		doutc(cl, " head snapc %p has %d dirty pages\n", snapc,
+		boutc(cl, " head snapc %p has %d dirty pages\n", snapc,
 		      ci->i_wrbuffer_ref_head);
 		if (ctl) {
 			ctl->i_size = i_size_read(inode);
@@ -755,7 +772,7 @@ static int write_folio_nounlock(struct folio *folio,
 	bool caching = ceph_is_cache_enabled(inode);
 	struct page *bounce_page = NULL;
 
-	doutc(cl, "%llx.%llx folio %p idx %lu\n", ceph_vinop(inode), folio,
+	boutc(cl, "%llx.%llx folio %p idx %lu\n", ceph_vinop(inode), folio,
 	      folio->index);
 
 	if (ceph_inode_is_shutdown(inode))
@@ -764,13 +781,13 @@ static int write_folio_nounlock(struct folio *folio,
 	/* verify this is a writeable snap context */
 	snapc = ceph_folio_snap_context(folio);
 	if (!snapc) {
-		doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
+		boutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
 		      folio);
 		return 0;
 	}
 	oldest = get_oldest_context(inode, &ceph_wbc, snapc);
 	if (snapc->seq > oldest->seq) {
-		doutc(cl, "%llx.%llx folio %p snapc %p not writeable - noop\n",
+		boutc(cl, "%llx.%llx folio %p snapc %p not writeable - noop\n",
 		      ceph_vinop(inode), folio, snapc);
 		/* we should only noop if called by kswapd */
 		WARN_ON(!(current->flags & PF_MEMALLOC));
@@ -782,7 +799,7 @@ static int write_folio_nounlock(struct folio *folio,
 
 	/* is this a partial page at end of file? */
 	if (page_off >= ceph_wbc.i_size) {
-		doutc(cl, "%llx.%llx folio at %lu beyond eof %llu\n",
+		boutc(cl, "%llx.%llx folio at %lu beyond eof %llu\n",
 		      ceph_vinop(inode), folio->index, ceph_wbc.i_size);
 		folio_invalidate(folio, 0, folio_size(folio));
 		return 0;
@@ -792,7 +809,7 @@ static int write_folio_nounlock(struct folio *folio,
 		len = ceph_wbc.i_size - page_off;
 
 	wlen = IS_ENCRYPTED(inode) ? round_up(len, CEPH_FSCRYPT_BLOCK_SIZE) : len;
-	doutc(cl, "%llx.%llx folio %p index %lu on %llu~%llu snapc %p seq %lld\n",
+	boutc(cl, "%llx.%llx folio %p index %lu on %llu~%llu snapc %p seq %lld\n",
 	      ceph_vinop(inode), folio, folio->index, page_off, wlen, snapc,
 	      snapc->seq);
 
@@ -843,7 +860,7 @@ static int write_folio_nounlock(struct folio *folio,
 	WARN_ON_ONCE(len > folio_size(folio));
 	page = bounce_page ? bounce_page : &folio->page;
 	osd_req_op_extent_osd_data_pages(req, 0, &page, wlen, 0, false, false);
-	doutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
+	boutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
 	      ceph_vinop(inode), page_off, len, wlen,
 	      IS_ENCRYPTED(inode) ? "" : "not ");
 
@@ -868,7 +885,7 @@ static int write_folio_nounlock(struct folio *folio,
 			wbc = &tmp_wbc;
 		if (err == -ERESTARTSYS) {
 			/* killed by SIGKILL */
-			doutc(cl, "%llx.%llx interrupted page %p\n",
+			boutc(cl, "%llx.%llx interrupted page %p\n",
 			      ceph_vinop(inode), folio);
 			folio_redirty_for_writepage(wbc, folio);
 			folio_end_writeback(folio);
@@ -879,12 +896,12 @@ static int write_folio_nounlock(struct folio *folio,
 		}
 		if (err == -EBLOCKLISTED)
 			fsc->blocklisted = true;
-		doutc(cl, "%llx.%llx setting mapping error %d %p\n",
+		boutc(cl, "%llx.%llx setting mapping error %d %p\n",
 		      ceph_vinop(inode), err, folio);
 		mapping_set_error(&inode->i_data, err);
 		wbc->pages_skipped++;
 	} else {
-		doutc(cl, "%llx.%llx cleaned page %p\n",
+		boutc(cl, "%llx.%llx cleaned page %p\n",
 		      ceph_vinop(inode), folio);
 		err = 0;  /* vfs expects us to return 0 */
 	}
@@ -923,8 +940,12 @@ static void writepages_finish(struct ceph_osd_request *req)
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	unsigned int len = 0;
 	bool remove_page;
+	struct ceph_journal_info __ji;
 
-	doutc(cl, "%llx.%llx rc %d\n", ceph_vinop(inode), rc);
+	/* OSD callback: reuse existing ctx only. */
+	ceph_blog_enter_gfp(fsc, &__ji, GFP_ATOMIC);
+
+	boutc(cl, "%llx.%llx rc %d\n", ceph_vinop(inode), rc);
 	if (rc < 0) {
 		mapping_set_error(mapping, rc);
 		ceph_set_error_write(ci);
@@ -984,7 +1005,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 				WARN_ON(atomic64_read(&mdsc->dirty_folios) < 0);
 			}
 
-			doutc(cl, "unlocking %p\n", folio);
+			boutc(cl, "unlocking %p\n", folio);
 
 			if (remove_page)
 				generic_error_remove_folio(inode->i_mapping,
@@ -992,7 +1013,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 
 			folio_unlock(folio);
 		}
-		doutc(cl, "%llx.%llx wrote %llu bytes cleaned %d pages\n",
+		boutc(cl, "%llx.%llx wrote %llu bytes cleaned %d pages\n",
 		      ceph_vinop(inode), osd_data->length,
 		      rc >= 0 ? num_pages : 0);
 
@@ -1016,6 +1037,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 		kfree(osd_data->pages);
 	ceph_osdc_put_request(req);
 	ceph_dec_osd_stopping_blocker(fsc->mdsc);
+	ceph_blog_exit(&__ji);
 }
 
 static inline
@@ -1118,11 +1140,11 @@ int ceph_define_writeback_range(struct address_space *mapping,
 	if (!ceph_wbc->snapc) {
 		/* hmm, why does writepages get called when there
 		   is no dirty data? */
-		doutc(cl, " no snap context with dirty data?\n");
+		boutc(cl, " no snap context with dirty data?\n");
 		return -ENODATA;
 	}
 
-	doutc(cl, " oldest snapc is %p seq %lld (%d snaps)\n",
+	boutc(cl, " oldest snapc is %p seq %lld (%d snaps)\n",
 	      ceph_wbc->snapc, ceph_wbc->snapc->seq,
 	      ceph_wbc->snapc->num_snaps);
 
@@ -1135,13 +1157,13 @@ int ceph_define_writeback_range(struct address_space *mapping,
 			ceph_wbc->end = -1;
 			if (ceph_wbc->index > 0)
 				ceph_wbc->should_loop = true;
-			doutc(cl, " cyclic, start at %lu\n", ceph_wbc->index);
+			boutc(cl, " cyclic, start at %lu\n", ceph_wbc->index);
 		} else {
 			ceph_wbc->index = wbc->range_start >> PAGE_SHIFT;
 			ceph_wbc->end = wbc->range_end >> PAGE_SHIFT;
 			if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 				ceph_wbc->range_whole = true;
-			doutc(cl, " not cyclic, %lu to %lu\n",
+			boutc(cl, " not cyclic, %lu to %lu\n",
 				ceph_wbc->index, ceph_wbc->end);
 		}
 	} else if (!ceph_wbc->head_snapc) {
@@ -1151,7 +1173,7 @@ int ceph_define_writeback_range(struct address_space *mapping,
 		 * associated with 'snapc' get written */
 		if (ceph_wbc->index > 0)
 			ceph_wbc->should_loop = true;
-		doutc(cl, " non-head snapc, range whole\n");
+		boutc(cl, " non-head snapc, range whole\n");
 	}
 
 	ceph_put_snap_context(ceph_wbc->last_snapc);
@@ -1187,14 +1209,14 @@ int ceph_check_folio_before_write(struct address_space *mapping,
 
 	/* only dirty folios, or our accounting breaks */
 	if (unlikely(!folio_test_dirty(folio) || folio->mapping != mapping)) {
-		doutc(cl, "!dirty or !mapping %p\n", folio);
+		boutc(cl, "!dirty or !mapping %p\n", folio);
 		return -ENODATA;
 	}
 
 	/* only if matching snap context */
 	pgsnapc = ceph_folio_snap_context(folio);
 	if (pgsnapc != ceph_wbc->snapc) {
-		doutc(cl, "folio snapc %p %lld != oldest %p %lld\n",
+		boutc(cl, "folio snapc %p %lld != oldest %p %lld\n",
 		      pgsnapc, pgsnapc->seq,
 		      ceph_wbc->snapc, ceph_wbc->snapc->seq);
 
@@ -1206,7 +1228,7 @@ int ceph_check_folio_before_write(struct address_space *mapping,
 	}
 
 	if (folio_pos(folio) >= ceph_wbc->i_size) {
-		doutc(cl, "folio at %lu beyond eof %llu\n",
+		boutc(cl, "folio at %lu beyond eof %llu\n",
 		      folio->index, ceph_wbc->i_size);
 
 		if ((ceph_wbc->size_stable ||
@@ -1219,7 +1241,7 @@ int ceph_check_folio_before_write(struct address_space *mapping,
 
 	if (ceph_wbc->strip_unit_end &&
 	    (folio->index > ceph_wbc->strip_unit_end)) {
-		doutc(cl, "end of strip unit %p\n", folio);
+		boutc(cl, "end of strip unit %p\n", folio);
 		return -E2BIG;
 	}
 
@@ -1343,7 +1365,7 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		if (!folio)
 			continue;
 
-		doutc(cl, "? %p idx %lu, folio_test_writeback %#x, "
+		boutc(cl, "? %p idx %lu, folio_test_writeback %#x, "
 			"folio_test_dirty %#x, folio_test_locked %#x\n",
 			folio, folio->index, folio_test_writeback(folio),
 			folio_test_dirty(folio),
@@ -1351,7 +1373,7 @@ void ceph_process_folio_batch(struct address_space *mapping,
 
 		if (folio_test_writeback(folio) ||
 		    folio_test_private_2(folio) /* [DEPRECATED] */) {
-			doutc(cl, "waiting on writeback %p\n", folio);
+			boutc(cl, "waiting on writeback %p\n", folio);
 			folio_wait_writeback(folio);
 			folio_wait_private_2(folio); /* [DEPRECATED] */
 			continue;
@@ -1375,7 +1397,7 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		}
 
 		if (!folio_clear_dirty_for_io(folio)) {
-			doutc(cl, "%p !folio_clear_dirty_for_io\n", folio);
+			boutc(cl, "%p !folio_clear_dirty_for_io\n", folio);
 			folio_unlock(folio);
 			folio_put(folio);
 			ceph_wbc->fbatch.folios[i] = NULL;
@@ -1403,7 +1425,7 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		}
 
 		/* note position of first page in fbatch */
-		doutc(cl, "%llx.%llx will write folio %p idx %lu\n",
+		boutc(cl, "%llx.%llx will write folio %p idx %lu\n",
 		      ceph_vinop(inode), folio, folio->index);
 
 		fsc->write_congested = is_write_congestion_happened(fsc);
@@ -1559,7 +1581,7 @@ int ceph_submit_write(struct address_space *mapping,
 			osd_req_op_extent_dup_last(req, ceph_wbc->op_idx,
 						   cur_offset - offset);
 
-			doutc(cl, "got pages at %llu~%llu\n", offset, len);
+			boutc(cl, "got pages at %llu~%llu\n", offset, len);
 
 			osd_req_op_extent_osd_data_pages(req, ceph_wbc->op_idx,
 							 ceph_wbc->data_pages,
@@ -1600,7 +1622,7 @@ int ceph_submit_write(struct address_space *mapping,
 	if (IS_ENCRYPTED(inode))
 		len = round_up(len, CEPH_FSCRYPT_BLOCK_SIZE);
 
-	doutc(cl, "got pages at %llu~%llu\n", offset, len);
+	boutc(cl, "got pages at %llu~%llu\n", offset, len);
 
 	if (IS_ENCRYPTED(inode) &&
 	    ((offset | len) & ~CEPH_FSCRYPT_BLOCK_MASK)) {
@@ -1689,16 +1711,21 @@ static int ceph_writepages_start(struct address_space *mapping,
 	struct ceph_client *cl = fsc->client;
 	struct ceph_writeback_ctl ceph_wbc;
 	int rc = 0;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	if (wbc->sync_mode == WB_SYNC_NONE && fsc->write_congested)
+	if (wbc->sync_mode == WB_SYNC_NONE && fsc->write_congested) {
+		ceph_blog_exit(&__ji);
 		return 0;
+	}
 
-	doutc(cl, "%llx.%llx (mode=%s)\n", ceph_vinop(inode),
+	boutc(cl, "%llx.%llx (mode=%s)\n", ceph_vinop(inode),
 	      wbc->sync_mode == WB_SYNC_NONE ? "NONE" :
 	      (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
 
 	if (is_forced_umount(mapping)) {
-		/* we're in a forced umount, don't write! */
+		ceph_blog_exit(&__ji);
 		return -EIO;
 	}
 
@@ -1735,7 +1762,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 							    ceph_wbc.end,
 							    ceph_wbc.tag,
 							    &ceph_wbc.fbatch);
-		doutc(cl, "pagevec_lookup_range_tag for tag %#x got %d\n",
+		boutc(cl, "pagevec_lookup_range_tag for tag %#x got %d\n",
 			ceph_wbc.tag, ceph_wbc.nr_folios);
 
 		if (!ceph_wbc.nr_folios && !ceph_wbc.locked_pages)
@@ -1752,7 +1779,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 		if (ceph_wbc.processed_in_fbatch) {
 			if (folio_batch_count(&ceph_wbc.fbatch) == 0 &&
 			    ceph_wbc.locked_pages < ceph_wbc.max_pages) {
-				doutc(cl, "reached end fbatch, trying for more\n");
+				boutc(cl, "reached end fbatch, trying for more\n");
 				goto get_more_pages;
 			}
 		}
@@ -1783,7 +1810,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			ceph_wbc.done = true;
 
 release_folios:
-		doutc(cl, "folio_batch release on %d folios (%p)\n",
+		boutc(cl, "folio_batch release on %d folios (%p)\n",
 		      (int)ceph_wbc.fbatch.nr,
 		      ceph_wbc.fbatch.nr ? ceph_wbc.fbatch.folios[0] : NULL);
 		folio_batch_release(&ceph_wbc.fbatch);
@@ -1791,7 +1818,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 	if (ceph_wbc.should_loop && !ceph_wbc.done) {
 		/* more to do; loop back to beginning of file */
-		doutc(cl, "looping back to beginning of file\n");
+		boutc(cl, "looping back to beginning of file\n");
 		/* OK even when start_index == 0 */
 		ceph_wbc.end = ceph_wbc.start_index - 1;
 
@@ -1812,9 +1839,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 out:
 	ceph_put_snap_context(ceph_wbc.last_snapc);
-	doutc(cl, "%llx.%llx dend - startone, rc = %d\n", ceph_vinop(inode),
+	boutc(cl, "%llx.%llx dend - startone, rc = %d\n", ceph_vinop(inode),
 	      rc);
 
+	ceph_blog_exit(&__ji);
 	return rc;
 }
 
@@ -1850,7 +1878,7 @@ ceph_find_incompatible(struct folio *folio)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	if (ceph_inode_is_shutdown(inode)) {
-		doutc(cl, " %llx.%llx folio %p is shutdown\n",
+		boutc(cl, " %llx.%llx folio %p is shutdown\n",
 		      ceph_vinop(inode), folio);
 		return ERR_PTR(-ESTALE);
 	}
@@ -1872,14 +1900,14 @@ ceph_find_incompatible(struct folio *folio)
 		if (snapc->seq > oldest->seq) {
 			/* not writeable -- return it for the caller to deal with */
 			ceph_put_snap_context(oldest);
-			doutc(cl, " %llx.%llx folio %p snapc %p not current or oldest\n",
+			boutc(cl, " %llx.%llx folio %p snapc %p not current or oldest\n",
 			      ceph_vinop(inode), folio, snapc);
 			return ceph_get_snap_context(snapc);
 		}
 		ceph_put_snap_context(oldest);
 
 		/* yay, writeable, do it now (without dropping folio lock) */
-		doutc(cl, " %llx.%llx folio %p snapc %p not current, but oldest\n",
+		boutc(cl, " %llx.%llx folio %p snapc %p not current, but oldest\n",
 		      ceph_vinop(inode), folio, snapc);
 		if (folio_clear_dirty_for_io(folio)) {
 			int r = write_folio_nounlock(folio, NULL);
@@ -1927,15 +1955,22 @@ static int ceph_write_begin(const struct kiocb *iocb,
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int r;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	r = netfs_write_begin(&ci->netfs, file, inode->i_mapping, pos, len, foliop, NULL);
-	if (r < 0)
+	if (r < 0) {
+		ceph_blog_exit(&__ji);
 		return r;
+	}
 
 	folio_wait_private_2(*foliop); /* [DEPRECATED] */
 	WARN_ON_ONCE(!folio_test_locked(*foliop));
+	ceph_blog_exit(&__ji);
 	return 0;
 }
 
@@ -1950,10 +1985,14 @@ static int ceph_write_end(const struct kiocb *iocb,
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	bool check_cap = false;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter_gfp(fsc, &__ji, GFP_ATOMIC);
 
-	doutc(cl, "%llx.%llx file %p folio %p %d~%d (%d)\n", ceph_vinop(inode),
+	boutc(cl, "%llx.%llx file %p folio %p %d~%d (%d)\n", ceph_vinop(inode),
 	      file, folio, (int)pos, (int)copied, (int)len);
 
 	if (!folio_test_uptodate(folio)) {
@@ -1978,6 +2017,7 @@ static int ceph_write_end(const struct kiocb *iocb,
 	if (check_cap)
 		ceph_check_caps(ceph_inode(inode), CHECK_CAPS_AUTHONLY);
 
+	ceph_blog_exit(&__ji);
 	return copied;
 }
 
@@ -2014,19 +2054,22 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_client *cl = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_file_info *fi = vma->vm_file->private_data;
 	loff_t off = (loff_t)vmf->pgoff << PAGE_SHIFT;
 	int want, got, err;
 	sigset_t oldset;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
+	struct ceph_journal_info __ji;
 
 	if (ceph_inode_is_shutdown(inode))
 		return ret;
 
 	ceph_block_sigs(&oldset);
+	ceph_blog_enter(fsc, &__ji);
 
-	doutc(cl, "%llx.%llx %llu trying to get caps\n",
+	boutc(cl, "%llx.%llx %llu trying to get caps\n",
 	      ceph_vinop(inode), off);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO;
@@ -2038,7 +2081,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 	if (err < 0)
 		goto out_restore;
 
-	doutc(cl, "%llx.%llx %llu got cap refs on %s\n", ceph_vinop(inode),
+	boutc(cl, "%llx.%llx %llu got cap refs on %s\n", ceph_vinop(inode),
 	      off, ceph_cap_string(got));
 
 	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) ||
@@ -2047,7 +2090,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		ceph_add_rw_context(fi, &rw_ctx);
 		ret = filemap_fault(vmf);
 		ceph_del_rw_context(fi, &rw_ctx);
-		doutc(cl, "%llx.%llx %llu drop cap refs %s ret %x\n",
+		boutc(cl, "%llx.%llx %llu drop cap refs %s ret %x\n",
 		      ceph_vinop(inode), off, ceph_cap_string(got), ret);
 	} else
 		err = -EAGAIN;
@@ -2089,10 +2132,11 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
 out_inline:
 		filemap_invalidate_unlock_shared(mapping);
-		doutc(cl, "%llx.%llx %llu read inline data ret %x\n",
+		boutc(cl, "%llx.%llx %llu read inline data ret %x\n",
 		      ceph_vinop(inode), off, ret);
 	}
 out_restore:
+	ceph_blog_exit(&__ji);
 	ceph_restore_sigs(&oldset);
 	if (err < 0)
 		ret = vmf_error(err);
@@ -2104,7 +2148,8 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct inode *inode = file_inode(vma->vm_file);
-	struct ceph_client *cl = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_file_info *fi = vma->vm_file->private_data;
 	struct ceph_cap_flush *prealloc_cf;
@@ -2115,6 +2160,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	int want, got, err;
 	sigset_t oldset;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
+	struct ceph_journal_info __ji;
 
 	if (ceph_inode_is_shutdown(inode))
 		return ret;
@@ -2125,13 +2171,14 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 
 	sb_start_pagefault(inode->i_sb);
 	ceph_block_sigs(&oldset);
+	ceph_blog_enter(fsc, &__ji);
 
 	if (off + folio_size(folio) <= size)
 		len = folio_size(folio);
 	else
 		len = offset_in_folio(folio, size);
 
-	doutc(cl, "%llx.%llx %llu~%zd getting caps i_size %llu\n",
+	boutc(cl, "%llx.%llx %llu~%zd getting caps i_size %llu\n",
 	      ceph_vinop(inode), off, len, size);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
@@ -2143,7 +2190,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	if (err < 0)
 		goto out_free;
 
-	doutc(cl, "%llx.%llx %llu~%zd got cap refs on %s\n", ceph_vinop(inode),
+	boutc(cl, "%llx.%llx %llu~%zd got cap refs on %s\n", ceph_vinop(inode),
 	      off, len, ceph_cap_string(got));
 
 	/* Update time before taking folio lock */
@@ -2192,10 +2239,11 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 			__mark_inode_dirty(inode, dirty);
 	}
 
-	doutc(cl, "%llx.%llx %llu~%zd dropping cap refs on %s ret %x\n",
+	boutc(cl, "%llx.%llx %llu~%zd dropping cap refs on %s ret %x\n",
 	      ceph_vinop(inode), off, len, ceph_cap_string(got), ret);
 	ceph_put_cap_refs_async(ci, got);
 out_free:
+	ceph_blog_exit(&__ji);
 	ceph_restore_sigs(&oldset);
 	sb_end_pagefault(inode->i_sb);
 	ceph_free_cap_flush(prealloc_cf);
@@ -2229,7 +2277,7 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx len %zu locked_page %p\n", inode,
+	boutc(cl, "%p %llx.%llx len %zu locked_page %p\n", inode,
 	      ceph_vinop(inode), len, locked_page);
 
 	if (len > 0) {
@@ -2271,7 +2319,7 @@ int ceph_uninline_data(struct file *file)
 	inline_version = ceph_inline_version(ci);
 	spin_unlock(&ci->i_ceph_lock);
 
-	doutc(cl, "%llx.%llx inline_version %llu\n", ceph_vinop(inode),
+	boutc(cl, "%llx.%llx inline_version %llu\n", ceph_vinop(inode),
 	      inline_version);
 
 	if (ceph_inode_is_shutdown(inode)) {
@@ -2469,10 +2517,13 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 		goto out;
 
 	if (pool_ns)
-		doutc(cl, "pool %lld ns %.*s no perm cached\n", pool,
-		      (int)pool_ns->len, pool_ns->str);
+		boutc_bounded(cl, "pool %lld ns %.*s no perm cached\n",
+			      (pool, (int)pool_ns->len,
+			       BLOG_STR(pool_ns->str, pool_ns->len)),
+			      (pool, (int)pool_ns->len,
+			       (const char *)pool_ns->str));
 	else
-		doutc(cl, "pool %lld no perm cached\n", pool);
+		boutc(cl, "pool %lld no perm cached\n", pool);
 
 	down_write(&mdsc->pool_perm_rwsem);
 	p = &mdsc->pool_perm_tree.rb_node;
@@ -2538,7 +2589,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 		goto out_unlock;
 
 	/* one page should be large enough for STAT data */
-	pages = ceph_alloc_page_vector(1, GFP_KERNEL);
+	pages = ceph_alloc_page_vector(1, GFP_NOFS);
 	if (IS_ERR(pages)) {
 		err = PTR_ERR(pages);
 		goto out_unlock;
@@ -2597,10 +2648,13 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 	if (!err)
 		err = have;
 	if (pool_ns)
-		doutc(cl, "pool %lld ns %.*s result = %d\n", pool,
-		      (int)pool_ns->len, pool_ns->str, err);
+		boutc_bounded(cl, "pool %lld ns %.*s result = %d\n",
+			      (pool, (int)pool_ns->len,
+			       BLOG_STR(pool_ns->str, pool_ns->len), err),
+			      (pool, (int)pool_ns->len,
+			       (const char *)pool_ns->str, err));
 	else
-		doutc(cl, "pool %lld result = %d\n", pool, err);
+		boutc(cl, "pool %lld result = %d\n", pool, err);
 	return err;
 }
 
@@ -2637,11 +2691,11 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 check:
 	if (flags & CEPH_I_POOL_PERM) {
 		if ((need & CEPH_CAP_FILE_RD) && !(flags & CEPH_I_POOL_RD)) {
-			doutc(cl, "pool %lld no read perm\n", pool);
+			boutc(cl, "pool %lld no read perm\n", pool);
 			return -EPERM;
 		}
 		if ((need & CEPH_CAP_FILE_WR) && !(flags & CEPH_I_POOL_WR)) {
-			doutc(cl, "pool %lld no write perm\n", pool);
+			boutc(cl, "pool %lld no write perm\n", pool);
 			return -EPERM;
 		}
 		return 0;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d5606456dbd5..85b78034cbbf 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -69,7 +69,7 @@ static __le32 ceph_flags_sys2wire(struct ceph_mds_client *mdsc, u32 flags)
 #undef ceph_sys2wire
 
 	if (flags)
-		doutc(cl, "unused open flags: %x\n", flags);
+		boutc(cl, "unused open flags: %x\n", flags);
 
 	return cpu_to_le32(wire_flags);
 }
@@ -226,7 +226,7 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
 	struct ceph_file_info *fi;
 	int ret;
 
-	doutc(cl, "%p %llx.%llx %p 0%o (%s)\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx %p 0%o (%s)\n", inode, ceph_vinop(inode),
 	      file, inode->i_mode, isdir ? "dir" : "regular");
 	BUG_ON(inode->i_fop->release != ceph_release);
 
@@ -294,12 +294,12 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 		break;
 
 	case S_IFLNK:
-		doutc(cl, "%p %llx.%llx %p 0%o (symlink)\n", inode,
+		boutc(cl, "%p %llx.%llx %p 0%o (symlink)\n", inode,
 		      ceph_vinop(inode), file, inode->i_mode);
 		break;
 
 	default:
-		doutc(cl, "%p %llx.%llx %p 0%o (special)\n", inode,
+		boutc(cl, "%p %llx.%llx %p 0%o (special)\n", inode,
 		      ceph_vinop(inode), file, inode->i_mode);
 		/*
 		 * we need to drop the open ref now, since we don't
@@ -332,7 +332,7 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap) &&
 	    (issued & wanted) == wanted) {
 		spin_unlock(&ci->i_ceph_lock);
-		doutc(cl, "%p %llx.%llx want %s issued %s updating mds_wanted\n",
+		boutc(cl, "%p %llx.%llx want %s issued %s updating mds_wanted\n",
 		      inode, ceph_vinop(inode), ceph_cap_string(wanted),
 		      ceph_cap_string(issued));
 		ceph_check_caps(ci, 0);
@@ -365,7 +365,7 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	ceph_mdsc_put_request(req);
 out:
-	doutc(cl, "%p %llx.%llx open result=%d\n", inode, ceph_vinop(inode),
+	boutc(cl, "%p %llx.%llx open result=%d\n", inode, ceph_vinop(inode),
 	      err);
 	return err < 0 ? err : 0;
 }
@@ -390,9 +390,13 @@ int ceph_open(struct inode *inode, struct file *file)
 	char *path;
 	bool do_sync = false;
 	int mask = MAY_READ;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	if (fi) {
-		doutc(cl, "file %p is already opened\n", file);
+		boutc(cl, "file %p is already opened\n", file);
+		ceph_blog_exit(&__ji);
 		return 0;
 	}
 
@@ -402,11 +406,13 @@ int ceph_open(struct inode *inode, struct file *file)
 		flags = O_DIRECTORY;  /* mds likes to know */
 	} else if (S_ISREG(inode->i_mode)) {
 		err = fscrypt_file_open(inode, file);
-		if (err)
+		if (err) {
+			ceph_blog_exit(&__ji);
 			return err;
+		}
 	}
 
-	doutc(cl, "%p %llx.%llx file %p flags %d (%d)\n", inode,
+	boutc(cl, "%p %llx.%llx file %p flags %d (%d)\n", inode,
 	      ceph_vinop(inode), file, flags, file->f_flags);
 	fmode = ceph_flags_to_mode(flags);
 	wanted = ceph_caps_for_mode(fmode);
@@ -430,6 +436,7 @@ int ceph_open(struct inode *inode, struct file *file)
 
 		/* For none EACCES cases will let the MDS do the mds auth check */
 		if (err == -EACCES) {
+			ceph_blog_exit(&__ji);
 			return err;
 		} else if (err < 0) {
 			do_sync = true;
@@ -438,11 +445,14 @@ int ceph_open(struct inode *inode, struct file *file)
 	}
 
 	/* snapped files are read-only */
-	if (ceph_in_snap(inode) && (file->f_mode & FMODE_WRITE))
+	if (ceph_in_snap(inode) && (file->f_mode & FMODE_WRITE)) {
+		ceph_blog_exit(&__ji);
 		return -EROFS;
+	}
 
 	/* trivially open snapdir */
 	if (ceph_snap(inode) == CEPH_SNAPDIR) {
+		ceph_blog_exit(&__ji);
 		return ceph_init_file(inode, file, fmode);
 	}
 
@@ -457,7 +467,7 @@ int ceph_open(struct inode *inode, struct file *file)
 		int mds_wanted = __ceph_caps_mds_wanted(ci, true);
 		int issued = __ceph_caps_issued(ci, NULL);
 
-		doutc(cl, "open %p fmode %d want %s issued %s using existing\n",
+		boutc(cl, "open %p fmode %d want %s issued %s using existing\n",
 		      inode, fmode, ceph_cap_string(wanted),
 		      ceph_cap_string(issued));
 		__ceph_touch_fmode(ci, mdsc, fmode);
@@ -469,17 +479,19 @@ int ceph_open(struct inode *inode, struct file *file)
 		    ceph_snap(inode) != CEPH_SNAPDIR)
 			ceph_check_caps(ci, 0);
 
+		ceph_blog_exit(&__ji);
 		return ceph_init_file(inode, file, fmode);
 	} else if (!do_sync && ceph_in_snap(inode) &&
 		   (ci->i_snap_caps & wanted) == wanted) {
 		__ceph_touch_fmode(ci, mdsc, fmode);
 		spin_unlock(&ci->i_ceph_lock);
+		ceph_blog_exit(&__ji);
 		return ceph_init_file(inode, file, fmode);
 	}
 
 	spin_unlock(&ci->i_ceph_lock);
 
-	doutc(cl, "open fmode %d wants %s\n", fmode, ceph_cap_string(wanted));
+	boutc(cl, "open fmode %d wants %s\n", fmode, ceph_cap_string(wanted));
 	req = prepare_open_request(inode->i_sb, flags, 0);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
@@ -493,8 +505,9 @@ int ceph_open(struct inode *inode, struct file *file)
 	if (!err)
 		err = ceph_init_file(inode, file, req->r_fmode);
 	ceph_mdsc_put_request(req);
-	doutc(cl, "open result=%d on %llx.%llx\n", err, ceph_vinop(inode));
+	boutc(cl, "open result=%d on %llx.%llx\n", err, ceph_vinop(inode));
 out:
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
@@ -748,7 +761,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 			      req->r_fmode, NULL);
 	up_read(&mdsc->snap_rwsem);
 	if (ret) {
-		doutc(cl, "failed to fill inode: %d\n", ret);
+		boutc(cl, "failed to fill inode: %d\n", ret);
 		ceph_dir_clear_complete(dir);
 		if (!d_unhashed(dentry))
 			d_drop(dentry);
@@ -756,7 +769,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	} else {
 		struct dentry *dn;
 
-		doutc(cl, "d_adding new inode 0x%llx to 0x%llx/%s\n",
+		boutc(cl, "d_adding new inode 0x%llx to 0x%llx/%s\n",
 		      vino.ino, ceph_ino(dir), dentry->d_name.name);
 		ceph_dir_clear_ordered(dir);
 		ceph_init_inode_acls(inode, as_ctx);
@@ -807,17 +820,24 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	int mask;
 	int err;
 	char *path;
+	struct ceph_journal_info __ji;
 
-	doutc(cl, "%p %llx.%llx dentry %p '%pd' %s flags %d mode 0%o\n",
-	      dir, ceph_vinop(dir), dentry, dentry,
+	ceph_blog_enter(fsc, &__ji);
+
+	boutc(cl, "%p %llx.%llx dentry %p '%s' %s flags %d mode 0%o\n",
+	      dir, ceph_vinop(dir), dentry, dentry->d_name.name,
 	      d_unhashed(dentry) ? "unhashed" : "hashed", flags, mode);
 
-	if (dentry->d_name.len > NAME_MAX)
+	if (dentry->d_name.len > NAME_MAX) {
+		ceph_blog_exit(&__ji);
 		return -ENAMETOOLONG;
+	}
 
 	err = ceph_wait_on_conflict_unlink(dentry);
-	if (err)
+	if (err) {
+		ceph_blog_exit(&__ji);
 		return err;
+	}
 	/*
 	 * Do not truncate the file, since atomic_open is called before the
 	 * permission check. The caller will do the truncation afterward.
@@ -846,6 +866,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 
 		/* For none EACCES cases will let the MDS do the mds auth check */
 		if (err == -EACCES) {
+			ceph_blog_exit(&__ji);
 			return err;
 		} else if (err < 0) {
 			try_async = false;
@@ -855,8 +876,10 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 
 retry:
 	if (flags & O_CREAT) {
-		if (ceph_quota_is_max_files_exceeded(dir))
+		if (ceph_quota_is_max_files_exceeded(dir)) {
+			ceph_blog_exit(&__ji);
 			return -EDQUOT;
+		}
 
 		new_inode = ceph_new_inode(dir, dentry, &mode, &as_ctx);
 		if (IS_ERR(new_inode)) {
@@ -869,6 +892,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			try_async = false;
 	} else if (!d_in_lookup(dentry)) {
 		/* If it's not being looked up, it's negative */
+		ceph_blog_exit(&__ji);
 		return -ENOENT;
 	}
 
@@ -979,7 +1003,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		goto out_req;
 	if (dn || d_really_is_negative(dentry) || d_is_symlink(dentry)) {
 		/* make vfs retry on splice, ENOENT, or symlink */
-		doutc(cl, "finish_no_open on dn %p\n", dn);
+		boutc(cl, "finish_no_open on dn %p\n", dn);
 		err = finish_no_open(file, dn);
 	} else {
 		if (IS_ENCRYPTED(dir) &&
@@ -990,7 +1014,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			goto out_req;
 		}
 
-		doutc(cl, "finish_open on dn %p\n", dn);
+		boutc(cl, "finish_open on dn %p\n", dn);
 		if (req->r_op == CEPH_MDS_OP_CREATE && req->r_reply_info.has_create_ino) {
 			struct inode *newino = d_inode(dentry);
 
@@ -1009,18 +1033,23 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	iput(new_inode);
 out_ctx:
 	ceph_release_acl_sec_ctx(&as_ctx);
-	doutc(cl, "result=%d\n", err);
+	boutc(cl, "result=%d\n", err);
+	ceph_blog_exit(&__ji);
 	return err;
 }
 
 int ceph_release(struct inode *inode, struct file *file)
 {
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	if (S_ISDIR(inode->i_mode)) {
 		struct ceph_dir_file_info *dfi = file->private_data;
-		doutc(cl, "%p %llx.%llx dir file %p\n", inode,
+		boutc(cl, "%p %llx.%llx dir file %p\n", inode,
 		      ceph_vinop(inode), file);
 		WARN_ON(!list_empty(&dfi->file_info.rw_contexts));
 
@@ -1033,7 +1062,7 @@ int ceph_release(struct inode *inode, struct file *file)
 		kmem_cache_free(ceph_dir_file_cachep, dfi);
 	} else {
 		struct ceph_file_info *fi = file->private_data;
-		doutc(cl, "%p %llx.%llx regular file %p\n", inode,
+		boutc(cl, "%p %llx.%llx regular file %p\n", inode,
 		      ceph_vinop(inode), file);
 		WARN_ON(!list_empty(&fi->rw_contexts));
 
@@ -1045,6 +1074,7 @@ int ceph_release(struct inode *inode, struct file *file)
 
 	/* wake up anyone waiting for caps on this inode */
 	wake_up_all(&ci->i_cap_wq);
+	ceph_blog_exit(&__ji);
 	return 0;
 }
 
@@ -1079,7 +1109,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 	bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
 	u64 objver = 0;
 
-	doutc(cl, "on inode %p %llx.%llx %llx~%llx\n", inode,
+	boutc(cl, "on inode %p %llx.%llx %llx~%llx\n", inode,
 	      ceph_vinop(inode), *ki_pos, len);
 
 	if (ceph_inode_is_shutdown(inode))
@@ -1115,7 +1145,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		/* determine new offset/length if encrypted */
 		ceph_fscrypt_adjust_off_and_len(inode, &read_off, &read_len);
 
-		doutc(cl, "orig %llu~%llu reading %llu~%llu", off, len,
+		boutc(cl, "orig %llu~%llu reading %llu~%llu", off, len,
 		      read_off, read_len);
 
 		req = ceph_osdc_new_request(osdc, &ci->i_layout,
@@ -1179,7 +1209,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 			objver = req->r_version;
 
 		i_size = i_size_read(inode);
-		doutc(cl, "%llu~%llu got %zd i_size %llu%s\n", off, len,
+		boutc(cl, "%llu~%llu got %zd i_size %llu%s\n", off, len,
 		      ret, i_size, (more ? " MORE" : ""));
 
 		/* Fix it to go to end of extent map */
@@ -1226,7 +1256,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 			int zlen = min(len - ret, i_size - off - ret);
 			int zoff = page_off + ret;
 
-			doutc(cl, "zero gap %llu~%llu\n", off + ret,
+			boutc(cl, "zero gap %llu~%llu\n", off + ret,
 			      off + ret + zlen);
 			ceph_zero_page_vector_range(zoff, zlen, pages);
 			ret += zlen;
@@ -1272,7 +1302,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		if (last_objver)
 			*last_objver = objver;
 	}
-	doutc(cl, "result %zd retry_op %d\n", ret, *retry_op);
+	boutc(cl, "result %zd retry_op %d\n", ret, *retry_op);
 	return ret;
 }
 
@@ -1283,7 +1313,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 	struct inode *inode = file_inode(file);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 
-	doutc(cl, "on file %p %llx~%zx %s\n", file, iocb->ki_pos,
+	boutc(cl, "on file %p %llx~%zx %s\n", file, iocb->ki_pos,
 	      iov_iter_count(to),
 	      (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
 
@@ -1543,7 +1573,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	if (write && ceph_in_snap(file_inode(file)))
 		return -EROFS;
 
-	doutc(cl, "sync_direct_%s on file %p %lld~%u snapc %p seq %lld\n",
+	boutc(cl, "sync_direct_%s on file %p %lld~%u snapc %p seq %lld\n",
 	      (write ? "write" : "read"), file, pos, (unsigned)count,
 	      snapc, snapc ? snapc->seq : 0);
 
@@ -1556,7 +1586,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 					pos >> PAGE_SHIFT,
 					(pos + count - 1) >> PAGE_SHIFT);
 		if (ret2 < 0)
-			doutc(cl, "invalidate_inode_pages2_range returned %d\n",
+			boutc(cl, "invalidate_inode_pages2_range returned %d\n",
 			      ret2);
 
 		flags = /* CEPH_OSD_FLAG_ORDERSNAP | */ CEPH_OSD_FLAG_WRITE;
@@ -1779,7 +1809,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	if (ceph_in_snap(file_inode(file)))
 		return -EROFS;
 
-	doutc(cl, "on file %p %lld~%u snapc %p seq %lld\n", file, pos,
+	boutc(cl, "on file %p %lld~%u snapc %p seq %lld\n", file, pos,
 	      (unsigned)count, snapc, snapc->seq);
 
 	ret = filemap_write_and_wait_range(inode->i_mapping,
@@ -1824,7 +1854,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		last = (pos + len) != (write_pos + write_len);
 		rmw = first || last;
 
-		doutc(cl, "ino %llx %lld~%llu adjusted %lld~%llu -- %srmw\n",
+		boutc(cl, "ino %llx %lld~%llu adjusted %lld~%llu -- %srmw\n",
 		      ceph_ino(inode), pos, len, write_pos, write_len,
 		      rmw ? "" : "no ");
 
@@ -2040,7 +2070,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			left -= ret;
 		}
 		if (ret < 0) {
-			doutc(cl, "write failed with %d\n", ret);
+			boutc(cl, "write failed with %d\n", ret);
 			ceph_release_page_vector(pages, num_pages);
 			break;
 		}
@@ -2049,7 +2079,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			ret = ceph_fscrypt_encrypt_pages(inode, pages,
 							 write_pos, write_len);
 			if (ret < 0) {
-				doutc(cl, "encryption failed with %d\n", ret);
+				boutc(cl, "encryption failed with %d\n", ret);
 				ceph_release_page_vector(pages, num_pages);
 				break;
 			}
@@ -2068,7 +2098,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			break;
 		}
 
-		doutc(cl, "write op %lld~%llu\n", write_pos, write_len);
+		boutc(cl, "write op %lld~%llu\n", write_pos, write_len);
 		osd_req_op_extent_osd_data_pages(req, rmw ? 1 : 0, pages, write_len,
 						 offset_in_page(write_pos), false,
 						 true);
@@ -2104,7 +2134,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 						 write_len);
 		ceph_osdc_put_request(req);
 		if (ret != 0) {
-			doutc(cl, "osd write returned %d\n", ret);
+			boutc(cl, "osd write returned %d\n", ret);
 			/* Version changed! Must re-do the rmw cycle */
 			if ((assert_ver && (ret == -ERANGE || ret == -EOVERFLOW)) ||
 			    (!assert_ver && ret == -EEXIST)) {
@@ -2134,13 +2164,13 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 				pos >> PAGE_SHIFT,
 				(pos + len - 1) >> PAGE_SHIFT);
 		if (ret < 0) {
-			doutc(cl, "invalidate_inode_pages2_range returned %d\n",
+			boutc(cl, "invalidate_inode_pages2_range returned %d\n",
 			      ret);
 			ret = 0;
 		}
 		pos += len;
 		written += len;
-		doutc(cl, "written %d\n", written);
+		boutc(cl, "written %d\n", written);
 		if (pos > i_size_read(inode)) {
 			check_caps = ceph_inode_set_size(inode, pos);
 			if (check_caps)
@@ -2154,7 +2184,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		ret = written;
 		iocb->ki_pos = pos;
 	}
-	doutc(cl, "returning %d\n", ret);
+	boutc(cl, "returning %d\n", ret);
 	return ret;
 }
 
@@ -2173,22 +2203,30 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	bool direct_lock = iocb->ki_flags & IOCB_DIRECT;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	ssize_t ret;
 	int want = 0, got = 0;
 	int retry_op = 0, read = 0;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 again:
-	doutc(cl, "%llu~%u trying to get caps on %p %llx.%llx\n",
+	boutc(cl, "%llu~%u trying to get caps on %p %llx.%llx\n",
 	      iocb->ki_pos, (unsigned)len, inode, ceph_vinop(inode));
 
-	if (ceph_inode_is_shutdown(inode))
+	if (ceph_inode_is_shutdown(inode)) {
+		ceph_blog_exit(&__ji);
 		return -ESTALE;
+	}
 
 	ret = direct_lock ? ceph_start_io_direct(inode) :
 			    ceph_start_io_read(inode);
-	if (ret)
+	if (ret) {
+		ceph_blog_exit(&__ji);
 		return ret;
+	}
 
 	if (!(fi->flags & CEPH_F_SYNC) && !direct_lock)
 		want |= CEPH_CAP_FILE_CACHE;
@@ -2201,6 +2239,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			ceph_end_io_direct(inode);
 		else
 			ceph_end_io_read(inode);
+		ceph_blog_exit(&__ji);
 		return ret;
 	}
 
@@ -2208,7 +2247,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	    (iocb->ki_flags & IOCB_DIRECT) ||
 	    (fi->flags & CEPH_F_SYNC)) {
 
-		doutc(cl, "sync %p %llx.%llx %llu~%u got cap refs on %s\n",
+		boutc(cl, "sync %p %llx.%llx %llu~%u got cap refs on %s\n",
 		      inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
 		      ceph_cap_string(got));
 
@@ -2228,7 +2267,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 	} else {
 		CEPH_DEFINE_RW_CONTEXT(rw_ctx, got);
-		doutc(cl, "async %p %llx.%llx %llu~%u got cap refs on %s\n",
+		boutc(cl, "async %p %llx.%llx %llu~%u got cap refs on %s\n",
 		      inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
 		      ceph_cap_string(got));
 		ceph_add_rw_context(fi, &rw_ctx);
@@ -2236,7 +2275,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		ceph_del_rw_context(fi, &rw_ctx);
 	}
 
-	doutc(cl, "%p %llx.%llx dropping cap refs on %s = %d\n",
+	boutc(cl, "%p %llx.%llx dropping cap refs on %s = %d\n",
 	      inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
 	ceph_put_cap_refs(ci, got);
 
@@ -2252,8 +2291,10 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		int mask = CEPH_STAT_CAP_SIZE;
 		if (retry_op == READ_INLINE) {
 			page = __page_cache_alloc(GFP_KERNEL);
-			if (!page)
+			if (!page) {
+				ceph_blog_exit(&__ji);
 				return -ENOMEM;
+			}
 
 			mask = CEPH_STAT_CAP_INLINE_DATA;
 		}
@@ -2266,6 +2307,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				BUG_ON(retry_op != READ_INLINE);
 				goto again;
 			}
+			ceph_blog_exit(&__ji);
 			return statret;
 		}
 
@@ -2293,13 +2335,14 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				read += ret;
 			}
 			__free_pages(page, 0);
+			ceph_blog_exit(&__ji);
 			return read;
 		}
 
 		/* hit EOF or hole? */
 		if (retry_op == CHECK_EOF && iocb->ki_pos < i_size &&
 		    ret < len) {
-			doutc(cl, "may hit hole, ppos %lld < size %lld, reading more\n",
+			boutc(cl, "may hit hole, ppos %lld < size %lld, reading more\n",
 			      iocb->ki_pos, i_size);
 
 			read += ret;
@@ -2312,6 +2355,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (ret >= 0)
 		ret += read;
 
+	ceph_blog_exit(&__ji);
 	return ret;
 }
 
@@ -2326,24 +2370,35 @@ static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
 {
 	struct ceph_file_info *fi = in->private_data;
 	struct inode *inode = file_inode(in);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_client *cl = fsc->client;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	ssize_t ret;
 	int want = 0, got = 0;
 	CEPH_DEFINE_RW_CONTEXT(rw_ctx, 0);
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	dout("splice_read %p %llx.%llx %llu~%zu trying to get caps on %p\n",
+	boutc(cl, "splice_read %p %llx.%llx %llu~%zu trying to get caps on %p\n",
 	     inode, ceph_vinop(inode), *ppos, len, inode);
 
-	if (ceph_inode_is_shutdown(inode))
+	if (ceph_inode_is_shutdown(inode)) {
+		ceph_blog_exit(&__ji);
 		return -ESTALE;
+	}
 
 	if (ceph_has_inline_data(ci) ||
-	    (fi->flags & CEPH_F_SYNC))
+	    (fi->flags & CEPH_F_SYNC)) {
+		ceph_blog_exit(&__ji);
 		return copy_splice_read(in, ppos, pipe, len, flags);
+	}
 
 	ret = ceph_start_io_read(inode);
-	if (ret)
+	if (ret) {
+		ceph_blog_exit(&__ji);
 		return ret;
+	}
 
 	want = CEPH_CAP_FILE_CACHE;
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
@@ -2354,16 +2409,17 @@ static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
 		goto out_end;
 
 	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) == 0) {
-		dout("splice_read/sync %p %llx.%llx %llu~%zu got cap refs on %s\n",
+		boutc(cl, "splice_read/sync %p %llx.%llx %llu~%zu got cap refs on %s\n",
 		     inode, ceph_vinop(inode), *ppos, len,
 		     ceph_cap_string(got));
 
 		ceph_put_cap_refs(ci, got);
 		ceph_end_io_read(inode);
+		ceph_blog_exit(&__ji);
 		return copy_splice_read(in, ppos, pipe, len, flags);
 	}
 
-	dout("splice_read %p %llx.%llx %llu~%zu got cap refs on %s\n",
+	boutc(cl, "splice_read %p %llx.%llx %llu~%zu got cap refs on %s\n",
 	     inode, ceph_vinop(inode), *ppos, len, ceph_cap_string(got));
 
 	rw_ctx.caps = got;
@@ -2371,12 +2427,13 @@ static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
 	ret = filemap_splice_read(in, ppos, pipe, len, flags);
 	ceph_del_rw_context(fi, &rw_ctx);
 
-	dout("splice_read %p %llx.%llx dropping cap refs on %s = %zd\n",
+	boutc(cl, "splice_read %p %llx.%llx dropping cap refs on %s = %zd\n",
 	     inode, ceph_vinop(inode), ceph_cap_string(got), ret);
 
 	ceph_put_cap_refs(ci, got);
 out_end:
 	ceph_end_io_read(inode);
+	ceph_blog_exit(&__ji);
 	return ret;
 }
 
@@ -2408,16 +2465,25 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	u64 pool_flags;
 	loff_t pos;
 	loff_t limit = max(i_size_read(inode), fsc->max_file_size);
+	struct ceph_journal_info __ji;
 
-	if (ceph_inode_is_shutdown(inode))
+	ceph_blog_enter(fsc, &__ji);
+
+	if (ceph_inode_is_shutdown(inode)) {
+		ceph_blog_exit(&__ji);
 		return -ESTALE;
+	}
 
-	if (ceph_in_snap(inode))
+	if (ceph_in_snap(inode)) {
+		ceph_blog_exit(&__ji);
 		return -EROFS;
+	}
 
 	prealloc_cf = ceph_alloc_cap_flush();
-	if (!prealloc_cf)
+	if (!prealloc_cf) {
+		ceph_blog_exit(&__ji);
 		return -ENOMEM;
+	}
 
 	if ((iocb->ki_flags & (IOCB_DIRECT | IOCB_APPEND)) == IOCB_DIRECT)
 		direct_lock = true;
@@ -2466,7 +2532,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		goto out;
 
-	doutc(cl, "%p %llx.%llx %llu~%zd getting caps. i_size %llu\n",
+	boutc(cl, "%p %llx.%llx %llu~%zd getting caps. i_size %llu\n",
 	      inode, ceph_vinop(inode), pos, count,
 	      i_size_read(inode));
 	if (!(fi->flags & CEPH_F_SYNC) && !direct_lock)
@@ -2532,7 +2598,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	inode_inc_iversion_raw(inode);
 
-	doutc(cl, "%p %llx.%llx %llu~%zd got cap refs on %s\n",
+	boutc(cl, "%p %llx.%llx %llu~%zd got cap refs on %s\n",
 	      inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
 
 	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
@@ -2593,13 +2659,13 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ceph_check_caps(ci, CHECK_CAPS_FLUSH);
 	}
 
-	doutc(cl, "%p %llx.%llx %llu~%u  dropping cap refs on %s\n",
+	boutc(cl, "%p %llx.%llx %llu~%u  dropping cap refs on %s\n",
 	      inode, ceph_vinop(inode), pos, (unsigned)count,
 	      ceph_cap_string(got));
 	ceph_put_cap_refs(ci, got);
 
 	if (written == -EOLDSNAPC) {
-		doutc(cl, "%p %llx.%llx %llu~%u" "got EOLDSNAPC, retrying\n",
+		boutc(cl, "%p %llx.%llx %llu~%u" "got EOLDSNAPC, retrying\n",
 		      inode, ceph_vinop(inode), pos, (unsigned)count);
 		goto retry_snap;
 	}
@@ -2622,6 +2688,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ceph_end_io_write(inode);
 out_unlocked:
 	ceph_free_cap_flush(prealloc_cf);
+	ceph_blog_exit(&__ji);
 	return written ? written : err;
 }
 
@@ -2630,14 +2697,22 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
  */
 static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 {
+	struct inode *inode = file_inode(file);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
+
 	if (whence == SEEK_END || whence == SEEK_DATA || whence == SEEK_HOLE) {
-		struct inode *inode = file_inode(file);
 		int ret;
 
 		ret = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
-		if (ret < 0)
+		if (ret < 0) {
+			ceph_blog_exit(&__ji);
 			return ret;
+		}
 	}
+	ceph_blog_exit(&__ji);
 	return generic_file_llseek(file, offset, whence);
 }
 
@@ -2794,22 +2869,34 @@ static long ceph_fallocate(struct file *file, int mode,
 	int ret = 0;
 	loff_t endoff = 0;
 	loff_t size;
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
-	doutc(cl, "%p %llx.%llx mode %x, offset %llu length %llu\n",
+	boutc(cl, "%p %llx.%llx mode %x, offset %llu length %llu\n",
 	      inode, ceph_vinop(inode), mode, offset, length);
 
-	if (mode != (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
+	if (mode != (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE)) {
+		ceph_blog_exit(&__ji);
 		return -EOPNOTSUPP;
+	}
 
-	if (!S_ISREG(inode->i_mode))
+	if (!S_ISREG(inode->i_mode)) {
+		ceph_blog_exit(&__ji);
 		return -EOPNOTSUPP;
+	}
 
-	if (IS_ENCRYPTED(inode))
+	if (IS_ENCRYPTED(inode)) {
+		ceph_blog_exit(&__ji);
 		return -EOPNOTSUPP;
+	}
 
 	prealloc_cf = ceph_alloc_cap_flush();
-	if (!prealloc_cf)
+	if (!prealloc_cf) {
+		ceph_blog_exit(&__ji);
 		return -ENOMEM;
+	}
 
 	inode_lock(inode);
 
@@ -2859,6 +2946,7 @@ static long ceph_fallocate(struct file *file, int mode,
 unlock:
 	inode_unlock(inode);
 	ceph_free_cap_flush(prealloc_cf);
+	ceph_blog_exit(&__ji);
 	return ret;
 }
 
@@ -2936,7 +3024,7 @@ static int is_file_size_ok(struct inode *src_inode, struct inode *dst_inode,
 	 * inode.
 	 */
 	if (src_off + len > size) {
-		doutc(cl, "Copy beyond EOF (%llu + %zu > %llu)\n", src_off,
+		boutc(cl, "Copy beyond EOF (%llu + %zu > %llu)\n", src_off,
 		      len, size);
 		return -EOPNOTSUPP;
 	}
@@ -3058,7 +3146,7 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
 				pr_notice_client(cl,
 					"OSDs don't support copy-from2; disabling copy offload\n");
 			}
-			doutc(cl, "returned %d\n", ret);
+			boutc(cl, "returned %d\n", ret);
 			if (bytes <= 0)
 				bytes = ret;
 			goto out;
@@ -3097,8 +3185,16 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 
 		if (ceph_fsid_compare(&src_fsc->client->fsid,
 				      &dst_fsc->client->fsid)) {
-			dout("Copying files across clusters: src: %pU dst: %pU\n",
-			     &src_fsc->client->fsid, &dst_fsc->client->fsid);
+			{
+				char src_uuid[40], dst_uuid[40];
+
+				snprintf(src_uuid, sizeof(src_uuid), "%pU",
+					 &src_fsc->client->fsid);
+				snprintf(dst_uuid, sizeof(dst_uuid), "%pU",
+					 &dst_fsc->client->fsid);
+				boutc(cl, "Copying files across clusters: src: %s dst: %s\n",
+				     src_uuid, dst_uuid);
+			}
 			return -EXDEV;
 		}
 	}
@@ -3128,7 +3224,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	    (src_ci->i_layout.stripe_count != 1) ||
 	    (dst_ci->i_layout.stripe_count != 1) ||
 	    (src_ci->i_layout.object_size != dst_ci->i_layout.object_size)) {
-		doutc(cl, "Invalid src/dst files layout\n");
+		boutc(cl, "Invalid src/dst files layout\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -3146,12 +3242,12 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	/* Start by sync'ing the source and destination files */
 	ret = file_write_and_wait_range(src_file, src_off, (src_off + len));
 	if (ret < 0) {
-		doutc(cl, "failed to write src file (%zd)\n", ret);
+		boutc(cl, "failed to write src file (%zd)\n", ret);
 		goto out;
 	}
 	ret = file_write_and_wait_range(dst_file, dst_off, (dst_off + len));
 	if (ret < 0) {
-		doutc(cl, "failed to write dst file (%zd)\n", ret);
+		boutc(cl, "failed to write dst file (%zd)\n", ret);
 		goto out;
 	}
 
@@ -3163,7 +3259,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	err = get_rd_wr_caps(src_file, &src_got,
 			     dst_file, (dst_off + len), &dst_got);
 	if (err < 0) {
-		doutc(cl, "get_rd_wr_caps returned %d\n", err);
+		boutc(cl, "get_rd_wr_caps returned %d\n", err);
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -3178,7 +3274,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 					    dst_off >> PAGE_SHIFT,
 					    (dst_off + len) >> PAGE_SHIFT);
 	if (ret < 0) {
-		doutc(cl, "Failed to invalidate inode pages (%zd)\n",
+		boutc(cl, "Failed to invalidate inode pages (%zd)\n",
 			    ret);
 		ret = 0; /* XXX */
 	}
@@ -3200,7 +3296,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	 * starting at the src_off
 	 */
 	if (src_objoff) {
-		doutc(cl, "Initial partial copy of %u bytes\n", src_objlen);
+		boutc(cl, "Initial partial copy of %u bytes\n", src_objlen);
 
 		/*
 		 * we need to temporarily drop all caps as we'll be calling
@@ -3211,7 +3307,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 					src_objlen);
 		/* Abort on short copies or on error */
 		if (ret < (long)src_objlen) {
-			doutc(cl, "Failed partial copy (%zd)\n", ret);
+			boutc(cl, "Failed partial copy (%zd)\n", ret);
 			goto out;
 		}
 		len -= ret;
@@ -3233,7 +3329,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 			ret = bytes;
 		goto out_caps;
 	}
-	doutc(cl, "Copied %zu bytes out of %zu\n", bytes, len);
+	boutc(cl, "Copied %zu bytes out of %zu\n", bytes, len);
 	len -= bytes;
 	ret += bytes;
 
@@ -3261,13 +3357,13 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	 * there were errors in remote object copies (len >= object_size).
 	 */
 	if (len && (len < src_ci->i_layout.object_size)) {
-		doutc(cl, "Final partial copy of %zu bytes\n", len);
+		boutc(cl, "Final partial copy of %zu bytes\n", len);
 		bytes = splice_file_range(src_file, &src_off, dst_file,
 					  &dst_off, len);
 		if (bytes > 0)
 			ret += bytes;
 		else
-			doutc(cl, "Failed partial copy (%zd)\n", bytes);
+			boutc(cl, "Failed partial copy (%zd)\n", bytes);
 	}
 
 out:
@@ -3280,7 +3376,11 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 				    struct file *dst_file, loff_t dst_off,
 				    size_t len, unsigned int flags)
 {
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(file_inode(src_file));
 	ssize_t ret;
+	struct ceph_journal_info __ji;
+
+	ceph_blog_enter(fsc, &__ji);
 
 	ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
 				     len, flags);
@@ -3288,6 +3388,7 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	if (ret == -EOPNOTSUPP || ret == -EXDEV)
 		ret = splice_copy_file_range(src_file, src_off, dst_file,
 					     dst_off, len);
+	ceph_blog_exit(&__ji);
 	return ret;
 }
 
-- 
2.34.1

