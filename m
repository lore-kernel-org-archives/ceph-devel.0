Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564A4AA3E6
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366937; cv=none; b=KZ67ZUQblEovaW2onZSLzgXUlAjmVxUXuXDotXasINLuRn8BLYn108H8yeM/d1wY2lGvoCmjz4eborSw+I26li/cwUq0Ohnh08mjppT9pZAxGhgB4jMe717dNJYG0OhlOxByCtzeynuG5KdAuULFYwLlyQfdcNv2ocJg6klJboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366937; c=relaxed/simple;
	bh=b+4cr//KTHdtH9y3belFVKy6m9NQe1/PbGrSu+2Fbo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvocEroc1lRbWe7P1iJym1h/aQXaE6bvpVQHDXbjaUqYUd8QfU16WLcT3+Isz5wjzuC4MSbQKDN0/PhQfOYIsrmU1qOVZsErEqw0S2O6XsjzUhXUJqNoK8CvL7GhVBUFxtX8hqROpFYsgouRlzTY6cVw+kwIeVLIPWdx+OXQSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=WHiV+VVb; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=o3mrWc5Q; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="WHiV+VVb";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="o3mrWc5Q"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682GZ5ic621520
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=rGQy
	tyu+hfKlnP9ENWv2ki4cFbW5IycOKsm9AkBuG18=; b=WHiV+VVbMsaN1sFM3prF
	2Lfipm/ZvQgVmA26ooifoRsLAKxxBYY64gqpilEERsPGsFx3Q1jEsaTcuUCPaVOp
	PLXz+dp0RqaVw2xFkam2QXYVJKZn+hmP5ZYiybJqlvBvPC/O/SCePvdiz0zQZvDo
	FK3Mix6m2C2zgJPt+p2ZrXAb2jKf1g2SPvOCXrS1zeuGdJwO1VUVf3Nr1eIn6bZK
	x+h0dRBWuW7hobOQz73pTJLtykCtxf/AQbb2w7jQEOKsdlvhfe2ZVDSiCH+hzF2e
	S9Vm8hZp+3fFBCUMIx0sSPgoMsGogf1WjgSuY79SaL95XW7B9ByX5WY4A6ypqTvy
	hw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ge833w640-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:35:33 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90cddf4f59eso23954666d6.3
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788366933; x=1788971733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGQytyu+hfKlnP9ENWv2ki4cFbW5IycOKsm9AkBuG18=;
        b=o3mrWc5QS8uCQHneWoN3KQDU/PWOSp3HuD7Nk+l9A6cOFAyAeiHZ+4px4LtIPavMsE
         i05009V+7ysuMZdy3lmeVvySMU7NGhkLTO4m45lSU01qlUxnJ7MoHhcKkFPeqggrhoRn
         SPkNCCz/CByQxdYNwAE/l8CHNu7Ugro8nkv3sVph+NDh4sSVbcAvB3z3rEqjcqeVbIT8
         6A7dK0So23f3aXVlRwKBXKMrfyMkG0nIJFjIU4nDp0sQqzYjrvlyyoazoUNLIorn6x0i
         y0+cqxW+T8RGyU67CTMtkAqhBJQv6j6mG+oHrp4aHvuqT4f2FHyOQIbnYSQsw78FMEMS
         GCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788366933; x=1788971733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rGQytyu+hfKlnP9ENWv2ki4cFbW5IycOKsm9AkBuG18=;
        b=nK+CIVIfrKeCOwr7Bk2s1c7iyjDeRLVVp+bbLgjkuVGSno8tImGpXljkMvxP+krZin
         5NFZHuJVrkWuRJVd7tGELwy6nNjlHKWPnGSx2/zsS/Wcbmpn7906v5QPb7N3QIA159yt
         etX0jpw67x8eVzp4zzzYu22Ws3eKAQ6eR/nixpQS5LMgJnJTZDV6Y+XXaCf1uL3e0Fj8
         2A3OPhEZhT1jaHsPqNAQV5vOmCaS+fi4k+ZXc8WDDyklmhJSf+19Q6uVB2fsNwc50kc9
         aTK2yguguK9FAe1AEX5aOctPftdWmgiJV+pyX2WZlsYdFkRAo+YaMfTBF+4YWOeQBxtd
         Zxyg==
