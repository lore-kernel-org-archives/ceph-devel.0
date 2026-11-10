Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794312739;
	b=m27ALdzn2O+wJ7IhPTBWTlZ6L0RfhXgSlOne9LC0EZ/Imp42KoF1dyceVUZEac7fGf5Z
	 p7tFVwzQmlfuXhU+TLDBKJcXuunJsuqSrgezNeMZF0dxedjHVoD5aJQZ2S+jBQJexTf83
	 nuAuvUAx/bN3gP0G2IWnw5LbwB0AllptIA0Fg3HiYd4b063VgAwo6NMwy98nluVd/YTy9
	 QcCuh3RJR2SpQzwUrE/qMlw+sDZlt+gcuwkCQWtq/UYcCwuEI8qJ08fC73QxFivkts+ag
	 kwfk0C+dJvw3ylVwPSVWF6dx+fUmOtzflUMIHCNY529bbjWM0wCFYmz5N/VIm6snF+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312739;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=2yoD5VZ9ZvyluG4ip+5+fzbZiI13Ev8Wj9W7ZG1+DXQ=;
	b=K4jlvXICcKPCWOR+W5lGxSiHVblTf/mYVkqBSAAxCyP4erF59/zFmBoYocQTDHVoq5mP
	 BRqEBUPiCD/z3zWF41MT80n3X8RB5j6JkbODLsdHQYfgJHNBShxCVJB8Y6OyDIBkBgqGx
	 anbxbqqwM4nwRptVD2jReFL3KsntSd58JDlh7kOCupTjvx7hx9dJ8GHQXANi/tFKvHq5G
	 pNug9CIPGi4D3FytBdXcMgusR4AVPcXGIqKmYqQJqv2WJkzifN1QkNMi08evNkls8uoRk
	 B8UgKQWYyTBSuCPA6P93TRg8GDiftWajkJ1fA9H8n1lFIGKz0Tr7ek483Ao3eoGwnBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FV8njbz9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3A606A32E;
	Tue, 10 Nov 2026 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FV8njbz9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794312738;
	b=yTOgB3mUa1xEfRRfxuYInpqylTBakIyBEOilwbaf0xJQbotUvy/sGrx2lUYH4r21rqIc
	 ZwsMGkGTMuxTrj84db7VpQmvpJZLdLeJ1vRwh2TRUU2rcnMCaHtyQ2GLE6TFNZd41rgor
	 2WuvNZ0nIhvCMPL6U9qKqTCyK5PfvKoPfxTSacHJGnYAwMn9gW5Vv2IctKUmbZ7n2rhE+
	 SdBrSAiU/J7fpQcsPfQEejZZPLSoyYgC7QzfmRsqS3borl6GmGlWnX/JavtCth5m1hzPF
	 xLcLV4Qkmk+WGjjjeIuh2h9My96aGQG5cpzvNLkNZyv/3V6k7crH+lMwCN0tAJE21eQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794312738;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=2yoD5VZ9ZvyluG4ip+5+fzbZiI13Ev8Wj9W7ZG1+DXQ=;
	b=ZiP8Ngx1MkBGb8c7UfO6Ky+YBM+Zu/dPyd74RamSzrVhjL+1CENZCE1GLKvO5pdLoqJd
	 cpWqnMGmfnefIhaKZXfwx+wInLNaYGNTT9yK7lg2IM+b1HSdQn29OvbWMND64YpfXmp2K
	 sBUNJRaMALAuOP+lFRJZoDxhvp50+uen19M3hNIel4xGYlDM2Vo+WqtzHkmUAj02fSCSc
	 qg+zm+Y3MSXsj8ZNH5gp4FRdYvUwJlxp+Rslue3Ax5vDWHCcm29lHbbbhF+mUje5kPwIl
	 nD3hdfbv65rGQHNaUWxYpbJOWK7dZ1gsaXp9jiYRS5kLzuwEhuMmGGbIm3qfIPNhPLQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1DBFA1F008BD;
	Tue, 10 Nov 2026 12:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312738;
	bh=2yoD5VZ9ZvyluG4ip+5+fzbZiI13Ev8Wj9W7ZG1+DXQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=FV8njbz9OzLs/QOmUrObxrlgttsD66DAKYu2ug+vGkPt8gWS8IRxiROx8iEJRWPOF
	 weKhvUeh7katYdGQWbMfvbr0OXy3vVQs1eVgAvgraNnRrAbXeDndfl+EVvxR7r+YQi
	 7r9FsRJiwxwSFEeBzfU2RMH+KxmsK4wvK9Q4/5nauDDOX6PrxcmiksHdUtcyKWLb78
	 F3Zh24fORSrzCOUeNvdwjVo+3tXTA+/39bdeMvvTEvXpt/18e6H+smPNE/M0+ksmD5
	 NYzJa/ui25yIUYRafsmXZDs5Aoamuy92dlYH/rafSvaYPkry1tESAaq9f1y0q5n+Rz
	 zWSNulM6R6nOQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 67C8E48B31;
	Tue, 10 Nov 2026 12:12:17 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH v2 0/2] ceph: lazy I/O write and LAZYIO revoke fixes
