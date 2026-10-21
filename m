Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792583554;
	b=4qpmEZ8nnooYLBggAELXQSsx4rg3oZhtMmi5Gq1CpiSKysFudMbqw5cXkWRDwKl15kUS
	 dNaM7JgZc6I/AEn0azh6FM66872DoqKss5cdFb9WCy1w3fUkLhl8ubtHKbs5HkeNR67XI
	 j3dH64VMsWIrky7+8THHcMWZCh6IAHtXiMDkJu1jDnK1Q4J3p0BpUzZBQjE6QBg2RJ40t
	 i50h5Qxz6n+w2juD4n9lDu8iaJKSCnvOpqlMXkOI88b2BZTV8uM7cjj+BYPQ20rkL7/nM
	 voHrs3VITvZ3EZ8qPpaYhCM6Omtc1mqRq5jf526Vr3ZnMv4tgYii6CER4GCmQUZLKZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583554;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=uGCvIIJrd49R+qzSq0TCHu7v490oUkGlmPJVa/XvZdk=;
	b=1ZNruipZkC2eNMvjhcTLveQ3vL7Y8BeJmoq8TuFy801jqfTPzZ/Zl40Wr3PFG6M/pU4a
	 G3xEjsZUlpq/B0Hx+JrDxyiu0+dYaR49J81dG3ToEBRM0s/xCFidoQqq1w1qsiPVL+Lay
	 /xQ4GvQKAoXqUsqWRKA/NFVTT9Ry4C1L2YPG1Exz5Ekz5ERhNQZAS/o+Xs2wB4HnYCf4V
	 OoCfw+bRjgT/4/P+GQ5UWljgI6OxKB6tNAVkUAgP2rZ2CvphWDF7benT712wqmIqUuGhM
	 Frw3+22pVWFisLSLAqNyEOi4J2OIt3vuI7wIu03OY0knE2d96W8JD+wW9+cHav66ByA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKbfPPJT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C882606A31B;
	Wed, 21 Oct 2026 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKbfPPJT
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792583554;
	b=OpUT8PDO0O6DTy5+JmzJTkpOrQOpZI+UBLkTsCp31U6AUDp1qIIQ0to5Arzk19upE7tm
	 klQ+ZEdjGPW3q99gAmgLk2ggWp+bo5UCRH1/NIZkijDL68hx0A9Hi1FKL6Jp3bPWYkbIj
	 kMoO33izVpfQGz0Kts9BL0PRo1uEZupemo1Iwe+sZYaBXo7CGfuRW5L3hLcjZLJQSZ7c4
	 mfECHLFMg0cl+mPMWPDNm0z1YdYxR9lQq/Sa4bXgGk7x5o4BsqjDMnM1xV05HZ2MakAcp
	 7j0LL0yTqIqpT8zteAG4H98eEUKyDuuNAjjI/pvgwXL0QvJWManzF7SiaEqmC/ACFPw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792583554;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=uGCvIIJrd49R+qzSq0TCHu7v490oUkGlmPJVa/XvZdk=;
	b=0dgCs8xc2n/M96Y025jF6o/jEwsOQ495Kn7drDRlUaj9GHyeb5FlUYJBRBk1Haf01zHV
	 lyS9ooyEUNUzXHTA79xXuG18C3WIgmqTqakFViLkNjmmCc9w3sL0kqGgn2MsEad4iKSea
	 LUUSS7c0I8rR6USlEPqH9xZkMXpm1Wq0JjGDGBWe2SALVg6jpase30+u5uLyCWnfsci/G
	 KTssd1riHaf7pXr9wRMTW9ADgjCdi0/xalLJIf67iotfit7d9HDIokX95Yeq9CvJCSRV/
	 Zw+Y5uf50qAnx1gXO5ukspZbVPWda1Ox6q5Ec2ESTn4aMDLku1ERSqpUpx3+Fmv4bGA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BD9961F000C6;
	Wed, 21 Oct 2026 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583554;
	bh=uGCvIIJrd49R+qzSq0TCHu7v490oUkGlmPJVa/XvZdk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=eKbfPPJTYbrvZXWTWPfOSEHhhSqKdln0glv/dO1qELUPCMSqPGUzyMjaaWCc7XOd8
	 jI39dbp1pkKJwECmz1AXyuN0QGQ7N88gssbFlS1Kriy3Ow8KDQe+Pww+T7zgzs3ml9
	 JkkF8MBUXTTtj5WV85mA3K6Q/ZJhjYEntATWXrBjdWA0mSEbn0bhln8bdjDM9jIBOC
	 KLLi1ke+JoGAu85sIDqwmwfRCbSisNMxa11tpgry7+Q+aa1i1GyVmos3j8zjn5JBjg
	 /Z0BYB8fo/Qq8rT/jsndHoM9D9Uz4qjT8zLOAXOyq/6K7qSCPl3MVr1BtxS+rW0K/3
	 nWDgXO+f0wGdA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1C4FB43354;
	Wed, 21 Oct 2026 11:52:33 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH v2 0/5] ceph: fix lazyio for shared-file writers
