Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62412FB084
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994125; cv=none; b=pyO6xsjIKOGeFkjFAEdqXdb8sDTN+j4E+cf6n1V+q1QOABxl18ffrO6/12vRScdt/8LnIKqNJ7EonlBnMd5AJu0h77txAycpVNIaQu4OIrDsGaUnzwOvx3C+dpIn2EAE2/25pZCkOrNh+QYWrkIQTcf/LFsCkXa1QT3VcSiGIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994125; c=relaxed/simple;
	bh=qVTLNDcbt+fJaFQvv2N1X2GXRE68u458QdYuIn9iM4c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xa1WS0Zm+ef8oF0422FEnNwnbIjvwVdNx+HLi65m8bzfsFg035odcyFsmMbX67pcy0NSnFoElMo1CJ671cozMvYzLbnrQRl2X1r3qE2y+lkRSSXMmlVL+Y06r2HwuyR/fT3MasyCJGyUzjVdUMAjryqC3APE1QxWzmszrP8nmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=cgEgAngC; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=aRf9KesZ; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="cgEgAngC";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="aRf9KesZ"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIYh9G3664059
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=uByW3kj0cNB59zzwcHQzAIcpQ5
	hlDdKKnX/d3JEUaiU=; b=cgEgAngC1RHM+L8E6tBdYeQb9iqkzadtLVuGO7mbO9
	dilB7H3YOGvtt2vHYykmsGIODc1BHasv+wdsMlwcbS0ndqFt5g0i2bsISQifFRRO
	AvN5cQ74rdLiu2fUcZqjlirXZLEcST2aP7hNlyPjUxI9sAE/rQM/NZydkpRTzuXk
	1jYW23Pd3Sd2P7p4MUCh6iVRpXjkrAp4rMSHJTvMC07sc4g6b/gGt2i9EXmc5L9h
	+K2uDiT4VkY82cIdvKXvmBdCBcxvXs7vX1HkdMf11l9sqOKM2Z6sVt1zK8gQ1Ygc
	uJOo8waAMjVBMOMjpZVQOu2B0ZgOoM8YBnqxD74rd1IQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g3mkfnqeg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:16 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-934979ee9f1so481337685a.2
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994116; x=1787598916; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uByW3kj0cNB59zzwcHQzAIcpQ5hlDdKKnX/d3JEUaiU=;
        b=aRf9KesZKrTIkcsG2kYcy2zQmy52MUCu6NITaGtTRgfjMEqaJcHqUEyvRx7GCIrv/3
         M914Qwdyg6xJqv4Q0oyUnbu+jo3q2JZkIYZSti1/5WspSssyv3Xd35rWX1+Xe2AcGJlQ
         CB4i3n1KLUcw3XMfH6Ewb99t4avsex3r8i4vv7bgsZhSXGJJw71LX38IX+/IjiWWOo7Z
         2eamk9Obqw8PLxtRMXjqwGH67V0/Wr1f3jw6kMY5pLiEoklfQ0EZm8V3whmgqTwq8vSP
         WE9hYfU3NL8WnBNDus2BKIPXECT+q5bfZk2N4PEjLsov1GmkWfesS6Ok5PImnF0A7RQY
         wnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994116; x=1787598916;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uByW3kj0cNB59zzwcHQzAIcpQ5hlDdKKnX/d3JEUaiU=;
        b=owHCuGGZZsgy9tmID8U7lfwlOvg70aN5sPtWqC3MYEg03f4GbQiN2hmHJk29FkO5b4
         //lcZ4gaOQx+HMR5gTOnDs4LX8+mlYLaNPkUMFLHYLu3iGwbYBZ4eLjrpgjSgh/JWAED
         DykOeXh85SiKLXJ/JFqjv5PRUWiI/5/4vssXeJ8XqsjDRgrYIqiJ2xBsBxKciH0Y9aei
         0vxJH0WWYs9nwsvMDjrt3Soz/JalMrv4c0C7IY+b7ImrBH6k11tqmZCT6uvN+MvdvRyD
         XJoTJEkpVd6RNzs5bCgSZfrX5mK3vauugcR/HD/mACw6D7yC5LZatCCdKPHxn740Betq
         dFHw==
X-Gm-Message-State: AOJu0YykOBXWGIwV6meGq57fYuV9xjIewuIPPE2jgGHofUBxcT4lOPuG
	iAjTI5Jm0m8HtjrZSHYd6X8uTsPotVoByb4NtbaasnTfPG1Or5/xW/dxcLjKWJ9hQq+x0vgOAk0
	z91h18iRiLnubyez2GXLdMifU4u7dg3TMP7RbveygdkwvU+fxYRVlwoDSU6U=
X-Gm-Gg: AR+sD10tYn9up3XWyN+aUyAiPYjmd5W7Vu78vFFUUOgzixZE7/pk873Be5jZ5fpEPRc
	N5TMg8i9fGyguiuJoZcvyKNPHhxfWja1XOLOvgZJvRv3rF3FdeAH6WufEQS9F72CUcq5SYmIMzr
	efpA80sSu2MfXzM4NXFv2jVpVNYhjKuxKM4Zl6GvliyFAvgEFzqeCTdRMpjSFKj/ApTZrmpewH5
	eVOkfu5UMT3R92+AxF/4MQjGmdNd6LURRxwxZ638s9nHia3GBb8WA204uABOYS3M20m8FsAtCGh
	gQBCiwEqfSjK2AOhzSvJnlrXCrC+M2Wmc9B9S6D8KB+t/LlPre4c8fsYkjrJOH25W0/vJAJ63Kr
	7E4suA7dI
X-Received: by 2002:a05:620a:aa08:b0:92e:db1f:185c with SMTP id af79cd13be357-936d2355b08mr2578316785a.43.1786994115627;
        Mon, 17 Aug 2026 12:15:15 -0700 (PDT)
