Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30593E0C61
	for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2026 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303827; cv=none; b=omtRAs+339sMfCAeyibqV21Iow8blcodEwSEK8yiaDuO4SkoU4d3aCDbYZq+4GckCO5L7FmhVpEGwa/dk8JnahNQv2sDnk/wWKeAtiUo/0wuavpYuD5kKdbH3orrzdU4+tDVLUeJq/cJdmKscPYTcZepiBKcssfjoydILHvjjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303827; c=relaxed/simple;
	bh=4vDqPI8DVk4MKXgzTTYnAtb5Hin/PlJJp6BgfgK/hjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OY/MqR948qU24ybsm3OPmwAlJPAPXM0nxmuk0JRVGlA15EzxfuKunoQmV12JQqv4hoD6ua3WaFWpHZgKgKhzghuiSIiFqhxPxjrPsGA4FGr5gFxUqR5iJ26jkg3KfL8wAOoe2SugEfsKggsQAih2O91uEQjNSk4nPVHsduGR+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRNxoZKC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRNxoZKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777303824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1+6dfsU9EA3zra9BmDxqCEbg56ER/RAJitXxHpONYg=;
	b=QRNxoZKCBwSawJJBLY5aA8+8j5du8kAJFeuQCETj3KKbO/vqZmG2xhO/lcCrJFevaTIRKC
	E36s1xK0glH8BVJah7uFq2vk+qX53KoiEN3VbPoQHZdFyKKe6jnb3T8yCppEJpjApWMvxX
	yd835lXXI6gLNJ/Vjcn0saRL2sVp/N0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-VGEojMTeMDqJ30AqFPnqOg-1; Mon,
 27 Apr 2026 11:30:22 -0400
X-MC-Unique: VGEojMTeMDqJ30AqFPnqOg-1
X-Mimecast-MFC-AGG-ID: VGEojMTeMDqJ30AqFPnqOg_1777303820
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F9AE1956059;
	Mon, 27 Apr 2026 15:30:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.126])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42C191800664;
	Mon, 27 Apr 2026 15:30:17 +0000 (UTC)
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
Subject: [PATCH v4 04/22] netfs: Fix netfs_read_to_pagecache() to pause on subreq failure
Date: Mon, 27 Apr 2026 16:29:31 +0100
Message-ID: <20260427152953.180038-5-dhowells@redhat.com>
In-Reply-To: <20260427152953.180038-1-dhowells@redhat.com>
References: <20260427152953.180038-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix netfs_read_to_pagecache() so that it pauses the generation of new
subrequests if an already-issued subrequest fails.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://sashiko.dev/#/patchset/20260425125426.3855807-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 3bc7d0c5c3b9..9c7a2f984be9 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -304,6 +304,11 @@ static void netfs_read_to_pagecache(struct netfs_io_request *rreq,
 		}
 
 		netfs_issue_read(rreq, subreq);
+
+		if (test_bit(NETFS_RREQ_PAUSE, &rreq->flags))
+			netfs_wait_for_paused_read(rreq);
+		if (test_bit(NETFS_RREQ_FAILED, &rreq->flags))
+			break;
 		cond_resched();
 	} while (size > 0);
 

