Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567903D7D69
	for <ceph-devel@vger.kernel.org>; Fri,  4 Sep 2026 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538385; cv=none; b=Vq0mWlzKuoTrk5KqaRqAgD2E8BHJOd25nj4C5MeP7BUrF7CPRLKHlPqUg+sH4RSUrPaWUCORjQpsJcZWRRTJFxaeLW9etci6aBN7tA8MBuoTxJBnjOjZJZJjxRzWYyPcuX5u0ZcSIJQYtwXiKPwuAAuS3HyVWIrSAOsmT4KoMIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538385; c=relaxed/simple;
	bh=HgT+KxvfjaddqNXFVkUtKH00CjJliL03d63DeMvCSSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DRcAL+rbm9nunw22ifdyx9h9aei4Q223fbeTa2P5kOoe+zCQqWSJOBVaPvicL8D54oT2BMOrk03eHUo1tpOhgGtQ7ro76KR7wTPrcDQTF7p7C5juKYZxakKMnJFGhaKKhaz9eZr/QyKkmbCjrcj5MWNehD7/1J72Hp6W5REucss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=tOA0oe1A; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=5aIss8Zy; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="tOA0oe1A";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="5aIss8Zy"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684G9xa62428970
	for <ceph-devel@vger.kernel.org>; Fri, 4 Sep 2026 12:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Dz9v
	Yhdfkr/TPCuaOD6quYTfPSbBDl29YSqczgESR3Y=; b=tOA0oe1Aaiq4vv5URDsb
	1yuqyw+aW1ySE/NHSyi6s7tb9XF40SndhC0T7Ve2hZlJHMvAqxfAHXNHjOGA8EEG
	4qXj2DK7yQMMCJ59GDiU86tz4bmSlgSFyxBjaPL+Mvr/u9sHH2v3IbacCnRz7w5P
	GXbfA5Ba8eTz0hLCsdFLQ2qS5ErQ8C/NpKalYcAw0cFJeW4qFhgRYZqqpG3tOJM/
	QEBTsHWEoHWLZ6z9PA5BlrfC5LzQKOHKZJm1jTlL41WJjNFHK8XMGBooDx+RBenA
	klt1K9Ka0XKesaI9m7ZWdN5iW/8c2T8aPXa6UexTJAU5DZQKhcAADXoAdubfG+zG
	vg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gfr25ngu9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 12:13:01 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9394ad7f64aso235598585a.3
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788538381; x=1789143181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dz9vYhdfkr/TPCuaOD6quYTfPSbBDl29YSqczgESR3Y=;
        b=5aIss8ZyGxAx92kaWGoVbhBIpWFyhdhu3JiySSrp17DqQdGhTHcJny98cyM8qKFi5/
         zKS3KfpL5Ixc91FL8XxT7rNbfx8L8f4A4W8142ZovTIQMMzwsZ7w8y9qWGOzhJPZdcxw
         KLyTwzMW7cakW9UJjhPkAIT9iu5j8LHuxbDIIvWqQur7UdA2qDzcdVZ+WUc1rASTi7pm
         Jnfa5rYeMltwNfY1QEHCf63nlMZ8OQDNSi65FzemXFFh9BwFg9juV77UK1MFpMjW3VAU
         rEtf8l61ubkO8/OD21fCxPJxshiaDJAOtcBwy5n+heHgdvPYM5g5jV9bScHsGoMJ9CxF
         s/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538381; x=1789143181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dz9vYhdfkr/TPCuaOD6quYTfPSbBDl29YSqczgESR3Y=;
        b=RApQJXgxXDj34qekMjxCOrNzgVAYj8Vg5xv+Yb6xmlUSrJOUIY3GZYWfW49T9gHAoL
         QbPkjedlUEJMTPE4Ao3kRky/gSeREKmSA6c5b8LLTWkKRI6564Rl1f3ocvpO2YE77bum
         wM/WLDCSAgcePDNtinOPjSc19h8+DlAo1rXAAJABVhBbaXknzwBV3MIThnHW+zNDMX+Y
         F/K4Ic69hHJ+EiAf/TVOKozQOfas8d7dHQ0EFlqCaybhrowSq08IFE79+7QvmbzfkJ/E
         ynsbP3zohFOu0jeOHzYiYriIcftH2mLoG3BoR9wrxWSgszAUn9ki5Uq7j4CzfYH4xpvo
         HJJQ==
X-Gm-Message-State: AFuF++lW/NEXEuFceW99lwVjdImbM191csiJMkLv1DN3ha9AnZsgO5bk
	E+5YKTCSeZcwMcxlT6fJvaPm9oZv40yUPfXCEC597ssJtXFmE60d+aJVc0W9bGFhh3k/1EN6Wuf
	2gQTFPGQJxTG24hq4oNJusSDXxEmxHxUtc1KtjhXZzzRwdYoIidsnyEVWxtk=
X-Gm-Gg: AYBFou0nV4+SzdaXiMB2bYr4vz5Zj0IakpXAPiBfMngqtU44Tu5Sh+LC49jCEAK4H9u
	grTd91lAR3W9plVzHIYWw5+xfLu15+EWGnZgUJNdzYl6PYbTOTJ2eOlEghbiQmJk6ZCmLYWYB3X
	WyKRwP7Gn+bqrZ3KC0FQ1KTIn6NW8C/RKowla67OL3ukkyswARMYoz/KPTWR/CPIZF62f4c42aH
	mnbU18xOkAxeoUjb4r8NSFTvSMqaW8BAwuQBgcNpRwFZu7Mx+Je/gY/Vs4g4aVVtrY91GsffJCh
	kGDE/mNRgwqblgNKYQrykNjnO5HPj3yffOBBwDk/3GfxghxpS5OkItBhIuf/PMxSybESwpMy7il
	z1Fm5//+jcfxeC+uyuylnm50Jnf/ns0CWeVuBQF0eWkoEfTWr
