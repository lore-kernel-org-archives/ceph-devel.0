Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D454E4A9D70
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365508; cv=none; b=jBWl8hC8mA1gOtU9ixu06ueLpLcnldlYLRzcrhUm1BqkuTVUuUIsbvLvKo5p1IMrnflvT8LxU0KiuB+sgjIieOByihRplVK2efJtCQkE8dEZW0hzmgeNhquqepdBdgi5VpK8q2G5IPArciFGholrzhvbCpLMEt36gSSb6mR5WoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365508; c=relaxed/simple;
	bh=vXDWSuDQTPW0LOvkYx1OZyCe//zjMEtG+2XJpjkTqZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYo1uOPjL033iLDXUSXoo1QYx+Yh88SJBe6c4DPdvlduHTLcIb86okf5io0anY7OOLhbAxquX1clJOl6CdZRArjqZNO/1gsKTjs/LJP5w3qeluoGDowxZ34eXQVLM1EDZUhEelL5eP/j1C50La8RmmYS/535DYFgN8A4+XijTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=pVLNu8bI; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=DCnpYdb9; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="pVLNu8bI";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="DCnpYdb9"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682FPcGu353572
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=R4v8
	n5N2hSAXM4UTei/X90YnX/8+tfva0eCUgcdDuBQ=; b=pVLNu8bIgkQ+KmC1gu1w
	BZi6DxSRL3sJywPZQ8c9IOLqzrE/mgMOXPt2oMvRIAv6EoTgaU8ZZlV/HhNQd5Ua
	3ObBlH1kp+Pkd/KS+DmBKyoC5oD3tla0W2bLzGEwdj3GX2R8xUA6n6pXMEo1BOPF
	x1GLaMV0LRpWGRywG4tPSPcyY2TGPcPMyG86/imG4VCuJMjxtVHEfBGNybdGwno/
	LzwPkBD7cQnjJ2hcFFMRDUnQak/5rMBwU+bRGeOgjiJfDoR3HfiM/PAL718/H/TS
	gUwBNO8GYan7eu+6dFTesqfkOwK/H+h8YhnUWlnA2Nu5pInwbDgDrnINkhpopEa1
	uw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ge835cxbj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:11:43 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90e98e74535so24651806d6.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788365503; x=1788970303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R4v8n5N2hSAXM4UTei/X90YnX/8+tfva0eCUgcdDuBQ=;
        b=DCnpYdb9E/m2z4+54yUbWZjE+qHxwxMf0e3Q66IjsXmp6XCuLpuD4jRvajvmn8hscI
         S0diPmhUbR5fjZq8QKK8W5H4lC0ZNjDVFoBP+RiETVi3tVJq8of9yV5x0e/uUTedfmmG
         08S33EBaADEfzmzOHa+a7/IfphmJxngZpzEdoDp8nmtgFlqXIDShUKV+n7lCl2jfQ78R
         vekEdVK8e0hufks12hcevK3CAROb8VSca0NF14kJlbej4Mj0TPD0UotACDXeoVu+TiaE
         ZLmouOOawxhLEnzF4JpwIe7caKUXuAuW+wAW9ZMBvu/kczGF7gnCHziQDIi2uPt08oLq
         8ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365503; x=1788970303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4v8n5N2hSAXM4UTei/X90YnX/8+tfva0eCUgcdDuBQ=;
        b=STXkgYg2oIgBosxnPylMrlL0LYjraOlH22ynQy6JLWtYeHEl6AHfl/qmlyQcaVveT+
         9I5Fq9yP/k2quFcdlZZTgYW+JTKg6T+ObwykU5JPrPpxY4v5Af9lqMjhKcMePIm/CwPm
         ADD5zqd9JSrFSKWjZ3RmrjgXaLEcA+4wxR9lsZtUnwbOsPjtAsA6dC/4aM04Ldz/CKW4
         wbgj3wT/Nr+ruqmhYdBs3kwFhgzgrrfDLLWbrw2R24bnbbDjFiy9zkZVGq0x5kzxxuWj
         /RLIEG10Gig5VN+Flj2+SdXn3dTbyEunSCklti/sXr98Xb9caQKNhwJkXSo1ugdjxHjY
         4uEA==
X-Gm-Message-State: AFuF++l+D8IdDcXfB5KQPQSdA9fUNSdOydoUQU/R/r1fekNqf4GHHHPN
	PIogpLmpghDGyp+9RyWUXC7yUzPNECa5TmwnQZvB2tiMZDPq3ivAx6AEgZoihQRnLl/Ct7H4C4X
	0NTlwoYbml0N+QzFSYAK7LCqth6G24sZAW8X4CjZ2O8SDjcQRKdJjBK5zicEQLqKRgd4mhg==