X-Forwarded-Encrypted: i=1; AHgh+RqE9KvJ0d14gC29VJ2NFXRL1Ocq+NiFSYdRhJfpquILC/ACgWoLlroKD6AIzizgjv4WnVpJ1CngVKBQ@vger.kernel.org
X-Gm-Message-State: AFuF++nzLCp3w3UrudGFlM2EjLaeRwXv7GmNZwGbtIihe/udVKfOu2ve
	0o7yKKfe/WcuT5S9HsaxQMTTBlSqsZBFbNHgMOv0Jw35d/L1qtYi13jQMghbsLYwl901aDxCdRt
	ssPaSK2Gbc5w0Lhf8GZzNZdWTab/UziWedLn3CbsK2XWaPCuCX8l8q4Q/COI=
X-Gm-Gg: AR+sD12zT/IUrkAsSNZEmX398VvNPa/BhEUALGjyJnfmmAjshFf1FUsoMfKPeF+yhWP
	9OjnEdOziYagfrz0fLM2djsdFQlOWSMtTK5b978yW3amR34ngzenVxOH8MMXAO9rG1+XTkH4ZPG
	LviBDWserW+J5+sndCFGwGEAbjngJEW1G7+sTRzI+OGmdSeX/NK1fEyjLxOnW1VJhZGeCDQVYyv
	Is95VCDZQ7xvCPYxHH4udSafJCqq+hD1/54LndZLWIH+qQBOvuqxMAyjFh9ty58fE0TmDXS42hI
	huCr2GbcfX4EgTAhgEmQghZaZb3s2eo2J75CWT9IanwS9XLhBOgHno4/u0FjSoyr6e82wdhMwPM
	0xq0hBmqqgb/BJ0wy+e6cL6NfI8/cwg2EImXgPV+afklNOsMNNdAugw==
X-Received: by 2002:a05:620a:450f:b0:939:13a7:70f0 with SMTP id af79cd13be357-93960ccf33dmr685802485a.5.1788366933295;
        Wed, 02 Sep 2026 09:35:33 -0700 (PDT)
X-Received: by 2002:a05:620a:450f:b0:939:13a7:70f0 with SMTP id af79cd13be357-93960ccf33dmr685796985a.5.1788366932798;
        Wed, 02 Sep 2026 09:35:32 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eef5067sm21805726d6.34.2026.09.02.09.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:35:32 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:35:09 -0400
Subject: [PATCH v2 3/5] ceph: use a folio in the READ_INLINE path of
 ceph_read_iter()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-ceph-inline-folio-v2-3-6c9098112352@columbia.edu>
