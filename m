Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795224081;
	b=kGn3qsV/+wvmiU3/zHPKlFFHmiPLivY4bw3t+hNaPFDQITC4knThM+cIy/jH18lCjCcY
	 W6EH9y98MIxsMzYtLVmV1fHnAgfaJBmLu0LQ9sLuzAFHDSqYNAJF4c060izOU3oc8hSKc
	 n/TVDUfkiOiuHtuuwPNjT728j8JK/DWTX+KTeoKpfOBQxSA7S0NfEXgZ/sd5vy/C5Ko7K
	 2ReW+LbSE4lkOWiPpx4FwiAsa0tWp6jMXcS4VGEWGnbMzevah6oPTjfc8EkP547L617qz
	 GDYeEfuTLnPvI9DxSVrmKqPnk1N7XsivcoMQfaZKayrIhHIZfHZaambNiUE6r9RWwqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795224081;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=7nN+j2hfkPr6uBqRp6A98tWhEuwkE+WnQxFkIA9FSCw=;
	b=NkZ4xlBSqm+gFr27iwBbAsEW0lpfShSgbbFugqnttoNLhbFAqZw+P20rsFhXaWEu2tsV
	 2HdOr5naS9bYFWfrvT+8Z6O2/jeZd6C20DPWpLBOSxKxIfnU+OMgPWfJPIg0pcO0q6kzb
	 OCZ6amazV5+dkP0FGQfCW2ywPNLvXz7XGOohfiAxv8uD8LquJX4Qy02n1FpR+Nz4WGPwH
	 AU/xp43JpvRT3xYpm8eU09oGO98vFhpbaORfC/QDTiKPLuPpD7u/Dn6gHsY6MrB2AZVE2
	 FRtLHKR3PeyoJhwT/dfllXsxxx1AknCOY4qquUSW9omugX/rjNCHlKaYbM45zBfGKww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5yP7+7x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE52606A692;
	Sat, 21 Nov 2026 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5yP7+7x
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795224080;
	b=BuPSXmkAPEDxjCo05j6YShMRa+joF1A+no18CrwVxnUHNU4G3tM4q9egBM903UIQcAQL
	 scU2OSkMKc5PrEC6DqtRGhPCHnHjfkO27WVv4rUQuZrIuIdZVWvWT5CBc2XuviURRQW0/
	 75A37QQZ8lOmuLyrRV/S3UBE8J+DpMRlD9y8a+Ur59j8GXKq5671SX0HqMzb4uQlDYCYy
	 dsWy5tqsLjU93yoBupGIArnQ7yWHWCTBpHX4dyQPjMjIdpaLNQ5883cTW49eCGcvOZ+v6
	 BFKVwOlY8UkV3P2viZnCMPKwAuUZkoSFDG/ugyKSFn/qpCQWOrNrHHhTD9YYVTt5v6w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795224080;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=7nN+j2hfkPr6uBqRp6A98tWhEuwkE+WnQxFkIA9FSCw=;
	b=eo0oqZlGT0ytm3ppY2R/ZyZvEq6FrhrQV2y/ggk6lt6bL5QKZGdNToXoAiwtFIAsgsPs
	 gtJK0AN8yS8U8rd76QJVPgH3xhsy7Wi4n53hBZ/GrdaeqEwLIaUt62ibICKr8UCYx0wvY
	 dAarLeyfXE3aEfgdWvQeF5SVWSVbPRm2t9LZze5apm3hiDVXS8plqS8E5WtM1OEix6Jtj
	 ViwJhYmp5Lr5LKOu8R1gMkf2CVn1fpQZEClynUVEvnxcWihS5+q4maDHW0mOu0qPH+f+9
	 ULLn0wcpaSCcczHlVSOyB+NVmX3J+nBAnUXJ0g2PSaHYj7LexOjdVZZZug9yrjpInsw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A32D11F000D2;
	Sat, 21 Nov 2026 01:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795224080;
	bh=7nN+j2hfkPr6uBqRp6A98tWhEuwkE+WnQxFkIA9FSCw=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=a5yP7+7x+hPDo8M7aMpgSwNO8GU7gKf8fibiin61Rxs/zydKJDRa+6byHrzsmjKRN
	 j0m/jBHn2XjxX2pUdn0fXLeQ56EiOb/zKNXRAL1QB3Qloz5V5fFtG9IR/WERPfktTq
	 fyXZloZyMEsoy78p3W+wPmoQk4o4CrMwylD1C60RSknq+w4SPkH/ltMYpzheRQwb6r
	 L7EhHaGquapto2/WOZM53x4IKZZnJfDzR6HQ5uMJXcaRPzIAlpv1tCTH/7OG2NUwcD
	 tfxSRbrydpp4bU5ECg0k+N0388k49QCRlno8afbYZ5qwv3tIZqUGU8kwidM5j99Cbb
	 mxo3ZE35CXcAw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 048194BA9F;
	Sat, 21 Nov 2026 01:21:14 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH 0/2] ceph: serialize O_APPEND writes across clients
