Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAE4A2A7A
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366937; cv=none; b=SmEdBcxAjiITlXfMHq6bXFyK5FAkenPez4b62bcl29WebHoPKeKGOBYZ8KBY6fVbq2nzFx3SzddmfLYgAZ8LYuZVQwtcj+9zRKG/VB+0m9AypePGNn82bN5Rj0wTPCY3g1G4arZHFJbp+JbHLlAuWE/NewmEcRyaznZNpsyCffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366937; c=relaxed/simple;
	bh=hmGBWo2Ja+1DmxMvk/ECCTpEyX+z1ZO+8x9wdCH+pIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWoMA4+ewVMNpTOpRKqrA0FsHbAvMhhrKJwfop6cuOlylX2rrRHz4Xp6KaE6OJkBzVoxaCp5T5aGqyYZ3K6Im0ZhV2lUcXCknD/uAkbK0P4maz1f+ic5eeNZamS5XjD7JkfWvaZ1dKCZAaYhBd/ljJjrUlGascxSJPXwZCSmcVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=NYkDS3BN; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=vvnfkN3l; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="NYkDS3BN";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="vvnfkN3l"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682GYtlQ1055204
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=hlDz
	w90ku8YTgCq315wh1d+QvwDRl1pfx6TsW0Gdp+c=; b=NYkDS3BND4COhPp7LeDx
	+wVebx2RPxEBF0tdMLSSGhymNAZ9g1gX7q8ScoJ25ynUFHhWs+P/pHTkJ2ttaWJN
	ttRL9hveEPjjdTAkbpmPLKGEp4zXDml5A88c4ZSFh3zh1Kj6Ml1j0SaQTiiBdM44
	TQiIKUrf6imZMs6NccjtdJOvAJImZrGIH7k2YUwcacuwWDSDi/N88VisucEhOG6z
	n4PzwpGcIqchaYzPLEs9xQZ+RJAWASRIrj0F1shZQ18PT6PXxsT1uEAlFEp7Cykd
	H5vxTUIwbr/ECvmfYfgqDm/DhP5d5erQJpg9mBfn02on9QYatStnt8VS1yb5n02i
	Ew==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gegv7u6xp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:35:32 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90ce8ad8002so24960226d6.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788366932; x=1788971732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hlDzw90ku8YTgCq315wh1d+QvwDRl1pfx6TsW0Gdp+c=;
        b=vvnfkN3lAhfJrM8qwd0pzS31hTD+mOo5VXl3as1zoVtdVzN9Y5ATqodoMPxftJpJCk
         6HHAnon/SNMxmUbmvNKpTwqCCeqVl75IvyrSgxx7hVv5QiSGFIepzmSOokKKaMgTonro
         fIKzwRUAG9RMDlE1/T1yZ7lX49lwA1cIaywxVSIjRAfDkOd+UQFuram86lG9oKI/0AA6
         n+79eWu3zaoOUL/kc8oh5tZpOffNgZx4bvNZtyIfLa8uuCYS5igG3Hit7HEz8a/mgHxs
         3hKFSWNLfpB0fUfvQk/YW7DGanEQjd1ArxIPawPtAfrLnr961XMpuOcEBTcKw6PyaFn1
         imkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366932; x=1788971732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hlDzw90ku8YTgCq315wh1d+QvwDRl1pfx6TsW0Gdp+c=;
        b=ZJgCvTe5C/88xO7+aj3ujpkt+KUG1OaA81LCqy7ii2E7i2Lgp92LtM22NYNxZVjDeY
         VLimNf29xEZr+w3UMrOf5a1BaIcxbTINaHKf4AyGAJrrfvpcqowvCKccRhC774gMilDk
         4taSjHcePXT9FXjqGCp355gUw+0tzZA1Et/TXLd9KKzMovCSmZorAtBLwmRI2fWdD6Dt
         nTjNflrsfLueUN31RItNZX7pXTxlh6ExPqnTDt0FXbu1SL0dgG/PtspRyrnfU0i9oaWy
         oxLxzid3kHp4KPajvIQnYa9t5kq64FRodztyeD9KL8bTJdgk36x7ZgP+wEVMZV/4glej
         uZfw==
X-Forwarded-Encrypted: i=1; AKwUvBxZq1l12g2UF5bFikCNXbLUc5zcVB7GkRbn4obhrEoj9cvoTlB5H75RVaNilOx3YJFL6naFA2r2YfmR@vger.kernel.org
X-Gm-Message-State: AFuF++m75xdMbA4OuP977of68Ro4NrBebRAJiWJG0880IPptP2i2Kbjs
	gl4HZ9JIZJiRSdrNnnMSJvd3cgL4NmwbB04qauZL/sFkSG6IQ6vgQEYmeR5mO7aQPC3PFxIhVuI
	GSSqcnP2PC0QNJz4p3QqYV5c6ACCZVwH2QwQSUQuC/YR0ibOumM3dXQC4O8A=
X-Gm-Gg: AYBFou1uZIxtVkI1Kyf+BAnmMECTpUhDaKl25V+/vry03UISdfP1GheFwOwkr9B5J3g
	43x8sIRgXH3Ws9QzibaYkLic5wD5sZgg+ob7HSLePpXVvvj9ZJkY63ekLBmZstSuhQDh/AnD6AD
	O/P5j4QPYXcmqO0C2ZyURzk+60Km6Lc8OgBcZAy1bR7nEmiTYpg64rMyeA2cU0plR741GPzcr/t
	Q01DCFfeQTdtEKUveOs3ZRvAFGFQ0xWDEKBVoFK4q1vF3DueMs31KUpo8PgWiMXRXUANGJGkt1u
	Ad9mJmItUeJDhKoPr49ZlASSs5qissuGKnFmRsCNftBjdI1YUqxP5sohmCx2o32UEuNARXaEvDj
	sw3pQhEF96UDk40RamzVV+/4vO4pxZyY0a9n/iL2QFAq4Y3QA1+o1qw==
