Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEC472092
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366938; cv=none; b=tCqFuhq9mU7qrqPwBLhu5JFiOnu8fWTKtxnLOaD+oHTw5ajX4l372UflsVIzJYzJweYNE4enVlkd00xj1MDvAfU/V3uhXTjCGPCwM23g16qTeOj5DvEaexkcXEwvAPElYQOmeVqPFDEjBcz0CrGTvw8kGJFg4O2vtWWyYT2LFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366938; c=relaxed/simple;
	bh=FKNO/gpmAVt+VDw7el0xjVHLO1MIiNJKgMXIKJGAeK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZLftCVpBYvxx0YBp8sk9RKBWwqXGw4irdpDNSSAE6fe7YwZVE9em9axHGNh/31zK7a43BUITDWlouCZvQ8wMqJMYhgjRKw4kBHO6gOiOyHQhNekihoLRE1GIfBKY3BH5boxONNovRhc8JOfpcvzVBxnNSMYNBwdaVc6xStkeR8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=G5/2Wf4s; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=qb7LErgT; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="G5/2Wf4s";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="qb7LErgT"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682GYv8k1055261
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=GTwc
	o3hmUZRwt41gI95cTAhbEEbMLzY1+oJYH554KZY=; b=G5/2Wf4sfp+nLTaNfhyM
	eBhy3vvGhz0z/aOeesEV+cXgTaYY/dPfKNC5976Fv/yCx9tBoPkSGMQkL3okQRjL
	YpNdGmhtdcRuRJIDUxVbVmxv7LRebB+RnpSvecGQQ1W4ovsfT1s+X/bNb1r0gQS7
	LaQn2KtYb/4YgT7pPhdTNOrkjsIqs7BSMfrohCjjBmnHKMtlQR+Pc3xPupHOSK7Z
	DuL/TcRiUo2N1Doid8IeSiTd54xbCQ6u8tetgtX3G0cLpy6eMJVQNGrU4UGrKrrl
	sq5Ak44RosC3uOZNR9Veo+4YlE6AmfBDjbX1XVzaK4MCShJcLRREoRA7q3qzN2qB
	Vw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gegv7u6ya-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:35:34 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90ceabcd64aso27020566d6.3
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788366934; x=1788971734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GTwco3hmUZRwt41gI95cTAhbEEbMLzY1+oJYH554KZY=;
        b=qb7LErgTIcfjnQpOt4yLwju3QOP6e8f/XVxjAvvKGuDbhvweGUbO0chLdh9FK8jK2z
         5wBdS0+DPzrCrKziBAl72b/9XqEf7Xpl86u4VVx9aPQCj6nOXL/XVu753Vf9AtRVTUBO
         thzjLLCogQu/CbZtJue09ypGp5HpDY+bMNLXXEdVcO0Vvpqn06nkvWK+j0t6GdAjRYqm
         SmQ+bFpywsN2y64DIHFZh4dR2Q/E4ga2ozFAhxUQJMO5DwcEk/y3nHDM+Jxby12gaBYt
         Rv+VANZ3RHCvGCf5NIW2vk1xrKCqM5pgSQ7lHXDhJhpb7zQgxwi8xXkfvGzuWrMpaV+t
         rdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366934; x=1788971734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTwco3hmUZRwt41gI95cTAhbEEbMLzY1+oJYH554KZY=;
        b=c6U5vsaSHKlmJZ1o4HbyWqBsDu/oA8CKoZHMyjhfxoQaHjulvhPboq7s2NOhVKb0cu
         O9A8m3eEYZyuMxQMMUpKKvs0PddZ9Ix1KOxYhKr59nb/WhKXIH/hAwpapUKL/+wJXfKm
         1ODnXzOOH6DyNGPEz6rWkvZm1gNKbmQFvyEkvs0o4GRxXfJrdIO1Bdxq7trkJvWcdWdv
         GmqAwIopyLkLdXp+xkyjYtCBQUlPFnF8Y3VpcfVsliUkVGkXdITnU/ATYfXpDVdgF2Do
         mUfb6izq5Tdn0B5yodR7cCDt42Brt49us30r9Jbm7urpyf/S3xkC3G51JazNnyjz082Q
         wBDQ==
