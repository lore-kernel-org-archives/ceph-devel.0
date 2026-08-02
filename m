Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD753C3F48
	for <ceph-devel@vger.kernel.org>; Sun,  2 Aug 2026 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689619; cv=none; b=B1vaRaP+87Sq9zzHgdgSwdWvnWt/Q4vDmRxz1HU0xX0qy/aw1qVfJQ5ErHt+hpS/EhECZwd7rHEZZAFZgy+iW3G80tme03A3+x0gGt+FO/XEEbSGEZ1WpjhEKbPHWJlwDO52dqK2KwYEi9vtBwMaGgLhA+4mpKse6ghxaPboKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689619; c=relaxed/simple;
	bh=hA71l4zps3FIZrXce++oKUdmiZgrWiFFt8Rlg/EPXQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEYUmTwTSG9az1+/cCJvzFkmG2FS5bLiJAXvhcN7I8ML38SBdnzL0/BI+W9YR+8njiYYtk7drXdwwUlFVpZ42/eyObgQfneKclDa3BddArLBkUU2VTywZsoDjpmqXYIV6e6qAw8PnrEJCHpsbtvOSD7nsDAVw0Tp5IuZK13q+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=VJFCRnFc; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="VJFCRnFc"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672GeBVH107834
	for <ceph-devel@vger.kernel.org>; Sun, 2 Aug 2026 12:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=bzSq
	CN2ouqH/79hGb/FloWxsYWLiwWNlCW+sts7/z0Y=; b=VJFCRnFcbNLUu8cH58YJ
	s7DAqqc6gSH+kjyFskxBpwJixkUKaah7HWdTfzrfwZzb99FL1a9M0wAc6C3OUvIe
	VVuOskaxSaFF40fVu7ekQrsIeSnNoyHq3/WxLkOq6VCTu7BtSXjRpS1qxb06Dcm1
	rKfOoJ9oycpBp+0sTVCcEwouT7xKNGcxHJGnBIm/VPxHRb2YKzRbn1bBcLDXG1i1
	mEW63dNyT/J3l8Wcjg97vn2TQNvp3wFE8Q6zdJoCZr7Nr94DLYx+IUJuI/7KXgyl
	16+MrjJHWuvrM/Lvhme5FMtgNwUQYoZguefFID7Ig95GccXsf5j/c+g6RKJA2ygQ
	SQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ft9m1r18q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sun, 02 Aug 2026 12:53:36 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c0f0a0760so54060861cf.2
        for <ceph-devel@vger.kernel.org>; Sun, 02 Aug 2026 09:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785689616; x=1786294416;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bzSqCN2ouqH/79hGb/FloWxsYWLiwWNlCW+sts7/z0Y=;
        b=HWTuJffLKULFPSomD9imCfOkwwtKd+Ahs5FS8atbOHz51Ax7ZVsYe6nGtUIi+Cj96D
         26NWq+s7DVG0eYy0E3MKDXqKU5iqavnjejUs3mtgAePGwMEqqw3kIlgVH10AZQhlkqeE
         vRrSNI6biX0thj6JvvuWiqhvA2IhQGHrTx3K3kvRZ+ywmApZ0dsIawtN/7d5GGBYYjON
         r5xw/IQ/Tkxog2D4z2kCYTGpqMcm41pi5mc5MxV3rjPpaZjsZjZACD0tBWtDGE4MAnQ7
         t+irLqFRkIN2kMXWC4VfZ/ximirS2vOS70XNYeUxAHpK49sOIE9rnMW68JnG152biqNn
         ei7A==
X-Gm-Message-State: AOJu0YxEDvjriJgaYaUzwl5zU/HHdWiyY4YJ6ILrMxAD+8/C+2IdX/l0
	D+GDMLPk8bfjsTuKcjVb7DGacrOyIIEck+1Gf4i8DuJxHykfbbckHomwP0t+5JpYKfzcevLe5tH
	RYYXpnsX4+AdjUBQu392dVWR3KB5kctC2Gi6+DJXIpelkJ+XZt+z6EQfBwGA=