X-Received: by 2002:a05:6214:622:b0:90c:e89f:14b7 with SMTP id 6a1803df08f44-90eca405209mr77459586d6.20.1788366932309;
        Wed, 02 Sep 2026 09:35:32 -0700 (PDT)
X-Received: by 2002:a05:6214:622:b0:90c:e89f:14b7 with SMTP id 6a1803df08f44-90eca405209mr77458956d6.20.1788366931709;
        Wed, 02 Sep 2026 09:35:31 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eef5067sm21805726d6.34.2026.09.02.09.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:35:31 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:35:08 -0400
Subject: [PATCH v2 2/5] ceph: use a folio in the inline read branch of
 ceph_filemap_fault()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ceph-inline-folio-v2-2-6c9098112352@columbia.edu>
References: <20260902-ceph-inline-folio-v2-0-6c9098112352@columbia.edu>
In-Reply-To: <20260902-ceph-inline-folio-v2-0-6c9098112352@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubli@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788366929; l=1873;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=hmGBWo2Ja+1DmxMvk/ECCTpEyX+z1ZO+8x9wdCH+pIA=;
 b=5NOyPbPoxQuFMeFnDAhslokb5nNj3iLIswNGDamjAWF4PPEuAudhp1mlVAuLENAKMOSj4KUQy
 qHWWVgO48RbCIP8iii0LAVmhrmo+44w1vfT6Hl7FufNVZ/mMqgR0wM6
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: HuiuPjr0BLCcIFYX7C3ay8cTaXJDbEXF
X-Proofpoint-GUID: HuiuPjr0BLCcIFYX7C3ay8cTaXJDbEXF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NSBTYWx0ZWRfXxQ1OkkrCStca
 Yr/UDnVzFpAqoxJ/PePekFiDHaGfZHsCam8ZXeZThKialkHaaM1jykHx4MII1WDH314KU0SZKq9
 ARu1M5z898ymf1FVX/B8nlizJRs6SQhd5deurk8GPCrYzX2Rfo7V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NSBTYWx0ZWRfX8zbOezkth4Ed
 EF3jMEmhO8o3071vESyeGuLj4u8E+GY8qVtsZhGrW++993vZz2oDBOozqL57vEY1UYx4zHA7ddw
 izNDK/yMCG/GpKvSTh1ez9HBujemz7eEPNJIqUddTPi/wBzfuo5gCUZJ3U/InGWLzDq6I2ORdc0
 gdsABOoXiE9ihifqmbgbl7jEuGEqLfS/qNUakHNLG2eh34d/1UGDuyttZt9/BJXJJxTAvEnwcPf
 h3UcUaS4cKK8ax/96MEgyIVDds3IT7Ywccy4RPzjZR103g4V6nkpDRvmMxmWEL7rEfFeflfkcfQ
 gDjZl3Sr7Re0hPeR3iOec/lEak6nUnusia/2Lb/HzZyCDPWnHI6VRPsvBGeJmAjGn8Nc1IwekzW
 0BYnBUMuhG6BJv41Ixxs35xAoWSxwPkapRlALB4j/0kxeBO0yC8YfHpYbDuVSUbL3B2V8Ku1uBI
 nihOKva3XDLrg/zY+DA==
X-Authority-Analysis: v=2.4 cv=JcCMa0KV c=1 sm=1 tr=0 ts=6a985055 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=Z6_CKfthfhLzab0EPLcA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 spamscore=0 suspectscore=0 adultscore=0 bulkscore=10
 malwarescore=0 clxscore=1015 phishscore=0 lowpriorityscore=10
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020145

Convert find_or_create_page() to __filemap_get_folio(), keeping the
existing GFP constraint. Saves three calls to compound_head().

The __ceph_do_getattr() locked page plumbing is converted separately,
so pass &folio->page for now.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f8844390f88d..16681133cf17 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2047,29 +2047,30 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_SIGBUS;
 	} else {
 		struct address_space *mapping = inode->i_mapping;
-		struct page *page;
+		struct folio *folio;
 
 		filemap_invalidate_lock_shared(mapping);
-		page = find_or_create_page(mapping, 0,
+		folio = __filemap_get_folio(mapping, 0,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 				mapping_gfp_constraint(mapping, ~__GFP_FS));
-		if (!page) {
+		if (IS_ERR(folio)) {
 			ret = VM_FAULT_OOM;
 			goto out_inline;
 		}
-		err = __ceph_do_getattr(inode, page,
+		err = __ceph_do_getattr(inode, &folio->page,
 					 CEPH_STAT_CAP_INLINE_DATA, true);
 		if (err < 0 || off >= i_size_read(inode)) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			ret = vmf_error(err);
 			goto out_inline;
 		}
-		if (err < PAGE_SIZE)
-			zero_user_segment(page, err, PAGE_SIZE);
+		if (err < folio_size(folio))
+			folio_zero_segment(folio, err, folio_size(folio));
 		else
-			flush_dcache_page(page);
-		SetPageUptodate(page);
-		vmf->page = page;
+			flush_dcache_folio(folio);
+		folio_mark_uptodate(folio);
+		vmf->page = folio_page(folio, 0);
 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
 out_inline:
 		filemap_invalidate_unlock_shared(mapping);

-- 
2.39.5

