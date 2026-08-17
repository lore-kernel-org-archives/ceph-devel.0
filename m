Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825C3DA7DF
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994127; cv=none; b=d5tB5/Ywavum+V8LuooHYFGnwDvXWfiYb2Tt6GRhonVBG9UBGheKWmf1r6II1oVLEC5YnMYOsImch3uyo8rhaSTU7XlvEkgd+ZbLmxcuaALHW27AOO7xLW/dWGT+nU3dxV2ruhNfhTNyPhJIYtZUjXlr+41ZAmfMn72WJ7M50GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994127; c=relaxed/simple;
	bh=PR2WJRorXsFJP25q+ha589sxpEGLHSUrsTYvs7exL2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhpqlomRnkLRMYJhwlm7ABk+925EChfPh5lf9ayVW9Bk64K4BaPGySk3GSNLtcDPcwMUjgPScPydswVRQhrtwpWh4a9eQXNa8pE9ojjr2kp2tL3aRqFfwj+5xvHmrkA54ErA6FMfzdYem07bo7d7v4Z1ItrdGQsv3cMmgHvtrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=LCWw5JIV; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=SAgjDAug; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="LCWw5JIV";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="SAgjDAug"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIviP33692117
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Dggv
	ESa2CSpFGON8I8M+asVXtRP298nD3FGbSrEXKPU=; b=LCWw5JIVGwNwlQ264hw/
	16CXJ97dztxkuxphSfp+yufad1UQKR+KFb1x586lzjDl/e+ek5Kl1iQptAt1xg4M
	cqHM/YeA+9lFNfY/a1WJZT7yrwIb/1DpDAW2mSiv8jYy67FcjGnAK2v2ZVSOJEAC
	kZPxB7w9HhiSM8Q/HIFgS2tgl59CjWuVy2/4tRqJhWpU1hmDGXZHE/xAWo02IRs2
	FOuJ5JwmYvwtw3wvHDY1guySZR6t4z84TpTV9IqvwyoTBCXGY/mOv0aysZXDcF+F
	zewbiYLDc6ifqu4QB+knUGJlLDrDe1C6moCgZLImDhe+OeIYJaScAO07TwSANqkk
	sQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g481r85qc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:19 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e695a3b28so25515985a.1
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994119; x=1787598919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DggvESa2CSpFGON8I8M+asVXtRP298nD3FGbSrEXKPU=;
        b=SAgjDAugL8a69tJ9fzGRVikdlDwoC7BZFampgk8MKyQ8RaCDC0CnsrXReE4mYVncpn
         +dLvQTwus6//4YxEOBfltQ2P+7b4NADuFUjvjfURABDMuckra458arkrRrYUNlHbxTBH
         8IK6YoF4irAi+bfGh832DohHb1zxM3xfLxHpuF/LJfZLmGNbvkpy51Bp03NNCnxSeGEs
         PJZcXre4Eb5N2gNZh+acI2S9WbbldjrfrwmoQpDuwBT6I6yRDyFXp4hUwMqrVCbsKprc
         3JKLVQSIIsbumdiw6AUsDdbE+5ofNByJHI+fo35mw277zHXxoxiEPCvmHVtmchGYWjix
         gAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994119; x=1787598919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DggvESa2CSpFGON8I8M+asVXtRP298nD3FGbSrEXKPU=;
        b=rdKlQKh39rD4DLcNzfH1nIx4SNXecLvI4IwP3imopJVJmmSLtOt3F8PXVt5pTJPjxQ
         IVbldrCUpcRv92JHjCCvBWinoCqRj6n910cT41r/iM3M/5Sj2WpjhaAMroa1B2qds+BG
         3TaX3Nx3gSlRbUpNvfXNH+gYVKkTj+ZySZ8HaAlEcaS99/cEz4O3/oeCa+a0uGcuPDrX
         LLBLOgLE1P148sOONxhiIkB+bybUpDdK0RRUQbOeiK5qFedX0z/f6bQxEKAQzZBXCAv1
         de8EtAtqBNulKUxL0XRdKITFx4f5blotizohBw6/blpgWT0U5mCaIMdekGhk9FjtOJgc
         cBMQ==
X-Gm-Message-State: AOJu0YyndKkkiVYaBjQhj0jjcE9kwRVC8TWjPMJ/moaQxOw+fYFr+42G
	ZXvZ52jpF6EWYc8xpXbxfBQiZ7FmQDxDcTq6jLj7Uu/tq2NnAWImsnq7eBUva7rPBgtyzvaiHAH
	5m70eLf3bdcD6ceuGQyRE5nb5eQ3vi7XdlCtDPhTtGy//ZadUugdJKPAOlBw=