Date: Sat, 21 Nov 2026 03:21:04 +0200
Message-Id: <20261121-ceph-append-excl-v1-0-5870375edeb8@clyso.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTsJUwgLr0Jc1OmvjCG1aZWQE
 O5O0eW3eG+jgmwodG02ylis2DtWyKUhnXx8gi1Uk2vdIOKEFWlinxJiYKw689ArOtcF8W1PNUs
 ZD1t/y/H2d/neX9DP+aF9PwDiK5dVdAAAAA==
X-Change-ID: 20261121-ceph-append-excl-64ce323d1a04
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Anthony D'Atri <anthony.datri@gmail.com>, Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795224072; l=2848;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=RCPLg7Ke9jKSrF2JxKZJ5I96oPla1eTrmZ1jJ4NOnWs=;
 b=GOoO+Hp6nnCDWHPEgyORCvLlfMUbIJy2HFEj8sd5wMCj4biuKWBOUWTKeeaqoVUgLMwW8pV66
 KvtBjaGRA+UBlUENECfLOlwVX6D/boql/HSNcLLxbq4Sd7YoWmBSRgJ
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

When two clients append to one file, the filelock is in MIX and both
hold Fw, so each appends at the end of file it has cached and may
overwrite what the other one appended.  Commit d2a8d446a09c ("ceph:
revalidate ki_pos for O_APPEND writes after cap acquisition") does
not cover this case: neither client waits for caps, and the other
client's size only arrives after it flushed its caps.

The MDS side [1] lets O_APPEND writers take turns on Fx, in request
order, and sends the current size together with Fx.  It is enabled by
the new CEPHFS_FEATURE_APPEND_EXCL feature bit; with an MDS that does
not have it, the client behaves as before.

Patch 1 fixes a reordering of the cap messages of an inode that this
work exposed: a later cap update could overtake the flush carrying the
new size, the MDS then finished its Fw gather early and gave Fx with
the old size to the other client.

Patch 2 is the O_APPEND change itself.

Tested on a vstart cluster with [1], KASAN and lockdep enabled, two
mounts (noshare, or ceph-fuse + kernel), 4 writers on each, without
any file locking; a lost record means one append overwrote another:

  +--------------------------------------+--------+------------------+
  | case                                 | runs   | lost records     |
  |                                      |        | base / patched   |
  +--------------------------------------+--------+------------------+
  | buffered, kernel + kernel            | 4      | ~3300-4000 / 0   |
  | O_DIRECT, kernel + kernel            | 10     | ~4000 / 0        |
  | buffered/O_DIRECT, ceph-fuse+kernel  | 6      | - / 0            |
  | 2 active MDS, export every 3 s       | 4      | - / 0            |
  | MDS failover during the writes       | 2      | - / 0            |
  +--------------------------------------+--------+------------------+

With an MDS without the feature the patched client loses records like
the base one, and does not hang.  xfstests -g quick shows the same 8
failures (ceph/006, fscrypt key tests) with and without the series.

[1] https://github.com/ceph/ceph/pull/70279

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
Xiubo Li (2):
      ceph: send the cap messages of an inode in the order they were prepared
      ceph: serialize O_APPEND writes across clients on Fx

 fs/ceph/caps.c               | 208 +++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/file.c               |  33 +++++--
 fs/ceph/inode.c              |   6 ++
 fs/ceph/mds_client.h         |   4 +-
 fs/ceph/super.h              |  17 ++++
 include/linux/ceph/ceph_fs.h |   1 +
 6 files changed, 261 insertions(+), 8 deletions(-)
---
base-commit: 6a9830a8f414d3830c584782568d0233be969d09
change-id: 20261121-ceph-append-excl-64ce323d1a04

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


