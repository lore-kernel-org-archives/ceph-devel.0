Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F3431A51
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994137; cv=none; b=lg/Ly1SHzaY7dCPkbCv2HVDoDbeZcofStsChCPhcmJbp7gp/rSv+1qTEcCQ9jHWe0DzU262vKH6/zC4JZsoh4Q02WSLJ6EpkiVXF+ROCBF1YH+O36HN2ZrgFqxgaGtP3KEPKbLz2TGW0vEovfNzy6fCFzRt0JGyZ9KQ5BQXPiZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994137; c=relaxed/simple;
	bh=CtACIxblCkTU4GIVsMywndtlFj4/darbY31uUhcppE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3YuPOFGrGaLYInsgDdq2KCHv9BCN4mXaS5XAUOTUbmotapOFNRK0EdScMr7e+dhShfgTX6EzKAwaBdxfChrA7bOzUdqM5aNcvJMRidC94xe1r5jz0V7jBNXo2HLUWT24RcPlt0x8u6nN815tc3kTsvzrmvxfJvelazNHwSsgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Mpbf+hhx; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=xlglK4Ht; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Mpbf+hhx";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="xlglK4Ht"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIZ1HF3664402
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=AIiE
	lFGXP+TJuv/wEXsiRAFNhkPhkbHdub17m4BLpvA=; b=Mpbf+hhxQOXecHMI5xg1
	yNQXNUCmCIeUEA5Z1GBHaN+77T3R+M4MSMfiXf88p782FXBku4ajZGvErbxUmLIp
	MCDiwx/pgOW+u7jddimLk20iZGmBZQqFxZ5JdkOm/INw7222tmMehpb5JMc5Xmwb
	PiUflXIIHDyvRwBnJCeU7MxgblcpifMs6vaeXYqolMIBihMCxS8vyNAzb3RTyos9
	CgP0BlpWx+ArAm5aZ6i5Kim/rN4pvmSaB74UKIyboxUyXhD/jAxTTHCOEF4PGzrW
	hc8nQogU/PmRHw2qkSssBDVnERslfvwTZsWnpm2LUIZw/6cpKa66sotnUMtFoSjZ
	Kw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g3mkfnqgj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:30 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936d067836eso391541485a.0
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994130; x=1787598930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AIiElFGXP+TJuv/wEXsiRAFNhkPhkbHdub17m4BLpvA=;
        b=xlglK4HtKwbyqts5tX8OVGFPgAY7mXL79PWTHWtYoD/qBtaCi2CcpUCEl+Rfaiqe8w
         uqoifhXnfacBUKhrQbMEgWm9PcvVLbR0zZzSC+f3fZjEvxLBOEoAKcg4TIIcUuwV1qQj
         o7ujvGheogaNKQ0CS/ZatunLYJ2ritzTclR+5+Vdfiptu40AOxIe4huxA3sC7rPXnq2A
         DbSNGM9MUaiEXgT6dYj3KoOa+gJLH6GvWzyD0dq8YTFmP5uKTLssPpIhEutY0KO2ctB2
         46EIi1szra11VwoDWbuZrXvNjquKJZ3mJBlmRnonKhi24mwqlvzjw9dhu9O+2mMRE19d
         vAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994130; x=1787598930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AIiElFGXP+TJuv/wEXsiRAFNhkPhkbHdub17m4BLpvA=;
        b=chJAOrQDvYQnR09ty40htZX42tYTh/t1ho31Jy5IpQYzqcSePO5kuRldv9BUBMPcUe
         sZxig+fPGgcj++R3L/16u9E0QFx0mHQa9nBsezvEEtVn1IQicD7lwkJ+RGK+aJMmzhpV
         RAhxrwbc+HZsvJfz/s1AZFH7WF+hMEj0kI48WCjpzg1NPzv8+lVHksC+Hw+2KXEymTEE
         MlRS4wD/8f/w8+M+WEnABURn+LEFa1+ga9WlSHH0JIlcSCl1nAtXnyXZ7JRjvWzsrG5M
         v0sMFFpofkMNoAA2R+LMLJ3nI4sv77KUgPA1WUtzjTxkEN0DjaUCzqYOz2kLxrK26gd7
         1MzA==
X-Gm-Message-State: AOJu0Yzd38Sb45BnttdSO6WOTqcivo1aE1vEKnpDKOLYRMx6bdLKxt01
	jepHXMS/eX9fHEuJtlaaHB2mhWrrUP5XBTLXCslOVW2JM6ZSdZKEI0w6q4L5zcEDZYjhhLERXnD
	6bU0CMIhuyChbhBMA5B9Z0HExAZ6w4JDtXfYAxHMWjiu4o4Q9gyqBUXeJ8S8=
