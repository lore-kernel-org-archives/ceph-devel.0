Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF118485CE6
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869563; cv=none; b=m4UH/diE6SKQP78m5EUm/6ycEmTeKCcJSQBE5NPPSqK3LhY1xKXpxL8FurPzhqRPf6SLEUrRgHCbgs3eKBg4q4F+qFJ/A02a3mEjj0YxArUMfBDByFuV9Jm6E0b0aN1mWFBFx24hV+RyR6n8YvQMI2K6JMoM8til0fQfF6T1xks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869563; c=relaxed/simple;
	bh=ot3FCX4ZCWU57RESMTwlWgtG0MyckOFVRrjXpb8SpwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=meipFVQeho3DULT5R3f0QoXNF5yvuqz6jPs0hxmfGGQTdvZKiquteZdrACxx2QCz65duDB+w6BnD2bMBCmWB2D1Wm3n4NFt/E411bJCUZV0h58ntLkMZge4oyjdwiEEdV2GPrReeKmM7iqGiG3hySYn1ON6C6328snMK4C8chXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=G78mi6xc; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="G78mi6xc"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IY6ZP2270781
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=BNbC
	kzyvx9N/XZgbSIGNDSvN3Z/YrabAYl1OWD2SP+8=; b=G78mi6xcsQXFKHaZtMTP
	7FtylFLk1t4NNKdPbdey181DbLVcoXG6IcUSOJHB2ohSG3b1W5EHxqG7QUFThdyk
	8QUB3cNlvoIBHjb2pO9Tu7vpSMIHgOazX6W01NXUOcgJezLbDoG9jxTIKDn2itoL
	1D4HNtq+zGQ5ieTFBktPA1TxjrQ6L+xc4jNstO//DjJ53lRMMtYgGhMEYSDmoBW9
	WJCEvwKsECe1Ara2ZAM26KNEwUibjEzKmwB8RbQ/R6z/MOrQr5QIxeFBOFjk7lWK
	zI13yRZ3YZto9yQtJnocn7PrEc1mBrwg/TIXkGBmBz+658N5eT9NysiCkWKKVP+0
	ZQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fugt12nna-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:39 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52769fc3f2eso1291251cf.0
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869559; x=1786474359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNbCkzyvx9N/XZgbSIGNDSvN3Z/YrabAYl1OWD2SP+8=;
        b=HDtJfQG9vnuCNBE5K4ZnxxOrOexnfb4e3g9OoNxI2XAwKQt98fcccRduuaKqrdoxnV
         CrUjs6JiDRx3OpS2GFIgaYYnEi5BIqJBbqWvNy9rC5wyq3+pc1XJmRf52ZfFoWxY0e+Z
         ZWudOS0dYOumtF2PXOXkCCPd7ARY+BfKbsLlKtFEbDmGL15gYezkR0QVQUOTyjAZo545
         n7yOl2T7p10X9UywyL3oM+4wLrqHnBC5QaJz8OKMiOKgWJVgrKfHVmWPy9ouKVLPg2Hh
         VRiMCBdIEB3G2AG4VSSlv5LHxZjA2C85MAusfRA1YaEcbtVtYwZ0ohZGqGchR20adbUT
         sV/g==
X-Gm-Message-State: AOJu0YzZdAMwNJ87hQspRR6r+yL8Di+hrbBe9oO7wgLPB2MFbjriC50c
	kLCO4s7tG/vuq3uqnMnvwydBAyHhA0wY+uUIWDS4a1QNzZRx2qwjuwOyhQGfdGVXM9IgbTPkSHb
	tvaSHWAbbejcTkPeuNpiR58PmwEBnPa2fFEBVyHlUMW9U5vZZVY3ElKwCKYk=
