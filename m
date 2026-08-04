Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF24746DA
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869555; cv=none; b=LfES9DNizZN9HPMJvqh+mCJdfNl8AMx++y9LJrcN6HhOXalHVJOkknqvCRXLyP+BN+uvZOjSnggBKIfF0ZCrivfnGIPEyYOMZdLUX0Myw3NfNzpPMfgO+zV4Jvih95/If4N+ZYB9nlPlQbKZrfvBbSbJGOMtlfnYkXTWEiVVpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869555; c=relaxed/simple;
	bh=zWM2+49jEMwBQwNik+CFCtiOiR0VjtZ6SxoPtniyer0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nIGnq6N6UKiWGAtsuvuRqVWNY/8Onxz9ySGpjdHGeUZJG0W4yvD6mi2SYhfqQaG0GcfTBZkl8C8VO7ysdG4nN3xo708WDUlBIdJTpv3iOvznO7IaeWqbFskQOhTkAs00L+ZVbcmFfBwr4fAT0nLXWxHl8vKc+E8dE6IFWmeaook=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UowxIcw3; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UowxIcw3"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IYZcV2271826
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=7YfZUeIFW9TVPjgB6SoqKQpgS0
	HUMDYLvGLEC86SVCw=; b=UowxIcw3t3wlAFDlemaKlByrLPdlI2o72gL5wLyZGT
	3X+Plr2b9u0eN0d8sTL1eMoYEv3VOcAZriW+ZfL0uXbvwZobyV0CxBiillFFSlkF
	NKa7df5UgoioU5Jf3R6TXVK/fP5jURHOjiQuR2OL5l9MAnZYdO0ButMqwbYCadVg
	iNjDOR1V8U1JI3KwMVi3BFe7VLfiIzrXFRlKezajPClhIoISeYk8tTtsJGP1DqVI
	oEiL8Pq0LHbS1tGVSjS7MOtrQapJr37nUM97XJRHVq0x8GV/6GW6tG32UIf2k7JJ
	nSW0yHhQ2U9exk3fU+lP7jmykSyJ3jE3kRrNz8aIQLDw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fugt12nk2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:24 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52cd0374265so1670441cf.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869544; x=1786474344;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7YfZUeIFW9TVPjgB6SoqKQpgS0HUMDYLvGLEC86SVCw=;
        b=AoALYQIgFd/GmpUfEo6TCytaI8R4sTm/Kskw1EJ5lMiPx7tf3ZZW+wHhRIThMxpvsQ
         6ryvkcXi9OsSnQLbroP38sBIA0vhsX84yg7Ekp4ew7ww0looDFi3bqsNvOpD0tnFTS2K
         9E10Efp1+HEKMSGEiP7m8EZ2VIR3MZrv5GkhpIUU0bnHbi4vICwDSFsO/YzwrtrZfsEb
         19Nq9O1RaiklqJKG9ZGyhudc77EuOjJCtgc3Ae4fBNL9XYUPZ+L4XkJXscBmXBqlFvdK
         3WibjHjaltu72jl012t1pmG5rxq2txU3AtX8FoimSghmYTd7jZIl+5+28BpA2Mu0K5dk
         5Qog==
X-Gm-Message-State: AOJu0Yy5pzx2yTWw9eHSA/prRonCb+Rr1hrsJQWVZwHm/ttoyoAL3exn
	6QWifEtvJVYPWe/jUufNDm7k7jHTfSPVng8E5Of2G9edJfV8Cn9ePl144RQY+VH7xwzCVB4dlDk
	hkEo9Yl3GgWNj4OybQZFGay8CajGQA20TbyulJLNIxwSturyV2MOHFDzj93U=
X-Gm-Gg: AR+sD13bUgQLb+ukBIwqYaBFaeUOgFflMLPM0gw0Qr6SUEvgJtzkRIYirRUzHn3JfXQ
	67Qxcy66UWIj7ezZN8Rjne/UZgdiR/byqJhkFajlhY78v9ELcwvPYB9ZH4sqfz9OB6kGsj1a2Gn
	19+504gGG5ax4g8fRzjgJxvKLHtnUGha8MNLX7YxwfkB1H5XeA7t7YNQErF1S2QYlkOn7RxF4U2
	MU7cKFIgMEQlfUofeJ32m5jAe+NSiaP5SmhLBRfMFz54E18Oshgx98j1ZTO2JGDxgKZsaN4hKb2
	EvjVbl8oOAUnitJlXhzIqlyE3G9YsO7TdGozzQ8t6D3kHQKeIAdjqzGhLHR6gn+cediFeQdhAB3
	gpMDTFvEK
X-Received: by 2002:a05:622a:2487:b0:517:a7ff:935f with SMTP id d75a77b69052e-52ce5fa471emr14549071cf.9.1785869544301;
        Tue, 04 Aug 2026 11:52:24 -0700 (PDT)
X-Received: by 2002:a05:622a:2487:b0:517:a7ff:935f with SMTP id d75a77b69052e-52ce5fa471emr14548641cf.9.1785869543831;
        Tue, 04 Aug 2026 11:52:23 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:22 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 00/10] ceph: convert writeback path to folios
