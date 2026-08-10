Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7B3F9F55
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371675; cv=none; b=LN7d2XDx0kde4mJ8n/aO/HK/3dv4l5qCSIU6wcA28ABRVGY8Qwo1ZKk9zSkJqCxZ7cs4PnhuUA9Xy3+w3PkBUiyDIkOeRzN6B+Xy2hcBguMv0LEA0+KQfyhu8MwnmTNCkYTe0MS+oMCHUk//uQcjbFA9/SoYsNBdo9mjo+Q7qug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371675; c=relaxed/simple;
	bh=T3CGmDuDwGWM9IS8v9V4tooVVC5cHChgIoIPoiiGhmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HghN7yd1GzYL35WWXfWIidFHpthtYar6xGWYbQA+OofRN8wk1z5dpLQ9acuC7S7nYlTYhSncGLYwUVpeAbWOgpVOwvRpiCsm4dcScoXWABRQeuUnDOPkokulOyZJ0OEqKuknYUHyRPTDiUiIfqPHKC6TAMqQOsE5qlkSBtR4Df8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Kgm6IU07; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Kgm6IU07"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACaJNE2763050
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=jKaq
	F4zxypYK+u31Iqe1KTFnP3GkPLOPF1h4Nf9JG/o=; b=Kgm6IU07c9cwPQpIn9YU
	Wqd+HpT0HKSjRsewAjcWShVXlp+t35l+DMKQJxI00adjnj3L/ctmd2sKoeHyzAT/
	ocGG07cRJ1hxBCGQbg+bMSN/ARy6SsW2Py2u0YOFU65dziZP40D9ZrYwxXZ5+QXR
	DwM5c/v6xaPVsouqGr8j5VgFgaY74zUCXRzGVZwjicIk6i/FtNHM4fGDUz+W2YyL
	9dS7+2IcDqzBfT9wh3m65P3Z6hyXK8dBiay05mOHAE3dsRbxlRXsCcQfngduatJh
	N681bo6ikKOC7VVOJsVqA5B0ytkZd0snkxrYATBCyv/410LsDne1mu8aaVH3Y5X8
	5g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fy3jdasws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:03 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c20762d21so25716211cf.0
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371663; x=1786976463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jKaqF4zxypYK+u31Iqe1KTFnP3GkPLOPF1h4Nf9JG/o=;
        b=ImtM4+XOa4pthF9GAXG4NCPMCIohWWhF4+1XHEM/nDpXx60HRtmJsyjFYB1V5a7Svi
         PTb/qERp0YdJGajaTvbIAjQ9J/yo6L0Mx9l5qhduLZ2Tvt0QSdUFH0bKSkqw+ENXHZ4K
         m4GPU36Zfzgt6DnBD4B6SAK25fzZU+7BqmYdDdggsVMIMnxgDZcYHHUO07PbFpfmF1fB
         0JgIjC/oxpSS1BfH2khhAqt0FKnUvF4NSwJEIac8D2xcf/AVIREq3EYqj0CYMJKyzT21
         ymyISechp4sG9qsmEyFoA7K70CY2wtasY9J4bszkB4xKnqmmCQK5G1zUnsvkGvo3Ja64
         FkHg==
X-Gm-Message-State: AOJu0Yy3WUXZgMDcGSAGxF0gJeVig2A7kYXjUWRg+dEwOXwCMRx6TVAH
	dU4EcXzcV0Zzc+/S5s5VkTqMCCR39nJn3t/O+ENdiTi6oKgkRNueMYA5kHzp6IkjuXX6Ix1Lg1v
	flLMqFoQ5D/+ModGUxUNI+ZTIex8V1ggBXdC5uvf6YsPFS5L/hlBRG57LLzI=
X-Gm-Gg: AR+sD10m/yddGv9xCWQYQ92tAivOp8LZVzbltJwAV+Y26K8ih0qNqM4w/9zUgDYrWfT
	rLqeCL+J97HC01P21CKHh1R3JVA1ZtYfAhphDgsR26LVjylbBrIm4cWKN39ent8WWpERxeo8EGR
	ZuJnQGiIMUaHDctHI04tr3E67vlpYnMkHDJSJSdmR3u7JIyst0VilkfH4AbD90BHmXXEa/FZJhV
	v9Z7G1ey6UUVq1OEYTzWY02AGSSOTW4AmU0zpX19ln3HiAsZxoO4U1WQUKCYMcYLVsownWkuQtv
	as/1Vs4WAimJW1axGnQ8P/R4IN3Yci0fL5bmKqP+U4ffVGyEUv8xpZ2Wi25d8NwuoAs46g9yTd0
	ZQ3J7YvB0
X-Received: by 2002:a05:622a:5cc:b0:51c:164b:b241 with SMTP id d75a77b69052e-52d18e6b4ecmr208100091cf.13.1786371662677;
        Mon, 10 Aug 2026 07:21:02 -0700 (PDT)
X-Received: by 2002:a05:622a:5cc:b0:51c:164b:b241 with SMTP id d75a77b69052e-52d18e6b4ecmr208098821cf.13.1786371662008;
        Mon, 10 Aug 2026 07:21:02 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:01 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:12 -0400
