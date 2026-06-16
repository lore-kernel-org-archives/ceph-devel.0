Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AAC429810
	for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2026 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604553; cv=none; b=WMUqDEC3HMnTc9xjWmME769Uq5qDkN2J6klw29+7zIYmv0Khs+G2XloyjTGKQoP84CfeQ14Jez71abqvdu/h3ORnC36tET0NzXGYBWM73wLjkqZ/3DEp1qtfD+mP9CW9wjESMvny1IKgl6bBgSES4UrmMok0heUY9RNeckDXv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604553; c=relaxed/simple;
	bh=AgT5FKbi7XMZS+3rhWehSP6ysiNHrsl+8NitUhTTQDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0Xrf6SRN4RC8Tw4zAHcHyzgO2TYTZcXLHvJyAZxwaTxmWqcH2v03YfGCmC0/KCDij9RGCyx9qci41z067cisHr5H0PdfFgGq/Z+9ZDAa5WORRO3H2CBkk+6H87Oh3C9MQKBIJ0Xix4QQhk6t+7d1ey58RBTslkbgRHHgp+CutA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5IZszMi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5IZszMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781604551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMrtitnL/aErCYJ1pJsAB/iWkHhwedFft/Iv1UJKIeg=;
	b=e5IZszMilJZMbdzo1D5zBshdeErFjNkR2lS1umfztFBT76JONjNeJ844/yolEB+HhNJCEK
	W+LzVBGnjSTbAyUTmTVRARC9VcbP2o1GaELn4yiHNOKulcA2TXlDDZalYFsMq9zbIVh/PE
	QfPXShgx+19JDX8NXPDeFGZjGVKBE1k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-Lx9QAI5SNyOJFYk2Q9E_Ag-1; Tue,
 16 Jun 2026 06:09:04 -0400
X-MC-Unique: Lx9QAI5SNyOJFYk2Q9E_Ag-1
X-Mimecast-MFC-AGG-ID: Lx9QAI5SNyOJFYk2Q9E_Ag_1781604542
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDD4B1800597;
	Tue, 16 Jun 2026 10:09:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DF2591954112;
	Tue, 16 Jun 2026 10:08:53 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v4 03/30] iov_iter: Fix potential underflow in iov_iter_extract_xarray_pages()
Date: Tue, 16 Jun 2026 11:07:52 +0100
Message-ID: <20260616100821.2062304-4-dhowells@redhat.com>
In-Reply-To: <20260616100821.2062304-1-dhowells@redhat.com>
References: <20260616100821.2062304-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In iov_iter_extract_xarray_pages(), if no pages are extracted because
there's a hole (or something otherwise unextractable) in the xarray, then
the calculation of maxsize at the end can go wrong if the starting offset
is not zero.

Fix this by setting maxsize to 0 if nr is 0.

Note that in the near future, ITER_XARRAY should be removed.

Fixes: 7d58fe731028 ("iov_iter: Add a function to extract a page list from an iterator")
Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Mike Marshall <hubcap@omnibond.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 lib/iov_iter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af7..dc9c6eb21bdb 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1595,7 +1595,10 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
 	}
 	rcu_read_unlock();
 
-	maxsize = min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
+	if (nr > 0)
+		maxsize = min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
+	else
+		maxsize = 0;
 	iov_iter_advance(i, maxsize);
 	return maxsize;
 }