Date: Tue, 04 Aug 2026 14:52:08 -0400
Message-Id: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANg0cmoC/42OSw6CMBRFt2I69plStBBH7sMw6OcpT4WSthQNY
 e8W3IDDk5yce2cW0BMGdt7NzGOiQK7PIPY7ZlrV3xHIZmaCC8lrLsBj5xLCpCiC62FQWZk8RdT
 KPKFGbnQlpT2aiuXG4PFG761/bX4cRv1AE9foarQUovOf7UAqVu/frVQAB2nKk5W6VLaUF+NeY
 6dJHdCOrFmW5QvsOSvR3wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=2554;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=zWM2+49jEMwBQwNik+CFCtiOiR0VjtZ6SxoPtniyer0=;
 b=fEDv7IHpkI8eMWnAST4q4BAmT9PhWrien1UJlpvi3iP8NJEIOvrTfVJt2EbDPSyKLSLZeHGWS
 jpYM3a1TgRsCm5MC1re6zBif6kyMG+VfIUTLjNCYLi3vuoSxRq6czKk
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: i0ji6vL_dfNBhAa6yruYX8ncpJMxSZFf
X-Proofpoint-ORIG-GUID: i0ji6vL_dfNBhAa6yruYX8ncpJMxSZFf
X-Authority-Analysis: v=2.4 cv=SOhykuvH c=1 sm=1 tr=0 ts=6a7234e8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=CvbYRxD_FV8rGtwQpYYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX4H18cOXES+aT
 Shm9ZOEXqPpnSjC/MWFQRhGH06yqQQajK6U/2XnkTj5FvO94dtkc3MVccFx9KO2B/TmQpXlPKwX
 zAUEKlaxKxbU03MMeaN37zcXvzbxKmBnPCXiGTewRkcglKegvCkUO/x8hvwLtKHbTNA73thbTe6
 fNFmM7FufFs3rrv32JWJXLIZ8k4lbM3kMpg3p9o1Mx295ISOpAB5dCUJz96lTVJNgFOHzbU9uug
 V/6PgnEAZet3XmLh3KOdOPKN4pGd/xTuLEws8jc9u85RvxhdTBXr1AsD4afeEJh3224cCPBsF7/
 85bG+0xENRiGsEjbqDg1ffWsmR9CAGltnAaKIN5srXNeBITexvav0dHh4xe+Aguy96YE0d+d9W7
 pSQcok0gI8spQ0/UTGHGPhvQ/I/YJ4/sOHHy5LnNoqe8zMLc71WxKKqyJqPtzFlgKdszUWqh5j6
 D7h/i4kKG8PVahZwj7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXzI189UD0/Xd6
 IqPnKTrx2O25D/62gfZoRT33DRfboJ1JyDgIV4hBeEY8TM5yR+u5ySzrqVl4mYjJplrEYysRQwn
 GyTMzGDX0AZXCITNYH4c2rgXpIXgo5NMwcNarFZgdzSEl8fB396x
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=10 phishscore=0 lowpriorityscore=10
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152

Convert ceph's writeback path to work on folios. With these
conversions, remove three mm compatibility APIs whose last callers are
eliminated: wait_on_page_writeback(), thp_size(), and thp_order().

Some page <-> folio boundaries are deliberately left in place where
ceph borders on some gnarlier page-based APIs:

- libceph's OSD data plane is page-array based, so ceph_writeback_ctl's
  pages[] and osd_data->pages[] remain struct page arrays. Folios are
  converted at the array/libceph boundary.

- fscrypt's bounce page API remains page-based for some functions
  (fscrypt_encrypt_pagecache_blocks(), fscrypt_finalize_bounce_page()).
  Possibly-bounce array entries are unwrapped to their pagecache folios
  via fscrypt_pagecache_folio().

This series is based on the ceph-client testing branch [1].

[1] https://github.com/ceph/ceph-client/tree/testing

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Changes in v2:
- Propagate tags (thanks David and Matthew!)
- Rebase onto ceph-client.git testing
- Rename the series to "ceph: convert writeback path to folios"
- Patch 1: Drop the folio_test_private() check in
  ceph_folio_snap_context(), per Matthew and Zi.
- Patch 4: Introduce ceph_fscrypt folio helpers and use them in
  get_writepages_data_length(), per Matthew.
- Patches 5-10: new
- Link to v1: https://lore.kernel.org/r/20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu

---
Tal Zussman (10):
      ceph: add ceph_folio_snap_context()
      ceph: convert ceph_wait_until_current_writes_complete() to folios
      mm: remove wait_on_page_writeback()
      ceph: convert get_writepages_data_length() to folios
      ceph: convert ceph_submit_write() to folios
      mm: remove thp_size() and thp_order()
      ceph: remove page remnants from write_folio_nounlock()
      ceph: convert page cleanup loop in writepages_finish() to folios
      ceph: remove ceph_fscrypt_pagecache_page() and ceph_fscrypt_page_offset()
      ceph: rename ceph_check_page_before_write() to ceph_check_folio_before_write()

 fs/ceph/addr.c          | 120 ++++++++++++++++++++++++------------------------
 fs/ceph/crypto.h        |  12 ++---
 include/linux/mm.h      |  21 ---------
 include/linux/pagemap.h |   1 -
 mm/folio-compat.c       |   6 ---
 5 files changed, 65 insertions(+), 95 deletions(-)
---
base-commit: 30c0913a2b44a66dc17283a88489b3f3e12f4327
change-id: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

