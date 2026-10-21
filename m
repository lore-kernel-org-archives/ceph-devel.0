Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792583555;
	b=UwdqdSQdtKWlYWIlvHOtIwwLvy/b8plUYjKdxm6i4xUCQewlkQ/0ijVA48kX9z0xpBWa
	 9t++fdy3omIyh55c2RBsoofPCDk1V1iWe5qsNyXtaPWRuczDp7dSdqYxR/lptg8R2aThR
	 i9yhX52aO/i+qVfGy1NaLbevx7dwJpOqgx8GjLB42Y8dxt/vmRFIHwLDZ00D3hedFitMA
	 qyTm8PVUOsQxspX57FQrhk/dDpnGIbs5KdCa9D9fC6lVYzn5KMt2j9q1n5fYPRgELqRJB
	 z8zMJTt6b+oL63Duimsn4cpLWHI7d7aYLo8+C2xsWzQTi2xqLkCFZ5JQ4GhxXN+UfIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583555;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	b=0HDeWy68WXHKv5tGQ3xt+lFhdyGDM8wMuIZ2Bo8UiZYhzcfafLV/PyMnFgndLtwophuG
	 3Cv56x8gnwTucLYkDhZTEfpv9Go0GyoP8vZrHcEYiksy4ulpMtmlJQqkLA1cTeTQeRECc
	 oinEsp4NWwPTujbU1SmwP3UV7dZWfsH/vfJE6IB+bwaFeWVebIru9VVkTYHSm6imR3ENI
	 Hx84IIrXk17orF+tVu57PrtUfAvf80UIyUlNwPZ89cKN7eZ9Jei7Lr4qaUhETtmV1ir9D
	 rEAhP10FfdE+xA/bWsZKPO7u7xUTxhkmKqqrRvExY+rbtt8Nq+AkR5S4rDeMCXYJLmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARMUtsQ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D745606A322;
	Wed, 21 Oct 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARMUtsQ9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792583555;
	b=ZJqde4x48SRXdhJ3WlV04jXt7Irgm3PFbRwlTrzGh56X0YpzZqkhAXITwo9pjOxsO6KU
	 WtdunJ768KdNbp6lDhGoe+NQJySxiHiQlVBS0X/q4mCyXfs79hP3fDh6dZJLodRpXAf6+
	 203VHaJaX4dP1hQYxV6nwRX87O91p/vIGt2XYIH+mm8tYbiaZM2IMc7V/cfU13oMNv/Yj
	 GoOQpsEAbqD6djnKXi+waVYs3YhsQFyEpXL9T/IB6ghzPteNrJuA6/WNW1ir9tZHDEiu1
	 AzwT8Vl7Tzx3xkTszMGw70vrHNRu3LBamWJzSKMoBsotu1SvdbMvmJJcI0cKNtB70lg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792583555;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	b=fnLJAxf7xOMaIP59l4KCxAKgtvSdqNdugUqWGZiek08QGuMLlU9Y1T1O16KI7QR9L30K
	 HSBSlR4ITcDmN3I4StW6AqGSMl+V6S3qtR82y+0JWJKJtWNbMyp6DmLaCIX5skEB095qN
	 zKhLXF4u+tmWHk8R7DUiCOkN0wm0/rQC8WTLURaWYS3bIStdeRBLeNtt03UwsPDFGq+G6
	 D5hHxy+0DICe0WcAWcpGWkL79u4qzKmqJC1wGMVlm9oYV9/gPPjbeOaO1y6gFFZTORoUl
	 6tXUc2ov2usmdYL3I63orFnhwH0BnEUGfTWzsSz2y3qqMier/whZuLcYoO9TDPOpSZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 027981F000C4;
	Wed, 21 Oct 2026 11:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583555;
	bh=Kq2hb77e59jXCvm+vum3diAj9PrESCNjUYLmNW0/uQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ARMUtsQ9XaLwQXlz6zsagPBxrJLbwSBKOm1cs+eUlRmw1c0kXdHt4doXNupBjdrTW
	 gaE7nCC2TMAyNKkMcX3yT+IVkEtjeLmA1ezgfVZRUgXHOKp700kshb5cUaBtO3ahQi
	 y9diJnzTdyuuJttUV3EnaN6Pse87KylQFZh5fB+PeaNtUYCSuOvWrtm11F3wXptblw
	 UStHv3IRjLEXBfKYSN7J9r5f8go0yGc9Wx8JhGSqDvyzmyZP5GbhD17ic473s/EhNw
	 +FZ7KRfCr1NvRqqrZ5vnqFWoQEojFTOO7q8Uz9/B5oIcb/xVoeicMzxNXpNcWBVPhk
	 ALP1DyybJ/rxw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 49B4843365;
	Wed, 21 Oct 2026 11:52:33 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 21 Oct 2026 13:52:07 +0200
Subject: [PATCH v2 5/5] ceph: keep LAZYIO with the read caps of a closed
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
Message-Id: <20261021-b4-wip-ceph-lazyio-fix-v2-5-25d28479d6ea@clyso.com>
References: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com>
In-Reply-To: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792583534; l=1563;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=vCRKa1jTwTRmyvIPqElXVacQQHdBR1gNvKu9DI1jLQE=;
 b=XNDWBH3zdJHMX+RwPS6lz2XN94hqUEf0FqBU0YMxIyMKX5cBmVWdWSUCAmKgLFAsFmNX+VYFS
 hU8aLij4lFSCMI+tSqzqdgKOdgKL2mugoE68QZ9ncCxU4GTS0sJB1K3
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


