Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795754098;
	b=v0jAUyxG0oh7bXi2rGp9WNsTGExwNnG7JdjTce5jcZQYwfwBffpfRTWVDMoQqIwiYhKp
	 O2Dg0IK+Rew3lzumyJfJUONeW+lKAzSkYFNlMKQEGfJUjsOwr0kPlYpgZvi4NbFTxKiZY
	 fUgpdFBdNEh8v0ivt1+MXUN63NwIGu2uWVvbGCqjds97n247BUg5wtLpvgAVJBPscBzHH
	 uifXbj1fVh7atIb2Q3fIVI6j0DOY6LS9l+t4Gi68M9Wl4dU6ENre97FY1P7G3QnW/uCFB
	 twzQYrJfY7yO/DzF8uyT1TKmAK7zxYZdj459yWR1IojL69cxM0MBqjmczMSoh8h93DQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754098;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3ffLJS34QBsIH83np5fcojC3QHjqCaDpj2LRhaVXeXg=;
	b=NX1nlYsJ8LQXzNgq8JDE1qW8wktsKfRkzc/Bw7oJCXrHVQc9SNU8XRlOjyYeW/K8agPK
	 dQpmtvFSO2DSo3HANqgCwz83V1K8DYpbuJ9/3JZu9E/notEmBBJ05x7SjUuDyKMQcNS7W
	 pMX1JA7xP7GghqfVOAWmu243l6ztfwMPeblchj6E7/vQzHFo9a0x5TWQgyeBL473fdBqG
	 OTGGbAJk41Wa4dsdUNNpoGoilqeiYLYvrF212M1oF2SF3ETraAb9SgSXi9sO7Wt4E2RM5
	 0EaYKZp1zza2DzWeHrtr/owt+k27HUKMsXJD/jvH43+tb+iPp/+FZrmaYtW28Fk5sWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehQDSZkr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28040606A31C;
	Fri, 27 Nov 2026 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehQDSZkr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795754097;
	b=pc85ujGb7t2/mkn5GzOqXr9mplIttXvAsg6lG5nPXX98yJrb1ujc0Mc6Ilk2bDkU/vkF
	 gSveoLj2azK4xdRO9dJA3LzvG9gA2qQS4lmALMiWJk5J4QQPo3N8SkRLnFZwqjZGBzqPd
	 6e+RIb44gtzD7XeyiFDczj7qxeucFADi9aBm29oZURV/274CP3Aum/5QYYg4JDE/YWzLx
	 cByZ1jTsIVHEH+VvOiosDvH7aHvcbCf2erfnTsGoBplJcorMZAUIIdTTsy2fap0xwcAmF
	 dK2aQyEGoP2aa0epZ7l12Zj+5JgBacVbv9LdS0nYuscv1VMpl7rDngvug4EohP657Vw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795754097;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3ffLJS34QBsIH83np5fcojC3QHjqCaDpj2LRhaVXeXg=;
	b=0oMuBPxO83W3eZAzKiBKIl03F1nCXCRWB97YDH67x3/k9vD7f2DtC275Tldfg6PuDzCv
	 Dfu+Cxx89tEgiJnwqmBa9QD7D9ifRMuU2er9MJ9miVfZrfd1b0fLG671aRiaiQ58FZqjN
	 7pvtx+UiFoiI3KNlnP0GrDNtkY9PKY6unhHUCHhkymlGhLIlgOS4R7n7QJvMMVe6hBrjc
	 Js4byulYvQVuku1Rs3el4LKs4dSFsQ7ZAK6Pj3A6MOTNoYo8z84z6S0qzoyjNKZZE/f+U
	 FwWU+6js9PGCdhVcJn2ZJ4mdhYOgYE7h87H1FIHjEELm2tq9jiQCJjrLZ5XGkHTX9+A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 509101F00898;
	Fri, 27 Nov 2026 04:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754097;
	bh=3ffLJS34QBsIH83np5fcojC3QHjqCaDpj2LRhaVXeXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ehQDSZkraOZ84JgshnJate8jEWu0ML28wOUWOtB08llMTJXTbwu7AuODtSE3Qk/71
	 /BaBBEDVqDYZhk6EbsOX8At6sk5SxUf/KtmyXzWoMEoeqe+xkASoocJ/TBbBC84Kz/
	 yvMU3qGhi2Wutm2CBEZUodC3tyDvLKdEwbZpbzSvBs8wO/VQRt5ZMv8gO9p/Hu/YL/
	 2uxKkya8R1d21ql2w/jmluT3eG/TqRoh/jqa3nqM08cam4aCT0zUPBjBzto1Z+axdi
	 9B9NBt3zDfc/4a/pwTamrQdl7ubCp3vgnVa/hi7utrdFup8tewW0aexjDFanyUg8VN
	 VxhMuHprIkNPg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D57C14B56E;
	Fri, 27 Nov 2026 04:34:45 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 27 Nov 2026 05:34:39 +0100
