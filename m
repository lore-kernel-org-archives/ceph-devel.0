Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B247F2CA
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869557; cv=none; b=kOptxT+aspPXpsWLaHwVp+T4PPQ+7rbyQ+6m5afBTZIOGwXOurhCL6JcqaZrionbqH35ZwGsFPVxqDcrJRrwHdm2zjjE6+bkiV5obynWokqJlZ/f+JL1wAphHETOGORe4bqfz7pmMGKrkHDYwnGokdfKvVyF66Tly1K94rw/Ank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869557; c=relaxed/simple;
	bh=6dxbAtDCmrnDYkfOuWrS6UKuWVd+lmgUjReNrbBmSH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZarnTlwd60U1Dn0WHUR8A19GKeIjvQHl/QqdZoX2Sp2pQ+WwGVvMM+La0twGDMScg/bdPiPGwuMZG5aLxuO80FRhgZhtNo0rVZCfhcZphtOTfg6yCO/cuViTmDu3p89FVa5ZMitXRyRm+OlmbARrGY0KUQGmCBRi19qFS7XtB3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Ltf+xSeG; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Ltf+xSeG"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IY6ET2212929
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=0np+
	Mh4g6FbtGTotF1tdHYY92zqeAhsY3aQwW/2FAQ4=; b=Ltf+xSeGzv0AQkYnla7e
	HMlda09qU+ceQAezbuwSwfpQ+s98hfRrxCrojTw200tDHO0KPJWtipa+mOndoYa2
	0faFNVbhALn0z4heQK6KRc5vqT+Zw91vYGijd+tQ/ZVzSziPHadAUv6hDXtU/i/L
	ynUN9BIQu2IK1g6uWXu4Mw7IZZ8V+TVEcfQWsxChodpUetUwIq3LZnyfE3QsqIFG
	vJgQe4bLMhOxd1rU5LOMm87Bc4ADLQATL+mW4RUie+BXWiilIjbe7wLzh9I5LX83
	evGCAdsnquSjRtxOwQG8Sj711pJ9EjNLgEJAZm/YC6jjB5BEeffKc1Rd2FDNTbTN
	ZA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fukgqs6ar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:33 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bff5c7035so1541741cf.2
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869553; x=1786474353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0np+Mh4g6FbtGTotF1tdHYY92zqeAhsY3aQwW/2FAQ4=;
        b=XvJJawfi80o5sIaXF9tBK14CgkO7D+c+RbnAiCvIU/8dzaFpEC0JrXblo6NqHM2QQy
         B2JlJYdu7vK4fyLUJSfKp822ERNOuYdPZ103imFtgkN3WpzjLsyMFErGLkiEhS/jMMII
         btYD8L2P09xA8JuFC6t4+oQ4gWRC/SWLiHEitbcwCudfht9axYif8FVJa02984ciNrnh
         CmAhj8zCXzt6NZ+xAtBpw1u/IONM7nwU5PRCHe95OSYuwVq9eihY1MCC5uItkwVwir92
         3zzzl16GlTmNFn92PDGhW4JS6SOJ3KI1O7Py24GMy6wbViXS97Zo7M/kFtbbT/uAg2oB
         +VGQ==
X-Gm-Message-State: AOJu0YyYp79MSfTSIWAPjP7HPC1/qs8fdisBRDsSDveReUQKkTEo31If
	hiLzo1n2O1nu/egekTUFbOekONkXqcP5AaPqo5mdrPUXE/yYZsFQNVa+nI/b7dNr5tDSdryfzE4
	sHiLEwFQZil6rmGWLuqjCNytCRyK2VL9Xkef0bFFYAAHlAGBP/6kP1gWJ1cQ=
X-Gm-Gg: AR+sD131igpJJc8rWOh79LbK41YM0qk8lktFYfrwLV4LW4k5MOlqgeX+srtk26J4ilv
	d2XkhIT2PlZm4lQNKAS5Ziu2KEPvFSBOu6+AAo6Jon2f4pnqaJWjoRuAAGyQ/p46eDMbKxFO6VY
	AKnO33maLGX3itlOlNd2i/GmlUpduVa3um5FIhcegWxoYHuAQ0c46T1xCs/hoyxU32IePr0ocG6
	Ivh9A3QBZ2c5/cIWQ7lfXQh8yrT095zRDVufggIaVUCUkoAVSBLiE5X7hDz+aeOTy9LyUr8sJOt
	W0yvxPaet9qgwLMAfEIA9RYr8V6xRzUWmwZZnFsTTgG8gXQEo54KOmsX9LoDMxkSvkhqI/jDVeV
	quCuIdHCl
