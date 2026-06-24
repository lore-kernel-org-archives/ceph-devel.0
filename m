Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E2351C28
	for <ceph-devel@vger.kernel.org>; Wed, 24 Jun 2026 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302323; cv=none; b=BlNNml05eNpHI1B5yCAuPTCfRF53Djwl31lrn/IpVyBzUVP0/Y2ub7vb4qzta6HpPqgCg4r5rMwHSmvynm7aoKdQ/U5KzsI3I4Zs83J5+38oPG5liQmtrA/e4fC1LpAdGWDE5eUkuUJqXbKDWgt7Melwwz1FGD8aVhvrV37jcJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302323; c=relaxed/simple;
	bh=ZTP7q8W8ggimp4fkS8Bp4m2KMaDOWPpUQdn/EzPXwAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+QsEz7hboMC0NjCdHqfpUoxqndaqhXScSK7YxnMzUzsos1j441P25XPdX3HUGJ8+8oHICINTKgNelwl/TbD6hkunhIofuiTJh+R2xBWxKRNmtDxCMgqAP774vubZ4uv7AmsCOmS2czYLpca0wtFsHZlIlqDw08LF338XUF8aF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCUIWgtU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCUIWgtU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782302321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lg3QobSmdRBdCansQlMNMTSeQxNIKRIjET+hDWCLJE0=;
	b=VCUIWgtU7Kk3HZFiAw5wFjs8crN/eAr7AT5TbN5/2mViSXA30A5ecpKdK1TUl123xI+rl5
	gtERFp8/coCQTL67dX78n3MdYHiJcwq4LlID9UMdETz9cv3VWYaUZMFJfPBcv9rpDlXfPr
	OxVY/aXLmZMDhZ5MAuWvxWeVYxHGNGc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-78NlhmLUNHShabjhWdEM3g-1; Wed,
 24 Jun 2026 07:58:36 -0400
X-MC-Unique: 78NlhmLUNHShabjhWdEM3g-1
X-Mimecast-MFC-AGG-ID: 78NlhmLUNHShabjhWdEM3g_1782302314
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E75D19540C0;
	Wed, 24 Jun 2026 11:58:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DEC81774;
	Wed, 24 Jun 2026 11:58:31 +0000 (UTC)
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
Subject: [PATCH v2 09/14] netfs: Fix kdoc warning
Date: Wed, 24 Jun 2026 12:57:30 +0100
Message-ID: <20260624115737.2964520-10-dhowells@redhat.com>
In-Reply-To: <20260624115737.2964520-1-dhowells@redhat.com>
References: <20260624115737.2964520-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Fix a kdoc warning due to a misnamed parameter in the description.

Reported-by: Matthew Wilcox <willy@infradead.org>
cc: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/netfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 243c0f737938..bdc270e84b30 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -753,7 +753,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 
 /**
  * netfs_resize_file - Note that a file got resized
- * @ctx: The netfs inode being resized
+ * @ictx: The netfs inode being resized
  * @new_i_size: The new file size
  * @changed_on_server: The change was applied to the server
  *