X-Gm-Gg: AR+sD12hlw9y2m5bB+qvGVybu2+aT9BXdvc/xu+4tzn8BB89mX/3FKzROJtXlDKv0vA
	gKJ3VGIz2Wht/qWkuuPeztFA200AFGdCWh0b6f/FUBoCKEcmd6najHQxX7DxcFl7hiJGqVxLbZj
	7B1ychLRkn4Pimrbe6aOW6okoZmAW94KXjsjyKXtrhQ8he0KA6wVCq3TuUEwMOsPsMHQ1t5IMDu
	hsdSWAaGp9BKACG5/ltUr1YSF3BJKvsZVuE1MEai1cc0CT7Mg+jpMiZOPdtKp6E+94t7bP5ugc4
	UFQDtNpHFDoq9B4ufu2QtzIyNm1VLNlTyVyGCW/FGmrzjc1TuOglQ0YRZoIUdCgRB44N5ipKrxr
	qgiRq/GjW
X-Received: by 2002:a05:622a:c7:b0:52c:cc14:ff5f with SMTP id d75a77b69052e-52ce61e5923mr11904931cf.38.1785869558974;
        Tue, 04 Aug 2026 11:52:38 -0700 (PDT)
X-Received: by 2002:a05:622a:c7:b0:52c:cc14:ff5f with SMTP id d75a77b69052e-52ce61e5923mr11904201cf.38.1785869558384;
        Tue, 04 Aug 2026 11:52:38 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:37 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:13 -0400
Subject: [PATCH v2 05/10] ceph: convert ceph_submit_write() to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-5-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=4892;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ot3FCX4ZCWU57RESMTwlWgtG0MyckOFVRrjXpb8SpwU=;
 b=G0grxSegvtpviy3zKZzUt9DT+v3NJt0MG4J+TlwxUUzGk0MBgrz1JzcFkY376tfuyfavF1yVP
 4stT/JFPkW/DHD+fGwVtZywUw2EuD32vhOm5g0FUOv0qjCb7koZ14a6
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: g7NQxDzWMu9GaeWD28c-Or2uPcH6ZdpS
X-Proofpoint-ORIG-GUID: g7NQxDzWMu9GaeWD28c-Or2uPcH6ZdpS
X-Authority-Analysis: v=2.4 cv=SOhykuvH c=1 sm=1 tr=0 ts=6a7234f7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=RfODlEta0-z8xtihUo8A:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX49bgQwIElud+
 W+IYcYj19n9Wn7qtxa37ISUcm4d1EVZGs8QGGKVJ+VRlPz5U4HM7UQe+ifhQ0dpSLU25UuAlD5f
 u1JXx+oD/HrL5CxoFIZ9TN80UWbn0B4JSVlMsr1QGdQPFusHJzbyleE6QgtxdmGg58m3PWInBEa
 mXrbnSgFj02aj2SRndQFgODNxVeaqrgIh7ryZmMQGH3nPSKttVDEVKf4bRooxLJ5iVVPjs49IRj
 2Cb7EfOmfkgDntkmt+0htMJeSAzvffJgtJoF9M/RRGlUh8L7mlEYkNftszqJLjbg1kMl3X+iClI
 xxKshHMbfGohPTaM5iUx4fBEFnqsHiVOcu9IdRZuwgcBbSnKiS6kfVKEM/iO2NwYibTQ5I5sUI8
 CZhTjc0WnVuRKUYD1RNrP6lI4J7Qs1rraP9DPYjlwLuK7pea81aVBfD9Ijn9yjGUjdBGan8XCmT
 W3tiDmwSPiHhnW7+Xeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXx0uUFJ6H6eXP
 k4siJzO+5LAoyDVM2WQbb1itsAFxlzcWVZamdQPjO2iYUjl6yPTV6+/pIMANax9ujTT81gra/3q
 OStr4bK3jHPxioJSFqDKVXz3c8D9OWscWNijjBJqYHEf3vCQoH8K
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=10 phishscore=0 lowpriorityscore=10
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152

Convert the request assembly loop and error paths in ceph_submit_write()
to folios. This drops ceph's uses of the set_page_writeback(),
redirty_page_for_writepage(), and unlock_page() compatibility wrappers
in the writeback submission path.

Add ceph_folio_start_fscache(), a folio counterpart of
ceph_set_page_fscache(). The remaining caller of the latter in
write_folio_nounlock() will be converted separately.

