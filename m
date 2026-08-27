Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC743BDD5
	for <ceph-devel@vger.kernel.org>; Thu, 27 Aug 2026 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823555; cv=none; b=NxHxrCU+o3iXrS3lUGRSl0RYemNS4XhdsYzZR7vmD1JS5IcIg4viSezfLd05cOukVCf1EHn/dOmwV+9TnCCSfSZYlz1s97P4LRkGVDca9fzlsMSAjha9c4DvjeINk627vO/aKmIzoh6qqUV6L2DE6Nc+wShRDNP33qeqrs5H1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823555; c=relaxed/simple;
	bh=QrdzqNcCR9iFFgQpRU6lHGZ+NgG7PoA+HmJTAzSrA4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTaKcbZbtc9Fm+yfFTjZDBuLRzL0PywSRqJwuq4MPc5rGl97quGJrWxmiwL19e93BaR8mQyPBWd76/VltfcBV3//YgH0VdY9BQoETz+5XSUDcwM5799E+mVhHyC7XWY27O/5IMPF1xa8mqKGSig516K2psywamHy19dWmC7kdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBOjZ9+P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBOjZ9+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787823547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2pt6wnBqtVDYBV6sOHnn+X/jyNpYuj5XG1JqmENcwc=;
	b=TBOjZ9+P4cmUSyInWEC1YpAFyeOCZeVAQXrb7WPb/U0bUPlbaaftzOI5cmZtHZJEx0g4hN
	vJsLsOiaG31wt7Kwvw5ED9gOSVYiQswauMk0Lttoll2NTaetN0OFHKEAYwmfzKNibz7TWA
	vkDDo/3dElnNCB3stIX3jtooMKyNXkg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-xH7X4unkNRGmDx4XinbiRA-1; Thu,
 27 Aug 2026 05:39:06 -0400
X-MC-Unique: xH7X4unkNRGmDx4XinbiRA-1
X-Mimecast-MFC-AGG-ID: xH7X4unkNRGmDx4XinbiRA_1787823544
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 687961800C36;
	Thu, 27 Aug 2026 09:39:04 +0000 (UTC)
Received: from warthog.com (unknown [10.22.88.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BE97180059E;
	Thu, 27 Aug 2026 09:39:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+6a13fc77eb6f0802be2d@syzkaller.appspotmail.com
Subject: [PATCH v3 06/10] netfs: break unbuffered write when netfs_alloc_subrequest() fails
Date: Thu, 27 Aug 2026 10:38:21 +0100
Message-ID: <20260827093828.1956211-7-dhowells@redhat.com>
In-Reply-To: <20260827093828.1956211-1-dhowells@redhat.com>
References: <20260827093828.1956211-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Edward Adam Davis <eadavis@qq.com>

syzbot reported a null-ptr-deref below [1] following a fault injection in
netfs_alloc_subrequest(). [0]

When netfs_alloc_subrequest() fails, subreq is NULL.
Later, netfs_prepare_write() tries to initialize members of
subreq(e.g., source), the issue in [1] is triggered.

Let's handle the error of netfs_prepare_write() properly.

[0]
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
Call Trace:
 netfs_alloc_subrequest+0x116/0x3f0
 netfs_prepare_write+0x76/0x7b0
 netfs_unbuffered_write+0x75c/0x2020
 netfs_unbuffered_write_iter_locked+0x7d6/0xa80
 netfs_unbuffered_write_iter+0x442/0x720
 v9fs_file_write_iter+0xbf/0x100
 vfs_write+0x6ac/0x1050

[1]
KASAN: null-ptr-deref in range [0x00000000000000a8-0x00000000000000af]
RIP: 0010:netfs_prepare_write+0xbc/0x7b0 fs/netfs/write_issue.c:173
Call Trace:
 netfs_unbuffered_write+0x75c/0x2020 fs/netfs/direct_write.c:111
 netfs_unbuffered_write_iter_locked+0x7d6/0xa80 fs/netfs/direct_write.c:290
 netfs_unbuffered_write_iter+0x442/0x720 fs/netfs/direct_write.c:382
 v9fs_file_write_iter+0xbf/0x100 fs/9p/vfs_file.c:409
 new_sync_write fs/read_write.c:595 [inline]

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Reported-by: syzbot+6a13fc77eb6f0802be2d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6a13fc77eb6f0802be2d
Tested-by: syzbot+6a13fc77eb6f0802be2d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/netfs/direct_write.c | 5 +++++
 fs/netfs/write_issue.c  | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index fbcfadb232ee..2361277416c7 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -110,6 +110,11 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 		if (!subreq) {
 			netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred);
 			subreq = stream->construct;
+			if (!subreq) {
+				wreq->error = -ENOMEM;
+				ret = -ENOMEM;
+				break;
+			}
 			stream->construct = NULL;
 		}
 
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 2d9cfcd43658..851f6f93ad45 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -170,6 +170,8 @@ void netfs_prepare_write(struct netfs_io_request *wreq,
 		rolling_buffer_make_space(&wreq->buffer, wreq->gfp);
 
 	subreq = netfs_alloc_subrequest(wreq);
+	if (!subreq)
+		return;
 	subreq->source		= stream->source;
 	subreq->start		= start;
 	subreq->stream_nr	= stream->stream_nr;

