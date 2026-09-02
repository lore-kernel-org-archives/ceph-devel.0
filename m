Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B834A8402
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365505; cv=none; b=f+4o7AHPRugE8SIB0PRyyNgf77xsa8uwwdVqxFbAKvjJrgHNEvj44Vz0TMRiXMb3gGaHpNIrRVFJna7E5KnReHWPugmJ/GeQbbrqOGkb5Iw80pocEYKQlOrAQXMmBFO5MBjte5JC9b3Ll2A7HN7uBW+21cgvIrubdiVRgSCwTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365505; c=relaxed/simple;
	bh=/ldrC0e6PknKOFmMc9BRmqENxGnXnBUTqXCF4n5xBxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SADMnZzzFTaNW+YzMRGV7xJz/dYEsPztWWh9V6PdRz/TVYUUoOEqN7DvaPjth69ebqLjyImK/K5AjyC2n7sFgJSFZIPwobPef0zzU59KRpQbyKIF7dFmI/j3s0hUDZ32oMk7n7PfBPUnVtqNSm1+ZyYUFWo3KqrypyTkqYxHWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Y59TB2Oq; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=1B7gU2wQ; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Y59TB2Oq";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="1B7gU2wQ"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682FPxBq353979
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=iwv8
	qT5yhbctNPqdGs2vYRHtBWgOy3PUEMBHx4XKUy8=; b=Y59TB2OqLkyCBNfzv/9Y
	Frx/eW7hWNSwklJsQcWxk8FjIRs+LG+AMCBSuqdSytZzXT5G8nYDMyi99Pwa4Z+a
	s9K6NzET74QAWUoptFT3PYla8XvGyIOg4Cwg82zxpPrGgb7WO6MhvwcMdrnI4hOM
	TveTCvTfc0zsU7zTkguSbyQYFhmnWCbRof9EiNGBBNHxNinUi7zxgMiMGvlOlW1i
	ahKTjnh08ADkXsOwoZyvZP1X7zr+Xi1ps0jSYCcqTi662bnjh6zsoxWHGbOK0vis
	C/8jYdUU6FcheMBSK2O1VVllN8ccz7sDkTkcOZ8D0o0MJyD1rqBNtAD62/SM0eLK
	jw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ge835cxb4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:11:40 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0e702df8so33680331cf.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788365500; x=1788970300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iwv8qT5yhbctNPqdGs2vYRHtBWgOy3PUEMBHx4XKUy8=;
        b=1B7gU2wQLfb7i6ei0jz9g5k1XICzTx+VjqjiGrYs31gvjNPOKXOfY2QwRtSQEVpn98
         Y36o6d/EZrL4k2eoxGd2FvMlmcFK2mjWpUu7aPX/2nPvX93AWwwUwAs9BC6CDgPON5j0
         rPY7VXLWmWQkT3t68jeiJQMXUawrgd/jVUro8r2BQuCYBDSJ2Y3xe2N2VN7w6LIgdrbR
         8d5So756muuOwneNz1qNf+v8/V/FxuYP+RwOWI1h4uszcSE/GrRmWshzn5wu7dcS2koe
         hI5Hvtr5X34sj0DcwEazxeM5NeALdr/EY748E6WCOzVC4sVBzuCnAmPY9Zg58uM1Xkkg
         G15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365500; x=1788970300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iwv8qT5yhbctNPqdGs2vYRHtBWgOy3PUEMBHx4XKUy8=;
        b=WVPTGNlKGJBIg+bY604sQ+nuTp6JQCx2szYAWabl3GVRKhUXEA5dfh36xiCZ1UfEEt
         6oLxXHbgcdEwvQels3h1g6ExGeIpBKb5e9fdp7qZtjaG7L0px7fOnUv5C5TTd9Kj+o16
         T5NOO3ca2bZznC/+alD0WwEYm28GeXiIrvKKdQj+yz7JKGGumw9qGck9D+ouxjO5rPEd
         GjcuWiI+hpjSdlpED7pAa26rAxkYv45cQi1H+cXgTdzrvQes6699bUPWX16QFbznYkRn
         lQhZVj9yGIHsyBGYqcytS2H5PkF6npHOca37jJk8Dwnocn+xJ2HoIu0W0qa7e286Xbfn
         JnPQ==
X-Gm-Message-State: AFuF++nE9E9I7fJv9RtVtNBKZcrcIkR6PYXDylzAIIfuEqgzDHBg3wqq
	wPZSK7cIoHAX1Eav/AY98BP1HLjdwtlEwJOJK+xUSGz8BwmdXOsTrSs9VdbgVuLCQpYnpkPv055
	+ycV521Zi69pzLqSUyUJu/ZdRUJxS3b/e1lx4zFupNGD6li3go1fxb5FLz6c=
X-Gm-Gg: AR+sD12YS5r6KycH5QRxLYmK2T0Rr+Lct3eWPNXpq0VseDCCI0VVemjzpmFEzNbXDQE
	nZGwmvymbK3a6zuj9SmbeF3vyf66MU3HmMUqfphFjwUvSUCbE3PyeSSPt9OsyfU+2ABYMeMq6Tk
	/bi/ttF0lPpUEu/D6VW5ZPJD0duSwJmzVGZgMGEyZS2ozqP2kx0S+Wdx9EPKWrAq1fWTWz7vtsC
	e2ZTECXvLWrc43gQ6vbtrgosWsbv94nKvCKpti5kGiTYIdX4S+UbCtZBxs9YWGxbUZMxtmNhD5w
	+mMKJNhYjUsMugRJsd3NUV0vmvSB2NhqKT3ve8cUrzuHG6aDr8CnqJBqjl35YPBlL6040pzpmLk
	M+3uhh1YoIj0I20WSJZ3aTtIn+9Y05NT8RuD/Nyy2iJq+TwwBomSZOg==