X-Received: by 2002:a05:620a:aa08:b0:92e:db1f:185c with SMTP id af79cd13be357-936d2355b08mr2578304685a.43.1786994114838;
        Mon, 17 Aug 2026 12:15:14 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:13 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v4 00/10] ceph: convert writeback path to folios
Date: Mon, 17 Aug 2026 14:55:16 -0400
Message-Id: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABRZg2oC/43Oy27CMBQE0F9BXuPq+hEnYsV/IBZ+3MAtECM7M
 a1Q/r0O3aAKiS5HGp2ZO8uYCDPbrO4sYaFMcahBr1fMH+1wQE6hZiZBGuhA8oSXWJDfLI08Dvx
 qa+WWaERn/Yl3CN61xgTtW1aNa8Kevh7+bv+b8+Q+0Y8LujSOlMeYvh8Hilh6/90qggM3XjXBO
 GWDMlsfz9PFkf3AMLFlrshnUL8DZQU70YN1YBrZ6RegegIFvANVBUNoGyVa0L38+3Ce5x9vt6w
 kgQEAAA==
X-Change-ID: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7
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
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=3475;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=qVTLNDcbt+fJaFQvv2N1X2GXRE68u458QdYuIn9iM4c=;
 b=YF0CAtusldpvdNFh8yT893tshJfP33e71vJS/zp9Vyv5PiufZBdZxAi16AvQVuq0GUUWC20VS
 /B4v9H2a8PNB9uBQuLwzJLJsesUtNCcC4r5QOysYJvEWLuOWP5opkIY
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfXzoyh4rR4Ex/p
 cBgz6hNBYue+FmhGyA9xHj9nGCZPMAclD+AGzaG9uTG7tqvBKbkwVj098Hvxefafhny7QnaSzy1
 jkDbMRlQEuvg/7c/LBmfZgqoeeG3RJ60VMt9Mx+7b4QhoxhjpGH/
X-Proofpoint-ORIG-GUID: l1ZhQD3buP0OFx7cdn2R0WIA93UB7Bxx
X-Proofpoint-GUID: l1ZhQD3buP0OFx7cdn2R0WIA93UB7Bxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX+WaoYdLZkkqh
 qxEMbN788g8he2hkgW6N1UGwQ1KfD37SK54dQMIxRGEpbDCvcwC6OCQaz/6LStQv8NTqIqC3V48
 9ua9gePCeBpEQ8yWURLy2x7gUI+q/TCrX4+7QZjxVnMpnoMeJn8skZ7Mp6ZxqCTfXXqw9ioYQvY
 HREWu0CWNZ13FW59D+qH9ODulDo/WfxNY6VeHRx31wipVs1+SHL5btAChwN2dQhjq1i2cZCcIOv
 VoRRr1hXeRpor0FMTbwIaOu69gDpDIX4fFolxKIoQyV9EXxZ9RDAN9Emocd6v2Mf9eDfjf+eFpg
 7xeYj5JMNJw8f1ZPTCllQTqqbNYN3WgMJQVOs+Nzv6jTdnTedpbbuqEz5nnwEhWj8UcK+6dt0j3
 atxAz8DCSrRkVBhstV3pyE9JHCakkKNzLTrWJqF+170IKfEWoNENms5psQ+ScK6vr3v4Kj2r1eh
 nkumEDUqHxImKLUCHyA==
X-Authority-Analysis: v=2.4 cv=C+vZDwP+ c=1 sm=1 tr=0 ts=6a835dc4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=K5e0w50Y35hYhEYsqgEA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=10 impostorscore=10
 priorityscore=1501 phishscore=0 bulkscore=10 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

Convert ceph's writeback path to work on folios. These conversions
eliminate the last callers of three mm compatibility APIs:
wait_on_page_writeback(), thp_size(), and thp_order(). Their removals
will be sent separately once the conversions land, per Ceph maintainer
request.

This also fixes a couple pre-existing issues discovered by Sashiko
along the way.

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
Changes in v4:
- Rebase onto the current ceph-client testing branch
- Drop the two mm patches removing wait_on_page_writeback(), thp_size(),
  and thp_order(), per Alex
- Patch 2: wait for the pending fscache write before bumping the
  writeback congestion count and allocating the OSD request, per
  Sashiko
- Link to v3: https://lore.kernel.org/r/20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu

Changes in v3:
- Add patches 1 and 2, fixing a couple pre-existing bugs found by Sashiko
- Patch 7 (was patch 5): Rework the ceph_submit_write() error path
  conversion on top of patch 1
- Patch 10 (was patch 8): Remove the BUG_ON(), per Sashiko and Matthew
- Link to v2: https://lore.kernel.org/r/20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu

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
      ceph: fix error handling when the OSD client is stopping in ceph_submit_write()
      ceph: wait for pending fscache write in write_folio_nounlock()
      ceph: add ceph_folio_snap_context()
      ceph: convert ceph_wait_until_current_writes_complete() to folios
      ceph: convert get_writepages_data_length() to folios
      ceph: convert ceph_submit_write() to folios
      ceph: remove page remnants from write_folio_nounlock()
      ceph: convert page cleanup loop in writepages_finish() to folios
      ceph: remove ceph_fscrypt_pagecache_page() and ceph_fscrypt_page_offset()
      ceph: rename ceph_check_page_before_write() to ceph_check_folio_before_write()

 fs/ceph/addr.c   | 156 ++++++++++++++++++++++++++++++-------------------------
 fs/ceph/crypto.h |  12 ++---
 2 files changed, 91 insertions(+), 77 deletions(-)
---
base-commit: fce4f3da41f1145cfa400002ce3a66e4a89a1902
change-id: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

