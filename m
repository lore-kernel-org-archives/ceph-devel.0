Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574303B3C14
	for <ceph-devel@vger.kernel.org>; Wed,  4 Mar 2026 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633059; cv=none; b=PUzrz/wRDU0dU64sVhjK2VqW4Qw8QWxzuJlqLvb10jICnavfdlPfJPi13vWYX6rhxnFp9BOdRtCSiff6e+hNv0Oh8Emf9pC/iHne8LYz/yrGIUlawGhHDb+StwEEA/7bs0jv6PYyDrgIxWEVftj7JCyoeqa4IiwiHeofnRuCkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633059; c=relaxed/simple;
	bh=VtHJ4dOX/PjPH5MYXwwUtFXjGjFdBrAXw9pfIcuXNAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJxjZKCzd8aZaPJbvMiHvHk1o+IwbP/wTHqmLkiYSbidm0xWGUH0WvzJde0l4r4A6kNvHsTdXUmsDpyvytl4XkyxRHwHIsXue/T+xQbGSIulBaiQmBMbO8k17oQRI0hQtj89A7pslWxES3kMJWLy5eFBBLZUdBu5skXUJizn7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=huoc7lbB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huoc7lbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772633057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0pc7secQPVFTQku/CWBUaEkOfxce2fVEUol8rfqZhc=;
	b=huoc7lbBRyOPENywJIjJmgshCw2XF+YRfhwERqbWXUOrfyVLEoS+8JnDk3msyEbRxnL3MP
	cjjUwhQUHSJ1zXAuHNqDwp3VF0FoTADXbWxfjaxYiBTGqnfOACOqueGJ1ayHj49S+alXxi
	SXV0smGM69S3Lf+fpNpt5oJp+lOO5YM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-P3PFo_NDPhW6M-Jve7q69Q-1; Wed,
 04 Mar 2026 09:04:10 -0500
X-MC-Unique: P3PFo_NDPhW6M-Jve7q69Q-1
X-Mimecast-MFC-AGG-ID: P3PFo_NDPhW6M-Jve7q69Q_1772633048
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38584180061F;
	Wed,  4 Mar 2026 14:04:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.194])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 105D8195608E;
	Wed,  4 Mar 2026 14:04:02 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>,
	linux-block@vger.kernel.org
Subject: [RFC PATCH 04/17] Add a function to kmap one page of a multipage bio_vec
Date: Wed,  4 Mar 2026 14:03:11 +0000
Message-ID: <20260304140328.112636-5-dhowells@redhat.com>
In-Reply-To: <20260304140328.112636-1-dhowells@redhat.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a function to kmap one page of a multipage bio_vec by offset (which is
added to the offset in the bio_vec internally).  The caller is responsible
for calculating how much of the page is then available.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/bvec.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index d3c897270d40..01292021f51e 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -308,6 +308,27 @@ static inline phys_addr_t bvec_phys(const struct bio_vec *bvec)
 	return page_to_phys(bvec->bv_page) + bvec->bv_offset;
 }
 
+/**
+ * kmap_local_bvec - Map part of a bvec into the kernel virtual address space
+ * @bvec: bvec to map
+ * @offset: Offset into bvec
+ *
+ * Map the page containing the byte at @offset into the kernel virtual address
+ * space.  The caller is responsible for making sure this doesn't overrun.
+ *
+ * Call kunmap_local on the returned address to unmap.
+ */
+static inline void *kmap_local_bvec(struct bio_vec *bvec, size_t offset)
+{
+#ifdef CONFIG_HIGHMEM
+	offset += bvec->bv_offset;
+
+	return kmap_local_page(bvec->bv_page + offset / PAGE_SIZE) + offset % PAGE_SIZE;
+#else
+	return bvec_virt(bvec) + offset;
+#endif
+}
+
 /*
  * Segmented bio_vec queue.
  *

