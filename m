Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793347674;
	b=pPHvHWIQyFNbG4qzkpvDrITmmG/oA5Iu/tezYvkVmgwsEsSTr37YpgptDuuzBv6qOZh5
	 KWBJnrgyMcnM7Rs1oV0iMLJeJHkGl9/zMbV4WDR9CN+9oOj8Ef/eUOneF3c0/s6dgW7IC
	 sSXS5o+vUp6kgEyz0Sp8OgWS51oFYyTeMJ3pW4rybcXIVE8K6pmI5ENMnV02xlI3S9W52
	 bs+NDn+thJU0O8nkxNrOWFW71hWdZe/mDbWCl8M/Vc+GlzqDLrgydOgpXh75Vg3mcAR+m
	 XuZ+NLNUMJobt9Ch/50HQtlK4GyQL6/b//OixuDTYajnmOMWdJSrH5Dz/5gMfght/hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347674;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=JIEYelu8LGfbAOWPMQ/DrmTZp6x2F2wTkAMkUsm9CJ8=;
	b=Kh04U+p7CJHKil6WV8ENCCKISVOVDCahErS8oAqb3sjfKBk/U3yGcLA+Wv9vvWRw/TGE
	 x2PevQ6H2/Q7bFnrEowbtobeFJdaWwCuaJbXRs4VWq/lIuAZVFN1L5klZhMQHkfCFxxOl
	 E1JQtH9pZ1tY9FqeVLvKm32iR3xmUQnyH3bNfpx5TcimRPJzwuDBZQQiUwQFFXl5cegFk
	 kn4zyYjCsB+IL6mcugdwF46VZ+tCQQMPjkah0bSdfGLcwrl7pIWy3rMTq8Dw42iYa+6is
	 5znlGsMAnZ9X6wihQd0SdPtT/SVliUyuGEfj7v3lJ0LNcDtD7aW373Ecc1S9yk45CTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNMxXDPA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BEA606A31C;
	Fri, 30 Oct 2026 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bNMxXDPA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793347674;
	b=U+iC5GigsNscRzt6XdyV3hR60ICvhNwvDO3G9Cch9oUwUvp8JAzINkvEPFyat6wzgDJ3
	 xsCz8fXlb31eF3o7ml9v+pIX423v6TIBI5a2WOQqd1jBTxXtmjs3DJECcmkgAgpj8aKTs
	 UthMPqO5BxJSIOLY/dDZxI1HVchiJOhVgCREDPjb/sCae5W3c6hNqv7D3/Ju+U7035NU3
	 7iptkp5Y0qn3uf8PzxUHStvptzu/acBoUOmWxMHn4DgBUTi4yVNpuA/A99LvJBDm6uPND
	 EXDAVo/JPooD+oqnv74hwTEPD7Y7dJe+ahmG/K8FsYpi5mPgZ95oK7wbL5wnlHmDMMQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793347674;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=JIEYelu8LGfbAOWPMQ/DrmTZp6x2F2wTkAMkUsm9CJ8=;
	b=BGyGps/uWGB0zDxycf2yZRoTk2NaBokc79Wi7Y9rP5taU91d3PxHEjADHJdwc/74mhXM
	 HHDLX0iZepnxUjOLzBdd5PJhVOlGCf23nEDC99L8yA8JwnRNafxp79KNYi6hgbezyQAiw
	 hS8jQdShq5a7vzElNgCx09pD1XjUqQqEY6gMZ+U0pipX5ZXmRUEBA54G1YRDzZ65e+/A0
	 tafvX4Ad2i40kwxFtDMwolU+bs7QRTji3UJ+TDlBY2uAe/bB2rBfyX+5BRE2pzlzNb+Tc
	 iGGurBiKqX5pGl1eFQt77pVPKtJzXA0u5bW5YfV6++cwA88KfHG4wqpuDp1qCMMUYoA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 10FED1F000C1;
	Fri, 30 Oct 2026 08:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347674;
	bh=JIEYelu8LGfbAOWPMQ/DrmTZp6x2F2wTkAMkUsm9CJ8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=bNMxXDPAmihN4qM9HTx6oLPNxJcyqRl81uJ84WHeq7o+uEYLxtRrc8jBbr0+Fdmtr
	 1DDzwuj/xsAWGvLQ8hWY1AKWYuBJNeccucRjHP52vPGPx3HbYsp3EhbWpvZbfzZOd4
	 AWDz7pgfsv7D40bX8zeWDWowM+mX2KnjanreJO71SB+jI1DHPQglaSRJ6Q7hq3rKq+
	 eCR9wlDl6raX0eUvGV399arNSDYiLbfhaV+BFflV7qndnzps4AxuJoxaCslnpqinVr
	 sIqMgvDuW9qP+E53tKmddbWfg3B9kwvZbX8AD7N0ggA7p+qwQrdUteykw2SJjIkuSE
	 n55LCQRBvfbwg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9663B436CC;
	Fri, 30 Oct 2026 08:07:52 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH v4 0/5] ceph: fix lazyio for shared-file writers