X-Forwarded-Encrypted: i=1; AKwUvByvSqHgF/DPZdZ4Nfg6rT7VLkKZ/AL500ks6r+b7L4jJVoHKVrNu6czmvf8c1EynxK3UdlcJxnCndFk@vger.kernel.org
X-Gm-Message-State: AFuF++mh8fEBvMf0JZYxRDoFcAWpoCYO9uLaotkSSt4CHkUG1jVcpZAm
	0jFy1J50Its4LH36K2UOTqKp3QQbEP3GhXJdNMd31KOnKO/BMnvoLB1+2YOSD/W0yyntnH6T/K2
	h9x4/KuTqxBDBxa0l4W6zibhnANStp5ox8UxT3UIcnN37RNy26lBeo70fQOA=
X-Gm-Gg: AYBFou35916osCnOJoBTC9RqzNv5DNqTApaqUdsyFKjWYlbyOVRL4QnZaGTvqbntles
	alvzNo35ecVVW81H0Tu48eAbrJMzn3ilzr1jpPusgmzzQAnBGQJdwkQ3QAMGeisGeAQZp95CEmT
	Ft6CbdQpaoG4OIlUKz+UuCGIJq0AsU22dGriNnKIoWP4CwI4Gl4HQwKJUvg93C7+HZojIUQwlgx
	1N4FVHZmrMPM9MqtLTdynuta7SCDpfDpzdtgP0Gu59ypHVF7quLnPFtF68AhK0Rtk8Gi/UEhYJX
	i8da8FeiU5D5DQvARe2da4U9STePFr7AenBVoNCU4P1iUxDfLHlBa4HXqO2m+IWRnMJoZ1rMCxT
	XMPHVNXK6SwTf6DA7h7fASzr0e7NmN7PKKpZcD/uRD68yGyqZq10Tlg==
X-Received: by 2002:a05:6214:3d9b:b0:90e:98b2:f594 with SMTP id 6a1803df08f44-90eca37a1eamr95960476d6.17.1788366934279;
        Wed, 02 Sep 2026 09:35:34 -0700 (PDT)
X-Received: by 2002:a05:6214:3d9b:b0:90e:98b2:f594 with SMTP id 6a1803df08f44-90eca37a1eamr95959726d6.17.1788366933830;
        Wed, 02 Sep 2026 09:35:33 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eef5067sm21805726d6.34.2026.09.02.09.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:35:33 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:35:10 -0400
Subject: [PATCH v2 4/5] ceph: convert ceph_fill_inline_data() to take a
 folio
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ceph-inline-folio-v2-4-6c9098112352@columbia.edu>
References: <20260902-ceph-inline-folio-v2-0-6c9098112352@columbia.edu>
In-Reply-To: <20260902-ceph-inline-folio-v2-0-6c9098112352@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubli@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788366929; l=4383;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=FKNO/gpmAVt+VDw7el0xjVHLO1MIiNJKgMXIKJGAeK0=;
 b=UhYWP6M6sORULWDfmLlyNcydClno0w8htjUfHIgnBlxtwz0xplWEFIk0Y1dWAVmjsUVMtbFvZ
 96nylYeIw1EALKDWJaQjsfNrU+p1lYZioTT4n8xbMfbsBVSuGzGzXdE
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: 2y14QSGSRQDghQlW-otEzCo9baPxUaf2
X-Proofpoint-GUID: 2y14QSGSRQDghQlW-otEzCo9baPxUaf2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NSBTYWx0ZWRfX60fB3H/dhlkN
 60vLv5WVFUqLF3poAWbKmAvcB8R+bGhNQ7zd//me5mCA+Kta5GyD6ejzhaIP0ck+VFBPoN175Zf
 DloRXtAqRjuYp5SvEkQzkc9Ig7bZ5mE2vXLECSqSVhATRmh/UPag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NSBTYWx0ZWRfX0gzFOyxRLaif
 GWv71W1wse2hh8vNkpY6rB7kqp6cMHhytN+7nsuIhqlHTml1lWR6B1OdY6KNMrLZTsy5r0WuJIk
 GWSWvKMXX3s/Nv4lCk0EnuMEF7FXkfrUWqFakwSZ/RGDCh+D2ZSVk2+gtqRuHOi6yoakpxxy3CR
 fzcdulQl4J+we7cG7rJi/D5k95C/Bj+tAR8D7fBax1m8By0GYp5Wzs1QpBEpqTt3LxFNIHUZ1yB
 7Cci8uvR31UGpMsYTUQAEZ/Xr3b1QsBBmcJ0aaybZQBgr4OIN1Uv12yMiY8VMIPxo1m+P2Bpi2l
 a0c2Q1dawa73+2pi34vUEOWnoW0a5VqquGuc6X+VSLGR4IfQvTqlb2N/VsBjNvtVpPbterJrbTC
 kR/n1cqvrE1BciHDDkkp9JcXRcwEJ8iN8+YbvuVzxm2bOWMCUv8s8jziugn+qxdO5nwve9R+Ckm
 qqD7uMCUzOUN5Hldu8w==
