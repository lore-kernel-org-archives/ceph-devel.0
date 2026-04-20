Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB223932F2
	for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2026 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674291; cv=none; b=LHOzfrY88YVHdOAduFmWuBIB7o8S33OjYCmfNxyUa5Oq3FSewxvTAwpgN5f7NvAcGnETcsnXWzCpVwPMgRX4PHlhQbbWG9DSc+LP3mLUrvkcpvex80spL4saJ9yzqE5i1fQDwaymc7GAGB9G13Es9oneTk6LoXcvBDTNljzEu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674291; c=relaxed/simple;
	bh=iWEKgr0fPS2LBwyZw/FU46u4D7VN/HA2cp40fXv2VUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWiVdGMFBdZuaO5EatH19EIJ3PaRg7l/G2EiWiLgy3O0baHVhjcQ7RiE/DmSucCcKD3MiF9wUFAFZsaX40gjqT9mx+TF0gUy7UP20K8fUQ80nBQwc3QXCXTTxQG4JZ7Nf32EIhViJcEygwKUf82qoTBNpa4PwrGaZUiXmGeDHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AeWzjOyz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeWzjOyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776674289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73kY/18lwrFclzGx58kIFewTdVs+3oxIn+HO6KCOAHs=;
	b=AeWzjOyzuf0IAFSuwqWkZCFrDWprgBLvoxZ31Gvw77fHMrX8E119nDq+Wpr/anXmqCp3oL
	TYgIxuBpbvGdkY59CnHDMHPyrdfbzh9oAq33ZamcFKwv/7miwR1488UH2nqZmKHEezuudA
	vDaUWFPi9vownif4O5s32r+1e/YuH6w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-rfE_8BV6PwedqQ7uh3JVAw-1; Mon,
 20 Apr 2026 04:38:05 -0400
X-MC-Unique: rfE_8BV6PwedqQ7uh3JVAw-1
X-Mimecast-MFC-AGG-ID: rfE_8BV6PwedqQ7uh3JVAw_1776674284
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 115EA195609F;
	Mon, 20 Apr 2026 08:38:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BDB8195608E;
	Mon, 20 Apr 2026 08:38:00 +0000 (UTC)
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
Subject: [PATCH 10/11] netfs: Fix comment about write-streaming avoidance
Date: Mon, 20 Apr 2026 09:37:01 +0100
Message-ID: <20260420083705.1009074-11-dhowells@redhat.com>
In-Reply-To: <20260420083705.1009074-1-dhowells@redhat.com>
References: <20260420083705.1009074-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In netfs_perform_write(), there used to be a section in which
write-streaming was avoided if either the fd is open O_RDWR or fscaching is
enabled, but the former was removed as netfs_read_folio() can now fill in
the gaps rather then flushing, but the comment was not updated.

Fix the comment to match.

Fixes: eac38f8a2b85 ("netfs: Fix write streaming disablement if fd open O_RDWR")
Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index c840f5448178..2abf451c38f6 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -278,9 +278,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 
 		/* We don't want to do a streaming write on a file that loses
 		 * caching service temporarily because the backing store got
-		 * culled and we don't really want to get a streaming write on
-		 * a file that's open for reading as ->read_folio() then has to
-		 * be able to flush it.
+		 * culled.
 		 */
 		if (netfs_is_cache_enabled(ctx)) {
 			if (finfo) {

