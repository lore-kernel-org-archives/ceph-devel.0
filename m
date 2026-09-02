Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0444AA1C4
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365511; cv=none; b=pmhysq1Ckc8fFQAjl8tmEQynE1gh/LTDkxatBwzekvCXdceIp+Dyk5Py9Y+bY4vvtVVXGFRfMDUwYl/UEG3NNO4vIISa4siABYSZkzUZtzYsAUcbkpufIn5mAG0g7M5PNaW9B542fA5SgLJ8cX1fsVNDsozlbvv5oWbGMgj2a5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365511; c=relaxed/simple;
	bh=s4aQr7hLLoPlSzWcET7qS2e8T5DJ7nFQ9HlOxIKnBJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+P9cE9W2DclzkwrFQXmvifG2RvCBfDtd3Arc6bSl4fxj6eG7rRUwXGMEMtrs1rjVzud/ycrp8xn1fWaBAzBF9KKzK5eWmS4cP5UEZqTYNCh2OWHsTI+szVwGJZguRvIECp37UpeTHy38t8AxPzN1ohdnm9dhg0aDUHO5g2rhx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=i5Yf6md5; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=byN1UxxQ; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="i5Yf6md5";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="byN1UxxQ"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682FPZqt521942
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=upg4
	sAfRj9dU4KqMgi0idkP7WjgB7CavxCy4wH5wtWI=; b=i5Yf6md5vc6Io5Xqzn14
	99UX3j6Nfj8enrb5t0a7KlGACV3paz2npbUjEjA2aU+SoVIkbfddFH7ktsjEHcFl
	Ef7K0N5oFAZBQfIagHg2FyAkah9OGztQht/LwKf/p5mk5Y53mquFX37TqkyVqWAt
	kdoT206CFsbt/UiEweQ7pwjF9VQogepN9Vpps/sn8cXzZfIZaXDW+TE6vG4kdUao
	Jq0PQ41FOiju5/uW6imHsIRXjYfeI2yp1tmL4ZHDeXzOK+3Upf5hnqblWM9XQdX0
	p2r1LScU0D32rWLW0rxiVfyVTHc9+3efYk8KDdpDPgb6YZVc7Ay6Z4z77BqrlObT
	sA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ge835myu7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:11:44 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90cc2b97f8fso20998366d6.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788365504; x=1788970304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=upg4sAfRj9dU4KqMgi0idkP7WjgB7CavxCy4wH5wtWI=;
        b=byN1UxxQfzmLuZuGKP+pFfn2lRkI1ZNr805LFL43VW3FfgNtMcQYq5l3djcmMiy07C
         bCDVmsbwgVhvj+lacjvdlrEYMXQyND2hIWaRnz/WimxTQkfyI3ProdlyskPIj2l6FM66
         0AGlBBZmjWT+KPSkKz7694VN3jADiEY1O8jeeRgpx1L6qfpRPMoo38WLS6IIULglutrK
         9IVM/fESj5pXh8gl+h+PaLN45SK9WArPqI9q0UM4njHy5cZNziZ1g9lrcT715wZ6Mk5H
         k3TdI9195VKCLIQyU0UnJ8G0rySC1YEDZJj547//Q0y4dZe+QvPylJY3EI/055Nl4sqD
         4NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365504; x=1788970304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=upg4sAfRj9dU4KqMgi0idkP7WjgB7CavxCy4wH5wtWI=;
        b=icehfL3JCVS9X+pSTJtCmfvoD3wN2YDDTQGuo7pkH990M0jOQ8hvlGlUJDmgNkNImk
         +fT/Jh0fe+C3JzH/S0VjD6Oc/jIg8rh0Y8uQS/aKnJjd26s7PSjh9Vqr5telsTrGKhq1
         Lp2ez+LBhMkVI9zaN7AfT1iBMXE3Hib3NDEy9z/e3hRxOEHtu04jj2U0dwKvJbw+bIV3
         1BwrtrHKUb1dXfAxn6S9+S+sMs2JPFdJM2mbvvdxaAyC8+Ojb+3wDTMe5+djzA5OSHyB
         8ZuUAynHuHcimN6PRgi+b/nDABwHhM5/XfL9poO5GuUxh9eS1GrxMUOIClpk3rh/JAsw
         OMOQ==
