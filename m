Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794184046;
	b=qaXKTxUlFuh6c/G89Ra48k8vqwgzXnGK4xojt7xtBDUIifj5/KdYirqQ4MopKehi/291
	 1JtFz0N3R03GdLNTUvqJSz+B55gcj8Lqxs0nLea/vG9V3MUnhmN5oS9tGXkFjYk3lXcVp
	 juGHEzoWz/cAo+RLMKFtQZZk6eOmKraB7jFa/IusWKMJ3EOAshY7VLeoqRatS4vkR4YzN
	 roWBrmiD+3VJyB1GDDf0muFqAIosw3ZoMLBdBNM/oI3JXY6JJm7G9Uk669u0opw6YoVQY
	 J/BST7hO8ixCuP4cjgTzuSbIxyWTKDf9ZpIF/Ozk6/cI3g4V7l87UDFg9lBzi7fZB+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184046;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Fgi8dZsDiVgf5P721ugNnqmxUTix2UebH9jaWVQXTb8=;
	b=ioHkCSbvcxgrmgUmeoQ0MkstQdTIqydxFC9tho5KaPxVvT4BXslToSnVyUkV5h8dsxOO
	 XJStexOmPVBqwjVWZEd1aKvWYEfirD3i71tIU80IHipQ46wmMZslOXIpa3/HW7wy2AO9i
	 qkx0cBEzvgYb1YgHQ83mOfG3Iqm4zHA/UHeYcEThKo3DjaGu7ozG5ooVi21KO+uz4+akS
	 necM/3bcFFyd1JQbPw+g4N4klp4rnrzZJhX7c2ViJF3Hh8f4klcrKD15liC/6knEtQeUg
	 iG8rNxJ9kzy0Ed0fipugiOKYuT/ZoDnYIfhP4kxRh3rF1TFh6Dlx8/uL3L//Dv0MW3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUVYf5da;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5CD606A31C;
	Mon,  9 Nov 2026 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUVYf5da
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794184045;
	b=RdsXnd5xhd7xVDv8v0lJ66jUdvlUtkuJhh2cZb6qFLj8Tk9RXav7OvUx0DO9Kk+K5cAw
	 +s2/SQH54APMKi8LA7pkHt5Qo8ywWYXkQa1nbHzDFg+rBVN3KWo2aj9p0N91X/YPIsrc2
	 2aZIn05MMdif1PaqGh3m0HuiBvsh7Shwh27MUKp1GpFgV0KHyyvk/VF8oCPb66kqxX/6s
	 e1vbkI6mZwHySbbEqiJdNH/YLJlPTurOdyiFS0IcU2QcB+ER/6V9loXrqMPnWPgo/fLhn
	 BNSnuzhQLIa5aFtjldT/WgAmHE6BXKF8GapIy0mhmK0XIAEHFFRnJSaxM9ecSmBiYYg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794184045;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Fgi8dZsDiVgf5P721ugNnqmxUTix2UebH9jaWVQXTb8=;
	b=ncRpzZHAGpEPkGZhvIllhhZTcAKaJnlZBT2YhhnhZ5cx/GtxFM4iUSOlHgy+6Wj9p0sj
	 2G47OsA8EgR0H54beba9CHG62w0bdei/agve4WuxblMIPuJYfhB2Og2Irgu6lOk2XAb9q
	 dElywECHSzHWhYFwOjrXwh6mgdG6FDD4GM6ToPEW46ILNrbHx7Jy9uo6m44uGbVeRLCKj
	 624RqWOq8V1TueWdcHRyh0jaCMllxbqFTL6nEKpgMJExP3J0G8eLA/5tm+B7f+UrZrCkn
	 x15F5jse0sfN2PJuH/s/Xbg7VABGDK9Z8aCObSl2YgpEX4bIUo8cHJmdpgczhaZkt4w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D733A1F008A2;
	Mon,  9 Nov 2026 00:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184045;
	bh=Fgi8dZsDiVgf5P721ugNnqmxUTix2UebH9jaWVQXTb8=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=GUVYf5daHBDxHwl8kwVRg+RWzxVyCO16CNueufhIumCKBOaLbQ5zM5pyRho1xPPux
	 2H94rOOd2MJb68TDk22Jt30mxeXho2DI/vPVERaZvYGg/V828rB8OWBkCZsaXM0IRx
	 HMC4qA2DlT8UO1xNDh65q7zcFqknZM0Z/oF5wbAa/NJhIO7JmHRevpYFPw8IVa8PR8
	 gofjDtb85Gxda2Lf3GXWyZBqjebqC0X3JRDmX+ek0iVh0pP2uKQ4km/KUkTdrUFoe/
	 TXeis3PecfC//V/HPVG8CA1y76t+V7X8An9DInY9ROe8cu2pyw66CcgrJH0etd4lR1
	 PURHsVAi1jM3g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 37F6948196;
	Mon,  9 Nov 2026 00:27:24 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH 0/2] ceph: dirty folios left at umount
Date: Mon, 09 Nov 2026 01:27:17 +0100
Message-Id: <20261109-ceph-shutdown-dirty-folios-v1-0-34600e8dab20@clyso.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMOw7DIAwA0KtEnmMJGNKoV6k6JGAXRxVEmPSjK
 Hcvbce3vB2UipDCuduh0ENUcmqwfQc+TulGKKEZnHGDtWZET2tEjVsN+ZkwSKlv5HyXrMh08uw
 4zM4M0IK1EMvrl1+uf+s2L+Trd4Tj+ACF24EUfgAAAA==
X-Change-ID: 20261108-ceph-shutdown-dirty-folios-fe7cf2fdb206
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184042; l=1539;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=DkStLvIYCGVjAQ5edL4dBSmnuabmcLt1n1rz2B8iYco=;
 b=7uEsb17jqcBxX+vBu72dHD9qkkoj9z4jHlj5shmzZGDT3qCIOHA2tdqpy/h6L2l8Ghm2QM9yY
 AaGh9GIeIyFBExGA0Q8RA1wKYjw72Q5xyOywJaLTkybKCSxRMIwZuTM
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

Two fixes for dirty folios that umount waits for until mount_timeout,
and that can leave the inode busy, which BUGs in generic_shutdown_super().

Patch 1 takes a folio out of mdsc->dirty_folios wherever it stops being
dirty: ceph_invalidate_folio() and write_folio_nounlock() only put its
snap context and Fb cap ref, so after e.g. a truncate of dirty data
umount waits for the folio until mount_timeout.

Patch 2 drops the dirty folios of an inode when the mount is shut down
and they can no longer be written back.  When the client was evicted,
the caps went before the forced umount, so nothing invalidated the
folios; they kept their Fb cap ref, and with it the inode:

  ceph: ... umount timed out, 0
  VFS: Busy inodes after unmount of ceph (ceph)
  kernel BUG at fs/super.c:731!

Tested with the qa lazy I/O suite (the evicted writer case hit the BUG
on the first run without the fixes, and passes 5/5 with them) and with
fsstress, on a KASAN + lockdep + kmemleak kernel.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
Xiubo Li (2):
      ceph: count a dirty folio out wherever it stops being dirty
      ceph: drop the dirty folios that a shut down mount cannot write back

 fs/ceph/addr.c  | 43 +++++++++++++++++++++++++++++++++----------
 fs/ceph/super.c |  8 ++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)
---
base-commit: 5dcec86cc31f8144857c0d9bf2a7fa13b6e6f531
change-id: 20261108-ceph-shutdown-dirty-folios-fe7cf2fdb206

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


