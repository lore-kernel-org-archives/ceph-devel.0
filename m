Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9FC3EC6AE
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994140; cv=none; b=Kv60t0b4Jt4xW9v8sqbItbhvcJBMeovpWIz2dCx6Ag4DWM8Bny51tiC3KXp+vpcAkXhHQ6kTziQobi54X6+QgsD78X+5/CxIIJrK3ClkxjsKEAdkODrGUD/ylZTOF3si4F5tYwikvAqHThEY1CqHp61uIAahZHILpb3v+rUdr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994140; c=relaxed/simple;
	bh=3Yr47TYe7cqBT8sK97KQzuLWu9tCzz5B2cD6geWhTi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kN3/wAvgv0SBWUU5cyIh/dTP7vPtr3JmFfA5EQew69wFY34rlp1ZzKxxQz96nPWiaJ91HBCwxv8o6Nt88aaOZQeG74QW149SXQ1FPCfUd6Pg4srkmtRE9ukdySKRKlXY6q4pygtSlZLTHwYM/UF/iNjAaFbNJKD501ZC4rw1tPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=lRg4L2ed; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=s4fObNcp; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="lRg4L2ed";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="s4fObNcp"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIYkW03617245
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=cv9x
	6z4kwz6bNvCwiXVm4zgaYEgf+1gg2Ey2bAsoUhc=; b=lRg4L2ed+Jsa2qHswH63
	KcodI3Hp8a4vPrVCD4k5YIU72t4hpEtRkrS4qasMfGjF3Mr4Sq0B7UE54JO9kkmS
	kAGoo3cloL+bXCOdDvpTRPS8BqjS4xLlI5o46K82KXQHVMk7yz/mkLZidYD1mqpl
	UxmIZQscOgNneKO6nlbvFMnTr3QpAEbABExwB6Pc87qYdC+VtKxYC7hUoDrSJLkd
	sXTg66q8bEllO8ycecl+3HJTG8o66q38vFjq60xj4k0l7/OFvfkiDOA6Kx4eQ1US
	6NqyJ0pzPdJgXiUEC4WwIiF8pqrxknFDhszQQI0zDGFiZo5tKCe0ZvGIq0zmZDYO
	Aw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g3kbte2q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:37 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930b571432fso27044785a.0
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994137; x=1787598937; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cv9x6z4kwz6bNvCwiXVm4zgaYEgf+1gg2Ey2bAsoUhc=;
        b=s4fObNcporOsOmyzwbnfWITzmy10mUhfEtV1auH0SSfiJo5DMSHoWISGRSUoRjLoTq
         aotGZ0ACtBr6phs9ZV36w935kdNNZosT0N1vMXDwa8+jpIoVLoo7WTRR8d93fwSghMc6
         tyintB4icStbTOt0HBkZxY0ic06wGS5GxfSTSpot6PrI2JDIbvOZsttNXLFGCHagqaxq
         YXtZtbOePZVmNkEN4NJyc6PH/btXp02HKHgIN9eHOOM3/COG8nKeE4MYtRXd9tkGw2Uq
         lZpy6bS5X6ZM7buKBOpH0T3vhw8w0ZvXHXQn3YncYmRx1DR2XlZFDuNgy0EL3bzD/O4p
         Wd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994137; x=1787598937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cv9x6z4kwz6bNvCwiXVm4zgaYEgf+1gg2Ey2bAsoUhc=;
        b=Cqysa2jz8EbBr++vmuzd7MqQzxh6DWgHQEaUl53IK/B8YTbR35kofcEPfYA3B1mt4z
         t88Bzo/xfTRjyIMeivopOm4or5uRJw3I4Pme8iJVoUWMNwf+N90EPnK4bOqD5wTALJqZ
         hWBql1eVHESq+hLeABy9fGs+bpfOU5xmAfTU6joDNVP8mHW6OsGYwq8/90eBsnUg6Yt+
         QVJzSNID2eh4n88PJyOHH37YfI1Jp9vNtp07jVUNnj2pfY5CBM5A30zzC/qBZermdqSK
         O9AvYb3CV8fp/pGQN3Bau2z+SB2Y/dejJ5Yqs/ztdOD1+t80Uqfu+YIb9Yp0j52VHxWa
         xFAg==
X-Gm-Message-State: AOJu0YzfP+qhXu0dNBWnMg6BHWSirwGvx3Csr+VNttAgaIPCqS8OdB7L
	z3xdPKXKujsS9xUXzyfV+V/+2dCep+fx7pgH1pHkGxx70Y2arXVlM4gWKq4OfaEXdYlf3kjTfFp
	eomH2w6W+x/m8UcEdMvwYgpD8vLWPZAZ6bnbL5IF8kvoISxZ96+AFOPBOiGA=
