Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7F3AD537
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005039; cv=none; b=gaCOWgMs2k0IBMB/oOp3g3tGhBPxYQ4ORNkLyDg4jEUqE94RMSN+d+IboLEpwpxnl2CJQRPKFEC8FzifuWjGcmTCDZOjBnpPZh/ZybCgMNfNPybmiPRpChMXMjP5ZJPGkbSUesJdbVOCeQdE/5mIcFGrsbOfvuRcJTOUPDOheGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005039; c=relaxed/simple;
	bh=3emUeJ/i3q5NhI80qYUlgdvPT7Gfl0fRu9MRHXU+YvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JdQBMHl24wXVZ6Vwb/pGOsZ8xn6GvXimvH/icSOI3JRutKmf5xF4CE+08npMyAPZztFl3Z0l7pti0f2D5maj96rAtUTvaVruJ+r4hLvvm2MtlkXqpgguppyVgTOxcJ85bjAczqoOJ6EtK1R3+M09Yg+YCyGtoAsj4/SHCp7DfpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=tC/ur6+b; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=4pyp751a; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="tC/ur6+b";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="4pyp751a"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HKYUVq3924378
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 18:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=IkqgLJDsDdwNABdulCMVbqC51Y
	mexyHq6HFpo9x0jwE=; b=tC/ur6+bl9+o96k8ze7vUkTUTVps+hFGbSFosJywHF
	Vj9fIKVU9CS8mfUmBS7LuMYMHjljIr43D2iCH6mrmSuBn6unNziMnx+EqDctiO4L
	4281rTLBh2/lLMRrTopngzcRx1/fKVeA2oiokZHlW4CGTJIbXMRyQkr7J5UtM+ef
	NlZmCwvNClKvk/+pC5r0jzG2ahQaBbmazLSdaBDzRF1cJNER9CGlAZr1TQwXnDxM
	TktQ1gUEcueetXqMMLKZK5511DKHna2H+fJIkztIiNilfBRHiVtR+IF9l1v+WFqP
	UNPNVsztvLwveH2Zi2zQX01WUv4KpdJG/o8dUmagr2og==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g48tagxu3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 18:17:16 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52827090cc5so5104601cf.0
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787005034; x=1787609834; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IkqgLJDsDdwNABdulCMVbqC51YmexyHq6HFpo9x0jwE=;
        b=4pyp751aWvJdFShB1AKfttG+7p5yG8dNvhDAyCcf4VlvpgTBVOhBFtc53CYdu95Cxr
         /ysj5Wydl0BYKa8jQVYwW6OghSbcylbjC3n48G150Eyvx7bqSFS0Uj5g62es827pEF58
         Zba4PyVYaq+E+FoObFyiRTz+IJbC0hyKwabEkNs6Dt97qhtxfKLO9ZdwIwviJCXi5yYn
         w5kqvBUMqZhnL7k45OmiIEyvD0lBwcAiuEvZ+ASklN1m27FmSMFN+B6w8ja1LKGawMnC
         8BPwhgS6uJy/KnPyuFwmD2d72l2WH2rhsQj5qr4CITI81ud8KQ4kBSGNII2T4ZBbPOJc
         jpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787005034; x=1787609834;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IkqgLJDsDdwNABdulCMVbqC51YmexyHq6HFpo9x0jwE=;
        b=ZvSRcelO8Tbg9QGqwuQzpFYxACHX74e+swMhY84vyvCYPzb3MmW7dw4vukVMxC9Tt6
         AWZQ3N7w2uIEj7o/bKcXYEDNKh7zLdN548fA6TmtA8HKh9jsVFgX0QBcxUozisc3dG5g
         Z0GiJTwhjCwzIaTvlme8eC8hLu6O2VREJ/B+rjXQPBQtZAZ7grbNWa1QAR5U5elragcg
         wmBASmp7NsPtUkFgpLA5irRmKbrK1MlriG/TnLl44bET5mSi3n7YCRga7iXla4eqom4i
         PUcXaM3N2jSDnktABE94PeRr2jCsoMOFIDmpxl8dOEShdR+CRDJ+nngGqcDpQ3OcdHw8
         qikw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0BdLyaUucENqoor8I7adlMC9nT/wctX9ZBHCwISk4/fOEbpKO8gurmal8EE4ZE/JxPMZF8zVMQmNS@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+Qu4f3NfNmzlMmdmdz/XGlMFQ9nAAf5sXh135ri1WtGqNMBF
	rDvCE7LFWLz2bGAcxEUjq0TSnVv3Fh6vIMNPh6s1qo4q/K6JKchZi8eXgyEDQgGyG3BxYhX/yrh
	gSTSX+DGxigVMKad+FVM+tiVlOABCC6BvtA1AhFsdxd2rvoKXo45yjR/t0xg=
