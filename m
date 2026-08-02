Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92A397935
	for <ceph-devel@vger.kernel.org>; Sun,  2 Aug 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689613; cv=none; b=NggR+pbu07YkQqHECehjXJrATiOlyChJ3q12s9mKRBnZQKNAuBPqOU163GKyUV+9rCJ7QEip7J0509J7oIgihfV9NLLESRL0YeACjpXDalJ2irg/IiX5jGx9P00fOWvGLjnZvRMVGM4oxTZdVJC/94JMIHJB5Nhic6UHG0vli54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689613; c=relaxed/simple;
	bh=4gWj9P/Tx5A8TCUYXaCRC+u4Ad2C15i9Z4yoGnfAAOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YvnhUDzdfyBQyq6CH4w8yMQucDUh6L28F5AcNLpgR7FQ1htJE7a7/UAAsnCBSStDg7mkWUSreLal8dK5JFWn6HKHhtk009niVsJKeENmZwltGCFw8bntUM5LNwSAnHiyzWg2fKN033iHmHWOLuXUp5Q2galyrYXBIKYBO3KeGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=P+geTUad; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="P+geTUad"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672CYqLG3860606
	for <ceph-devel@vger.kernel.org>; Sun, 2 Aug 2026 12:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=jdmVuzsAgoF8ZG4dTGff/k/Wwa
	0EKprHUxiw6VPwyFs=; b=P+geTUadJWXWXd0dA2+8ob4HxWiNc2WyVVpMG4hQSU
	qr95KBa3NoopgGnmbqtW2mmrseQbEcv+epsnSR9qfdWOapIld9M30o+ljxAGRkk/
	bM07HYlA2/D9rzTvymRtLeZV9VgC8sp0r6oPDhCcniV2oBfmbdHyS3VmKOGUizxq
	BzDW4xOpn7j1pJLc4d6yUQNf6FqMCgeBWJEz2d+cikXG3oOvMQLNFAvkrKUD38l5
	myDlDbQ5yLL9a5xEXQGQAaATwAC6dqd1mohF1RHOfEP4kYFKmQRpnjh4WmLrx+tM
	5STlCqtdwifU/iV9N3YP87mbWpUgj5A0+idRquIfzzqQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ft1st9mmc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sun, 02 Aug 2026 12:53:30 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e52306621so215149185a.1
        for <ceph-devel@vger.kernel.org>; Sun, 02 Aug 2026 09:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785689610; x=1786294410;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jdmVuzsAgoF8ZG4dTGff/k/Wwa0EKprHUxiw6VPwyFs=;
        b=fqoMDks6imER/DjUQNJH94pXXdRTuN9z21L1cKlhniFElPhMW1v8lrhlfFtcU+ibMU
         foavdu1iLMH+ftyeoXuehPctrzpY9vamn+StOtkeT4uCMuy4FABHBQ0zZkSQexjl/IdZ
         eCrOCQII8Eeb4qC+8Q8iFNcZZAnbYDpLBOl8qwzLY31CNS5l7IB3IOydKlFElyFEUm0p
         bNeQCGfxrqJkGsm+StNasZrhTEhaXGo4CifHZh4EkImFl4KSFNYfyAkvre1lKF0cBMFD
         /qvNt0/PyJWSAHvQTGhkd6J2ZDlyXKj+U4hBh5dIb2n6Fr267bucz7cWJjxxaOfyo1jX
         qjcg==
X-Gm-Message-State: AOJu0YwVgWO9wuile8G57VbhTAMcFip/XcuGqzVO3A7ZLQxdbMyU2gJV
	CSgCiUoZs+6uhkSKXXc31sc3pAQbYnovK/pyXsq+h0+9CKRmE+R1z8evMSK1HWpV5EzdU+QuiSU
	2SsQeuMtEIAHWKV4zCQTgvu15CDARFQpqt7DsRuIQx0vvVJfeSjlUWyD35jc=
X-Gm-Gg: AR+sD13aFVoYcs2/8DKm6Xu4K3I66GHVkwpisD6EjV27WegUCzHIJ3gL8HXjLiKu/D6
	BVTvvdjbtWh7kQWT6oXeuGfclCEZL8445f1DO0Jli0YzLj/uQ7jy72QXwkhaBjgLJYaXL7b01O2
	u/myUlKln8pnVGNhX95wCycVAWwEugoI7nNk8loXFR/2DT7fYGUN8a/nLOH+7pD4ID8PUwjqt3R
	Om1m7ab6kxYRKKAhBFXOLCfaAfHZgpBz4lj3ocW1cMI6GbkZssiIAiTlfLpx5C7ZSu19cCmS3uv
	IRi097pAo49ELD//yqjupUMfjMLz0W2fq4MNTWsyicroJEZEOz3Lor+eqVbk7a5HU+1pA71aHnG
	G+lFBb0ncpd8Jxh2S0yZ5rbkDsgV3AgsVyzV9IEVRg1n9OmhCt60=
