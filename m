Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA05485518
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869565; cv=none; b=FzvEfbYCIscrxwy0rvL+CdNYStUkovqmoibVqqBxIkWjc6514889KnvZIoyjxHN8oMZCT53g+ASrz68ea+4SVE62v2ZfXBuP3zxuc46MB3VQKC8o0Eh/lpHOULSNXDZJ+X215YF2ROrPVOTb8VA6nnBPGzl/HQ9I1N9WcKOVdxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869565; c=relaxed/simple;
	bh=e5RnTghCgGxRcPefvNu8eHDy7gFWlXJacvM2LVI5FtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YgAD6sHGv5tqtAnTcOgpISlYidmxi+5glmwx2LxeP0y68btOPUiqqvXXdhHePNKaAVg72m5xB30CRenYK3oZfeuWjBXsv/lgdLEq4TVgESTBp1leZ77xoLFKeL6ysK5pi85ZdxHdDK3lziM0BuU2EgvlYd/5hN2lheTGWJzcAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=XZpc3OUE; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="XZpc3OUE"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IYDNN2126308
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Hfui
	Aq9fRwaotC1CJREPqRYjNBrhvyD6iaPba22WJLg=; b=XZpc3OUErFhDuYUKKUqZ
	NgyX4ZEu4US2rdX/qTNvhwRViyaUx1n5QBVsAxLukRBmCfbhPulRIl7pI8ZDFjaF
	K+vabneR/odcpWaGUDF6t8CFft8WaFIHJCl6b6Hb9O/LgrsKt2lD7RQqD0CrJLqi
	29pYTxRZqvs0ZZJu4YByWOtr9BqMmo3FjbIL/7WTQIXBcHz9ZixlSTyfn+p+tY5u
	672KBL7qpWA54lXDvJWLL13s2HDgKLWmET9XFH5k3zkCZTcEsd+FHAzNAAAjAdeR
	gPLlUl4louazwblLm7hX411RaqSamXuZedV75DfhQXmISFnjR8MZBWTXH3xweNSD
	JQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fuj0et166-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:42 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5276aa86d00so1013271cf.2
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869562; x=1786474362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfuiAq9fRwaotC1CJREPqRYjNBrhvyD6iaPba22WJLg=;
        b=fN8u5K7777ofLyzW0gTEQ5OO0bhOWIF4sYEA1X6VFhhfceTX+XlM5IWNh5rgmoqTXt
         xUXz8pNuTQlpMqyeRPNAQnFSFS6mMiJ043TfZ/SB68Nw2A3mhHlGQEmUSsT2biecUFcJ
         BUWUb5H609rSCyyuzXBN1FLB/7FoaDu5vJ0M4bwTnXC/IpWTTjGhAbtlCDkNK6wkDyH7
         /GEOJltzoyPSQ+vUcbkW+x9bEOkGvcwGkmKubQ8fVs+TeVwbkcwVm56a49mvnRvNoGhv
         5RgcSnvSgbBFfQbPaYRe2QoxRPpxv1d5sb+sIxUAckdqATOObiv//oEdZCWaFcttDpfS
         tNGw==
X-Gm-Message-State: AOJu0YzlTJ1sZRech64OefoiQOENjxVyqSz8YOOoXQJNnUG7WcC6lBF2
	EWw1kjTab/tgSrZQxXq1rK4x6t23tKEUVP5H2HMEbUds1L44HjNYfdxNrndcuH8Ho+YKOZ2m4uN
	t1vkYty7fw3sukN0EVrQrh9mLP8UX0t9GQoXqCmK63twiNigk1L0eeX/wDcc=
X-Gm-Gg: AR+sD13h0JdVtSv12MDDDtd+vUwsvQBdKPZKLnFWckpx6ido0V+ZFIZHftYaAIdM9r5
	RI7MlbnCJGkBBYR9s48ipKWhuvYJZYOtkBnvIkPOhTenwR2j6AOdlsQAy++CAtJuTxeHaerEyTP
	m79cdrd5r44vtHwrKiwdBNeRrFheRPQ96FVvEGxwxkfRLYBTPmsblcuowv5Fb3yoJAUFsDjlhg8
	ulLAMkcA+imWKcvInIlO/+VaLfUuHqM/Kf76uXKQqLOJ0varPQAiD9XiiiS/ohxACH8lucnUq+9
	7ygvQ3AYR4YhDsY3cjezvLYHvCc16vxKVYXRzA//NNHpweWYt9sNuuP5QgSq78FzMRdO3nhTXFX
	NTdza7Vsp