X-Gm-Message-State: AFuF++lNTFGxI/S+n7lzujtn2qCGSBo4VgJHquorB6dqcv8iP7O4lAKf
	phmG+kYXVxktVEAE3lPW8zNp7I5fhBKHnUs/+uggogf3EWdTlG5PsJgqKBQsZDloJO1+4Xjy4V5
	kxkhq2hw4ey3KSgBCNsJ2VcL0JoUpf4Owm6tnyDENolII1P2DklB5cADgS9g=
X-Gm-Gg: AYBFou1ZytxVZ3n9ZMT5lPk++919M/IqZYMEO1eYv7dKImvG4ezqpByuD+ZbMB6P6JY
	B3hZvBJ4nyrmToOLlfZtqP4v8C6yq1NybOZ29pRbvAYotJROhMFWafaocmebe04qivwAqPHnUx3
	+kTLLU99rs4XbZdXZ550cB/IHncpz+U0bNPgX6urtmpXlQ4Cm41ptz/BJ5xn2zAEII3tWQu9FyI
	hxP8iYCOLjihkYUC8SbuoVHqhoTz+jvE7FIvGK/Cu+DHyiwCcLJsgp2VSuP9kDTCQR7Iyju1vVD
	p+x+SdWAKOKD2R2V/C4TCc29dfArTMvCmgz7sBhLuuXRbvxs1OMhpsX5JFOfQtmM3x0mSuQE2wN
	8gKZTXu9SbhRcULK+1CveVklnU1osCybm+Zs7Jr5x64dsYG1aoG0OyQ==
X-Received: by 2002:a05:6214:d64:b0:90e:8356:9bd8 with SMTP id 6a1803df08f44-90e9f238884mr82314546d6.11.1788365504346;
        Wed, 02 Sep 2026 09:11:44 -0700 (PDT)
X-Received: by 2002:a05:6214:d64:b0:90e:8356:9bd8 with SMTP id 6a1803df08f44-90e9f238884mr82313856d6.11.1788365503812;
        Wed, 02 Sep 2026 09:11:43 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec7608sm21172636d6.26.2026.09.02.09.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:43 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:11:30 -0400
Subject: [PATCH v5 06/10] ceph: convert ceph_submit_write() to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-remove-wait-on-page-writeback-v5-6-0b512e77e75b@columbia.edu>
References: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
In-Reply-To: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788365497; l=5038;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=s4aQr7hLLoPlSzWcET7qS2e8T5DJ7nFQ9HlOxIKnBJw=;
 b=AFrZBahtMjgmqG9lVd7/Tv8Z3B9eVyzMxdg0iDwqVokx0dHe8n/F0oGPBclpyyMb/MtxC4b2x
 3e9knfiCSjYBxejaJWbZ2BoofoAMIPpleibPyjPP3Z75opqcgbn1lQv
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfXwnfVWyybpids
 0ZTJtWst0DrZR9mLjDXtxRysDEjj+ZQhduNAWvgOIBa9g9197gY5w1czKviWmZ5M42phVxuHVfR
 HtP/Ds4QOZ4WI8HnwcBCIL3Rzl8kphahKeJ8wSep3zPK3peP1hAi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfXxs01TVomWpxP
 CcU2Qa3gg920Qunk7x0VURK/k/Pm1t3dvK0QmYpbn5IPSrZmk9tmQQdDkuRQ9crJb4gLh/NTOO5
 e57Qgd0vlUix8Svo5KRpU38L2ay+noD2nasfjm7AepJ8DtUQgFagO+wJToMNbEysE75thMkkOzV
 DVirbhr9MHdlG2gpPdJ4ufFQf5wlKD00p3QLpH+9ZllH+5Z6MBasdd3RI1pzgZxgy4HpPRoHSs7
 0QR6YUH1TVbAAg/pudGJj1sj6KYcgM/oQs3IFBJXLspHmVcfxCdXYAyMgnwGhkJvcvbkokVlZ1z
 WhHuyuWm/uw3cDmWKCpcx/9bBPVx31Wt5CxCISIyPgQw6VxEKCefBb/I8b6//HNYSYJbd9Mt/Ho
 +gfKS/Nd47QISkQL6GPXoTsiUKc69K1pw18tnKIF0gqFTvocdvSF5skjETJclP7W1eFm9YM71L3
 eCQvDK+P4aZjkuDKAFQ==
