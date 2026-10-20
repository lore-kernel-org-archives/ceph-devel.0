Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792483571;
	b=cwDxZMPjbqotoHFNLwm6uaKKOeV8jeCUHZ+6K4QNNixzhC5ZeZnvZk9gT6wVVAS3ZSmc
	 ma8keNRiWun3BqCzOjwjy0+XftoyE0zBqt4TjW+NzQIzEHlbb4VV3LI90uD4b/rL0h69Y
	 AgyssOedaadisZlTA3oFyroeuvYjmggsOwnC8hpyMiNVDhp3oVX5aX6lRsnuAxq1h42RB
	 3T0zwjwA1kascKVdn94JsAw/3AGHMmkKuN+kfzFqWF1NWnyvdz3fw6zMGkgJRDH9MHEFO
	 K/exph2fIyaXzbGqQz6oZq9SKmXOCO55YX7Rc1EXh9QZ6AsUy30XuQpI0tM84WLrnKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483571;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	b=uY1XrSGfpanzhYnTJ5n06nLo6OOWYt6XFpccVv3zZWYsbMzB5IVPniIw9oELV7lNptYO
	 F9MhIf7e9GGdZmIOoVHwRs7iUsUHsiB6ayv3sE46Sid7kf57yMIoNrgOD45if1sMTPG2O
	 HprpZlZ5G1aac+SdLe5A2VQDj7S5aDeGCzXQOUcp7uH+rFGkzx/p37ANsfl2GublKkpSq
	 Cl3hPq1mqNpOuN9aq8uHb6QQ7XbXe5o1PlfPKv4NyVDWUY96S9L5oe/wU9Ard1mQqOjs3
	 eH5gjOJgmfVKFBiQY5SHY2XPkMi6kTIpMGG7HC0Wc06/PJauX8OkzuPx70Kllpsy1Sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIu3FZtd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB6606A319;
	Tue, 20 Oct 2026 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIu3FZtd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792483571;
	b=xjwuHrk4XXmOmXP3WdHJ8oCmRPrqublqW0wXrkxf8QmQitt6eeqeSdN81aIi45v7N9Me
	 KA6gdq7mCJeu2n3hXNl06spgkNCOSgGSOPsy/Bjn/UMwY3Ex/V6L2+1XOhItzytW/ipWa
	 y/oF2jBOboVzs3SbM2V2IsYxjht/pgT5Vj9BYEcnrqk1+jOt93vwSNIX7NDyxHm9/Kojp
	 8J4AKoiVvfIoDtwywtD7JUlc/MwFIe/bR8tlMzcr6zF4tj5a93+PgYekFmgP5I6M7sokC
	 fjaAXc2Ti4Qgj60qkQos5kvgzodRUmTncsXuGBk9R8AS8nEj6ouOcKIVq4blqxSiAtA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483571;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	b=O76jto2BJyNsJMxnfbCM/2hJcromIPaRpFp+F/hPQGOS1Gskmd7oEyTKw0f/tP8b2glF
	 jiDvsKwpXAhTf+h0vExMFqjAY1CwxV9atsl/oRttieXD9kDOTEygDX++SeLwbhc8QmEO3
	 ohtxFm+FCu4ZSF9jtdt3UrH+VInciV6WPMouzRriJTmprvz/j51+HfSt2QEATI3oup2CY
	 FlN8UAWjvsl8NG3HHgsSoG+P+yLR0vzoNe4Z6dIvL2ZISreYX9TalJ0o+BDtsKQ3kFlxu
	 vMATpjnOYWLquETrVdmZgb151DGK26W3VE7efT8r0DRmKasKB0raM8xB5kcnVn8O6mA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 280B81F000C8;
	Tue, 20 Oct 2026 08:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483571;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EIu3FZtdE90Mxq/JyuSsIcLmmXjV8q67DLLmAruwJtPxCIhwUIkFkqwSTSkl4Su4s
	 /HhU2UUzVOEbUmRVaUPtaUYv+N4NK/GURYli7YjrsRSVhC5CQU+Swxms6AKOCtT91x
	 2S9Ym4dfEB9RUYE/GG5/bNqtad//HCXZRCY+Lq0rDH73Qs+fMSyNq+eKjLs/bvFrrp
	 sIgKdCtV4Iajbyaw7CDou0dE2AOR5Mv1O60GU7UhjawrIqMsp0pO2PgICU0SE0CrE2
	 P6vK4xfsMErignY4XVKjdWZUq+2yz/xpjgohYoOy08jnmcqfVRRaM6VpxPFI9/KFW8
	 b/iMPDVLFJLng==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 62A2D430BB;
	Tue, 20 Oct 2026 08:06:08 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 20 Oct 2026 10:05:51 +0200
Subject: [PATCH 5/5] ceph: keep LAZYIO with the read caps of a closed file
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
Message-Id: <20261020-b4-wip-ceph-lazyio-fix-v1-5-f4cc62459d37@clyso.com>
References: <20261020-b4-wip-ceph-lazyio-fix-v1-0-f4cc62459d37@clyso.com>
In-Reply-To: <20261020-b4-wip-ceph-lazyio-fix-v1-0-f4cc62459d37@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483564; l=1563;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=vCRKa1jTwTRmyvIPqElXVacQQHdBR1gNvKu9DI1jLQE=;
 b=Z/Hs4K4lnERsSrvgustj02cukELiGN4Y+hBDpPlHF02CYvdciuRLbk+RUlhqGv0YUZ9UbMxQK
 uE+l9Vl6d98BXkY8M0bnd+BV78Pjd+GNp9uJSwzQbQo/FFbOI6K6k2s
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