X-Gm-Gg: AR+sD10X0zQ9fPIPSNjkIG6d7PWgVgwLbALKVZkfZOGEpFj6h29tPE70cgcvC5cYSot
	wAY2vCCDHtS5J/cfcwb6+vjDRaF+cc1RwJLIaXa5Txc4XecpR+GlsZhWeeAuKecpbIWAUE88icG
	pwSYZDIfzgPNEgVqVmtn1bEovwBSLQ4vmBn1/wo0bCPxaTV0KxeVVfmr9xQRpT4558dggK1MqnM
	JZ98zT7ABo3OeHVb7+QX/1Yw+MihhZh+46HfDLQX9AqNCgQ0x+advLyVb+HIRpA6M5tM/8+IS4Y
	AAVVNTBsOJ8r/Q2tGgh4nHzeiI0RhekmKIOhlJPmXY7MzWd4BkPVsgoKy3et1ux3RGalLtuO/DE
	swlhc
X-Received: by 2002:a05:622a:5915:b0:517:c582:9161 with SMTP id d75a77b69052e-52dbed24a50mr29439991cf.7.1787005033953;
        Mon, 17 Aug 2026 15:17:13 -0700 (PDT)
X-Received: by 2002:a05:622a:5915:b0:517:c582:9161 with SMTP id d75a77b69052e-52dbed24a50mr29439361cf.7.1787005033265;
        Mon, 17 Aug 2026 15:17:13 -0700 (PDT)
