Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429064;
	b=nsVy+1ry1i+gfpmnEIev+Hr7d7cSBYTE0OiJw7DiXn/L5H0G6sx4qPTecyGRPk9HFkIO
	 qMeCQMj1IuBYN1LifDS9T2C393WSx2R43MZTkzOjJztXAme2gFHdmBqF/R9IX9a09+BHc
	 2XwKigJvObQMTEHOVGSsUXpMEZ6UrHWHfAmI1f+KwHvOpdFFn5z7uPqnMpN+FHXpEu1a6
	 sb+BDdCOgGr6VcMInQMwjaGpobrT4vl1V2O0dV9Vbp59ONSrxt2jWhAEUZzrkEMA6O04m
	 V2Kf1s5myM5w56m/g+/WsOytH79sm3K3DMiH14pgqbCQGm2O+7+CnZ5bi1PZbW4gsMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429064;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=PhNajVV4YOAVa6HzjBax5Vzcm0CeXg6v0Uflf51EUrc=;
	b=3QbGcKGikHRa8Mg3Gk1WbPFjxXa/jGQsGKJaWpIIuXYJ7EMqX3GlZ33I6elxOLOGGi81
	 kUK3mGBzLyQUmxg8Ew4rmD0bNHtW65JSvl/mY+9Z1hLAXjtBv/Qwo0hjYW6UuG4vRTNUV
	 PrG+M05S8ICTLy+AR0XgYnIE7CJneDUjGbwOwxK380pfZjEjXsEOFO4H9OqR1IJ3fLpHJ
	 kcBROAbQkVTSOOAbTGjmbplRAxYz7wpuKDdg/tINFWrjX2VPt1OP5BIiA41bnsPaOqJRz
	 VrnndlXW3iQYemLuBDMZanMp5ygdXiEnVoVU517zP883knLQ+TmSOUK6I60lXsQM/Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V50qKkdE;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED10606A33F
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 20:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ED10606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V50qKkdE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794429062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhNajVV4YOAVa6HzjBax5Vzcm0CeXg6v0Uflf51EUrc=;
	b=V50qKkdEutiCq2aCVnZSbO22l6afxQRufmwEPACd/ARFTUQE4QdZ5V2mFGyNjb60xTbYH3
	3pHopsxs9BUI/Uk0lC5TuAnSdIg83GCBfiWEyy6wVAN+WX2DMebJd5OhbD5v2xLJg04tMJ
	y1PYKWElbKuyt9N3cLpsLhmx9WTuSjA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-hydzC3_6OiinoPNewJCP9g-1; Wed,
 11 Nov 2026 15:30:59 -0500
X-MC-Unique: hydzC3_6OiinoPNewJCP9g-1
X-Mimecast-MFC-AGG-ID: hydzC3_6OiinoPNewJCP9g_1794429056
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F21C18002E6;
	Wed, 11 Nov 2026 20:30:55 +0000 (UTC)
Received: from dhowells-thinkpadp1gen8.rmtgb.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E133A30000D3;
	Wed, 11 Nov 2026 20:30:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org
Subject: [PATCH v17 02/17] Add a function to kmap one page of a multipage bio_vec
Date: Wed, 11 Nov 2026 20:30:15 +0000
Message-ID: <20261111203034.2126314-3-dhowells@redhat.com>
In-Reply-To: <20261111203034.2126314-1-dhowells@redhat.com>
References: <20261111203034.2126314-1-dhowells@redhat.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add a function to kmap one page of a multipage bio_vec by offset (which is
added to the offset in the bio_vec internally).  The caller is responsible
for calculating how much of the page is then available.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@infradead.org>
cc: linux-block@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/linux/bvec.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index b63914ff56e3..7ea62643cfb7 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -344,4 +344,22 @@ static inline phys_addr_t bvec_phys(const struct bio_vec *bvec)
 	return page_to_phys(bvec->bv_page) + bvec->bv_offset;
 }
 
+/**
+ * bvec_kmap_partial - Map part of a bvec into the kernel virtual address space
+ * @bvec: bvec to map
+ * @offset: Offset into bvec
+ *
+ * Map the page containing the byte at @offset into the kernel virtual address
+ * space.  The caller is responsible for making sure this doesn't overrun.
+ *
+ * Call kunmap_local on the returned address to unmap.
+ */
+static inline void *bvec_kmap_partial(const struct bio_vec *bvec, size_t offset)
+{
+	offset += bvec->bv_offset;
+
+	return kmap_local_page(bvec->bv_page + (offset >> PAGE_SHIFT)) +
+		(offset & ~PAGE_MASK);
+}
+
 #endif /* __LINUX_BVEC_H */