Subject: [PATCH 2/2] ceph: check the caps of a closed file the MDS thinks
 we read sooner
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
Message-Id: <20261127-ceph-drop-stale-wanted-v1-2-763882859c5f@clyso.com>
References: <20261127-ceph-drop-stale-wanted-v1-0-763882859c5f@clyso.com>
In-Reply-To: <20261127-ceph-drop-stale-wanted-v1-0-763882859c5f@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?PATRICK_B=C3=89GOU?= <patrick.begou@univ-grenoble-alpes.fr>, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795754083; l=2555;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=kTwNLo7MYDuLOGtN7iAIiJVkQ9HNzoSGkjITAYSGCyE=;
 b=Ei9rBDZ2zIcVyeH//4kd3096Wpz0OHGUNMBkuWGrHyyESqnWRoPVbTBeamdDlOGGmp9a6BTQ5
 fM8XWqA3AMND6p/TiSmoXRAYhVdpUWh0KahYpQ3/XkFfp1Iso+QwRLG
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubo.li@clyso.com>

A file closed after reading is checked again at caps_wanted_delay_max
only: the earlier check at caps_wanted_delay_min is for files that
hold write caps.  Until then the MDS still has Fr in our 'wanted'
mask, so if another client is writing the file, the filelock stays
in MIX and that writer has no Fb for up to 60 s after a single "tail"
of the file here.

Queue a closed regular file for the check at caps_wanted_delay_min
also when the MDS has Fr or a write cap in the 'wanted' mask of one of
its caps.  The check then sends the one cap message that tells the MDS
we no longer want them; it would send the same message at
caps_wanted_delay_max anyway.  A file opened without asking the MDS
(caps already issued) is not affected.

Same test as in the previous patch:

  +--------------+---------------+----------------------------------+
  |              | before "tail" | after "tail"                     |
  | kernel       | ops/s         | ops/s                            |
  +--------------+---------------+----------------------------------+
  | before       | ~120,000      | ~85, as long as the test ran     |
  | patch 1      | ~120,000      | ~110,000, from 60 s after "tail" |
  | patch 1 + 2  | ~115,000      | ~120,000, from 10 s after "tail" |
  +--------------+---------------+----------------------------------+

Reported-by: PATRICK BÉGOU <patrick.begou@univ-grenoble-alpes.fr>
Link: https://tracker.ceph.com/issues/83627
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index add63a8f6212..2a6c21d8b7af 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -5261,9 +5261,15 @@ void ceph_put_fmode(struct ceph_inode_info *ci, int fmode, int count)
 		 * the exclusive caps from us first when another client
 		 * looks at the file, e.g. stats a file we just created.
 		 * Check again after caps_wanted_delay_min instead.
+		 *
+		 * The same goes for a file the MDS still thinks we want to
+		 * read: it keeps the filelock in MIX, and a writer on
+		 * another client has no Fb, until we tell it we don't.
 		 */
 		if (S_ISREG(ci->netfs.inode.i_mode) &&
-		    (__ceph_caps_issued(ci, NULL) & CEPH_CAP_ANY_WR))
+		    ((__ceph_caps_issued(ci, NULL) & CEPH_CAP_ANY_WR) ||
+		     (__ceph_caps_mds_wanted(ci, false) &
+		      (CEPH_CAP_ANY_WR | CEPH_CAP_FILE_RD))))
 			__cap_delay_requeue_idle(mdsc, ci);
 	}
 	spin_unlock(&ci->i_ceph_lock);

-- 
2.53.0


