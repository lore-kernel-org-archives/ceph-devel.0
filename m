Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794019958;
	b=FrX09NNFCta9k1eUh/EabNXDvcyPJ/qxCd+m7GMOZcnfCzT047xQSa2tAXgrzRMXInKY
	 d5ye2jyNmf5E0AQyh3UOJ7CXzesemF0ld3QqJ52MdFyDfthNfHYwafNsuwCfan2Q2bLg9
	 AXtkQzzX51510BCDSYJdybb+vlX9HsKT0yVgfFq6tXPLWyhdAY2NO2vHQtekNLKZGDyiv
	 6wmpr/pIQwdXzoE01U92kSav47UZA6duNy1Q0v/jJfHerkiuu4p/BqahTuQupvXvo9LlB
	 +0fSpoTtnd0jCQsoEk+NlZA+V/cXc4mQIOTqyJNpkfFGlUUnubaTvUfseJYMQwcs9zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019958;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fBpJrKlEAuVA87x0dP+f5k3Nd0VhDLyH4dPX6EOktrM=;
	b=1EPpCoDJEe3N5UgNK8MkyFwrYfcDxZzMfUQ2EMzCzhx042SW+U9+XlYI9XqTY9tLfUR+
	 7KZE+QLvUgTNfR58eieQi2HrvH3jKB93mGVcDAt1q/hnkS4EzuPXyZhaEHPK3KpvtfMTB
	 E4ICuFEiytaV8SE8GUqMH2HlvvVir39YKoO4gokDFCyCMB3h5YU4KOkV4DiIbh9OMFoUc
	 tzPBvec3WR8maoL0PzVK+9FXoGG+MTjlpEliauE4xxxbLbe5g804sWbHvaTri3Z8BxZu/
	 dcFHq81eRPQVI2LeGluzohsdGQxr7h+CEn7iXMQa2VPic8qZG4cVOl5dre/0kG8aEhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i48X62Af;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD2606A32E;
	Sat,  7 Nov 2026 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i48X62Af
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794019957;
	b=Mn4Z9WJLoZTomwoJy5orGlxXujmoYNj+/VwbwPzASM7ux28CGfbWpuLFJGJU68aIRuoQ
	 hhU29nPbg+YhDIfvAy/ZxcqAxdxI2jC7A4QkBRYnNSLdRuF3smTM4YO2ctU4Z7RsvmP0k
	 DZB557WUShaNzrYWyOibQOjseOhcj81svPL3HKhngjY6hNL+I8ociHpkLjjpJF1DnaKe4
	 L07UL1jM3LZTnIUvio2s8Tt9aKxxGP4lHPu/TC9UcfNyXZVrT66zJ5tqF16sneNwWofEu
	 K1NAWwMlVCYpq22OJzozdC6Yqpw1AoXmOeAS39ENdiG80zWYeYc1augIJrLTcBUfilw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794019957;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fBpJrKlEAuVA87x0dP+f5k3Nd0VhDLyH4dPX6EOktrM=;
	b=OuaCvzyD2U080YqXaieQuGHYt+eXyR5x4Be1XGlfBVUO6KNQaZayziJ/WbdT22tEgvW+
	 QyOhHCokUmqMZmUTFAgm/mFuBxsjIoeRj5GMh14BsioDwBjsjSZJOqQufXfgejcjspC73
	 ZjEjob//kFW971/ha2fTo26u3kxp/O9fFaYJcMhws8ZR+UKdn9n3NPn7+WO8bGkCyFnrp
	 G3iBzWH5oXmssP8KHZ/gCNnCx3UQgQL1PNCE7Hitw462VRBtHahfU4qYziMyG+Pu6T1WQ
	 V1UYgsnX5tpMuox0iclPqntl9TTXuuDOXXZH7KQlgJlYeHf6eVYTffraB4UJFj2MpuQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2AB611F008A1;
	Sat,  7 Nov 2026 02:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794019957;
	bh=fBpJrKlEAuVA87x0dP+f5k3Nd0VhDLyH4dPX6EOktrM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=i48X62AftLf1lAjvvHLEP8JkH+ykJ8iGgZuERsOSVxdQDkjIk97PPMo3zswVXVLnx
	 e9Qf1j/HVQL2iR3/bFwwL28gDJZM2kxfKQhqc6zsEJ/8ikSJKZf7u7reWGZjzh0h94
	 VvqL+sKPpoCDprOXuuirLPkOEzHAGpdTiInFUWMNq92qcOFaf4urIosXOP2NS5/qxK
	 D+e7GsBwl1+bx9FM5USHCAcVZlS+U7IGixOufOTl4eDVggkop7OfaHnUSJhzsLIYoI
	 kr3qNUU4c+rc1Au/tjuw20S3Ly+6wSEbbSByL4oTu3qibPGiag4G28HjiPSoW+b+8N
	 excQYTkxT4h8A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AB6B54798A;
	Sat,  7 Nov 2026 02:52:36 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Sat, 07 Nov 2026 03:52:27 +0100
