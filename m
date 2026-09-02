Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC624AA00D
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365507; cv=none; b=FfcvXgfZz9LiAbQpv7cRDWiXCpL1tv1aVWq4WaLcakbqXRdWlP0I40aPEgHMiW1Zh4BYwh+a6g2irU7ugRbBlf/b1wwZG3C+HOBzw6mMW1AZpZACbPwmU4VRd2XpMfumS78GkqxTcaxbmUMyf2EJ3F4T9rHo45m6+OnZvb9GOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365507; c=relaxed/simple;
	bh=DvGJjxDjvkeBc3Pgy04HlKwc6JzK4G0xkf22NnVZUUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mH0VBQyr8WRjw1F67jTjjvFUDpHLPmECZ8RoANR9qR42E+jHuweMLvx/JO3QGHy0OxifHkTONPetzu2YQisps1i3tmH5LYTaxTwVYkcwTHYPBeePGEfbQUHIfe3Q4xaanblCU9I+AzPxWMbhx/y3NsIEYeIuJ2u1hkLFgz07+64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=osIVpJdY; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=d0er/jc6; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="osIVpJdY";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="d0er/jc6"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682FPZph697084
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=/p5I
	yxMhiyN+xECiFbmQYjs/BfmH8yfl9vXNENMvPmI=; b=osIVpJdY7TSOJgL5uTid
	qDapcPx3LmfPlnsnaeuMuhpPefBVkpoYDShjN49kB8e6RPRKA90XQYbXnz9BoEwP
	Aj7s+nar/tU2FG5kQTAH05k8EFKHO41t66JcTbelpJkFZ9tKOABZ/mwGEy+IYFqy
	XY3CC0CshYfBB8n+aP4yGjZLTTcrhZiPfXqXOrCe7xxdvqIFX+R3fXqjrKN6gJWF
	LKUwaYF9zVGNCa5mFyCoRHMqSYveBVp5dVjqOpXLC4XJ9hmVrB+vFWU+Uxk5HIk2
	MExlaR9iBeGbVTSn1yy4OS39YriYoS7YAb7LSzzoqriJEL+eZ6+Zkahh1VpTj/yB
	Lg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4geayx43h0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:11:42 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c01ff996dso5162311cf.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788365501; x=1788970301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/p5IyxMhiyN+xECiFbmQYjs/BfmH8yfl9vXNENMvPmI=;
        b=d0er/jc6pkv8KVAbSYPhWymiw0sEcXzykrHGuSmOHB0I4a5xNsZKajFwX+7nIXu8Xn
         4B8yQviUjm2NOxt1lYHfP3vjulJQSayrtpVAswW4h6YubnJRlmiH/7zBs4id5S2sgnWk
         /9MlfJip6omgV5nVudnCSsZBjRmRLgulX6oudJ9wDWBoun7SHk0bpQvwT0xGHoJo4SY4
         aLdWFTy+JFw8wARrd9Qbyn/uX7X4xlW7be/8rWSJdw2ADj/5T+mDPYFicaIMjhudL4UF
         Ti/jHWX35bBB3yO7yqoOZE82DCPeq3s/Ycw6rPluE6L24VsAA8PvIJ0Z74sNkbujCWUO
         R9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365501; x=1788970301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/p5IyxMhiyN+xECiFbmQYjs/BfmH8yfl9vXNENMvPmI=;
        b=M+dbcoe0vTDSh2wvqorl3xcr0cUiiiztD1ER3HpIpZo6MLH506LF52B/EGOUh5hfvn
         joqr7sGFfkHkTncr779NB05nEU+DhEGM9+ebK2gunP2g1v9Y0fLNfQsFxZaJQuq1+wF3
         gdD9VmBMmYF3bShUjlTWHjVjZH+i1yZWFQsuWljMiKkdQRkvEZT3x0RTWqCMwRBe7CxU
         ufnx7t9Y2hpZZTJq2LZ+fnBX4WWu8oI9f4GNzWkYlNGnj9h8uGlDW1pIJhgsqowgaD5J
         nopw6rYQ6SAyRNJLxJfUMjbcpfytqME10lUAMlaS3ktIjx7rJfQT62orkYsTaoG+slRn
         U3QA==
X-Gm-Message-State: AFuF++nu6JfMAJlSTuYnjz6ZvDwEamClZGio/pS3XPMhxVzlTb758zW8
	UPufiN+nTu2T7ZylC0U+NpH/nR2peRSuAU+p9aIDLJe+Nf8pWjhX82PHcikvt0lNu1HaPM6PNZ8
	nBRsrwWDYEWsG+4iklp++DRQfoZRAxHWJLHnZ46C1o9OMjpkccEqouL/CVcs=
X-Gm-Gg: AR+sD10PlLzD0f84nQBCYbXKinMOCBVAl2l12OBAvmDpJJRPPw6KHSnxNBU0CgRGl5V
	oCKLro+4BzxXR4Oz7RBLWV+0NnbKMtzbRUiiHpohhNAJPGxloth+Oj4s7x9jAWQlLWrX2D/B5X9
	dblbBLGa0AhU8LXEclWKV3VON+uFTATim/UPKcEklSF5pw7W9KE0XwYkw+dmePmSrUyOfkzqyiF
	t71yYrxytr8DjrMIZHwpTaTS67tYQmayUD5DqnXU/GVdTvLM3faamQvqJZlc82qnBzglEJNvutx
	C5qyhSe3J0Ws/qgRj0i/Sjd52J3EJZVE41k8KqupIJE6UZ5MF0nlsOv6mjTC2jqNuErHjdb/f6P
	gHFGmD6RUAdOB4ILFINlR+JU+/YJMHKxf5PAGKlUXAv/XgMgcu2rdsg==