X-Authority-Analysis: v=2.4 cv=H+LrBeYi c=1 sm=1 tr=0 ts=6a984ac1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=RfODlEta0-z8xtihUo8A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: st5Kr-CVs2iCiNTP5Oy4rCJNig5K4ob9
X-Proofpoint-GUID: st5Kr-CVs2iCiNTP5Oy4rCJNig5K4ob9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=10 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=10 bulkscore=10 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020143

Convert the request assembly loop and error path in ceph_submit_write()
to folios. This drops ceph's uses of the set_page_writeback(),
redirty_page_for_writepage(), and unlock_page() compatibility wrappers
in the writeback submission path.

Add ceph_folio_start_fscache(), a folio counterpart of
ceph_set_page_fscache(). The remaining caller of the latter in
write_folio_nounlock() will be converted separately.

In total, this removes eight calls to compound_head() hidden in the
page-based APIs and one explicit page_folio() call in
ceph_undo_wrbuffer_claim()'s caller, while adding four explicit
page_folio() calls.

Note that get_writepages_data_length() must still be passed the
possibly-bounce folio, not the unwrapped pagecache folio, as it checks
fscrypt_is_bounce_folio() to round encrypted lengths up to the fscrypt
block size.

No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a72efe96e1f8..b0deff481d95 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -558,6 +558,11 @@ const struct netfs_request_ops ceph_netfs_ops = {
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
@@ -585,6 +590,10 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
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
@@ -1467,14 +1476,14 @@ int ceph_submit_write(struct address_space *mapping,
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
@@ -1498,14 +1507,14 @@ int ceph_submit_write(struct address_space *mapping,
 		BUG_ON(IS_ERR(req));
 	}
 
-	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
-	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
+	folio = page_folio(ceph_wbc->pages[ceph_wbc->locked_pages - 1]);
+	BUG_ON(len < ceph_fscrypt_folio_offset(folio) + folio_size(folio) - offset);
 
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
 		for (i = 0; i < ceph_wbc->locked_pages; i++) {
-			page = ceph_wbc->pages[i];
-			if (fscrypt_is_bounce_page(page)) {
-				page = fscrypt_pagecache_page(page);
+			folio = page_folio(ceph_wbc->pages[i]);
+			if (fscrypt_is_bounce_folio(folio)) {
+				folio = fscrypt_pagecache_folio(folio);
 				fscrypt_free_bounce_page(ceph_wbc->pages[i]);
 			}
 
@@ -1513,10 +1522,10 @@ int ceph_submit_write(struct address_space *mapping,
 			    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
 				fsc->write_congested = false;
 
-			ceph_undo_wrbuffer_claim(inode, page_folio(page));
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
-			put_page(page);
+			ceph_undo_wrbuffer_claim(inode, folio);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 
 		if (ceph_wbc->from_pool) {
@@ -1542,8 +1551,8 @@ int ceph_submit_write(struct address_space *mapping,
 	for (i = 0; i < ceph_wbc->locked_pages; i++) {
 		u64 cur_offset;
 
-		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
-		cur_offset = page_offset(page);
+		folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
+		cur_offset = folio_pos(folio);
 
 		/*
 		 * Discontinuity in page range? Ceph can handle that by just passing
@@ -1576,12 +1585,12 @@ int ceph_submit_write(struct address_space *mapping,
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
@@ -1592,7 +1601,7 @@ int ceph_submit_write(struct address_space *mapping,
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

