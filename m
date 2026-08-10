Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7C3F9F55
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371692; cv=none; b=Xrq+TuuzkyvmHkamgqBQUDtiPJiPt182c8r6Qrk6cW9Q5FRJmXEbNkB3IpsIk6PTJJww+yPsFi+ASywIKcIeWdjq7H83HoVM4hI4RTJ6bPwEmfrvwS/8kYmImbj38WjNuaaKEdS48MKwjHasa5c3Yqd8rQal95ahzDbCt7bdM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371692; c=relaxed/simple;
	bh=GT6KsnFlFKH28GmoGfMAppH64tmtgEJSjAsPDSSVHww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhdL/e1oQEHccDaJ+o5oANRxPw8j8bhrgtmerPL0v/LfSQj5TWQ+4BcgbQw7SSuzFZOwzbPiPT9lBq2V4QUbkABK5mZuNWYUpOyGyfnXP8Kj81S6eUdZnVt0zRWW/xSTrn5TS2/nGpk4ig7EvS531+yCgDLKW6/EguQQpzgjboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=dLmpK/OL; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="dLmpK/OL"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACa8i03194073
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=IVyh
	2I0xknPiazMq45DWF306MKF484odlddz5jbEe2k=; b=dLmpK/OLQz8CU/TbBRcD
	wffnn2Mb6OYdhpCnoHsIMBQCQxCM2lOU95CMLabWmepCtZvxKZAhrqWQh14IpFyx
	zuMHFDaY1FvGUWkLbUOavcfk2cvFAdJsSGZGuy4wGxHZYk8PuY0HEdt5+pAv/zYI
	M77KIk9rNd6/lpD9p8mUMcv9ZqdeJnMahAHeJgkPYsqr8TqEDhVdnWVN1AxT5Wqn
	AId7tMIW3zmi5qNzbCmq+0Van4AMFJuZ2a82w3pU6fsDl7cBmHwlHKVGENOqvo0m
	rEQoiWjLBF3P7s84IxiauMhiMiJpt7yb9IW58R3+v/vu6liLLu78R69CEDr4FqW5
	Tw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fy29132e3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:25 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c01ff996dso26642891cf.2
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371685; x=1786976485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IVyh2I0xknPiazMq45DWF306MKF484odlddz5jbEe2k=;
        b=af839ZjG1dAXTpoJVJ4E8kmHTwtLnCnDNd9zg5ppB1Io+4RzH6z+RKN7HXLekq3DWl
         B9hkg7P76xUdZ8Wrs0E+kjhMMWA6+zRQDK+A7v89YLgmQiPannO9YfsT1SxJDWs4pzmV
         FyxOZ/9jrWOn9aCKMePMQZNPpeZWGv1NCOOGLoRy6ZBHDrW91HKHK3ioau9Qe9IlUBRI
         pt3Y0SK7h1mIR1fVTnKlOEqRk0mlcCrWTkEcQL2V+G1UhbsZqH3srC4h+GdOH/NLR8h/
         +XMfBRuUig1y5EgzTirsYGqpk6ubzUF7N0A1QNfa4xUsAZTycxoP4kBgip0Fs+8+fuQP
         KWOA==
X-Gm-Message-State: AOJu0Yx0+LTUQdiGCXjas2bX8QJHxmtGyvTgJvJ5lTTGbhsDAWhHek0y
	DmdycdthJIrMjKG9PmWV9yX8cjjYIvvwMbOZ5GGy64F1ebuoBC4iSASo4bsx6oO+lk5l6wegvSP
	iqiz455qLLoxX3iYpsK3o4bR2ObVL/uaIJj2+/4ppM445amRnaMagfG14mdo=