X-Received: by 2002:ac8:5949:0:b0:52f:b729:8b3e with SMTP id d75a77b69052e-53036d4f2a5mr64642661cf.36.1788365499764;
        Wed, 02 Sep 2026 09:11:39 -0700 (PDT)
X-Received: by 2002:ac8:5949:0:b0:52f:b729:8b3e with SMTP id d75a77b69052e-53036d4f2a5mr64641451cf.36.1788365499053;
        Wed, 02 Sep 2026 09:11:39 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec7608sm21172636d6.26.2026.09.02.09.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:38 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:11:25 -0400
Subject: [PATCH v5 01/10] ceph: fix error handling when the OSD client is
 stopping in ceph_submit_write()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-remove-wait-on-page-writeback-v5-1-0b512e77e75b@columbia.edu>
References: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
In-Reply-To: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788365497; l=3742;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=/ldrC0e6PknKOFmMc9BRmqENxGnXnBUTqXCF4n5xBxk=;
 b=ZRRp+zYKSg5cZZ9WsqKtGmfMb7YlOIULJAO8lcGjJzzTMjEHMVfrDjA+BV0A3q6s8T8Wbdbxd
 euXimuC/ES/CTD1yrYIH5KPt0PPM5lDbqe02vBhJjGSwfOD28hPUO5X
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX9xKsLSJEaivH
 7FowSrFklat1W4gx7NHO3ZBbsx7H1hE/O1JkSFVylWyaVesRgF0gnSqPfyfi3/9rcQhbF46OvpF
 yCH0nqWwLl8xTGUvCMN+GWDpv4dCx8cX/zKzzxCjWBuGxFJX9spC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX1LOTULy5Vzf7
 iLJc/uetari2N3sgNjlJ3TWKog0ws3BFT2uRHGMDnCFMcCZoI+m5cocxnj5ltDYNKaTtFkw9gud
 ZsewoizDSQOcL4clPeLNvstkMERSwmpTFjr4vvXeVKsvoEEDIU8oQ2Cgi9e5fZ+vkiBi+Rum2zW
 dFXiGjVK6NfLJeHjsuti9DleCkAi/AS+NGaU4AiNNaoA/Ki7huGfk9tza6DGBAeb8XmFA9Ju9LL
 rUmksgLvNJLr8XM0ke6RFbSOnQN6puJ04YGdcJomGUAE1LIazf1F4ZGUfEX1zNcrwHmCnyI+F0e
 zzf2RKPPl7tbZc32OS98hUCsGnnjeyZpVoBBtRRa9iFCrQGc/M9JMfHm59SkGsAMawfszdEVUNC
 LtKPKD45v8aOejCYm5uzAquKv6Tb8aIvSA3wobRfdcvdHXP9bjuoNY/anxV7vCNSZzKc4egE8iX
 QblRWqqcc9lyqS+qIdw==
X-Authority-Analysis: v=2.4 cv=XY+5Co55 c=1 sm=1 tr=0 ts=6a984abc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=W980AcPXFMIW1GselFUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: GePS4akYcFNs1nd4RYQbWlmmmlbrcPnh
X-Proofpoint-GUID: GePS4akYcFNs1nd4RYQbWlmmmlbrcPnh
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=10 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=10 lowpriorityscore=10 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020143

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
 fs/ceph/addr.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f8844390f88d..28fb76ded32c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1491,28 +1491,32 @@ int ceph_submit_write(struct address_space *mapping,
 	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
 
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
-		for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
-			struct folio *folio = ceph_wbc->fbatch.folios[i];
-
-			if (!folio)
-				continue;
-
-			page = &folio->page;
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
-		}
-
 		for (i = 0; i < ceph_wbc->locked_pages; i++) {
-			page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
+			page = ceph_wbc->pages[i];
+			if (fscrypt_is_bounce_page(page)) {
+				page = fscrypt_pagecache_page(page);
+				fscrypt_free_bounce_page(ceph_wbc->pages[i]);
+			}
 
-			if (!page)
-				continue;
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+			    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+				fsc->write_congested = false;
 
 			ceph_undo_wrbuffer_claim(inode, page_folio(page));
 			redirty_page_for_writepage(wbc, page);
 			unlock_page(page);
+			put_page(page);
 		}
 
+		if (ceph_wbc->from_pool) {
+			mempool_free(ceph_wbc->pages, ceph_wb_pagevec_pool);
+			ceph_wbc->from_pool = false;
+		} else {
+			kfree(ceph_wbc->pages);
+		}
+		ceph_wbc->pages = NULL;
+		ceph_wbc->locked_pages = 0;
+
 		ceph_osdc_put_request(req);
 		return -EIO;
 	}
@@ -1745,8 +1749,11 @@ static int ceph_writepages_start(struct address_space *mapping,
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