Subject: [PATCH v3 01/12] ceph: fix error handling when the OSD client is
 stopping in ceph_submit_write()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-1-dd7531704f26@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=3631;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=T3CGmDuDwGWM9IS8v9V4tooVVC5cHChgIoIPoiiGhmg=;
 b=2PzsUvUOzvsyYXoDMifxX2JH5H5L5d7NJVCvp7biws0VILAxDeFCGwwEFrhhXRkyaNnZtYJp0
 MFluyWaO9YKC2mGH1bvKySBgaNIQC+AfRq3SqMwAqiOSUPfv9i7rufO
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX2PNsNNOs3rZl
 301AkwPI/IuU3yre5r79/q+Sl7j4i3yO3o4oZaXu7uJN3NTcWGHc/OO65meCFzv7gVevETUrmJn
 CT21lVGMQoIUWPfUSZvd7FjYpYWXgwWXg7E/S+JHMna6spIwSFy1
X-Proofpoint-GUID: w--M1APYmo4eDjxV8nf9nbCqSwzi_WjT
X-Proofpoint-ORIG-GUID: w--M1APYmo4eDjxV8nf9nbCqSwzi_WjT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX9L+msGWHTkCe
 JWWaCTWGGWgESKDwNm0vLFVtPLKyeu1WGnvOfgueHxd/L1UCabbka6nTGAzzFPZiuQaMeJe5Dwo
 g72yuSYF6bn7hXhNy/Ns8flRUo/FDAWcJBEDe4A/Vk8B2JJ9lKpIPb8BUKnUwXtWrIlruJJt5qP
 Y9ohXFL3upIF+UgTCzxXDIePbCAkeHbj0wu9gzel33yyJwr0oiwlX+amepyJLEy/IkiBQdim5q1
 aXj2gnxk0AU3CxnAqcZNEvIU4fEajbQNdCIzB+57TGzTcukzdEsgSvHGKTsQLvgrVShpkFCFmpk
 ORiLcRoGNMnwjYWDbIavmrN7bMb0EAn8mzGvvZqyrPWuxrk/arOkmFSIcyegLlFg3s0yjc6w8mz
 G1qbhyazZjwHxdUMqZep8cYcts3DtQwDsyPz0omg12SLervONWkOlz43lLnXVSAwHRboiN6E5nQ
 dvbof8iARLiYpLs6Lcg==
X-Authority-Analysis: v=2.4 cv=JPQLdcKb c=1 sm=1 tr=0 ts=6a79de4f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=W980AcPXFMIW1GselFUA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=10 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=10 clxscore=1015
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

When ceph_inc_osd_stopping_blocker() fails, ceph_submit_write()
redirties and unlocks the folios remaining in ceph_wbc->fbatch.
However, none of those folios are locked at this point: locked folios
were moved to ceph_wbc->pages[] and removed from the fbatch by
ceph_process_folio_batch(). Unlocking them triggers
VM_BUG_ON_FOLIO(!folio_test_locked(folio)) in folio_unlock(), or
unlocks a folio locked by another task.

This error path also returns -EIO without fully cleaning up the folios in
ceph_wbc->pages[]: their references are never dropped, fscrypt bounce
pages are never freed, the writeback congestion count is never
decremented, and the pages array is leaked. ceph_wbc->locked_pages is
also left non-zero, so ceph_writepages_start() loops back around and
hits BUG_ON(ceph_wbc.locked_pages).

Leave the fbatch folios alone, as ceph_writepages_start() drops their
references when releasing the batch, and unwind ceph_wbc->pages[] the
same way writepages_finish() would have. Abort writeback in
ceph_writepages_start() instead of continuing, matching the handling
of ceph_inc_osd_stopping_blocker() failure on entry, as the OSD
client is being torn down and further writeback cannot make progress.

An LLM was used to verify that the cleanup was comprehensive, and
suggested aborting the writeback instead of continuing.

Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284%40columbia.edu?part=5
Assisted-by: Claude:fable-5
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e2da3ab9f808..8cd24f66c981 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1472,26 +1472,27 @@ int ceph_submit_write(struct address_space *mapping,
 	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
 
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
-		for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
-			struct folio *folio = ceph_wbc->fbatch.folios[i];
+		for (i = 0; i < ceph_wbc->locked_pages; i++) {
+			fscrypt_finalize_bounce_page(&ceph_wbc->pages[i]);
+			page = ceph_wbc->pages[i];
 
-			if (!folio)
-				continue;
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+			    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+				fsc->write_congested = false;
 
-			page = &folio->page;
 			redirty_page_for_writepage(wbc, page);
 			unlock_page(page);
+			put_page(page);
 		}
 
-		for (i = 0; i < ceph_wbc->locked_pages; i++) {
-			page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
-
-			if (!page)
-				continue;
-
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
+		if (ceph_wbc->from_pool) {
+			mempool_free(ceph_wbc->pages, ceph_wb_pagevec_pool);
+			ceph_wbc->from_pool = false;
+		} else {
+			kfree(ceph_wbc->pages);
 		}
+		ceph_wbc->pages = NULL;
+		ceph_wbc->locked_pages = 0;
 
 		ceph_osdc_put_request(req);
 		return -EIO;
@@ -1725,8 +1726,11 @@ static int ceph_writepages_start(struct address_space *mapping,
 		}
 
 		rc = ceph_submit_write(mapping, wbc, &ceph_wbc);
-		if (rc)
-			goto release_folios;
+		if (rc) {
+			/* the OSD client is being torn down, don't retry */
+			folio_batch_release(&ceph_wbc.fbatch);
+			goto dec_osd_stopping_blocker;
+		}
 
 		ceph_wbc.locked_pages = 0;
 		ceph_wbc.strip_unit_end = 0;

-- 
2.39.5