X-Received: by 2002:a05:620a:1a12:b0:939:57ca:7e0a with SMTP id af79cd13be357-939802f2eb5mr704995785a.7.1788538380931;
        Fri, 04 Sep 2026 09:13:00 -0700 (PDT)
X-Received: by 2002:a05:620a:1a12:b0:939:57ca:7e0a with SMTP id af79cd13be357-939802f2eb5mr704987485a.7.1788538380284;
        Fri, 04 Sep 2026 09:13:00 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-177-158.net.columbia.edu. [128.59.177.158])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fafbd99sm241625085a.7.2026.09.04.09.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:12:58 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 04 Sep 2026 12:12:38 -0400
Subject: [PATCH 1/2] ceph: fix writeback_count leak when a bounce page
 allocation fails
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ceph-writeback-count-leak-v1-1-d41b070bac9b@columbia.edu>
References: <20260904-ceph-writeback-count-leak-v1-0-d41b070bac9b@columbia.edu>
In-Reply-To: <20260904-ceph-writeback-count-leak-v1-0-d41b070bac9b@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Milind Changire <mchangir@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788538376; l=1796;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=HgT+KxvfjaddqNXFVkUtKH00CjJliL03d63DeMvCSSM=;
 b=4uDw3wmZBIHvepJLtO7dmYBt+aLMgbDTQesBy+KkR2tX8jiJai4QqJJhIELSRmBLt30RPEmix
 k7PDvtsf27HDY2vGnyuFronC/utpfhy+Tn+PlG4U58XEIEpttirSAUD
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: 8oxDq4lGNCXVkD58URbhvsZwwFNGuCQw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0NiBTYWx0ZWRfX45TB0SSyER48
 kTfykSDUw18bLRCU7sBObCI2WktFhx76sKP3whI2vq1C6IPWY91/rEj256f9SfUWZwJUiITcxi5
 3c8DpRqEYikuziQQ0/EzJA36O2lGI2IS3xyC+J4z2na95Uf9qLct
X-Authority-Analysis: v=2.4 cv=T5m8ifKQ c=1 sm=1 tr=0 ts=6a9aee0d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=tLges04aSNaZGVAfhBIy2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=Ga7MZtB6ZCvbnmRj4ugA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0NiBTYWx0ZWRfX/wuupNwXXdRQ
 ngUAXCVFNJAG2pE3XlyU5lMrDCrXrg0coe13ofwCS0vsHGmBkC/+Ev9RzCDrJlAkpeq2Sxd7c8J
 ZuN+0tVSJ8aH2x/yvi+1WgMbSe6SjOsLkHHAy/pfSb8pcztz55PkuGCJv6MkwFY+99G03siIB1W
 Ddg1C8s9tG/bRAFZr0qe1KYu8hKCBkx3GIVAvLP5q5gclr74AqkJ1D/ElAQxIi4vDYYkjbZpaJm
 T+2Cj4lUoB2gDBUIfefRoaWhFlonbl5nMNZvx4VzK6Y4MIZkmf5pGwwNYGQEjK4g1llZl1ymTeX
 i3/HsdmT1y2DLQ0sAW13AmuiLF45LLFT+aIe4LNUc8XuebWS/CdKjZaSkhYigIEAOU6LdTHo4tR
 TPYNsxTSoIkiwhaO7/LDPoKofFEaU+JRwiwyn39WrAxleFC0QOMAAzXpAYYbX4HtdJUgSmMjMn3
 +5FE7NsqFghKw1nv1eA==
X-Proofpoint-GUID: 8oxDq4lGNCXVkD58URbhvsZwwFNGuCQw
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11895
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=10 phishscore=0 impostorscore=10
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040146

ceph_process_folio_batch() calls is_write_congestion_happened(), which
increments fsc->writeback_count, before calling
move_dirty_folio_in_page_array(). If the fscrypt bounce page allocation
there fails, the folio is redirtied and never makes it into the page
array, but the count is never dropped.

write_congested is only cleared when a decrement falls below
CONGESTION_OFF_THRESH, so the leaked counts set congestion early and
eventually leave write_congested set for good. Every WB_SYNC_NONE
writeback then returns 0 and background writeback stops entirely.

Bump the count only once the folio is in the page array.

Fixes: d55207717ded ("ceph: add encryption support to writepage and writepages")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b%40columbia.edu?part=1
Assisted-by: Claude:fable-5.1
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f1404664c97a..69f2c4c8498a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1457,8 +1457,6 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		boutc(cl, "%llx.%llx will write folio %p idx %lu\n",
 		      ceph_vinop(inode), folio, folio->index);
 
-		fsc->write_congested = is_write_congestion_happened(fsc);
-
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
@@ -1471,6 +1469,8 @@ void ceph_process_folio_batch(struct address_space *mapping,
 			break;
 		}
 
+		fsc->write_congested = is_write_congestion_happened(fsc);
+
 		ceph_wbc->fbatch.folios[i] = NULL;
 		ceph_wbc->len += folio_size(folio);
 	}

-- 
2.39.5

