Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792483570;
	b=KDF9a80XGOfcTKJLB31jlLPpTLSnVjI4RXU929G1XQSebwSP6kXkTTxWceR/8jGMhVsr
	 e4CGFn3cDDN+suAct7+dMWglfvef/SOumtBgRqL05V1th9jmPukqKxJxYWe6pj5DhcEqD
	 b1MaciuRQ5dsn4t7PgrXlpVlDa5jnCvqn8msSwqsiuqd+K6G6i++7qxb/d/zWFlgB/c1f
	 zXoVZ/tWixaqDyLW6kOMWSfe1xD/POyJwHGH+WPKp6D2tcq14Oa/HbJe0mHc7IJxhsLWB
	 Tu2n3pzMIwmqxCL48CcWWeZZ7y9U+GmejvIqGVOzfDKPcoYDgvejHW7QirR/5Mj5vrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483570;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=vNIB/yB414wsy3q4LO/av8IT/K8/u/HKety/w57bU9g=;
	b=m3ktVuy8mxYhUlZG5udnRKn0BKzQ4fm600aVVik3OZJKYwXlL7GuArKxY8usHSdOrFWc
	 G4kOUbtVqNwfJp5Bzkt+AR+VD5nQ5d0vTz7LfTrnI3OaJbEmhd3vK9+KXkFDQ8RsoRsga
	 e6Y9dCMLBctv2xnX/ta5J0Hnk6JveAP4gP7hleCJlEehPCZE3m/q4yUbJGO5YcxDHNisV
	 QN73orrYuBfXLeX0MVcbselx+iSSlKM08e6OhnXL0x9E4iQDufcwMyN4KJ06eZT4Mb1gB
	 3c7CFILul4ydKG2PmudQgJm8rFXujOowq7PkvOz3DIIYZtLyO3eJc9HFJe/l784I6zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9fWiZBQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1272606A31C;
	Tue, 20 Oct 2026 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9fWiZBQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792483569;
	b=k6/ScyOBW2xFkQ6F5l9Zs02vIzSIo8/L/un9QeHDU/mYjKmRvNCX0KJT81+1fFZ5OQqT
	 5C+XLal6sIAPlkq6L3ZmMjQeSkMQ/9dxZtp1LwAT0KhvO99q5Cgapr34QFD41TRhj7RCc
	 NN2YLELZINfJeXx9Mcunve/BZkgFNqcKy1RzT6vDS5x1drI6CAij7eAkjFCkEbawXyYkO
	 c5hGhwaq/nwERRyNz/JUo9kWIroaAbbaW3WNu6/96WEerGuvtLgjoXBmhR2cQSYKzABAz
	 t/nIe9vMgAhZfQq7ftQ4DmNGTmBw+hRCjvMLoIqStaEvDKAB6yzW/EtHJSA0V8MJMSA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483569;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=vNIB/yB414wsy3q4LO/av8IT/K8/u/HKety/w57bU9g=;
	b=Avrs6d/qXf9tC6QDWTUJemfTMZEdIarmiAJ6jI+2+vKTWJjzSf/DTZ+bjJ0Im1P3XCdL
	 spbTIDCFhZj3Qqc8VmRHrUsNiEsM9KcuAFDw2tEHlIPRnGjPBEN8MJx+n9hLFnjVDDqKS
	 155R1wAzRP+0usJ2hBqW0pBAtKVLR3bcWNs4RNQQwk3cFWfQH93KO58BYxTiH2s1ctMPP
	 +7Ss8Stm7HbN79bIChX8MzlfnA3Ba5NPU1dWrFeIEzDLzHQYid1UlSut+FWsds//jXuhb
	 TpJhBFhlk0Opivupe7+B2/6qpC97wAy6W/EE1anT1R2Zch+OvZvgWqQhzl9tdFTlsoA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E19C81F000C8;
	Tue, 20 Oct 2026 08:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483569;
	bh=vNIB/yB414wsy3q4LO/av8IT/K8/u/HKety/w57bU9g=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Y9fWiZBQDkhntNWxBwJFg925nEKdAO8h0XlmGjP4Ttia/87ZYt7e/l5azqx6TTC3g
	 oHH+OegetXDgAHo7PVcQZFgmKNFbpy0bp9M0mUqDPIip3jzZ0B4s9j3FO72NxcZqZG
	 kXx8OddcAnZVcAcccHXwLdto9iCx6GoKEQNuIfvQFeVlm+pzVHk906wVhSBkg9zYP5
	 QcgDdn3OUAY5pOHmXCnN9m/lpa1baTYIvQxN13QU423tFJlA+ya7gdwgFzMlqg4a80
	 LiSPomDiYItfSMDpAW+8mS8g7W7XO3nawon3q6GFxYiPXp1jZHQTgpYHc2CbmNJpLK
	 NRuJM/+QqKyiA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 41DC043085;
	Tue, 20 Oct 2026 08:06:08 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH 0/5] ceph: fix lazyio for shared-file writers
Date: Tue, 20 Oct 2026 10:05:46 +0200
Message-Id: <20261020-b4-wip-ceph-lazyio-fix-v1-0-f4cc62459d37@clyso.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VeRWXcgiVWkr1K60OlER0RD4l189
 6a6/A6c/4DAXjjAKznA8yxBhj5CPxKgpuxrRvlGg1Em18oorJ64iENi12BX7psMaGXFzOrUsk4
 LSwTx7DzH+Qq/P7fDVLVM478G5/kDXMelDXoAAAA=
X-Change-ID: 20261020-b4-wip-ceph-lazyio-fix-5f13fe138fcc
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483564; l=5859;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=XH2a8zLAWIxqBUyfnhvSRVD0/EPS7XChq0jkTxdXs/0=;
 b=QZJaPRm03RP7mL/N8XNXWAzs5JdqvnrPMiuRl7Jlhe4ZSoCnMHe/ByZLEci2DExfTTELMWPOP
 EEQG08+R190BZj0jk8546YAxqFibrDL/oyXaxmXO0uOYxRtgf2mFT4b
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
Xiubo Li (5):
      ceph: invalidate a revoked cache even while its cap is stale
      ceph: do not ask for LAZYIO for a lazy reader that holds CACHE
      ceph: write back only the dirty bytes of a lazy I/O write
      ceph: ask for LAZYIO only once the MDS turns CACHE or BUFFER down
      ceph: keep LAZYIO with the read caps of a closed file

 fs/ceph/addr.c       | 360 ++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/caps.c       |  51 +++++++-
 fs/ceph/file.c       |   4 +
 fs/ceph/mds_client.c |  10 ++
 fs/ceph/super.h      |   1 +
 5 files changed, 386 insertions(+), 40 deletions(-)
---
base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
change-id: 20261020-b4-wip-ceph-lazyio-fix-5f13fe138fcc

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