In total, this removes nine calls to compound_head() hidden in the
page-based APIs, while adding four explicit ones via page_folio().

Note that get_writepages_data_length() must still be passed the
possibly-bounce folio, not the unwrapped pagecache folio, as it checks
fscrypt_is_bounce_folio() to round encrypted lengths up to the fscrypt
block size.

No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c81e9da42df9..a96986c503bf 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -553,6 +553,11 @@ const struct netfs_request_ops ceph_netfs_ops = {
 };
 
 #ifdef CONFIG_CEPH_FSCACHE
+static void ceph_folio_start_fscache(struct folio *folio)
+{
+	folio_start_private_2(folio); /* [DEPRECATED] */
+}
+
 static void ceph_set_page_fscache(struct page *page)
 {
 	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
@@ -575,6 +580,10 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
 			       ceph_fscache_write_terminated, inode, true, caching);
 }
 #else
+static inline void ceph_folio_start_fscache(struct folio *folio)
+{
+}
+
 static inline void ceph_set_page_fscache(struct page *page)
 {
 }
@@ -1436,14 +1445,14 @@ int ceph_submit_write(struct address_space *mapping,
 	struct ceph_client *cl = fsc->client;
 	struct ceph_vino vino = ceph_vino(inode);
 	struct ceph_osd_request *req = NULL;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	bool caching = ceph_is_cache_enabled(inode);
 	u64 offset;
 	u64 len;
 	unsigned i;
 
 new_request:
-	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
+	offset = ceph_fscrypt_folio_offset(page_folio(ceph_wbc->pages[0]));
 	len = ceph_wbc->wsize;
 
 	req = ceph_osdc_new_request(&fsc->client->osdc,
@@ -1467,29 +1476,28 @@ int ceph_submit_write(struct address_space *mapping,
 		BUG_ON(IS_ERR(req));
 	}
 
-	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
-	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
+	folio = page_folio(ceph_wbc->pages[ceph_wbc->locked_pages - 1]);
+	BUG_ON(len < ceph_fscrypt_folio_offset(folio) + folio_size(folio) - offset);
 
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
 		for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
-			struct folio *folio = ceph_wbc->fbatch.folios[i];
+			folio = ceph_wbc->fbatch.folios[i];
 
 			if (!folio)
 				continue;
 
-			page = &folio->page;
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
 		}
 
 		for (i = 0; i < ceph_wbc->locked_pages; i++) {
-			page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
+			folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
 
-			if (!page)
+			if (!folio)
 				continue;
 
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
 		}
 
 		ceph_osdc_put_request(req);
@@ -1506,8 +1514,8 @@ int ceph_submit_write(struct address_space *mapping,
 	for (i = 0; i < ceph_wbc->locked_pages; i++) {
 		u64 cur_offset;
 
-		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
-		cur_offset = page_offset(page);
+		folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
+		cur_offset = folio_pos(folio);
 
 		/*
 		 * Discontinuity in page range? Ceph can handle that by just passing
@@ -1540,12 +1548,12 @@ int ceph_submit_write(struct address_space *mapping,
 			ceph_wbc->op_idx++;
 		}
 
-		set_page_writeback(page);
+		folio_start_writeback(folio);
 
 		if (caching)
-			ceph_set_page_fscache(page);
+			ceph_folio_start_fscache(folio);
 
-		len += thp_size(page);
+		len += folio_size(folio);
 	}
 
 	ceph_fscache_write_to_cache(inode, offset, len, caching);
@@ -1556,7 +1564,7 @@ int ceph_submit_write(struct address_space *mapping,
 		/* writepages_finish() clears writeback pages
 		 * according to the data length, so make sure
 		 * data length covers all locked pages */
-		u64 min_len = len + 1 - thp_size(page);
+		u64 min_len = len + 1 - folio_size(folio);
 		len = get_writepages_data_length(inode,
 						 page_folio(ceph_wbc->pages[i - 1]),
 						 offset);

-- 
2.39.5