X-Received: by 2002:a05:622a:2d2:b0:52f:bd64:c147 with SMTP id d75a77b69052e-53036b90e86mr59636291cf.8.1788365501311;
        Wed, 02 Sep 2026 09:11:41 -0700 (PDT)
X-Received: by 2002:a05:622a:2d2:b0:52f:bd64:c147 with SMTP id d75a77b69052e-53036b90e86mr59635491cf.8.1788365500817;
        Wed, 02 Sep 2026 09:11:40 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec7608sm21172636d6.26.2026.09.02.09.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:40 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:11:27 -0400
Subject: [PATCH v5 03/10] ceph: add ceph_folio_snap_context()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-remove-wait-on-page-writeback-v5-3-0b512e77e75b@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788365497; l=2021;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=DvGJjxDjvkeBc3Pgy04HlKwc6JzK4G0xkf22NnVZUUs=;
 b=YHFkn3aeu/zB2unSDs4R+gKwkgS/GLUjgJlDh8UQiLxktU0qaRlg4TlbyZIriHKTjERxntSWs
 6j3gwCcidlZCq72wPNJ0ZKsXx3LWhN0DbW0DHbXWLcgbtEffoYM1QTC
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfXxCvdXyu5EX/X
 Fadjp8UGn2rJ7nwvoWrtBELx8uSpYXBycceBY0mbGQW5Norfy95R1Hwe8BAGDaW6Ety6ElX/OoQ
 kzkC8NoT0c9KdsG/O8V2iLvFQNMWX8clY+qnRXW8JravZjXpsq9Oxo/SSF9/VoEwCSzzozh/8oN
 k8ucZs3hrmqTNgFHARpKadzE9U8Mbkp2gJs0mTj3aZZEeHH6DFs1Js/4wjXI7bUl7EqV54Bovi/
 XoUSU1+5uMOFPAtyJ668nbGZ2E+h4eOPOA6Gi7jvrMqTaRqFgUK/K+P4p6mYYY3yoTFP2ptqM2g
 bSi10FTJGJmnInyHDj9SR2VxKQfqBB76PundIh3goqN2UNXACnhepqyCCWqO51+8f6pshfOaQJj
 g5Xa3lZWVZ9qlby71Rsgt6N+UdbKmiHPHTk483g6QpqbcV8kZhWjJxHFTyEriVyz4JXtzEgNcYT
 vsEcw3wwgDg38gJhUsA==
X-Authority-Analysis: v=2.4 cv=M4997Sws c=1 sm=1 tr=0 ts=6a984abe cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=JfrnYn6hAAAA:8 a=Ikd4Dj_1AAAA:8 a=bg0B0yAPDd754FioS-UA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX2WspRUvyjwyN
 GIx7PQN9qo9Pd/jYepMOPmMRXIXn6Qco9bpeAZLCokr9zvW/c9jGmukA/g8E6TVsvoXHBNOgCie
 4Od2KPhEkiEdgtO8xKOG4CcggwtCUcXDwD0vtECQBAAF48qJztwP
X-Proofpoint-GUID: x7W4mLrxQ54vhpdHL0KK9w5oPofJxxuC
X-Proofpoint-ORIG-GUID: x7W4mLrxQ54vhpdHL0KK9w5oPofJxxuC
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=10 impostorscore=10 malwarescore=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=10
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020143

Add a folio-based counterpart to page_snap_context() that reads the
snap context from folio->private directly.

Convert the three writeback paths that passed &folio->page to
page_snap_context() to ceph_folio_snap_context(), removing three
open-coded folio-to-page conversions. No functional change.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 5452e73ae11b..2fd3d6d0ffa8 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -75,6 +75,12 @@ static inline struct ceph_snap_context *page_snap_context(struct page *page)
 	return NULL;
 }
 
+static inline
+struct ceph_snap_context *ceph_folio_snap_context(const struct folio *folio)
+{
+	return folio->private;
+}
+
 /*
  * Dirty a page.  Optimistically adjust accounting, on the assumption
  * that we won't race with invalidate.  If we do, readjust.
@@ -763,7 +769,7 @@ static int write_folio_nounlock(struct folio *folio,
 		return -EIO;
 
 	/* verify this is a writeable snap context */
-	snapc = page_snap_context(&folio->page);
+	snapc = ceph_folio_snap_context(folio);
 	if (!snapc) {
 		doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
 		      folio);
@@ -1192,7 +1198,7 @@ int ceph_check_page_before_write(struct address_space *mapping,
 	}
 
 	/* only if matching snap context */
-	pgsnapc = page_snap_context(&folio->page);
+	pgsnapc = ceph_folio_snap_context(folio);
 	if (pgsnapc != ceph_wbc->snapc) {
 		doutc(cl, "folio snapc %p %lld != oldest %p %lld\n",
 		      pgsnapc, pgsnapc->seq,
@@ -1863,7 +1869,7 @@ ceph_find_incompatible(struct folio *folio)
 
 		folio_wait_writeback(folio);
 
-		snapc = page_snap_context(&folio->page);
+		snapc = ceph_folio_snap_context(folio);
 		if (!snapc || snapc == ci->i_head_snapc)
 			break;
 

-- 
2.39.5