X-Gm-Gg: AR+sD133EaJlaFJU4B9Ta89sROMDwzAgTVNSLRQE+L3cpHS6mISP99LE4RLcZctNMCW
	X6Shc/KMLLzq01caEzfK4pbyPUdTHVZbMaTG9GhR/Sk5FgH9ZoMrTuA2ruyL1PgTTVmOy6TTBIm
	tBtUwkJywIeERm8jQ3ZbtaX2DL4wNn9mW8nUn9RySGu0Am72GCvRZCoYTAujoO81q2bdP/PQseu
	gicmUyHqJeSN8kMlAbFeqx+kWDLK6WNedilBI3QLLp0oYXYpdChWyZx3/v6RNGldlh6bMfFtEi8
	gJyPYpgLxA1T7UhWpJSCgOFs3PICKJYl4O6nQPDzyKyxsLbTYPDmKgT9TCvPxxd+TiVncEDKrB3
	7C2B/vl0+0PV5xaeG2A2UFjh//zp9Pxhvzy0HpVgX+j4dqqeNluQ3YQ==
X-Received: by 2002:a05:622a:2292:b0:52f:c0f3:fff8 with SMTP id d75a77b69052e-53036c85c1dmr75336391cf.24.1788365502714;
        Wed, 02 Sep 2026 09:11:42 -0700 (PDT)
X-Received: by 2002:a05:622a:2292:b0:52f:c0f3:fff8 with SMTP id d75a77b69052e-53036c85c1dmr75335451cf.24.1788365502092;
        Wed, 02 Sep 2026 09:11:42 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec7608sm21172636d6.26.2026.09.02.09.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:41 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:11:28 -0400
Subject: [PATCH v5 04/10] ceph: convert
 ceph_wait_until_current_writes_complete() to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-remove-wait-on-page-writeback-v5-4-0b512e77e75b@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788365497; l=1518;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=vXDWSuDQTPW0LOvkYx1OZyCe//zjMEtG+2XJpjkTqZc=;
 b=NG3QtEbbjKEIQ3qsAPvXfUpqHY/T1XZ+awxl0PX6gmy9m1aBj7joXos1cKghD4PnfMxl4Nm/w
 4MNeYkL0U9bCns9ZaN62ZcTCmH+7OQxNfp9OGNJHUJtVi4b+hWbEeEF
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX6yUS/iSlTYIv
 bAnEWBz6PhX7EqULmzB+Dh7q1JAnL1nSfwuStL5qfiSWauJqNKjJeqoDuPYMBA01KZ3Sp5KcJ7g
 gt5RgRHbPJwFKUGs48cEtYWxOXiYcabHvHNpGQV28D3L2ex6IAUC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX6EY1ybpNCenE
 /j3V8eTp+5yACjlTa3UiyiQ84UPNSlquzUKa/n8G0DEvIz3dUxIOh7AgkC8fSwb6MuQBkJzBxfQ
 gsiaoIRslQf+b7jZzROlaEwLfrPEuvMBGlxWQcNg3aJLGxhX1Go0hPBD1YWOKLzk3c1mBGq9a3q
 UDTpk8ZCyRv1GP1d89oqngZFbRHhXGS5M0bBXRn3uuF6kZ207Vp86kDPWonuSvZ75ruoeRBChxK
 VrlkhshXOUSAKCGDAUHfZZbnvdgqxM6vVZLN9NX34OVW+ZON9YMjAbGQjetOB0kcfJM7s1qwqvV
 Vi58TdYxSJ/j7oZbig7s1w+KTZHodoUqB4GHgxfSX1Mm7KuFPQd3w8KPI32sivG0wXoArTpGhrm
 twoa40C1eRg8uxaUaNo6J3gOf0fgduhkfzvuEgKHkFknArbUb4PrWYiRShkmC7EEkR4ZaNLLjoG
 Iv1uwkHaXlHwTEAgIig==
X-Authority-Analysis: v=2.4 cv=XY+5Co55 c=1 sm=1 tr=0 ts=6a984abf cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=JfrnYn6hAAAA:8 a=oBeIbaJldBQvbLH65vwA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: pm5PAJFny7OkuF0AyCobR-dgqhmdCRJ2
X-Proofpoint-GUID: pm5PAJFny7OkuF0AyCobR-dgqhmdCRJ2
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=10 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=10 lowpriorityscore=10 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020143

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
index 2fd3d6d0ffa8..5e4b9da5970b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1660,7 +1660,7 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
 					     struct writeback_control *wbc,
 					     struct ceph_writeback_ctl *ceph_wbc)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned i, nr;
 
 	if (wbc->sync_mode != WB_SYNC_NONE &&
@@ -1675,10 +1675,10 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
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

