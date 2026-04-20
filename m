Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5C38C401
	for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2026 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674254; cv=none; b=dRsy961vtOPdIlOowvaQY4ArGszIQ4nAxGosHQ8U7t4l55+AOT1s/humx/JsJ/ErgfNknBtcgW4pR27Ya+W1jRcxwOr0Sp2O2oM3t3AsnGtxVD39BU0dBHHt+JYLCjXo8Tm4o2zELJ2ToPBJi4afJZjwreXJ+yV2xi6ylrPFMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674254; c=relaxed/simple;
	bh=rNCuGEe+cUkbJVv0l2fZwrYWlgVSaWB6ya+QriIWRmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvXhi+/NEkI5fT+HTYfZHznpcmD8tAFNqt5hgddO/0NglYEV7VsQqmUBPpkBsOXCvoPlI+zsigliLBoMiTjxY4ZkyjRWGZ5f7D06ALI8Wg2z60V6zIOKmhES7AuADvRShNWM6Rar4GUltILzVOxcuHvm4gZ6lYowTxPo+NB7QuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjqUElnd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjqUElnd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776674252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYjLbr3bROmxtkNCAMr+RVTMxNJEUY0LOnKnAfK28Pw=;
	b=CjqUElndoLEL3y4XPsJVNKOqOiHFIuCpmzLxcWy53va6gHoM9Bb879yUZA2K7UFGrwUCaL
	AR4039SARiKCp7QUA3vhV5Xm3TFC47lEK4BlQcmNHutir6jEKFL/PMEDBcTBLTdGNxq7Be
	LUUWNxmxqV8rzoQm8LAOgvHRU1iZTLc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-v2fYY0HbOlOf4XvvOzKBmg-1; Mon,
 20 Apr 2026 04:37:27 -0400
X-MC-Unique: v2fYY0HbOlOf4XvvOzKBmg-1
X-Mimecast-MFC-AGG-ID: v2fYY0HbOlOf4XvvOzKBmg_1776674245
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBBC4180034D;
	Mon, 20 Apr 2026 08:37:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4C5973000C15;
	Mon, 20 Apr 2026 08:37:20 +0000 (UTC)
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
Subject: [PATCH 02/11] netfs: Fix leak of request in netfs_write_begin() error handling
Date: Mon, 20 Apr 2026 09:36:53 +0100
Message-ID: <20260420083705.1009074-3-dhowells@redhat.com>
In-Reply-To: <20260420083705.1009074-1-dhowells@redhat.com>
References: <20260420083705.1009074-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix netfs_write_begin() to not leak our ref on the request in the event
that we get an error from netfs_wait_for_read().

Fixes: 4090b31422a6 ("netfs: Add a function to consolidate beginning a read")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index dc50690fdd44..51caad535438 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -688,7 +688,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	netfs_read_to_pagecache(rreq, NULL);
 	ret = netfs_wait_for_read(rreq);
 	if (ret < 0)
-		goto error;
+		goto error_put;
 	netfs_put_request(rreq, netfs_rreq_trace_put_return);
 
 have_folio:

