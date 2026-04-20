Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8C389472
	for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2026 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674281; cv=none; b=MqeQ35J9np/538CjghtjpERuRR4GimUncQMbOYVYoCQh9M5T3Zt09f0U6+zYUt5cEu748wl3WBqxgDMGe3BQ7gzwmLw5qr6nm/04tZrRE1822zTVTMqZ6OxQn5dXB8ZpbDkVqniuZn8ZW2NxM1bjHK9/c4TQmIe5eAMVnEMsecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674281; c=relaxed/simple;
	bh=GGDFb5ISDq+aR8ATjSzxtl5omBuaGFifLzzJCHqEBkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VP77kL6kuiuq3S5whdmKlYQjEUWZ8aYkC77+tGYexqzZwBb3HlzFefuu8HwKZhv+O+qb4a7ppWaDDqLH00qcayxIc3LGyxTC8nHeVe4VottRb/4EJgsxe5EfOKDKDoso9fOMCosIm2nxMTxwxjC/NE7ilTQZVfKgOOZ72HQlEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h86SMyOQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h86SMyOQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776674279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OThphTeJ4h2mrXd17LwJkpBdeaA+i2LzOzBKWtPenbI=;
	b=h86SMyOQXboDEAqaggqxx69A1R7Dh+FA8hM/62mVoUkwA5XvPm/xT4dIxu6LV93hz0r7SN
	c3F6nNlbbReO9bl0ZGSWBtwXo/HKPn4N7VxDC4JfSzIBmDVWX0sck2JeBKSYcfS95YuFZ5
	F/JAcrCzbgSsfbCAjpknr47MM4lfsw0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-sRAaOMn4OZqrasR8f5rHrA-1; Mon,
 20 Apr 2026 04:37:56 -0400
X-MC-Unique: sRAaOMn4OZqrasR8f5rHrA-1
X-Mimecast-MFC-AGG-ID: sRAaOMn4OZqrasR8f5rHrA_1776674274
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8668C1955F0E;
	Mon, 20 Apr 2026 08:37:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BC801800660;
	Mon, 20 Apr 2026 08:37:51 +0000 (UTC)
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
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 08/11] netfs: Fix group handling in netfs_read_gaps()
Date: Mon, 20 Apr 2026 09:36:59 +0100
Message-ID: <20260420083705.1009074-9-dhowells@redhat.com>
In-Reply-To: <20260420083705.1009074-1-dhowells@redhat.com>
References: <20260420083705.1009074-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix netfs_read_gaps() to not discard the group information from the
netfs_folio struct after successfully reading the gaps.  This is still
needed to write back the dirty data.

Fixes: d259cfb7dd32 ("netfs: Fix read-gaps to remove netfs_folio from filled folio")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index b4d271538f75..98bfec0af0e1 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -461,8 +461,10 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 
 	ret = netfs_wait_for_read(rreq);
 	if (ret >= 0) {
-		folio_detach_private(folio);
-		netfs_put_group(group);
+		if (group)
+			folio_change_private(folio, group);
+		else
+			folio_detach_private(folio);
 		kfree(finfo);
 		trace_netfs_folio(folio, netfs_folio_trace_filled_gaps);
 		flush_dcache_folio(folio);