Date: Tue, 10 Nov 2026 13:11:51 +0100
Message-Id: <20261110-ceph-lazyio-noread-v2-0-259775214b39@clyso.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7ZgWDQVX3MOwKNNRxiAlLRKRc
 HcB9y5f8v77M0QOwhEuyQyBR4niuxXSQwLU2O7OKG5lSFWaaa0MEvcNtvYzicfOB7YOVW5cVud
 EVDhYh33gm7z36LX6cXzVD6ZhK21GI3HwYdpfR715fw9GjQqdOp+ygoyytSmpnaI/kn9CtSzLF
 wj6UGTGAAAA
X-Change-ID: 20261107-ceph-lazyio-noread-087d6b8ccc9d
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794312723; l=2171;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=46MayRn4PkowK9ASiX0DvHBX+OfL5NdVD7YGVyWj/BA=;
 b=GgXnyZE3IzT7VP0izkQ5xcbLu1b+Wh5PGbuTgtvGFEd4S3AjouRpdyV0D32JA0sEuOZ9xQfwX
 gQ/1kobFcL/CcP3RTSikmVyNaaA9XOxFHnjvazRjtD/G29DPYRNvn3p
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

Two lazy I/O changes on top of the lazy I/O series already in testing.

Patch 1 stops a buffered lazy I/O write into part of a folio that is
not uptodate from reading the folio in first.  That read is done
synchronously under i_rwsem and serialises every writer of a shared
file on the client; with lazy I/O only the dirty range of the folio
goes out, so the read buys nothing.  16 writers on 4 clients writing
47008-byte records into one shared file go from 0.27 to 0.71 GiB/s.

Patch 2 makes ceph_adjust_caps_used_for_lazyio() move a use to LAZYIO
only when that use is in the used set and its cap is not issued.
Otherwise a file with only clean cached pages holds a LAZYIO revoke
until the delayed cap check, up to 60 s, and a getattr from another
client waits that long.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
Changes in v2:
- Patch 1: always install the dirty range on a folio that was not read
  in, even if folio_maybe_dma_pinned() reports a pin; a folio that was
  never mapped cannot be pinned, and a refcount false positive sent its
  unread bytes to the OSD (Alex).
- Patch 1: accept and report a short copy into such a folio instead of
  returning 0; the copied bytes could already have replaced bytes of an
  earlier write in the dirty range, and a failing retry wrote them back
  without reporting them (Alex).
- Link to v1: https://patch.msgid.link/20261107-ceph-lazyio-noread-v1-0-d04369c70ab7@clyso.com

To: Ilya Dryomov <idryomov@gmail.com>
To: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Xiubo Li (2):
      ceph: don't read a folio in for a partial lazy I/O write
      ceph: do not hold a LAZYIO revoke for pages that CACHE covers

 fs/ceph/addr.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/caps.c |  11 +++-
 2 files changed, 174 insertions(+), 16 deletions(-)
---
base-commit: 5dcec86cc31f8144857c0d9bf2a7fa13b6e6f531
change-id: 20261107-ceph-lazyio-noread-087d6b8ccc9d

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