X-Gm-Gg: AR+sD13CgF9bfRR7TiTNn4M0SPxJqVfCPF74qKL+GbRB9xEN++4cMFLHY2pkgpo2ed7
	D5Z6Zn3JU67UmbK2nm/YYijmikXb+eWvDq7EunzbTQ32DQKd3mzGn5yyJFcslt3eOUyMiJt+FN9
	UQhVIu/LG6x0tROguzxl/FFBJZodaSG887t8YgpsKG75S/RkNTdQrF4g2BtQlyYe7VI8HjzQzRO
	6Bkbx4I+LJYnPzohYFXTbiwE+9YYJ0qaUelMV8hQVFM4/PLqGlKug01eDt70kW+7T6/M1w2o3Io
	nxHZ+VvyGCkZxGWEi70q9/AGvwQCkRLPPZOWSLPZr+C/hkOe2VGEAaOUA7QlgjAUwehO4oymBE0
	u1g4xRUTw
X-Received: by 2002:a05:620a:2313:10b0:92b:6e09:b0d9 with SMTP id af79cd13be357-937066cb326mr126137585a.21.1786994136505;
        Mon, 17 Aug 2026 12:15:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2313:10b0:92b:6e09:b0d9 with SMTP id af79cd13be357-937066cb326mr126132185a.21.1786994136084;
        Mon, 17 Aug 2026 12:15:36 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:35 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:22 -0400
Subject: [PATCH v4 06/10] ceph: convert ceph_submit_write() to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-6-0e5e53d47eb0@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=4837;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=3Yr47TYe7cqBT8sK97KQzuLWu9tCzz5B2cD6geWhTi4=;
 b=HevgqnjCrhv7I6rtbygRfzOdftYjeffz3QrWztwIqA4nnzsdtsyhS4Vf1/OT/2/P9RAjsOas3
 +udOFxtguS3AMtcBhXi8TgPRbonGiMlS/BouQqru1fUXtT3VoqirO/5
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: OG1BZMqKrbV1b1AYKcoi2xJrS1PTRVFt
X-Authority-Analysis: v=2.4 cv=McdcfZ/f c=1 sm=1 tr=0 ts=6a835dd9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=RfODlEta0-z8xtihUo8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX65r7Wz4c8Ec6
 oFICQjrEEWu+QcCTk7SZFx0O1h3QO0xjweXdF63Sj4zYuIXyKobHw6FsqKeO6PJH5CJMcRNyILV
 ayJWMpZhUT2MOEsimk6kJ53F3Q3u6Ym8cuEyQCXoAIjPC/ng505/
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX1V8QoGpe29cX
 ZsDKX8JKzrCfAz9Bsy/V69TH2usipG0Wgq1RlkV8sU1HkvgJ08V3ePcgOl4Y9a3Kg4gX1TZ7m0/
 UUTbUYICqV4Vyk5Bd9l67jX4PlNkDUn+uT3kPabxqY+0bXL64HOcEY+VW+n6vtgpeP48iH1+hT6
 CKMsrN97roUubho5+IzNH+EJ+ytjTeeIZEA7MkupI2fCjbBCBiYmvAVAMWAa1Fb+nvmWO6p2Bmm
 pnWvEbcrsL4RLHgi1NvhDg46AuvmWEn9RzkOZXSC41cnkf7ivsFoxpMZBpVi+Nnwpbst6IFSUeJ
 FQuKMlTCHkEjvCLAf0AvFp3z4MZESgeJFmf8CRItGJ+t3eyQiIaINw2Zna1qVjOrU6tVrgjTH3I
 sgIQyLGufgYc6r5pLAlmNL++ZcIF/uzxbOTattvJSXGl44V6qlDq9dO9XXnQZVX6vw5YQ1vXxTt
 UBZgXCrGEscseepgKqQ==
X-Proofpoint-GUID: OG1BZMqKrbV1b1AYKcoi2xJrS1PTRVFt
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=10
 lowpriorityscore=10 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

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
 fs/ceph/addr.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a34849374f65..2d89d3d51bf1 100644
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
@@ -580,6 +585,10 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
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
@@ -1458,14 +1467,14 @@ int ceph_submit_write(struct address_space *mapping,
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
@@ -1489,22 +1498,22 @@ int ceph_submit_write(struct address_space *mapping,
 		BUG_ON(IS_ERR(req));
 	}
 
-	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
-	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
+	folio = page_folio(ceph_wbc->pages[ceph_wbc->locked_pages - 1]);
+	BUG_ON(len < ceph_fscrypt_folio_offset(folio) + folio_size(folio) - offset);
 
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
 		for (i = 0; i < ceph_wbc->locked_pages; i++) {
 			fscrypt_finalize_bounce_page(&ceph_wbc->pages[i]);
-			page = ceph_wbc->pages[i];
+			folio = page_folio(ceph_wbc->pages[i]);
 
 			if (atomic_long_dec_return(&fsc->writeback_count) <
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
@@ -1530,8 +1539,8 @@ int ceph_submit_write(struct address_space *mapping,
 	for (i = 0; i < ceph_wbc->locked_pages; i++) {
 		u64 cur_offset;
 
-		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
-		cur_offset = page_offset(page);
+		folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
+		cur_offset = folio_pos(folio);
 
 		/*
 		 * Discontinuity in page range? Ceph can handle that by just passing
@@ -1564,12 +1573,12 @@ int ceph_submit_write(struct address_space *mapping,
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
@@ -1580,7 +1589,7 @@ int ceph_submit_write(struct address_space *mapping,
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