X-Received: by 2002:a05:622a:2615:b0:51c:2022:cef5 with SMTP id d75a77b69052e-52ce61009f2mr13701601cf.26.1785869561760;
        Tue, 04 Aug 2026 11:52:41 -0700 (PDT)
X-Received: by 2002:a05:622a:2615:b0:51c:2022:cef5 with SMTP id d75a77b69052e-52ce61009f2mr13701091cf.26.1785869561259;
        Tue, 04 Aug 2026 11:52:41 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:40 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:14 -0400
Subject: [PATCH v2 06/10] mm: remove thp_size() and thp_order()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-6-81f0ab065284@columbia.edu>
References: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
In-Reply-To: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=1208;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=e5RnTghCgGxRcPefvNu8eHDy7gFWlXJacvM2LVI5FtM=;
 b=352CGDr9OG3l8KsRpsq9VMlqpPZh/MfaEoDT8M8ftVE1jeGcs1HXBprsWM41xxX90zxLaaPU/
 J3mqutft1KOBPqpbEFXWNVkoXdMQb6b5ZCY8fxhWijzmLWTs7ZOOQ/3
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=ePIjSnp1 c=1 sm=1 tr=0 ts=6a7234fa cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=5wpFShScvf9Uq2YMFBAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX86oYI70LDoPF
 SSv1lOHOxF61MPVKkuK8zc3miDtb1czG9f0+ad0BjH9JMbyJAIU7U/jjuFb8V6bgDGhZe4I8iKk
 uExyqGPjKUqwOkSO6cldPVdGRFtJQL5Qi3k3dyqywhyoelzqhsbT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX/mX/xxakVCrE
 RCxMHv5aLVFjzuSO8eBL4O/Uvda/sdCQdVWQPDOyM6aUANOlkCqry8pSTua15JE6FTP0UGZIwHV
 P1m7fNEHV248RDn4Kx5nzB8KNAuhI9GX3MJLvhE23UPemoYFbDhibaIuzvSKc5ssVXu+XJm5u7/
 61GoK6eMyaStBFaZumJYOSQ278JFmDKvyCeV0Q0PCKNYl0UGaDslGeGGjPoXK0QwYud+D80yEr8
 ZulTlm5sWb34fofGI3+41WQcKk6X+VuHwKveldX8L3xU0EGseO9BdpSwyK8IbUdgCxywoKRUxiB
 3898vRdbZ9/0JK+GYcZmwyJUvkiBbnqv3IGMQ9ZAXFGV7EflJWVMkoJqkpitd77oIcigsfmhecd
 fyvUBzS1tdGlPSIS4sspDZVTa2Kejwi/lRuH5W4VB4gSDDBJZZ6wgkWWYTC7ldOnfbhLh/SPPOO
 c4gqxh8nHLqLzpmih0g==
X-Proofpoint-GUID: wNzBDipIHFN3xdfzadE0EsfS8eSDKWrd
X-Proofpoint-ORIG-GUID: wNzBDipIHFN3xdfzadE0EsfS8eSDKWrd
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=10 lowpriorityscore=10 bulkscore=10 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152

The last callers of thp_size() have been converted to folio_size(), and
thp_order()'s only remaining user was thp_size() itself, so remove
both.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/mm.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..48e821454ca0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1966,27 +1966,6 @@ static inline unsigned int page_shift(struct page *page)
 	return PAGE_SHIFT + compound_order(page);
 }
 
-/**
- * thp_order - Order of a transparent huge page.
- * @page: Head page of a transparent huge page.
- */
-static inline unsigned int thp_order(struct page *page)
-{
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	return compound_order(page);
-}
-
-/**
- * thp_size - Size of a transparent huge page.
- * @page: Head page of a transparent huge page.
- *
- * Return: Number of bytes in this page.
- */
-static inline unsigned long thp_size(struct page *page)
-{
-	return PAGE_SIZE << thp_order(page);
-}
-
 #ifdef CONFIG_MMU
 /*
  * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when

-- 
2.39.5