Subject: [PATCH] ceph: flush the caps ceph_write_inode() queues from the
 delayed work
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
Message-Id: <20261107-ceph-write-inode-flush-v1-1-6d414faf9ccd@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VeRWXfABIylr1K6qJNJMyJRMt5Af
 HfTdvlxOP8ByllY4VEdkHkVlTEVmFsFFN/pwyi+GGxtnTF1i8RTxC3LXJY0esYwLBrRk2vdvaH
 QWAPlPGUOsv/Cz9ffunQ90/ytwXleIq3U5noAAAA=
X-Change-ID: 20261107-ceph-write-inode-flush-dc67685cf521
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794019955; l=3761;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=eXGBJFcag2PmzZJslBHNOIJ2VYBfjzGWaTeJs83E7T8=;
 b=hmVP6bqC0CKaiq78vyVAC+LMrYfML6EcvTnpAfoOq8Ktsl0OVa6Ntgh6z/k1Ztlaa6esA5U+f
 DGnmqP/1QJ2DifG/Sqn0+4u4s+xohJNNkLCa3gdEePMu0oX4+WCYqr4
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

ceph_write_inode() without WB_SYNC_ALL does not flush the dirty caps:
it sets CEPH_I_FLUSH and moves the inode to the front of the delayed
cap list, so that the caps go out once, after the data writeback.  But
ceph_check_caps() turns CEPH_I_FLUSH into CHECK_CAPS_FLUSH for every
caller, and a buffered write calls it whenever it puts its last Fw
reference.  So the next write after a writeback pass flushes the caps
at once.

A file under steady writeback, with the dirty page limit reached, gets
a writeback pass for nearly every write, and every write dirties Fw
again (mtime).  The client then sends a cap flush per few writes, and
the MDS journals each one.

Honour CEPH_I_FLUSH only in the delayed cap work, which the inode was
queued for.  Other callers still flush dirty caps when they send a cap
message for another reason, and fsync() and sync writeback flush them
as before.

16 writers on 4 lazyio mounts, each writing 47008-byte records
interleaved with the others' into one shared file (IOR, -t 47008
-b 47008), with the dirty page limit reached, mean of 2 runs each:

+--------------------------+-------+---------+---------+---------+
| metric                   | unit  |    base |   patch | speedup |
+--------------------------+-------+---------+---------+---------+
| write bandwidth          | GiB/s |   0.711 |   0.713 |   1.00x |
| cap messages, the file   |       |   78360 |     368 |         |
| MDS journal events       |       |   93470 |     600 |         |
| MDS journal latency, avg | ms    |    4197 |     556 |         |
+--------------------------+-------+---------+---------+---------+

write() latency in ms, 2 runs each pooled:

+-------+-----+-----+-----+-------+--------+----------+------+
|       | p50 | p90 | p95 | p99   | p99.9  | p99.99   | max  |
+-------+-----+-----+-----+-------+--------+----------+------+
| base  | 0.2 | 0.2 | 0.2 | 16-33 | 66-131 | 524-1049 | 8854 |
| patch | 0.2 | 0.2 | 0.3 | 16-33 | 66-131 | 66-131   | 2965 |
+-------+-----+-----+-----+-------+--------+----------+------+

The gain is in the cap and journal traffic, not in bandwidth: any file
that is written while it is under writeback sends far fewer cap
flushes to the MDS.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index aca09351a094..d95eb2f42f42 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2211,8 +2211,6 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 		return;
 	}
 
-	if (ci->i_ceph_flags & CEPH_I_FLUSH)
-		flags |= CHECK_CAPS_FLUSH;
 	/*
 	 * A revoke whose response was deferred (see handle_cap_grant()) must
 	 * still be acknowledged.  Replay the forced flush here so that even a
@@ -5056,10 +5054,20 @@ static unsigned long check_delayed_caps_list(struct ceph_mds_client *mdsc,
 
 		inode = igrab(&ci->netfs.inode);
 		if (inode) {
+			/*
+			 * Flush the dirty caps that ceph_write_inode()
+			 * queued here.  Only this work does it: other cap
+			 * checks leave them for it, so that a file under
+			 * writeback does not flush them after every write.
+			 */
+			int flags = test_bit(CEPH_I_FLUSH_BIT,
+					     &ci->i_ceph_flags) ?
+				    CHECK_CAPS_FLUSH : 0;
+
 			spin_unlock(&mdsc->cap_delay_lock);
 			doutc(cl, "on %p %llx.%llx\n", inode,
 			      ceph_vinop(inode));
-			ceph_check_caps(ci, 0);
+			ceph_check_caps(ci, flags);
 			iput(inode);
 			spin_lock(&mdsc->cap_delay_lock);
 		}

---
base-commit: 5dcec86cc31f8144857c0d9bf2a7fa13b6e6f531
change-id: 20261107-ceph-write-inode-flush-dc67685cf521

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