Date: Fri, 30 Oct 2026 09:07:32 +0100
Message-Id: <20261030-b4-wip-ceph-lazyio-fix-v4-0-f734a26bbaab@clyso.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOwW7CMAwG4FdBOWOUOGnacuI90A7FcdZM0FQNd
 OtQ350ULjAJ7fhb9vf7KhIPgZPYrq5i4DGkELsczHolqG26T4bgchYo0SqJEg4GvkMPxH0Lx+Z
 3ChF8+IHCK+1Z6coTiXzcD5zHd3j/8cjpcvhiOi/astGGdI7DdG8e1bL3b8moQII3RBZNUTtd7
 ug4pbiheBJLyYjPjHrLYGawcFiZsnaWm7+MfmbKt4zOjPNYoyUtK/vyzTzPN0SjEz5cAQAA
X-Change-ID: 20261020-b4-wip-ceph-lazyio-fix-5f13fe138fcc
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793347670; l=10971;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=jCK/y9SZTTiG05+uogXL/GpT5eGRDR/hHVAhDleYRSs=;
 b=HTvmJCr9SEMIsWyj8pRXvY/7z/ka7pNyY4Hdd+2QI8bKy1CItnWTzvjPeHpmnT6SuYneLEVSG
 i32eyJBejPGBnbPGBYfZsgX4+f+lBsBIJk8E1uWECL0UE+GXgHGVmpM
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
unchanged and sends whole pages as before.  Nor does a page that may be
pinned for writing (GUP): the pin could write outside the range without
the page being dirtied again.  With fsc, the cache still gets whole
pages: it only serves this client and is invalidated with its page
cache.

Patches 1, 2, 4 and 5 fix cap handling problems found while testing it:

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

 - Patch 5: a closed file keeps LAZYIO as long as it keeps its read
   caps, instead of sending the MDS a cap update for every closed file
   only to give LAZYIO back.  With lazyio, io500 mdtest-hard-read sent
   about one such message per file read.

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

Lazy I/O functional tests (x86_64 QEMU guest with KASAN and lockdep,
vstart cluster, two or four independent lazyio kernel client mounts;
every test but (7) checks the file from another client):

