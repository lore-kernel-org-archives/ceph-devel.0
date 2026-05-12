Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882039E9B1
	for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589337; cv=none; b=XRhH4NVsffj6WyK7xfb5Ss0XpKNiQWSIuCUbvxXMRPSn4596M5wWNr9snzzIcOlLckoZGJuy83PJjvbrN+v1XVvjZDdI7OzF+DK0hwFaYitCbb4z1MUUbRGt3A/nxFGODo9CGPDQPgFuJ60h6Z4wQypMASqhKGxnwLP+IznpuTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589337; c=relaxed/simple;
	bh=Ra6U6gVayYC75UIDtEgw+2ZMKy6gd1WCP5YcWQqvOqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4sYU7lFgNMYDqkMkeom0bUqerOs1D9KQCfrAI50J80bHxgA4IbwGRWSWJVih580Q+Ki8jT6TCmY/a2iBx/XIqh7FFZg8O2tf0XDWTfSDRkaXfspmKR17Sm3sdMaSNfFydkjujP10R8WtyYEjv+rIJ/pvcIlOhK6HV0T6JRDBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/AWkD5n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/AWkD5n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778589325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OV31Ucptd7+GGbgBqJ/Bk1eVcVLZSLeP7GQONRl+DJ0=;
	b=Z/AWkD5nBWrnnaSwUpVEDKDOKbP13eydeRCIOKFhOjTWIBqIji2GDixG5vOqSX8ej0dGtw
	5SArF/KIR2/i/q0hYaP7Upghr5yjVgCBShpwQOldeADiIJrGCyw2gLJvJqJRSaOC/M2Ih2
	jJPlmNNLkmQOBA6DAkOR5EcPfyA/3/k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-wJPqa3k-MquIX1UU--azBA-1; Tue,
 12 May 2026 08:35:20 -0400
X-MC-Unique: wJPqa3k-MquIX1UU--azBA-1
X-Mimecast-MFC-AGG-ID: wJPqa3k-MquIX1UU--azBA_1778589318
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8653F195609F;
	Tue, 12 May 2026 12:35:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CF8441800591;
	Tue, 12 May 2026 12:35:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/24] netfs: Fix potential deadlock in write-through mode
Date: Tue, 12 May 2026 13:33:51 +0100
Message-ID: <20260512123404.719402-15-dhowells@redhat.com>
In-Reply-To: <20260512123404.719402-1-dhowells@redhat.com>
References: <20260512123404.719402-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix netfs_advance_writethrough() to always unlock the supplied folio and to
mark it dirty if it isn't yet written to the end.  Unfortunately, it can't
be marked for writeback until the folio is done with as that may cause a
deadlock against mmapped reads and writes.

Even though it has been marked dirty, premature writeback can't occur as
the caller is holding both inode->i_rwsem (which will prevent concurrent
truncation, fallocation, DIO and other writes) and ictx->wb_lock (which
will cause flushing to wait and writeback to skip or wait).

Note that this may be easier to deal with once the queuing of folios is
split from the generation of subrequests.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Closes: https://sashiko.dev/#/patchset/20260427154639.180684-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index b0e9690bb90c..03961622996b 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -414,12 +414,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	if (streamw)
 		netfs_issue_write(wreq, cache);
 
-	/* Flip the page to the writeback state and unlock.  If we're called
-	 * from write-through, then the page has already been put into the wb
-	 * state.
-	 */
-	if (wreq->origin == NETFS_WRITEBACK)
-		folio_start_writeback(folio);
+	folio_start_writeback(folio);
 	folio_unlock(folio);
 
 	if (fgroup == NETFS_FOLIO_COPY_TO_CACHE) {
@@ -647,29 +642,41 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 			       struct folio *folio, size_t copied, bool to_page_end,
 			       struct folio **writethrough_cache)
 {
+	int ret;
+
 	_enter("R=%x ic=%zu ws=%u cp=%zu tp=%u",
 	       wreq->debug_id, wreq->buffer.iter.count, wreq->wsize, copied, to_page_end);
 
-	if (!*writethrough_cache) {
-		if (folio_test_dirty(folio))
-			/* Sigh.  mmap. */
-			folio_clear_dirty_for_io(folio);
+	/* The folio is locked. */
 
+	if (*writethrough_cache != folio) {
+		if (*writethrough_cache) {
+			/* Did the folio get moved? */
+			folio_put(*writethrough_cache);
+			*writethrough_cache = NULL;
+		}
 		/* We can make multiple writes to the folio... */
-		folio_start_writeback(folio);
 		if (wreq->len == 0)
 			trace_netfs_folio(folio, netfs_folio_trace_wthru);
 		else
 			trace_netfs_folio(folio, netfs_folio_trace_wthru_plus);
 		*writethrough_cache = folio;
+		folio_get(folio);
 	}
 
 	wreq->len += copied;
-	if (!to_page_end)
+
+	if (!to_page_end) {
+		folio_mark_dirty(folio);
+		folio_unlock(folio);
 		return 0;
+	}
 
+	ret = netfs_write_folio(wreq, wbc, folio);
+	folio_put(*writethrough_cache);
 	*writethrough_cache = NULL;
-	return netfs_write_folio(wreq, wbc, folio);
+	wreq->submitted = wreq->len;
+	return ret;
 }
 
 /*
@@ -683,8 +690,12 @@ ssize_t netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_c
 
 	_enter("R=%x", wreq->debug_id);
 
-	if (writethrough_cache)
+	if (writethrough_cache) {
+		folio_lock(writethrough_cache);
 		netfs_write_folio(wreq, wbc, writethrough_cache);
+		folio_put(writethrough_cache);
+		wreq->submitted = wreq->len;
+	}
 
 	netfs_end_issue_write(wreq);
 