X-Gm-Gg: AR+sD11DENgEL/3J1G3BXY4Ag6v7RUlX5EhdRxXjRvWzwQyXDELpy5SoPxKbYzJbaIi
	2E+0/p8xFm79fJWHKueedJZdYjnVWA3D7npcSbApTMA3h8UxC2tD73deHYxZMj4QgZ7YfaSEajH
	7mXX5UNU71v3Gj6K0hK7q987oocmH8jeukc34ydn4JsNs+CxM+jK5oZRMkTVJU82lW8XSygCzzm
	913g9qmZPNvh8GGh4AkVOOXCe6vDLzdfYA9KYnIL6MsTi/OaacOl7GAM3S0d6PouQDIoFim/zKj
	Kpqd6DU74WY3BRbNW6qkyYV+7rE12SY3NfzO1qkRK94F2ejYKfEUhHpXSN+m7XqilVbz6JXRYCD
	znoXw7XGf
X-Received: by 2002:a05:622a:c8c:b0:51c:2340:bbdb with SMTP id d75a77b69052e-52d18fd59d2mr274381511cf.26.1786371684863;
        Mon, 10 Aug 2026 07:21:24 -0700 (PDT)
X-Received: by 2002:a05:622a:c8c:b0:51c:2340:bbdb with SMTP id d75a77b69052e-52d18fd59d2mr274380581cf.26.1786371684393;
        Mon, 10 Aug 2026 07:21:24 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:23 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:19 -0400
Subject: [PATCH v3 08/12] mm: remove thp_size() and thp_order()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-8-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=1262;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=GT6KsnFlFKH28GmoGfMAppH64tmtgEJSjAsPDSSVHww=;
 b=byVHWSYhAVOyPGElt43i+q4xX+4IztrMsjuV0Aj4ZkDgjduVsEwlE1w6aC03ZvxffCRtw3I34
 YJP87fwzSOrBu/eta67oEU9hFHy2ow571dm4QIVUtQyq6PukSc9Oav4
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: 4H4H5wqX4SGnSBTxwhhX28eQgY6hR-b6
X-Authority-Analysis: v=2.4 cv=aMTAb79m c=1 sm=1 tr=0 ts=6a79de65 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=VwQbUJbxAAAA:8 a=5wpFShScvf9Uq2YMFBAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 4H4H5wqX4SGnSBTxwhhX28eQgY6hR-b6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX0lCaxrMjXhtA
 /bFrHJCvbIRJeeRBLUeDp/4RJQ5PcxX0Q8fO5yW3YATM4uODWKVxs/tDC1liuEeiHx7jQY/kVxO
 /ZYS1cwuEEa8TwvfRSC2KqK2dBXf1HKEcEOEoJ7127RGm0fdESlL/C/xy6ukSfDJNMILn68Pk5h
 kfKzuRkkMvzTLldrMB3cPUPd4wMXH0Yt0Sz6ahW8gZOUj9/Ad8LJO6fGP7KH4NF/vCACSn2Jsyt
 V7pV5RTEpEdfy6tTH+ym9b99I5eD+z38tq1VJfLUVbke/4U4Nl2UuQRx9YY3HdzX1BrzSVb4um+
 VtY3+Czxn7WuJBRBxIZSx7FYFufzAF8kpeawhMMLTwlAanAbco8YRrHAcd31KEOA38QrqBBoI7w
 URO9IE7fkOBO4rZzSNAEFhvWhUU+fw2yyQ7ZGciEl3PYg2sQCdsElqepEQHshe50UlcLQody7qX
 RAoDRsS5+xSzOy0b3Ag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXwV4cNNz0mbXx
 +zlZd/uInDwh8FP/FNjPpo1Xfgx9M/78jugMrDSDQFVlykm9h/KzNS/nFhpFWriHD8LwzKGGQ1+
 eVIceHp1WpZuYkbYwBhVOb66VTlXGRUsxXOhKhocN9SJ7aXRLFxw
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=10
 adultscore=0 phishscore=0 lowpriorityscore=10 suspectscore=0 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100123

The last callers of thp_size() have been converted to folio_size(), and
thp_order()'s only remaining user was thp_size() itself, so remove
both.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
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

