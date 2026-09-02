Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B954AA02D
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365505; cv=none; b=LGa01aK3tjWCoOnMbZ4NiZsuK3+wJkI2w9/LW5ANq1ww8AKkyj4xuMtdFJJhdMWSC/w3g1JrBictTNOXuNsPi2/ERx5n+hiYPBDT4UEVY78I7zsXU4L1LZEhtDriTRS6wvvw0bLyJKF2KcakAYeVs5iHs9qyewjUdVwMxWlNHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365505; c=relaxed/simple;
	bh=2pRj7k7aQRbRlhByxKH2HrTZSqCaw7QV05nYRAwfYew=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fHR9EGG4ZcivNf+WNWNVIUmGnepMQlTpI6bjvFwuYhsP94M09fw87zZkvm1c3LXXLPPfLqT0RUDM4XYTRSsOt3ea31Y3gyznHOdxAf9Krn2sgoUneDkgvYFEjqh24yqeyNRPZxZZVwYy+n5AXLsirCbO/L46iVBNIwlfiz0UuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=fv/geYVG; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=DTfWbaM5; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="fv/geYVG";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="DTfWbaM5"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682FPYUq303560
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=kCr/a9cXpZoXkRqqHwD0NrP/0r
	IC96oDo8RjchhsNyo=; b=fv/geYVG7lQJQ32TLmn7lXEb0PyPDF8mMfuZyRSg+e
	laxzxEkND1tTCQgOBJUYtnb+FF6XcthlHoa1l/TkJo8bkZoxKUZAGRvsPhJBQ7Al
	HrzhDt3k8WPMsqi2zV+h8G29gxvFvKrC1u680qYwpyoPuQYjfNBRfTMjFOQGeCKU
	RsPh+oUmghMynkQZIEA/vKsEB9rnu7Lx3C1qEfjRUdOk7vyZuEdHxt8Cg+4Rduvz
	MhCClhMxKmXWXAAO1NIP0ey2x1bty9X14i6cekWXPVP0tsfuPIsq0HEwiyQlYRAq
	ieXqMsGXFbZIHGjHxMaTKdAfnNk4dqAZ3wVgPFjSXcBg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ge8gcms65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:11:39 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90cea0b5522so24348746d6.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788365499; x=1788970299; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kCr/a9cXpZoXkRqqHwD0NrP/0rIC96oDo8RjchhsNyo=;
        b=DTfWbaM50P1a0sOHPXjEI6vh9sFLmo3iTgCrJwyW9fB4fSakBwvH2wWh/uxRnBaCbh
         ztpuJtPkO5dw1jQ95N/d2qKsC0JRVueC6SUqd3/y96HcTuVf6c2teXAivhpj108v2STs
         QTiNfvnBOlDf0qSSM0am69QLo/6obyVpZlpVYO2rLCtBQHwjFayJJUeAnVM9Lnp5HAPN
         z+3i75+m7wCXkbOQBe9ky9zcCZUkgZ4fzssUm1XBkxv0VVvpn7vjwSNCGRAnnvAWUpHh
         vLVrDmk4miUkP+bSzTnx9DpyNU/kfSy6uWmEEMYlBajgdFTNsl2Rnrn8kKGBlRf3BBy/
         HWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365499; x=1788970299;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kCr/a9cXpZoXkRqqHwD0NrP/0rIC96oDo8RjchhsNyo=;
        b=GJJLyOJyZ3+nAlRsn+hi3hnNinozaO7ZccdLqcJQR5pHuV5LIk08PJedg2zsedgtxd
         AyWV4fT6TjJiv9fIAcHvlvSY8ZRqWxiF0RqHT9HZL86ZBoRWBA6XHsHgtmZNe3yi2hlS
         CBJigYFR3EMS9A5F4eUfFImGMBFE8O3kSVEuQdjCVHig3EBIjRAMQ6n2p1hnPu5PqBRo
         80pEm5VjnhJ0ArL1PWcKCvCpVRwvvuS8GgrucOqoPWuCu5qJXia5ktMW/oQoda7lSS6u
         bctYL31eVzMnoTmBmU9Up1cJLN/BsSWn5VG/auFyaRuz7jF77jXLSJO7ZEaz2Qiuy/9v
         +86w==
X-Gm-Message-State: AFuF++l5O1m1Vhq9S1E7rwNkjxkcdFgVL/0/OpvyamVWd2Y34Hq3a5iO
	GrWQl4G1Y9Edy/N2l279SHiMAVcOi2PT9DCxJwcSUmUj4ImIGx3/HjjeUmGuKxIhPL5Y1lhW0lI
	w3cxckBzjuejlvF38OM2Z/7VgNSrDyNO6z632W0Us0LiQ/eF65HOFG5Gnzkg=
X-Gm-Gg: AYBFou0Xzp9zVvuvPg5Gfjo9hJtiuWOeNsMF5tdRaZK80KC0be0e2VHtWSxgMqt3Fcl
	yGeDBrO6KgvDFAAxuOyPbNr9vng+V2TQCkD8HKIFSnYJy8j6wagFMOSoscTDEQdh0ycLijfzOiY
	uii5wOjD/viHNLD5ouMeTeqi/0YPAz/gTFg3mSfRkHOloVphElgdFusMdWl0kohv36WRX6gwC1Z
	bkH1+7iP0vGAlx+ugxyGn7rdRmrilpNe52PuhcQp62O/s0gpVcdj/3hMKQxN1vGYwg8O9pMZZaY
	Ai+uNym/RhhASe8xCX8HOHI8y6zNcLgIgLjA4wX2vujaQLfV1htt3Sb7xcV8LiBC4X1drFgBfy4
	sjFYHCyOap7OhezqvKoO32XSl9G2nzkdgCiASTF2iiSA0MNTwsLvnAw==