+------------------------------------------+----------------+----------+
| Test                                     | Without fix    | v4       |
+------------------------------------------+----------------+----------+
| ior-hard pattern, read-back check (1)    | 3 of 3 runs    | 0 of 3   |
|                                          | fail, with     |          |
|                                          | 2408-2693      |          |
|                                          | errors each    |          |
| Truncate below a lazy dirty range whose  | -              | 0 of 80  |
| cached prefix another client rewrote (2) |                | cases    |
| Same, truncate injected on the writer    | v1: 19 of 20   | 0 of 80  |
| (3)                                      | dropped-range  | cases    |
|                                          | cases fail     |          |
| Same, writer's session stale across the  | -              | pass     |
| truncate (4)                             |                |          |
| Writable GUP pin held across writeback   | v2: 3 of 3     | 0 of 3   |
| (5)                                      | runs fail      |          |
| Same, the pin released between the lazy | v3: 3 of 3     | 0 of 3   |
| write dirtying the page and its pin      | runs fail      |          |
| check (6)                                |                |          |
| lazyio,fsc: overwrite at page offset +1, | v3: 3 of 3     | 0 of 3   |
| evict, read on the same fd (7)           | runs fail      |          |
+------------------------------------------+----------------+----------+

 (1) io500's ior-hard arguments (47008-byte records, 1000 segments),
     8 processes on 4 mounts.
 (2) A caches a page, B rewrites it, A writes 32 bytes at its tail,
     and A or B truncates the file below them, with and without
     extending it again.  The MDS revokes A's BUFFER cap first, so A
     writes back before the truncate.
 (3) A test-only hook, not part of this series, moves A's EOF below or
     into its dirty range (with and without truncate_pagecache())
     before A writes back, which reaches the clipping and dropping
     paths of patch 3.  v1 sent the stale bytes in front of a range
     that the truncate dropped.
 (4) A's MDS connection is blocked until its session goes stale, B
     truncates below A's range, and A reconnects.
 (5) A 2 MiB O_DIRECT read from a dm-delay device into mmapped pages of
     the file, held across an fsync and a 100-byte lazy write into every
     page.  v2 lost the other 3996 bytes of every page.
 (6) As (5), with a test-only delay after the lazy write of the last
     page dirties it, in which the read completes and unpins.  v3 lost
     3996 bytes of that page.
 (7) A reads a page into the cache, writes one byte at its offset 1,
     fsyncs, evicts it and reads it again.  v3's cache write started
     inside the page and was rejected (-ENOBUFS, ignored), so the read
     returned the old byte from the cache.

KASAN, lockdep and hung task checks stayed clean in all of them.

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

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
Changes in v4:
- Patch 3: look for a pin before the lazy write dirties the folio, not
  after: an unpin in between found the folio dirty, skipped it, and was
  gone by the check, so the pinned bytes were dropped. (Alex)
- Patch 3: round the start of the cache write down to the page.
  cachefiles rejected a write starting inside a page with -ENOBUFS,
  which is ignored, and the old cached page was read back.  The OSD
  write keeps to the dirty range. (Alex)
- Link to v3: https://patch.msgid.link/20261027-b4-wip-ceph-lazyio-fix-v3-0-df2926c30867@clyso.com

Changes in v3:
- Patch 3: start no dirty range on a folio that may be pinned for
  writing (GUP).  A pin older than the folio's last writeback could
  write outside the range, and the unpin does not dirty an already
  dirty folio again, so writeback dropped those bytes.  Reproduced with
  an O_DIRECT read into mmapped pages of the file, held across an fsync
  and a lazy write into every page. (Alex)
- Link to v2: https://patch.msgid.link/20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com

Changes in v2:
- Patch 3: when a truncate clips a lazy dirty range to nothing, or EOF
  moves below the range, drop the folio's dirty state instead of writing
  the whole folio up to EOF, which sent the stale bytes in front of the
  range.  Fixed in ceph_invalidate_folio(), ceph_check_folio_before_write()
  and write_folio_nounlock().  The new ceph_folio_drop_dirty() also
  decrements mdsc->dirty_folios. (Alex)
- Link to v1: https://patch.msgid.link/20261020-b4-wip-ceph-lazyio-fix-v1-0-f4cc62459d37@clyso.com

To: Ilya Dryomov <idryomov@gmail.com>
To: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Xiubo Li (5):
      ceph: invalidate a revoked cache even while its cap is stale
      ceph: do not ask for LAZYIO for a lazy reader that holds CACHE
      ceph: write back only the dirty bytes of a lazy I/O write
      ceph: ask for LAZYIO only once the MDS turns CACHE or BUFFER down
      ceph: keep LAZYIO with the read caps of a closed file

 fs/ceph/addr.c       | 417 ++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/caps.c       |  51 ++++++-
 fs/ceph/file.c       |   4 +
 fs/ceph/mds_client.c |  10 ++
 fs/ceph/super.h      |   1 +
 5 files changed, 442 insertions(+), 41 deletions(-)
---
base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
change-id: 20261020-b4-wip-ceph-lazyio-fix-5f13fe138fcc

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