X-Gm-Gg: AR+sD13UQhtVO0Kf+0bZHAKe85jiH2BJnv5Wt3sbdAIH9VGHG8Ip9tiip3GWGEdDPzX
	Vom5E36RMUOudZeypjgmx0O8MAbTflvKxMvI6NKAr/KvQXy5/YPmZHrVrXv4N5lH7adYyxefjBK
	adWVzjqkfOM/WQfE1kKl1NXH1EJX3V2sR8yo8K7rrIMB/DF0446CIfAsQdZdVJPLVpUr4sbsCx+
	LD4ncvXWFpURZ3koZjfFoXlju19MTawkD4fdf41IuVRWbGOPmeO/7pbPVDbViixth9MNClDrxiF
	68YPsygDIijGNVi45bPECzHCCKjxg88f9A03TuYIkalRxFs9tr5nrodyREGKKvxQuWxWJgEfzZC
	wmjuofQvW
X-Received: by 2002:a05:620a:480e:b0:915:e9c3:f1a0 with SMTP id af79cd13be357-936d22840f5mr2649155585a.12.1786994130023;
        Mon, 17 Aug 2026 12:15:30 -0700 (PDT)
X-Received: by 2002:a05:620a:480e:b0:915:e9c3:f1a0 with SMTP id af79cd13be357-936d22840f5mr2649148185a.12.1786994129555;
        Mon, 17 Aug 2026 12:15:29 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:28 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:20 -0400
Subject: [PATCH v4 04/10] ceph: convert
 ceph_wait_until_current_writes_complete() to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-4-0e5e53d47eb0@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=1518;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=CtACIxblCkTU4GIVsMywndtlFj4/darbY31uUhcppE0=;
 b=nIMGKfsxXx6M6GzoWM4iYtnVdPx9NR0aDw+bCSaFBNWhD63LVG3atj+/qqu8/Yz6tEBDnGsoN
 1ecdxtRxUCeCpDtJIU1agCfCHEGVsNVlqr48rrktcXV72oraquBe8/y
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX5HBTYmATyyzP
 CSFCfyCMUQp15e166AVk9QCf0RZFGIiqshNu79heMk5ctRrLb4Hiwn14UxsqeE7NRlO69x2x06V
 gtOO17eGh2FzsyJISKcg+q0CQstUwdkwVA77AIbHveZlYy5i9n7D
X-Proofpoint-ORIG-GUID: YFi0lxmzPn9ANF5Eo3H0sZmSfL8khVKt
X-Proofpoint-GUID: YFi0lxmzPn9ANF5Eo3H0sZmSfL8khVKt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX9HHtuK53+xXq
 bC3kYpZmMY41DZkK1qKV0G7HakqeTBUBAvcDlJb8EhJM8tlYX5Y8ChWkzAObmBuVoMc/hIk67eh
 chvKAerd7jmQ01YVhzoyCps93VF0gXX5c32I+BPe0RjPX5O5w6IJwhUdnBPK80FgrS0jOZrugLQ
 gXziJt0J2dJ7IIa1ocKPeGRSN8/h16KTv1DYFq5ufxT7b0LaPKeg9QifpGzE1IvRuwijiVo/Fng
 iT288MdvE4ZchzKU9x7fPpJClBbMb2VIPMFkcburpwESg9w7F8jiZ1rwELTgXiqfe0aDj7Do3aV
 mWGS2J15PQUY1prFNxo72eFAlpdMAcm3pBr6m2NS9VpVxFHZC7L9bXW7q8cmcVM2envTQWCFFnH
 Hak0jkkSs8uYnPSVEiVsIUNAPujmWw9257XdYCGRPJARQ+4TfGF3gz6p7vUBfbe5tUgJsLF57E0
 O0TEYvboT6+e/ATRZwQ==
X-Authority-Analysis: v=2.4 cv=C+vZDwP+ c=1 sm=1 tr=0 ts=6a835dd2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=JfrnYn6hAAAA:8 a=oBeIbaJldBQvbLH65vwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=10 impostorscore=10
 priorityscore=1501 phishscore=0 bulkscore=10 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

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
index 60955060dd1b..5efc8c7c91df 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1648,7 +1648,7 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
 					     struct writeback_control *wbc,
 					     struct ceph_writeback_ctl *ceph_wbc)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned i, nr;
 
 	if (wbc->sync_mode != WB_SYNC_NONE &&
@@ -1663,10 +1663,10 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
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