Date: Wed, 21 Oct 2026 13:52:02 +0200
Message-Id: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CQBBEr0JmbZv5AH5W3sOwgKZH2iBDZhBFw
 t0d8AAuX6Wq3iwCeaYgzsksPI0c2HUR9C4R2JTdjYDryEJLnSupJVQpvLgHpL6BtvxM7MDyGzK
 rjCVljhZRxHHvKcbb8bX4cXhWd8JhfVsbDYfB+Wkzj2rt/ZWMCiTYFDHXaXaqzeGC7RTcHt1DF
 MuyfAGOc9fzzgAAAA==
X-Change-ID: 20261020-b4-wip-ceph-lazyio-fix-5f13fe138fcc
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792583534; l=6387;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=Vu3NjQZ8b/Yq6wrIMyCJLLHh+Xe4OaVxwf2VurdNroE=;
 b=Z+xKGCykdFdy8k5Pr5ZLxALNn8p7cBk9nqv1fnCzHaEsEWdfvv4PFtMPZxlrGeDgqy3ZXh762
 T7DIEmCPhKxCyhrB3tuczGLNwderRFrfCnytCpqbsBzjlZ0ataOgIF4
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

The lazyio mount option lets several clients buffer and cache writes to
one shared file.  With it, the io500 ior-hard phase fails its read
verification and the whole run is marked invalid.  ior-hard has every
process write 47008-byte records (11 pages plus 2112 bytes) into one
shared file, interleaved with the records of the other processes, so
the record boundaries fall inside pages that two clients share.  A
client writes such a page back whole, and the bytes around its own
record, read before the write or zero-filled beyond its local EOF,
overwrite the records another client wrote into the same page.  In the
tests below each client is a separate kernel client mount.

Patch 3 is the fix: a page that a lazy I/O write dirtied only in part
keeps its dirty byte range, and writeback sends only that range.  A
write without lazy I/O starts no range, so non-lazy writeback is
unchanged and sends whole pages as before.

Patches 1, 2 and 4 fix cap handling problems found while testing it:

 - Patch 1: ceph_check_caps() could put off invalidating a cache whose
   CACHE or LAZYIO was being revoked while the session's cap was stale,
   and nothing checked it again.  The MDS then waited for the revoke
   for good.  A lazy writer on a slow client (arm64, 64K pages, under
   QEMU) hung that way after shared-file writes.

 - Patches 2 and 4: a lazy I/O open no longer asks for LAZYIO while
   CACHE (for a reader) or BUFFER (for a writer) is available, and asks
   for it only once the MDS turns those down.  This saves a cap update
   and a grant per lazy open of a cached inode, and the LAZYIO revoke
   when the only client of a file opened for writing becomes its loner.

Testing
=======

One host, 3 OSDs on NVMe, 3 active MDS with a distributed tree pin on
the mdtest directories, 4 kernel client mounts, 16 io500 processes
(4 per client), io500 with all phases unless noted.

Data verification, lazyio mount option:

+-------------------------------+------------------+------------------+
| Test                          | Without series   | With series      |
+-------------------------------+------------------+------------------+
| ior-hard only, bad records    | 131881           | 0 (3 runs)       |
| Full io500, bad records       | 142876, 73999    | 0 (10 runs)      |
| Full io500 result             | invalid          | valid            |
+-------------------------------+------------------+------------------+

