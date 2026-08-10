Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC933F39CB
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371697; cv=none; b=rACU7JDrDsaAeu0ywkH2a8dI7EciBiUa0Fn5JvpwvVcefiu4YtvQ9qTGGrzYuWe3XVJec6XUwdLy/YVh0NtNwqVm/ef1p+J8Qew95P8TthGlUSQScPloyaLtca8oIK0aKvfZi+8YZMYEtS1h1Mby8bTTMTJHcr7K8h+F6vs9lXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371697; c=relaxed/simple;
	bh=l3uEHuwNVk6EU1qiSYF/Q0V/FDAY448POx4+1dXVCT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtyQf6PJRc+uA0xFVKPfJ+xStHZPz8O/KzIdd2anGJbl4RPUpT8ebEKoOVFQ/WYFirHdt0o0bA97JWjlOd05aWfQioaeZq9vuJySmFftDGUX6XJfw+Ge47vhL7bzerrtb8j5UjLeSjqu//h6XT1B+QhyB83WRc5dNbOqqj56VPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=seVJQEGw; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="seVJQEGw"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACbOnu3845147
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=jW8u
	Io9mq1l2z2LJqV2kSeHNoorVMZ6STN4QBox7XYc=; b=seVJQEGw48BgY3Nu9Psy
	tQQuCjl+9yc5O8F27BW5VVwDRtmwyNqign08Gujtt587mOgRMxa+TxRCOuvFzAnX
	fACFqvlqUg77CEbTfrcUVjEnc8Y6hvJN7VIXP8gLteGpb9S/s/KI6CFbScKO5rjC
	G/x5IJZj9UQ5RaWoqT5+Lj4qgWKKgWh7//KaugA9v8ccpAW0gYdtFe43jwh35TJE
	jALRLyOj+M3yxht9j6PmS2DQzBA+7MAFLMhpgJ3ygC+kWWkUbT1UQsbLUfrnXY41
	7rvVKVvDB2euC0f1HgOUVS4OClT7f7vdAbYXTfWHd2TpVuOZokMPmw9pNqHblRnh
	1g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fxyb9bksr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:13 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c20762d21so25721361cf.0
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371673; x=1786976473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jW8uIo9mq1l2z2LJqV2kSeHNoorVMZ6STN4QBox7XYc=;
        b=A29Ydsv1AqvtFeG1Z08FmeSwN6Bj1K42YFz64VZo8UFAENmCi2zoLHz+MosjCNbhFk
         vtUIO1vJkIbGESQom4xPP0QETADR9vS20Fit/jzhF9TRHg1yFMDgwHIMJ1z4bMw8AbSh
         Ml/CTOZNrpFtnuNsi+2UTxe9zfDeXcJoJK1rQKTqsKOJQPH0x/Ji4HzD4YOlc7yvc7ND
         JunZFE6mcHEtxxId16MI8QPDF9tALR+iUQ3my7VW3JLXQYiQs4NNQUYEHLRCR/lrVE/a
         p2RzwRcLYuCXzzIYAYhgyhM98AXil81YhCGyme53nkuYYj/b4CXI7ECSugZs/tTJ2Aag
         rz3g==
X-Gm-Message-State: AOJu0YzBNBtM/+P7Tk4UACNYVUC72Sz7dR1/ZtzkTGswH5tlKehUoSp9
	pGn5w98eFNwZZzeC3GvVrFbjymqfNjMLvGq46RJnKgIEfr3qIOuSP0m8wRZhQ5Bqs6P2Wjyyr6A
	fXCqvWQuI58KkcZULt9QEVdXQbwC+a3dWRht23rbPeB+Bzr0duFvlx7/8jnA=
X-Gm-Gg: AR+sD12JYn058x5GgJwI/GlzokzbX3yt7v1JIL4sOAbn9+8YK3+Dh7ZUcy0WAdPZZkF
	g/m7EJ15Z5EuwsWsYsdDfQAlJ5fdN7xmkW1M5iJljQJZnVolYEXQWpjGdb91Rcsps2Fc/juUVJs
	4DyqO1jHhc1vJL1XfcCC5kh/Nz99uA/AayCUe7vVM/j1WD7vRw3P0X+gRW8R6gju7nmqMjo5G8D
	bo8Tw7oabW+gTzAhB0ftDyUhldQlH9+Y4PR+ns15sxmGp2WEotGsGguHkysuMoCMalMFbR5FFbu
	Y5qaZ5bkOUcKrJp4aoufOvb+IHBueGSOSF7oTjpE8OWIQhd0RKPo4nlJ/A4hKzlSFUz9eIeYvja
	R/WOvs853