X-Authority-Analysis: v=2.4 cv=JcCMa0KV c=1 sm=1 tr=0 ts=6a985056 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=WbdBKpkgloUaICT7gCgA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 spamscore=0 suspectscore=0 adultscore=0 bulkscore=10
 malwarescore=0 clxscore=1015 phishscore=0 lowpriorityscore=10
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020145

Convert the internals to folio APIs and pass a folio in from
ceph_fill_inode(). The kmap_atomic()/memcpy() pair becomes
memcpy_to_folio(), which also flushes the dcache, so drop the explicit
flush from the folio creation path. When a locked folio is passed in,
the callers flush after filling it, so the flush in memcpy_to_folio()
is redundant there, but harmless.

This removes the last caller of find_or_create_page() in ceph and saves
six calls to compound_head(). The page_folio() call added in
ceph_fill_inode() goes away once the locked page plumbing is converted.

Remove extern from the function declaration while at it.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c  | 47 +++++++++++++++++++++--------------------------
 fs/ceph/inode.c |  3 ++-
 fs/ceph/super.h |  6 +++---
 3 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 16681133cf17..71d9f7bdb0c6 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2190,50 +2190,45 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 }
 
 #ifdef CONFIG_CEPH_FS_INLINE_DATA
-void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
+void ceph_fill_inline_data(struct inode *inode, struct folio *locked_folio,
 			   char	*data, size_t len)
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
+	struct folio *folio;
 
-	if (locked_page) {
-		page = locked_page;
+	if (locked_folio) {
+		folio = locked_folio;
 	} else {
 		if (i_size_read(inode) == 0)
 			return;
-		page = find_or_create_page(mapping, 0,
-					   mapping_gfp_constraint(mapping,
-					   ~__GFP_FS));
-		if (!page)
+		folio = __filemap_get_folio(mapping, 0,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				mapping_gfp_constraint(mapping, ~__GFP_FS));
+		if (IS_ERR(folio))
 			return;
-		if (PageUptodate(page)) {
-			unlock_page(page);
-			put_page(page);
+		if (folio_test_uptodate(folio)) {
+			folio_unlock(folio);
+			folio_put(folio);
 			return;
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx len %zu locked_page %p\n", inode,
-	      ceph_vinop(inode), len, locked_page);
+	doutc(cl, "%p %llx.%llx len %zu locked_folio %p\n", inode,
+	      ceph_vinop(inode), len, locked_folio);
 
-	if (len > 0) {
-		void *kaddr = kmap_atomic(page);
-		memcpy(kaddr, data, len);
-		kunmap_atomic(kaddr);
-	}
+	if (len > 0)
+		memcpy_to_folio(folio, 0, data, len);
 
-	if (page != locked_page) {
-		if (len < PAGE_SIZE)
-			zero_user_segment(page, len, PAGE_SIZE);
-		else
-			flush_dcache_page(page);
+	if (folio != locked_folio) {
+		if (len < folio_size(folio))
+			folio_zero_segment(folio, len, folio_size(folio));
 
 		if (len > 0)
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 }
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 209e8972287d..21d72b7667bc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1454,7 +1454,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	ceph_fscache_register_inode_cookie(inode);
 
 	if (fill_inline)
-		ceph_fill_inline_data(inode, locked_page,
+		ceph_fill_inline_data(inode,
+				      locked_page ? page_folio(locked_page) : NULL,
 				      iinfo->inline_data, iinfo->inline_len);
 
 	if (wake)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index f3d99027e193..ed750ea73d85 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1434,8 +1434,8 @@ int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invali
 
 #ifdef CONFIG_CEPH_FS_INLINE_DATA
 extern int ceph_uninline_data(struct file *file);
-extern void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
-				  char *data, size_t len);
+void ceph_fill_inline_data(struct inode *inode, struct folio *locked_folio,
+			   char *data, size_t len);
 
 static inline u64 ceph_inline_version(const struct ceph_inode_info *ci)
 {
@@ -1459,7 +1459,7 @@ static inline int ceph_uninline_data(struct file *file)
 }
 
 static inline void ceph_fill_inline_data(struct inode *inode,
-					 struct page *locked_page,
+					 struct folio *locked_folio,
 					 char *data, size_t len)
 {
 }

-- 
2.39.5