Full io500, unpatched kernel without lazyio vs this series with
lazyio (2 runs each):

+---------------------------+-----------------+-----------------+-----+
| Phase / score             | Unpatched       | Series + lazyio | Diff|
+---------------------------+-----------------+-----------------+-----+
| ior-hard-write (GiB/s)    | 0.193 / 0.192   | 0.267 / 0.272   | +40%|
| ior-hard-read (GiB/s)     | 0.459 / 0.457   | 0.460 / 0.458   | +1% |
| BW score                  | 0.914 / 0.908   | 0.982 / 0.980   | +8% |
| MD score                  | 27.30 / 26.36   | 27.45 / 27.53   | +3% |
| TOTAL                     | 4.994 / 4.893   | 5.192 / 5.193   | +5% |
+---------------------------+-----------------+-----------------+-----+

Without the lazyio mount option the series changes nothing measurable:
full io500 TOTAL 4.932 / 4.929 unpatched vs 4.935 / 4.910 with patches
1-3 (patch 4 only changes lazy I/O opens).  A non-lazy fio sub-page
overwrite test was within the run-to-run spread (about +-4%).

arm64 with 64K pages (QEMU guest): fsx, overwrites checked from a
second mount, and lazy writes of 47008-byte and 3000-byte records from
4 mounts all pass, with 0 bad words, in crc, legacy and secure
messenger modes.

Known issues, not addressed here
================================

 - mdtest's read phase opens files read-write.  With lazyio that still
   costs about one LAZYIO revoke per file in io500 mdtest-hard-read
   (2.5-2.7M per run, against a few dozen without lazyio); patch 4
   removes it only in a smaller reproducer.  Opening the files read-only
   in mdtest removes the revokes in both modes.

 - A lazy read that starts about a second after a lazy write of the
   same file can hang in __ceph_get_caps(): a LAZYIO revoke is held back
   while the cap is in use, and nothing calls ceph_check_caps() again
   once the use ends.  Full io500 runs, which have other phases between
   ior-hard-write and ior-hard-read, have not hit it.

Xiubo Li (4):
  ceph: invalidate a revoked cache even while its cap is stale
  ceph: do not ask for LAZYIO for a lazy reader that holds CACHE
  ceph: write back only the dirty bytes of a lazy I/O write
  ceph: ask for LAZYIO only once the MDS turns CACHE or BUFFER down

 fs/ceph/addr.c       | 360 ++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/caps.c       |  44 +++++-
 fs/ceph/file.c       |   4 +
 fs/ceph/mds_client.c |  10 ++
 fs/ceph/super.h      |   1 +
 5 files changed, 381 insertions(+), 38 deletions(-)

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
Changes in v2:
- Patch 3: when a truncate clips a lazy dirty range to nothing, or EOF
  moves below the range, drop the folio's dirty state instead of writing
  the whole folio up to EOF, which sent the stale bytes in front of the
  range.  Fixed in ceph_invalidate_folio(), ceph_check_folio_before_write()
  and write_folio_nounlock().  The new ceph_folio_drop_dirty() also
  decrements mdsc->dirty_folios. (Alex)
- Link to v1: https://patch.msgid.link/20261020-b4-wip-ceph-lazyio-fix-v1-0-f4cc62459d37@clyso.com

---
Xiubo Li (5):
      ceph: invalidate a revoked cache even while its cap is stale
      ceph: do not ask for LAZYIO for a lazy reader that holds CACHE
      ceph: write back only the dirty bytes of a lazy I/O write
      ceph: ask for LAZYIO only once the MDS turns CACHE or BUFFER down
      ceph: keep LAZYIO with the read caps of a closed file

 fs/ceph/addr.c       | 391 ++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/caps.c       |  51 ++++++-
 fs/ceph/file.c       |   4 +
 fs/ceph/mds_client.c |  10 ++
 fs/ceph/super.h      |   1 +
 5 files changed, 417 insertions(+), 40 deletions(-)
---
base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
change-id: 20261020-b4-wip-ceph-lazyio-fix-5f13fe138fcc

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