X-Received: by 2002:a05:622a:581a:b0:51b:fe7a:4eb8 with SMTP id d75a77b69052e-52d1918e143mr244244931cf.35.1786371672719;
        Mon, 10 Aug 2026 07:21:12 -0700 (PDT)
X-Received: by 2002:a05:622a:581a:b0:51b:fe7a:4eb8 with SMTP id d75a77b69052e-52d1918e143mr244243051cf.35.1786371672052;
        Mon, 10 Aug 2026 07:21:12 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:11 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:15 -0400
Subject: [PATCH v3 04/12] ceph: convert
 ceph_wait_until_current_writes_complete() to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-4-dd7531704f26@columbia.edu>
References: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
In-Reply-To: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=1518;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=l3uEHuwNVk6EU1qiSYF/Q0V/FDAY448POx4+1dXVCT4=;
 b=MN0UzA0s4wH6d3PLNpiFNlpzeBQU1Ayj1yl+dxXmrHHGmwf6FOlt2/PLR9CC+k7hpkkVwBz/A
 zWPq6NK5C5PDacjs4Oon93gHT3vjCh1ok9uHfjQLVsS+prVu7VChuak
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=QKxYgALL c=1 sm=1 tr=0 ts=6a79de59 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=JfrnYn6hAAAA:8 a=oBeIbaJldBQvbLH65vwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: B9HbwsxK_LzS2TGy4KdWFIib5uKMY9jd
X-Proofpoint-ORIG-GUID: B9HbwsxK_LzS2TGy4KdWFIib5uKMY9jd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXy0YnP5DpYS+6
 vloMJeapQCQvtUj7vjJ2Mi3T40LLhHNSqhYi5nZW05OeOEFc/rLKQ4hxnnO0GEdKTg+aKMb3Akl
 m1N0R6IVuHsQDcCvMEcOuYQgWYrtCj5ZvhdnorxF6YTLOLL9U7FVlQNMBZyUFRlrxkMr6ho7NYS
 lAxR2VFQWLZP1CtrBAwIE7OpTm3xQJWMuihkDLN/FLC022MSWEWb5ecp6jSsTr39Bsd5J9/LBm6
 c93zZkuwuOX/ZMgBvcpMbentgvgy6eN0UOGI7PzZzJStF610EToc/khsYO3/MRPprLvVStjL7IN
 e157M5JMP84JXBkF1VuAh8MmCVlay4q3yXl1OMlfGY6CdqRoT6JD5LmwookD6YqipZRscOSR7HO
 VAxSV9ex4y8klyfjHzR/wWsOHdJlDkCWBl4FoXtEDcFjHRAx/yojZRSRjtXj+sG4dR2wZq7q+YF
 Zj4o+EwSHgZhdAXu/ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX11e55pFmxzzQ
 036sNX6sdA9azb/x2T+CzqlyWTff4zRDIdqcVwkvnAYbZBocuiN1cYE7O4kJZi6s928GhUe+6DC
 ty+psAvOE+MmbfCRwWXvpoNovKqZ8mItBEGRTO0U/8NTD3EbaYQL
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=10
 clxscore=1015 impostorscore=10 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

Iterate the writeback batch as folios rather than using
&folios[i]->page. Use ceph_folio_snap_context() for the snap context
check and folio_wait_writeback() instead of wait_on_page_writeback().

This removes one call to compound_head() and the last caller of
wait_on_page_writeback(). No functional change.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3d86e4c85b06..c08fc70321e6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1637,7 +1637,7 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
 					     struct writeback_control *wbc,
 					     struct ceph_writeback_ctl *ceph_wbc)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned i, nr;
 
 	if (wbc->sync_mode != WB_SYNC_NONE &&
@@ -1652,10 +1652,10 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
 						     PAGECACHE_TAG_WRITEBACK,
 						     &ceph_wbc->fbatch))) {
 			for (i = 0; i < nr; i++) {
-				page = &ceph_wbc->fbatch.folios[i]->page;
-				if (page_snap_context(page) != ceph_wbc->snapc)
+				folio = ceph_wbc->fbatch.folios[i];
+				if (ceph_folio_snap_context(folio) != ceph_wbc->snapc)
 					continue;
-				wait_on_page_writeback(page);
+				folio_wait_writeback(folio);
 			}
 
 			folio_batch_release(&ceph_wbc->fbatch);

-- 
2.39.5