Received: from [127.0.1.1] ([5.29.21.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a7c57fsm6879160f8f.22.2026.08.17.15.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 15:17:11 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 18:16:56 -0400
Subject: [PATCH] libceph: use iov_iter_extract_pages() in
 ceph_msg_data_iter_next()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ceph-msgr-writeback-v1-1-38f3754034b9@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAFeIg2oC/yXMywqDMBBG4VeRWXcgBqqhr1K6iPFXR6mVGXsB8
 d2b1uW3OGcjgwqMLsVGipeYPOaM8lRQGuLcg6XNJu985YILnLAMfLde+a2yoolp4ljVrT/Dh64
 E5XJRdPL5X6+3w/ZsRqT1t6J9/wLpIBlJdwAAAA==
X-Change-ID: 20260808-ceph-msgr-writeback-a67d25e28f1e
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787005030; l=2969;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=3emUeJ/i3q5NhI80qYUlgdvPT7Gfl0fRu9MRHXU+YvE=;
 b=DSwnX+x8QsU/1mHqSk6JgvCrywrtF2432q8gLEVJWLjvlwKF+p0ERVxxlLsEElU0aCou9g3YU
 BsiVFup94ePB5thPUzO8CgpLGw3WIzz3Png+jw+/mhDeoH0jNavGscm
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE3MCBTYWx0ZWRfX31Q+TURqrf1X
 I7xW1LtvnQhpBDydfES25ooSXPLDEegixMeEt6lOYqNANw65zG50piIMvMgroEGQe3aH9SZwRUY
 KG3VdjqlRWkOFPweFGP9TuwGXfBD13mKH4+fF+e1+FvBNYZc2NlU
X-Proofpoint-ORIG-GUID: Nq_1W4ws2HnOcDslxQUcB5SSLOKFYQIq
X-Proofpoint-GUID: Nq_1W4ws2HnOcDslxQUcB5SSLOKFYQIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE3MCBTYWx0ZWRfXxLDWQm99tRb1
 dNOLBzfKcPIm4sNarTwW+viEdkclRwekRPshL+mR2oW8Xef3jSZD5xqRpurzU6SndInx5cu5DpI
 g/kHzhQvQNZ931E96sGHLcX6fP/spqEmmxzhAMGazsEwHAv/U8Vn61vnl7oG4xXSHGsxASoOZx3
 utkz7c35Bi7fNRKcJ400kfC2N6ecHxl7zElS1AVjSKQ5NGk6xhTBXadhg64oWqYMCKfDwVb/8K+
 +6nwTM7LxuQJrvZAaIQC3UG+HB2VAg9oWfDTpppD0A4+UTL2ISmErhZRdqzYT0ZU97oRkrKUkjn
 Vr/7U1Zw8gtfvi8W+NWWJz2bk0UfoxC8N7g5uiDJ8EQXDcOHMAvzPOIo1OOIsymFTJCuJsRUN06
 Dky3v8ITy5EjIHGxrNCv7KIm1YzJGcbfnuMN5iSxVNdLRDScf9TmdZyvCte1GT5oejVpzgjegjE
 k7PTtRFyaScYANb2Cxg==
X-Authority-Analysis: v=2.4 cv=UNDt2ify c=1 sm=1 tr=0 ts=6a83886c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=+jhzTfgB9+Zh4fN54NgtOQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=TEv_gA4yw5qAGLHRRRsA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=10 lowpriorityscore=10 bulkscore=10 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170170

ceph_msg_data_iter_next() gets a page reference from
iov_iter_get_pages2() only to immediately drop it, asserting that the
page is pinned some other way. The FIXME here predates
iov_iter_extract_pages(), which takes no reference for kernel-backed
iterators.

CEPH_MSG_DATA_ITER data only comes from osd_req_op_extent_osd_iter(),
whose only caller passes the netfs read iterator, which is always
kernel-backed. Use iov_iter_extract_pages() and remove the put and the
assertion. The messenger still relies on the upper layers to keep the
pages alive while it uses them, as it did before. Extracting from a
user-backed iterator would pin pages that nothing unpins, so add a
precautionary warn in ceph_msg_data_add_iter().

This removes the last caller of PageWriteback(), allowing the page
flag accessors to be removed in a future patch.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
The assertion is the last caller of PageWriteback() in the tree. The
removal of the PG_writeback page flag accessors will be sent
separately.
---
 net/ceph/messenger.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index fd9c9e64dc8a..e08c3330b9f2 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -996,28 +996,17 @@ static void ceph_msg_data_iter_cursor_init(struct ceph_msg_data_cursor *cursor,
 static struct page *ceph_msg_data_iter_next(struct ceph_msg_data_cursor *cursor,
 					    size_t *page_offset, size_t *length)
 {
-	struct page *page;
+	struct page *page, **ppage = &page;
 	ssize_t len;
 
 	if (cursor->lastlen)
 		iov_iter_revert(&cursor->iov_iter, cursor->lastlen);
 
-	len = iov_iter_get_pages2(&cursor->iov_iter, &page, PAGE_SIZE,
-				  1, page_offset);
+	len = iov_iter_extract_pages(&cursor->iov_iter, &ppage, PAGE_SIZE,
+				     1, 0, page_offset);
 	BUG_ON(len < 0);
 
 	cursor->lastlen = len;
-
-	/*
-	 * FIXME: The assumption is that the pages represented by the iov_iter
-	 *	  are pinned, with the references held by the upper-level
-	 *	  callers, or by virtue of being under writeback. Eventually,
-	 *	  we'll get an iov_iter_get_pages2 variant that doesn't take
-	 *	  page refs. Until then, just put the page ref.
-	 */
-	VM_BUG_ON_PAGE(!PageWriteback(page) && page_count(page) < 2, page);
-	put_page(page);
-
 	*length = min_t(size_t, len, cursor->resid);
 	return page;
 }
@@ -1967,6 +1956,9 @@ void ceph_msg_data_add_iter(struct ceph_msg *msg,
 {
 	struct ceph_msg_data *data;
 
+	/* the messenger never unpins pages, so the iterator must not pin them */
+	WARN_ON_ONCE(iov_iter_extract_will_pin(iter));
+
 	data = ceph_msg_data_add(msg);
 	data->type = CEPH_MSG_DATA_ITER;
 	data->iter = *iter;

---
base-commit: fce4f3da41f1145cfa400002ce3a66e4a89a1902
change-id: 20260808-ceph-msgr-writeback-a67d25e28f1e

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