X-Gm-Gg: AR+sD104qQAwJHHKcv4Ox3XF4hmvm/34RIUVX+OsrLcpqBg4ps7bp9pIA3h6elpbRm1
	9B0CiYCXSXZW6g7hL78TgG3H5PkGlvplTFajzht86pSABp9m5EkbDP1XB6hqVuAifhCGN5U/kaW
	VJ2SogJXVAL8RzL5QNbFTMjZ0F9IDCHDr70xSP0YAr+7G5zFbqDKioLRHJQHsOr1Hgo91mHZAgk
	Bb3rEzkz0ZA5bPxH7PVQhF2LRZninvOgIUv8kKfeSUJX3ycZKlwRlhbV4Dzjtrj3TuLCgoi339E
	VDZfIGxjveAHIa+6VifJYSjumUnuKfGmELX6sZjrwuq5ecxsmiuiS6Qo9EuMgRSpYu+3ERyF9Qz
	tGIduEopGgl3g5wAU2hjd2wz/Ag18muFOEJLEjBJxhzCbKGEXhoA=
X-Received: by 2002:ac8:7c48:0:b0:51b:7af7:77de with SMTP id d75a77b69052e-52b566abe38mr141990901cf.14.1785689615764;
        Sun, 02 Aug 2026 09:53:35 -0700 (PDT)
X-Received: by 2002:ac8:7c48:0:b0:51b:7af7:77de with SMTP id d75a77b69052e-52b566abe38mr141990671cf.14.1785689615218;
        Sun, 02 Aug 2026 09:53:35 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm24064574f8f.34.2026.08.02.09.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 09:53:34 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 02 Aug 2026 12:50:03 -0400
Subject: [PATCH 2/4] ceph: convert
 ceph_wait_until_current_writes_complete() to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-remove-wait-on-page-writeback-v1-2-6c35d6b3ad36@columbia.edu>
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
In-Reply-To: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785689606; l=1458;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=hA71l4zps3FIZrXce++oKUdmiZgrWiFFt8Rlg/EPXQg=;
 b=NXcXcTwUKpw/VIbn16Dx6cegEB7ZHn9mIgTG7Ygwab6MpVdeUesY1ep5jkehOa6xD+NThEIbd
 Vk1axHal36zA+fFgqbopbWbRnXaom8Fun+tidHpPwN/TLt6hKEzLiKm
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX2W3F+pDZSyc1
 TxetKxPL0HYXBY4CjTlmj+GOrb6pMIdIDHLKjLvwOQJR4rSs+6Ve8K0RRYBUzdH+P+X8z3/nQnK
 h2ZrpJAJfVUjNKA7h8uevNzeJOok9c/46kpgjHgQ7gZr+Sc/xhiS
X-Proofpoint-ORIG-GUID: colvjIUU-8ua0xUW3xQ7PBDWPPnGS52V
X-Proofpoint-GUID: colvjIUU-8ua0xUW3xQ7PBDWPPnGS52V
X-Authority-Analysis: v=2.4 cv=FdsHAp+6 c=1 sm=1 tr=0 ts=6a6f7610 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=oBeIbaJldBQvbLH65vwA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX3YI1kZYHEj3H
 CVx6Vxw+A/6zcWB4foFZf5eRqyFHXvafTZphIA07MbrJkD/QYV017HPRR4MqPZITezx9pwpD00q
 w+Dy+sMe74rCjHhIWE0aKKpwfyVvGlvWxUxl3Na12I0bcKX0k2c1FBHTQlnEOxiifHVz2xPQpeD
 ST0GEaEpqzp6TM7WJd55H+6SMVlx0Muxxcp7uJaeXSwoqIZa+h1MfptGbEcrhIAlGh0aHmGMt9F
 mH8NyFkSgSxa+iqBSVN9uOjZG8t/ksMscicvsCBvarg58k7THD1iuJSzklhh/cbxXob3GGvd+BI
 4/BxqrifDh9dy6NotFEGdsiut/78m+aWm2gAVw5pcEGjB7iLSTU8ZbmmO0rPG3+6maSol1Zmuvd
 nFGG92lGXddX6ccOdKQdEVEEwuheJac0+Mt0Vj0Y/U6nxomHB4otP4VgJ5VCH/SilhMcE1ULVzO
 2/FxVIRSopi+p0eUwJg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=10 spamscore=0 adultscore=0 bulkscore=10
 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020153

Iterate the writeback batch as folios rather than using
&folios[i]->page. Use ceph_folio_snap_context() for the snap context
check and folio_wait_writeback() instead of wait_on_page_writeback().

This removes one call to compound_head() and the last caller of
wait_on_page_writeback(). No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a8ed2a14da44..f4aaf9a5f196 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1625,7 +1625,7 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
 					     struct writeback_control *wbc,
 					     struct ceph_writeback_ctl *ceph_wbc)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned i, nr;
 
 	if (wbc->sync_mode != WB_SYNC_NONE &&
@@ -1640,10 +1640,10 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
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