References: <20260902-ceph-inline-folio-v2-0-6c9098112352@columbia.edu>
In-Reply-To: <20260902-ceph-inline-folio-v2-0-6c9098112352@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Xiubo Li <xiubli@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788366929; l=2358;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=b+4cr//KTHdtH9y3belFVKy6m9NQe1/PbGrSu+2Fbo4=;
 b=Da4oX/LTHkK/aaEoVeFCIuUv6xwKj0ErZkO66RR5jrhwVLBo76PSFr8Nt+lRCyVKoSunh5Zbc
 flwmJOJQx1nCHwdg1mH7hy6hbdsSxTFXhNTaACXoSFU6CufxJYJTZAc
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: -6A6KGcF3XUw7vsrbze3FQD1oBuxEF-Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NSBTYWx0ZWRfX4TE/5JC9vNRO
 /NYqGoOy1cxNSn1jKRDJA+kYvc8DPhLY3WizD+IE3qj10SNUpimQ+B20btqfJRNf/PSaYan2UuL
 03i+5gH62fuSC2I4XEVICcS4c0Jp8/oi40No0EXHNbIAWl0MRT+0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NSBTYWx0ZWRfXzJbja21HIeZY
 1R95KEZn3SsL3CWGtGe7lGMALl01+ZYKV+X67P00/+24XlewrkVr/FnRDrg5uXU6K4tBx+nyNDz
 ebkVrtIqUDhg6D/0teatZPVS8Kjizf+beYMSoIpU82zYyTZxjjqACLNOAusmlctqtmUP1ECjroX
 DRN3NxzVDLj4Sd+2QPv80+HGtt88GH9P4zRmg8G9djSn2tiEGb4pdttxk27YX5xqHwpQJG2Q8Dj
 bimkkU/LJyF64bvRw+wHu1qJ51ErXQ8p0uqyPntgZISRXaDbTmCPiTxLeSEP7Ldl3rbbIp/c1XQ
 hfrO6OqzofeWyaUR8Jfubyg/L7lf3YpemQPyre3+KhA9Z0umPh+p7cdX7roczNp1zTRD2CalxiM
 2/YUR4YXu1I3OPi+XsHM5IRmAjGKVM7aUvE+AK0zNIKo97VoZrB2oB1Mhfaujb0almQGnMzJ3OM
 W+yoK+WA2pVSjbOQ9Pg==
X-Authority-Analysis: v=2.4 cv=ZpPd7d7G c=1 sm=1 tr=0 ts=6a985055 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=lYjiPEibtFqA77pR:21 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10
 a=A0y_DWxS2BwA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22
 a=jHxIr1HyPKZ_Q5_91PL3:22 a=lJkK8zq6xVIZ8jstRnwA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: -6A6KGcF3XUw7vsrbze3FQD1oBuxEF-Y
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 impostorscore=10 priorityscore=1501 bulkscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020145

The inline data is read into a scratch buffer that never enters the page
cache, so allocate it with folio_alloc() instead of
__page_cache_alloc(). This drops the cpuset page spreading that
__page_cache_alloc() applies on NUMA systems, which only makes sense for
page cache pages. The temporary buffer here is better off node local.

The mismatched __free_page()/__free_pages() pair both become
folio_put(). The __ceph_do_getattr() locked page plumbing will be
converted in a later patch, so pass &folio->page for now.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d5606456dbd5..f0e77a1ab4d1 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2247,21 +2247,22 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 	if (retry_op > HAVE_RETRIED && ret >= 0) {
 		int statret;
-		struct page *page = NULL;
+		struct folio *folio = NULL;
 		loff_t i_size;
 		int mask = CEPH_STAT_CAP_SIZE;
 		if (retry_op == READ_INLINE) {
-			page = __page_cache_alloc(GFP_KERNEL);
-			if (!page)
+			folio = folio_alloc(GFP_KERNEL, 0);
+			if (!folio)
 				return -ENOMEM;
 
 			mask = CEPH_STAT_CAP_INLINE_DATA;
 		}
 
-		statret = __ceph_do_getattr(inode, page, mask, !!page);
+		statret = __ceph_do_getattr(inode, folio ? &folio->page : NULL,
+					    mask, !!folio);
 		if (statret < 0) {
-			if (page)
-				__free_page(page);
+			if (folio)
+				folio_put(folio);
 			if (statret == -ENODATA) {
 				BUG_ON(retry_op != READ_INLINE);
 				goto again;
@@ -2278,8 +2279,8 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 						   iocb->ki_pos + len);
 				end = min_t(loff_t, end, PAGE_SIZE);
 				if (statret < end)
-					zero_user_segment(page, statret, end);
-				ret = copy_page_to_iter(page,
+					folio_zero_segment(folio, statret, end);
+				ret = copy_folio_to_iter(folio,
 						iocb->ki_pos & ~PAGE_MASK,
 						end - iocb->ki_pos, to);
 				iocb->ki_pos += ret;
@@ -2292,7 +2293,7 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 				iocb->ki_pos += ret;
 				read += ret;
 			}
-			__free_pages(page, 0);
+			folio_put(folio);
 			return read;
 		}
 

-- 
2.39.5

