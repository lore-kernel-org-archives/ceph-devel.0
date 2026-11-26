Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795675845;
	b=iXW4J5CPzYw/avgtLPaHDybDmc9JyKAHS0jPTUG2TtGwKyEU0V72YeXqZFxkvaLLEzM4
	 9W1ht7+Edshje6psijTIGlBJfYObXWgB0jxOTmQfPnRg+mJSgGs0FYUUQesWLYxiNVpjO
	 MVxORjdux0wZC3oMNSE3B7F9mVyNb82wQL3A9PGR+EszvkWsypXAL/oWYy/qOrgw3LPOW
	 Y5BniW46pbXlAo3C0HXIbQ5AleFFbykAz54ZKbgiZqxSGdVMQi6EtOFl+kePFHzuhdjy/
	 R2Zc43dRp2K+OF1rT01BE/MNXfqaMGzznCbvieJh910uTmzVOm4DzBka0UY9h/Cp5Dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675845;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=GITWCZpfGAPgLC68CTN58WtoEbo20uJh8ldAc2YtjQY=;
	b=xwMNeBgdyWvoDl1BYq/Ps44Ya5lnYyhdpkw1P8UHHBCn+X+z7/ZB8u1limABT3ALkCfh
	 vWRhSvjitaLTtzDZfDAfdHteNecwvAo+t91mQmqluNNp/3kvKJ1LipJealsrF0ojF5ppE
	 oZCGE7jEzf7m+bF6EsyF4LnLkvd3Vkh8sRy+B7DpRblw4jOzYrVTcMSLxGAlBxu+Zd5W6
	 uZu0kRkenFnMA9czBuklySaRuoB/RXdHiPwxMi/rTJKnW+JS5UG4XKowPS83yxFNRL20F
	 Y1PAyIKzD/T3nQk+SR4yRoeVUR/XhtwM0QOIbRN6MAt02Qn0SFyQPg8aC1/o7h7cECw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8oF1Igf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6AA606A31C;
	Thu, 26 Nov 2026 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q8oF1Igf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795675845;
	b=bcEsJjvpRtUtGFTf8jr7MMUjRsmQ0t0cV8tCfCNFGhrMGGTKtx/FpTxlgODhvElRKo1+
	 KarAwlfW2K8MAkCOp+zuk9GBUcGGxGIbWyOvERJ01OEGPmH0/dpn50vNM9km6z4ZxFbc2
	 2ZaVAnixnbvjK4LKtKHfKkpghSYQK4WHAMYttDom9wHZwGPCZw8td+YylOg/zsygnBEx4
	 hmqS8qdhL0JB1JESZdpLGPzW8sWyJQM0eenbRY86ty5IIC2Rne7Ukzk/CsvqJaPDieuD0
	 w6EzF2sJZfXpmjUrBeoNc9P/HgMvzIqHuwVRd6+7gVbYReisxUM2QZ2q8N4GqVmdJSw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675845;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=GITWCZpfGAPgLC68CTN58WtoEbo20uJh8ldAc2YtjQY=;
	b=qXVH+Nigzm9PL/ywd5zbhpZlRxiMugcbs2x5V/PGzK3ZkHolgnGeB2VLFkL0EP1JKOtC
	 A8UYs/3eTwgzIaBt84g7sK/V6SYYAZtREjWnaVdvPXdL3Yt0YfvMXF2zcjt0AvstvNjB3
	 a0DknN1NF/UjjAqQ08bBXwrvFAGjz+tvuPrAmBLJpVCK2O4zxODJ9UvRiKvjiK2ZOqNfr
	 3TDelHti9QcHTAgs/smESjJFZNZheW/5hUyIYpWNrinf+R90bhNG4HdV8yC2GX0i+rDFL
	 kMWsdD6xCcBUocDMSQTNfmyMTQ2oFJ6GkQT0NvI9fLcLaqAWCZ3v6ovPSDUazllFLwA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A63FC1F000C6;
	Thu, 26 Nov 2026 06:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795675845;
	bh=GITWCZpfGAPgLC68CTN58WtoEbo20uJh8ldAc2YtjQY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Q8oF1IgfHdZORvXMyoGg7P3D6WATWVOo90wTmMudo7QC4tmRAJsie75jLHfK0zKtC
	 1XnE13uE5vhxEzsCtpqNNDDJpaWQleAGSi3OJVDz0z9k8w2fibgv/1C+p7cTucRcIt
	 toTlAqPXSGVNlL84kdmi85d2ngxy4zP5YW811cJSzghkdB8wsuV5ON1FpAmt2/hqGr
	 ynydJGGJ4NCppZtN8OFwadhlMeBR4lm1Y4m47ZhjMA8cE+MsROwqtmAOYuIhYlkKCH
	 nLf21AHlwNEBnC13hxUAbumGfJUI9+X19dYWH7m91XAlOKjfv0CT7R68zS3feDH+pG
	 0k0LmjHJRYjQg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 33FAE4D2A0;
	Thu, 26 Nov 2026 06:50:38 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH v2 0/2] ceph: serialize O_APPEND writes across clients
Date: Thu, 26 Nov 2026 07:50:30 +0100
Message-Id: <20261126-ceph-append-excl-v2-0-e8707d123d77@clyso.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4XM2jFtecYV/2FYwHSUGqRNiwRC+
 HcL7l2e5NxzNwjsDQe4JRt4nk0wdoygLglQ345PRqMjgxKqkFJJJHY9ts7xqJEXGrDIiFOVatm
 KDOLMeX6Y5Uzemx+HT/dimo7OYfQmTNav5+csD+9PfpYoMK9KkZY5a+6qmoY12CvZNzT7vn8BV
 NjcF8IAAAA=
X-Change-ID: 20261121-ceph-append-excl-64ce323d1a04
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Anthony D'Atri <anthony.datri@gmail.com>, Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795675836; l=3273;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=yDlR2d1RaIN9FaFD/PWjCvrzAXlYIS3GqdUNfZSh0VY=;
 b=20Yin0FM0HaY2A4M/cr7hLxyOBioqxrqW+iW5L5Pt/AhYMbq3I0Q5H76VGxMp2W8oAb6Hn9oK
 ZB0g0sw2OrSAVl4cCCQijcv3lEUDNtnxxDH/b7rpze0hZ9/UpIMo4Hj
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
not have it, the client behaves as before, also when the auth cap moves
to such an MDS while an O_APPEND write waits for its turn.

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
Changes in v2:
- Patch 2: fall back to the Fw-only path when the auth cap moves to an
  MDS without CEPHFS_FEATURE_APPEND_EXCL while an O_APPEND write waits
  for Fx; such an MDS may never send Fx, so the write hung (Alex Markuze).
- Link to v1: https://patch.msgid.link/20261121-ceph-append-excl-v1-0-5870375edeb8@clyso.com

---
Xiubo Li (2):
      ceph: send the cap messages of an inode in the order they were prepared
      ceph: serialize O_APPEND writes across clients on Fx

 fs/ceph/caps.c               | 246 +++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/file.c               |  38 +++++--
 fs/ceph/inode.c              |   6 ++
 fs/ceph/mds_client.h         |   4 +-
 fs/ceph/super.h              |  17 +++
 include/linux/ceph/ceph_fs.h |   1 +
 6 files changed, 304 insertions(+), 8 deletions(-)
---
base-commit: 6a9830a8f414d3830c584782568d0233be969d09
change-id: 20261121-ceph-append-excl-64ce323d1a04

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