X-Received: by 2002:a05:6214:23c6:b0:90e:8a62:3344 with SMTP id 6a1803df08f44-90e9f26550cmr73437406d6.13.1788365498891;
        Wed, 02 Sep 2026 09:11:38 -0700 (PDT)
X-Received: by 2002:a05:6214:23c6:b0:90e:8a62:3344 with SMTP id 6a1803df08f44-90e9f26550cmr73436396d6.13.1788365498298;
        Wed, 02 Sep 2026 09:11:38 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec7608sm21172636d6.26.2026.09.02.09.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:37 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v5 00/10] ceph: convert writeback path to folios
Date: Wed, 02 Sep 2026 12:11:24 -0400
Message-Id: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKxKmGoC/43Oy2rDMBQE0F8JWlfh6m266n+ULvS4bpQ2VpBsp
 SX43ysnG1MCznJgODNXUjBHLOR1dyUZaywxDS2olx3xBzt8Io2hZcKBa+iA04ynVJFebBxpGuj
 ZtsolxxGd9V+0Q/DOaB2kN6QZ54x9/Ln57x/3XCZ3RD8u6NI4xDKm/Hs7UNnSe3arMgpUe6GCd
 sIGod98+p5OLto9hoksc5WvQbkF8gZ2rAfrQCveyQegWIEMtkDRwBCMEsyA7Pmjh3INmi1QNhB
 QoRJBGnTwD5zn+Q8mcXU20gEAAA==
X-Change-ID: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788365497; l=3737;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=2pRj7k7aQRbRlhByxKH2HrTZSqCaw7QV05nYRAwfYew=;
 b=0fO3lCLgE+PFNczDuEbd5ZsAvWYXDiiNFbHBhwl5x1scec+kUEgKF1RQEDJouvtra0W95Ysb6
 OgOntcY1dJ5AEzuZWIRdI0Se4T3aCdr6E/D5F27P6v4ybBlMmBoLV3Q
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfXzNxEagCLBgsT
 FV/H2uRM1tO1bCexRaW3a1f20hta3vVGo/JkssbKbdR1m1kxh6Fq7fNNCI9cinIxODUWbNYIXgv
 c5yQQjbcO8sVeR8sG8nNezwotIjW0t3+XVPFyP0D4PnQgcB6Zkt7INwLW6IyaK6NuHM8p2LJndN
 DXi2n72/qtIhYl4rfIAs7qA4tbHTRD6VPaYfORmlTDdO6M8W11JsJIeJ89mWwQZZZprOOsMIglU
 pgEHfr907JqOWo1k22b7cVEPM3AxqzaVprey04uJN4RyLWUKTWBCvwEBCLq/WRAFTRGax/r5aPf
 kekw5BV2EAR8ILGDuSR4w3Fg7NzS811NX9yK0P5iHepy6Q0jA0PTfEOeJbY4tHBq3MIUYIv43nj
 A/sfR6trn4z0Aa6HjpCcLZN1rBIPilh/mVwP2ZDb68KVgly10/42dwfwdYoAZsP6BjLAh0ORqFT
 Zrfhf9QBe6ANnyPVrtQ==
X-Proofpoint-ORIG-GUID: JOlKp79IfyFyWBzKXLxCc0PtDRgMEkGF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX+U0pd5l7QH35
 XizUiVdlucsbBDWKpbwsYPC3Q6Olo8EzqJHBKVvTnNRT0iPETjnLKpQnhempkRnnivYy+etCH23
 6nVxWQgXeQPEBDvc/9yZewJXzRvsday+WO3OVxZ70P+GTeXeuMku
X-Authority-Analysis: v=2.4 cv=HNbz0Itv c=1 sm=1 tr=0 ts=6a984abb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=K5e0w50Y35hYhEYsqgEA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: JOlKp79IfyFyWBzKXLxCc0PtDRgMEkGF
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 suspectscore=0 bulkscore=10 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=10 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020143

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
  (fscrypt_encrypt_pagecache_blocks(), fscrypt_free_bounce_page()).
  Possibly-bounce array entries are unwrapped to their pagecache folios
  via fscrypt_pagecache_folio().

This series is based on the ceph-client testing branch [1].

[1] https://github.com/ceph/ceph-client/tree/testing

---
Changes in v5:
- Rebase onto the current ceph-client testing branch
- Patches 1, 6, and 8: open-code the bounce page unwrapping, as
  fscrypt_finalize_bounce_page() was removed in v7.3-rc1, per Ilya
- Link to v4: https://lore.kernel.org/r/20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu

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

 fs/ceph/addr.c   | 164 ++++++++++++++++++++++++++++++-------------------------
 fs/ceph/crypto.h |  12 ++--
 2 files changed, 96 insertions(+), 80 deletions(-)
---
base-commit: 6b039a71d37a39bb90a64c4e271f90ee0588ac4a
change-id: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