X-Received: by 2002:a05:622a:c07:b0:51c:17cd:1fd4 with SMTP id d75a77b69052e-52b56845401mr153860941cf.41.1785689610163;
        Sun, 02 Aug 2026 09:53:30 -0700 (PDT)
X-Received: by 2002:a05:622a:c07:b0:51c:17cd:1fd4 with SMTP id d75a77b69052e-52b56845401mr153860481cf.41.1785689609667;
        Sun, 02 Aug 2026 09:53:29 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm24064574f8f.34.2026.08.02.09.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 09:53:28 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/4] mm, ceph: remove wait_on_page_writeback()
Date: Sun, 02 Aug 2026 12:50:01 -0400
Message-Id: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADl1b2oC/yXMQQrCMBBG4auUWTsQg6TFq4iLJP3VUUzKJLZC6
 d2Nuvzg8VYqUEGhY7eSYpYiOTXsdx3Fm09XsIzNZI11ZjCWFc88gxcvlXPiybdkUakIPj54gIm
 hd248xJ7aY1Jc5P37n85/l1e4I9bvlLbtA85vU1uBAAAA
X-Change-ID: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785689606; l=1390;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=4gWj9P/Tx5A8TCUYXaCRC+u4Ad2C15i9Z4yoGnfAAOA=;
 b=pNASrzhNLQvlvnBF+sfz/L5yPNAba9F0lNWjDHJrGgXdSZk5xP0Zq2QRt9cBu7U85CTudE8Ym
 7MEugh8NiYDB/Q5bk5LCgMuVuLJcddMU/E9la85P5BX0kzWs6U2bS8O
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX9MVRc0umeRcp
 0j/BV02Tft+oF1Y04EEtNoawlHSdXKB/2yfa7zfoWbuzevtfTZ1NTMO9sZjwPcwSt9fDGOCmVcU
 4bZ9uKXChk1ejLOxLZyplLM5U0dOSWNCsPmBiuL6WDKn52omL6qsLFCPPdLysu/qAxka/9wnl7f
 EfPlWDHLVdps+qgMA7WDODY50en4+PpmCNz1mpZa+Un+0YxVIILzIrmey+8P6axrpBSqgcG+tfu
 1RMSqG0OGQr9Hp7+9YiAKoXBzDAXjMXl3AINY1J6qkVhzPFUoWLhNYRlajavwXb31heskxSSGka
 3LY0jYW9WhirsvbN0GLRFts0tOqSjlCMtMWeOzGgwYuTs91w6P/Pot4KPRAked21eVdhQoJQIl1
 Qgfx5LQLZp8ms3XXPb0EIocMmmZGruaT4faz7cyjTtPeCDWm/olekGc+Ur7G6CIu9U0L0Ejt3vg
 /pi2phETo5fArpHeUzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX93y0rOboqRlU
 WOA4up5Kggj9HMIzmruwtICNsDDRu0ELKVrH6/by/GcHRhytNjfasxR0K3g1CO28lYu2z5+49/0
 qGo9Q4n7BIUJXAAsfG7hfrI2chX7FAppHsZsoul3LrjkCGGqkN2v
X-Proofpoint-ORIG-GUID: EwL9e9szD4rSeV1YV289wSITzHbhumMJ
X-Proofpoint-GUID: EwL9e9szD4rSeV1YV289wSITzHbhumMJ
X-Authority-Analysis: v=2.4 cv=TuLWQjXh c=1 sm=1 tr=0 ts=6a6f760a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=VNIlXpW_hWjJ5J6HzMUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=10 priorityscore=1501 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=10 bulkscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020153

wait_on_page_writeback() is a compatibility wrapper for
folio_wait_writeback() and has a single remaining caller in ceph's
writeback path. Convert that caller to use folios and remove the
wrapper.

Along the way, replace ceph's page_snap_context(), which uses
page->private, with a folio-based ceph_folio_snap_context(), dropping
three &folio->page conversions at its call sites.

No functional change intended.

Note: This is currently based on mm-new. It may conflict slightly with
Zi Yan's series "Remove PG_private by using page/folio->private checks
instead" [1], which should allow simplifying ceph_folio_snap_context()
further.

[1] https://lore.kernel.org/linux-mm/20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com/T/

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Tal Zussman (4):
      ceph: add ceph_folio_snap_context()
      ceph: convert ceph_wait_until_current_writes_complete() to folios
      mm: remove wait_on_page_writeback()
      ceph: remove page_snap_context()

 fs/ceph/addr.c          | 28 ++++++++++++++--------------
 include/linux/pagemap.h |  1 -
 mm/folio-compat.c       |  6 ------
 3 files changed, 14 insertions(+), 21 deletions(-)
---
base-commit: 1dbd7c34bb92dd9c0b0363b75f6ec444299af108
change-id: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