X-Received: by 2002:a05:622a:2615:b0:51b:fb82:67d1 with SMTP id d75a77b69052e-52ce6112cd9mr13729611cf.20.1785869553264;
        Tue, 04 Aug 2026 11:52:33 -0700 (PDT)
X-Received: by 2002:a05:622a:2615:b0:51b:fb82:67d1 with SMTP id d75a77b69052e-52ce6112cd9mr13728971cf.20.1785869552803;
        Tue, 04 Aug 2026 11:52:32 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:32 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:11 -0400
Subject: [PATCH v2 03/10] mm: remove wait_on_page_writeback()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-3-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=1451;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=6dxbAtDCmrnDYkfOuWrS6UKuWVd+lmgUjReNrbBmSH4=;
 b=ZZvU1M4pLXeTAriOtmeOSI0mHfXaaquENtCXvCsHWefyUHy7xTa8qlvMhdOavhouCXtH/NY/9
 QkGdKcRbTsJBwgWtf4Ig/DUGBu4bGeMxHWQm7D+6O8sOhgz7BM0DOKW
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX1/5NoIPqggOf
 VUj59fGc0wsiGhxzvTOVkCfjzynC3mdtykelDfcrOp9fYXSINngWfdvRwKWgjL6zi2OCBo8P1g2
 iYsiHEyHgnxNGEsFkG3Mj5M8h9kyVl9HShZZcAnKVyyq3bX9ZrzG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX2yG8MZyZRLwT
 7N+UIxGwwmraG4N2XLZiQyeeAXL0Lj0ygKCKhOYboH6Ww9XIGAQnX/dcL+r9aE2ZElwHJoYj2bx
 cZndwvplBdXwCSlc+70kzrHwGMqdy4WS/CeCqpyhDEZhgYyZyBJdX7p2/lSgSKb6ebWYElvKIGK
 4NqJYH2UY0VEjXqAm2zsI5La4EBRyk9/P9eOpe04OQ8NvUoW6wxR9DjEye4vOMceYJ4iNOpaDsT
 WzzzOj+gdHnwRnXuMgnaRCbJdMRbUTEdHSv0RrHXsRfzgDJ0TPkYWQK8pS4tyvfo362NCPYQoeN
 Ul+VnvBEQB2eulSWo1DMwRRqAhcGWXV4MNO6NLU1fZEFuH00oQ7e36nTrZerTESWT/mk1eyXkxh
 vLrKOg53nMzMurUusekUhtmiv0Ag+H3FzRbZUhfYRVivVcrtYnYm2p1ET8ovJmsLfi5fsg/98IS
 xeFmdX1hz9qMvXhcTvg==
X-Proofpoint-ORIG-GUID: LUeGtYlESlVcj6aI__g0-jTqUq_yAqW_
X-Authority-Analysis: v=2.4 cv=X+Ri7mTe c=1 sm=1 tr=0 ts=6a7234f1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=qBqFc3eaEPVjc8k8qNUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: LUeGtYlESlVcj6aI__g0-jTqUq_yAqW_
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=10 impostorscore=10 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=10 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152

The last caller was converted to folio_wait_writeback(), so drop the
wait_on_page_writeback() compatibility wrapper and its declaration.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h | 1 -
 mm/folio-compat.c       | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2c3718d592d6..3748dde2b97e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1240,7 +1240,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
 }
 
 void folio_end_read(struct folio *folio, bool success);
-void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index a02179a0bded..ae0271591d37 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -23,12 +23,6 @@ void end_page_writeback(struct page *page)
 }
 EXPORT_SYMBOL(end_page_writeback);
 
-void wait_on_page_writeback(struct page *page)
-{
-	return folio_wait_writeback(page_folio(page));
-}
-EXPORT_SYMBOL_GPL(wait_on_page_writeback);
-
 void mark_page_accessed(struct page *page)
 {
 	folio_mark_accessed(page_folio(page));

-- 
2.39.5