X-Gm-Gg: AR+sD11B35F0sw3EIkUNt9yP0vBiT6t2bGiU5w9r+UiIUkYbpdvr6RWaxANVSBmiMSE
	hCd4d4HGJsEmgcqK5Z55hpk6cSByYlASLEFAkr+9dF6VvG2Wx5uQHAmtamDnao/Uvrne5IJnY/1
	S/Nb9fmeF91FEVdPvUoAOmLUQnCpiQZDW8twA1WgRGVhYxou3tq/2/6fJyfj4jvWAVTazujRhKZ
	FUnV7r13pvRxLPnQpTAgUx+TazMrKPBm5QRFDfKxxXc8mGFngqwKi5DhNeJT1IaKHQ1r283Lu6T
	Hk5Iy3Nv66I+ir0XMfuZbRAhZMqvsoblpU5bm1Gxs6QjsofamSj3HwE+DC0hAuBqA9ZEwxEr8dn
	V4v9bLPN3
X-Received: by 2002:a05:620a:a2cc:20b0:934:b798:c245 with SMTP id af79cd13be357-9370667ddaamr124716085a.16.1786994118875;
        Mon, 17 Aug 2026 12:15:18 -0700 (PDT)
X-Received: by 2002:a05:620a:a2cc:20b0:934:b798:c245 with SMTP id af79cd13be357-9370667ddaamr124708885a.16.1786994118444;
        Mon, 17 Aug 2026 12:15:18 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:17 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:17 -0400
Subject: [PATCH v4 01/10] ceph: fix error handling when the OSD client is
 stopping in ceph_submit_write()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-1-0e5e53d47eb0@columbia.edu>
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
In-Reply-To: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
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
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=3647;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=PR2WJRorXsFJP25q+ha589sxpEGLHSUrsTYvs7exL2Q=;
 b=MiiNBNV2/TEXmunVAfFweNzSbK1tOrILyKq6hig9fRhHD4mptc9CP13bSnvq9tUhn4BJarq8m
 zyRitg3Xmy9CS5XcwYpEcwgBOKrL2PtxpNzgf7r1WjjZkGT+5QUzJJL
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX925+vplnmmBv
 jXt42vu4NLRh+hjLR0GzJ9krtSavYDFp6Cc8ryEXFTkUQESRvukHT5gPI7YgSvBNudOfbLHTxlj
 /iRJvZn70QxUlFTtMbQLFQsIBPrX+qHYf0InkZFjvShP+AAgwwXS
X-Authority-Analysis: v=2.4 cv=MOpQXsZl c=1 sm=1 tr=0 ts=6a835dc7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=W980AcPXFMIW1GselFUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: vBPMUGvBtx5hJeKkvhMW3SFJ4jLGHLfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX11Vwq0j2XM4v
 7QNgGFFlAoPIL8eXTmxPw7GjZdazPQu/Fv/RH3AsSmxOJHkbewSEtLd20gDtb8y/HYM2rO1ANS9
 O6VPLc1UrOl797LGi8izERwTv5c9OGqNWLjz6HuqelurwIHVbI7spOEksQbRwlWEl2cy8Hh+o6o
 SRRzbRg9kGPHRLabB3M7NrqCekVTgyDWRh8X9/ulagflA5tEllM1QSyuzxXpD3jnQBEHKhXPERj
 mTw0UkBEf+jp5aVeTqTxcUgK3zeg7nuewfCfUU/MdeJ0cKiKeX8qQpDgylpl0LVAkbqgfw+CKsZ
 pAgxBNHil40YBxW6w+IF3aajo8WyqIUUaepvpM3NzoeRrNWA1TAHIVq3AVO9EPSMNYLagVZz65r
 a5Y10TmAXu+m6c+YL40Y+n/+mGUro8+liphwkAyTTY1sPh9URHOrduyG8PA/Q4/r4dUUGvcY55D
 DA/4W4muFWtz1Ybrc0Q==
X-Proofpoint-GUID: vBPMUGvBtx5hJeKkvhMW3SFJ4jLGHLfw
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 adultscore=0 phishscore=0 lowpriorityscore=10
 impostorscore=10 suspectscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

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
 fs/ceph/addr.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1f77aec8e960..d5a349daf4d0 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1482,27 +1482,28 @@ int ceph_submit_write(struct address_space *mapping,
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
+			fscrypt_finalize_bounce_page(&ceph_wbc->pages[i]);
+			page = ceph_wbc->pages[i];
 
-			if (!page)
-				continue;
+			if (atomic_long_dec_return(&fsc->writeback_count) <
+			    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+				fsc->write_congested = false;
 
 			ceph_undo_wrbuffer_claim(inode, page_folio(page));
 			redirty_page_for_writepage(wbc, page);
 			unlock_page(page);
+			put_page(page);
+		}
+
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
@@ -1736,8 +1737,11 @@ static int ceph_writepages_start(struct address_space *mapping,
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

