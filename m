Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793084465;
	b=Z86ggbYnwqw7t4N/Tl57nOcnCaLoILhCxU/OKWi5Xl0G/WqG7WTBa0skDpTIH9nHEQSu
	 zThgmIt8Lmn2fN/124++oyzMtplNJlg3AtXcbjzM5XFG5dVcPOXRN3FoqmuPgjqw2wWka
	 Pe3fMmeSfZFLiktBLYFqxmrfVg1RYMT/Az0GiyCnC4ovMHBE1Efe3ZUU738cM8eHsaPt2
	 0fpMABpwqpn+LceUxdp/y8N5U405glTfWbVBMg0sYyD1O/brDBPvhH5VjfTckbL7hfFqP
	 DV7B1d/2+YbvVSD4dRo9zHQt7WSGVQQw8lYrjpWlI6/wvWdxT8wUNYl2gHSclOj2FiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084465;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	b=rbCzNHoB45WjxMxt5NChVKx49UuSLzIXS/V5L1h3jcfbxL2QBAnnyNIYp0NeiBVFn/jX
	 N2SHlwU5/JFjzAL1MIzFTtxG40rIFGgSX6YK5bDgtB2wd9xH2kUetEKd/O2yoluctwTir
	 +E5SLIyIXjX6GyaAA5rvkpU/HYDB6Sn1W2uYkeP3ONLicmr4jjqjFleZzZeoVhVu5h7yZ
	 2LqlB8FXIGMjqrdoNwzfz2Q4TYr0JplYIVe7Y/hBZ8qhxtam2Ib/yRYtYP8TMcUSY+MZW
	 jMh9ZQOyKNnwmSkxE3YXjaD9FBfZHZ+ydiu+xviSPHw2bNHePlTzeBkv8s10MLu6Ajw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJBTW0nc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D3606A323;
	Tue, 27 Oct 2026 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJBTW0nc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793084465;
	b=k9644lxK7nVm6Nf2D8XyVNl+d8sW+6/iqUPZ2imNqHhF6X0JzqSfUQqZnPslhScfS9Ic
	 LY4WHesSYNbLbr93lF2nwPjvRpkk+pVRgN2fQc1KOVN4pru2o0Coavtu0SmtQZm5srlUv
	 NtU8eHNmZcYED5y0GkgeeGWyBDwLITxi2lAuhJZaUJYNa7p/s9Hyt5JMBPO2AwX0CgAdg
	 7Bfj2b/Sms8q3el/aspZShLog31nlGU4ozkPHyfJNUXh/q4Ng8jWWA9fDMohkGqsIw579
	 eYdi8lTwTpNQjo1qSVfXslF+M8Od97yEXd2/PQHO1k6lvBK8elPL4P8IQpdQJUgN3wA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793084465;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	b=UYBkB2yw31oEUCD1XkM16fUcbYWX3VuBbyNpNSk21cKNTZyaMavZanKOiijpFECSb3e1
	 3nm/vwH0plZ/xXmvZqUGmf2q8YfBKUDbsfbcw1W5udehfNXdD3QkpHdSOooyMifo+BTlY
	 kILmfyQN/rD2qasz0R4ACaoaeEwlnUnpz0GzX8lrzGVtDaiR74Yrmc7JmAkEAUhy9OkEk
	 REa2bqsaNqrIbSV7/D0rTYvhdOjabeieaf36TKgNe9foQ4O74CQN2oYDydnpeklgGAZtp
	 hceFtCqEXRMTt6nPCQikWmsBigPshezlTWuySo6qJgKJGxJgHIUkngc56NXmwxCkzyg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EE30C1F031E2;
	Tue, 27 Oct 2026 07:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793084465;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FJBTW0ncPLogVl2yrw0s5TGj6B7iRz4pwsZjW0KfL7lNaT3WeurOAoHX1cjzuUulv
	 7iVpNZrh9CcQpH2Cm4HtgmBqUG8mP6Rr3SdS7kBNOy3ic7u7XAJK+YT0AF1JpqOLC0
	 hKATfhQO0sI+yGCy+9+KVHwdbcVGb16Xos9GhfBjc84KOm7hjyuxCp1MV/KYd+KZq6
	 WK0LF2nLxt475rJoVtvnWw5bQVUCqAVAsmFpckth18CWWKsEkl7T7/n8J58g4qtcPU
	 oFkhPYhuLyCEz9anPcUi6BzHfohXhBu04tFfMsy3831KoH10l3VjK4u1LsuxRxhvv4
	 eio2OdTI9+jGg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4806D45004;
	Tue, 27 Oct 2026 07:01:03 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 27 Oct 2026 08:00:49 +0100
Subject: [PATCH v3 5/5] ceph: keep LAZYIO with the read caps of a closed
 file
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
Message-Id: <20261027-b4-wip-ceph-lazyio-fix-v3-5-df2926c30867@clyso.com>
References: <20261027-b4-wip-ceph-lazyio-fix-v3-0-df2926c30867@clyso.com>
In-Reply-To: <20261027-b4-wip-ceph-lazyio-fix-v3-0-df2926c30867@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793084460; l=1563;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=vCRKa1jTwTRmyvIPqElXVacQQHdBR1gNvKu9DI1jLQE=;
 b=q+KIBCZrX/5m1P407OHS3rX7W5lbaJeEzIkzXA7XEeT/bc16angVEzTn65lTIE9s6a+41JvAv
 9le4YNUQl0dBcw2XZC1BngsVcE2fs/2VRpEDi3Aaawwc0w3AdG+xzgw
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

A lazy I/O open of a file in LOCK_SYNC gets LAZYIO issued along with
the read caps.  Once the file is closed and its wanted caps lapse,
ceph_check_caps() keeps the shared and read caps of a file that was
not opened for writing, but not LAZYIO, so it sends the MDS a cap
update for every closed file only to give LAZYIO back.  With the
lazyio mount option, io500 mdtest-hard-read sends about one such
message per file read, from about 60 seconds after the reads start,
and the MDS serves the reads more slowly while they arrive.

Keep LAZYIO under the same condition as the read caps.  The MDS still
revokes it together with CACHE when another client needs the file.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 49e5c1c36b68..aca09351a094 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2266,10 +2266,13 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 			/*
 			 * keep RD only if we didn't have the file open RW,
 			 * because then the mds would revoke it anyway to
-			 * journal max_size=0.
+			 * journal max_size=0.  Keep LAZYIO with it: a lazy
+			 * I/O open gets it issued in LOCK_SYNC, and giving
+			 * it back costs a cap message per closed file, while
+			 * the MDS revokes it along with CACHE when it must.
 			 */
 			if (ci->i_max_size == 0)
-				retain |= CEPH_CAP_ANY_RD;
+				retain |= CEPH_CAP_ANY_RD | CEPH_CAP_FILE_LAZYIO;
 		}
 	}
 

-- 
2.53.0


