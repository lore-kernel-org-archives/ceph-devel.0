Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793347674;
	b=S9m9p2Mc69CY5pdm76cWEhSSjeVBY7DK0Ljk2PIasp3tx1RXcFHI5MUrYKP95QLRXx1+
	 Crj/T3GOXGCLM9tPS3XsyS8ebtgC4zD6tmjtyiIYQbZb0DQ6HegxyLdjpHDCPC61I2MZL
	 0UQT42On6q9FuKraPW9iQ13gPbrlMWJfEgc8owWjPFIjWogj4WrUIhOtq5z6YZgS+3+M7
	 fYELqwGbxtA1MVaW1ingLSfMSQesbTRjv5zaiObBWMgkfBgY9k3x1/HhpOx4U9cPtZQvg
	 aWEsF5H9Jv8RIsewNsltRjvU/yWPdRphnmbUVOjIHZt4Vv4OR9dMxJ0JATGSrOJIiGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347674;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	b=p1Z8/aOkaPzyeHHAxzIWqWAfZ8AgCH+lMNk8lVM5sd6PYT8Pg4thO3XUailbflG0HUhJ
	 AF/BodeSWZuvjURtmhbMSzCQp7yWg2flbGfHDH51dLza/J9qsHdrjSr6JbY5+YjJiNLBR
	 Jt8i6dECMXel0mTcn+kLjgZb5rhX5uf4SX7Yr6C97kBoURmr6ea/uMuJiCoXtk5jGBNfk
	 Sqs0MAVygDx24JOKAgfHh6NproQBu3pW8149OzY7/0NtVBu+7zWo1uTTTLhX+xa2H9y/l
	 xPBFgrgV+ZNjLLw/d/2LW3DgKj2raqupAvABlTbNu5EdIvFjkIy2z2gLqwxo/WF+wXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4bbyIiV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83705606A31F;
	Fri, 30 Oct 2026 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4bbyIiV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793347674;
	b=SJTGgFsVxVx5+BlI9s+eG6RUBCUG2FR/5JNAhEZjPBmJdjSrWUVPX6VOEtO0yI2fywqt
	 9T1WZj7exIA/iYA9hELc5E42FzJdIK+4atqAtbCmymNCHhJ+tX03kqTmM/WTRW9k2Z/t8
	 sC1/ZO3w/MOpijItng7XrYfWyVmCHjFb1WoT63houaMk41zVOhSZi3LgLhN54c23Xi7rz
	 B91MghNzRHv6tqWMWm8X7CDFG4lG1zx5WkUn2HslylOQ2VjcMSczKtj9cxNR5b2MC0i+A
	 rlsWjsetPN9USI74gGTYopYzbQ2oP5alj79B/IcXNYuwTdTCVG/lb0iPJh3YgClX2pw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793347674;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	b=D/JKMHC3uuc6jPqVP8iU+88RlZlHjKat0kOdRi6sVGRdumMkm6OhmldG4MJE9SRo7Nsf
	 uHiJ7nWxkEwNnC9CFR1BPZ7vPD4T7TQ1MQF/maqYzs6K8y8aXWNjfMAmvE0iIByCaYBkn
	 3Sjjo70qKJiXRzNfNxDrKzkAgvNnEVzNDK7trbp7E/z4XZbhn2VRAO9vbv4WStJ9Gw5WO
	 RAvwo7jq86mFFOGj79WEVK22VoVbpt2ZkbVCDMkVrRccFxKNSFFXT96jiPpX26hVHtAxt
	 16nfBPnU3RdF2Qj7AgvYFuT/TzSVTQ6mkUWosr4Ob44w2g/7I4L4AeZHRK/lYfwns/w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2BB191F00A02;
	Fri, 30 Oct 2026 08:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347674;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=O4bbyIiVaavwSYgW4cyq2mukiGcCNXRPT+Royf9EBVvP1yvSSkDRBWQFw/LaWq/x6
	 pMNsg1SfznV8YCz40gSqwiP/DyIOmU/jLK/r+YzeL3U0uN11BoLioaU7yzKfdwLdVp
	 aE8DS05cJwnqCtk6DaMTC5/3YpAASGKyKJkNGYJj+B9xds8YMzXDR2igW4xYfxwpi3
	 x3GfsWpff4YQ3E27Nj8eLp0Kn9FAz8tyKciadTXBxgmRnheNtM5D1XXNaW7twmzmm2
	 /jtQYhDLWHhj501ZITSbrbuSG/qvY9kXkTXkxgDVSIzp21+TcTYpRHIWxdlEuwnnhm
	 S9E/wxIItEDpA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AD4B4436D0;
	Fri, 30 Oct 2026 08:07:52 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 30 Oct 2026 09:07:34 +0100
Subject: [PATCH v4 2/5] ceph: do not ask for LAZYIO for a lazy reader that
 holds CACHE
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
Message-Id: <20261030-b4-wip-ceph-lazyio-fix-v4-2-f734a26bbaab@clyso.com>
References: <20261030-b4-wip-ceph-lazyio-fix-v4-0-f734a26bbaab@clyso.com>
In-Reply-To: <20261030-b4-wip-ceph-lazyio-fix-v4-0-f734a26bbaab@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793347670; l=3495;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=9pCeVzQYSDJ5vZuuue3pphdfQCNRxqQXpuIHp+vghK8=;
 b=zr/BM/qg8XLf66sB/7lLayThtraymXPuwqOkBd8TDHJqIyVw6zfv9m757Zo2QZXuq6DBo63ML
 8ll547GwmHdDir1P41Hd3XdTLkGLKlFZSMfEIRUR2Uau5NdKA/RxYz2
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

A lazy I/O open adds LAZYIO to the caps it wants.  When the inode
already has caps from a lookup or a stat, the open is satisfied locally,
but LAZYIO was never issued (nobody wanted it), so the client sends a
cap update to the MDS and gets a grant back: one extra round trip and
two MDS messages for every open.  io500 mdtest-hard-read, for one,
opens each file once from a client other than the writer's.

A reader whose cache is backed by CACHE gains nothing from LAZYIO.  Want
it only for writing, once CACHE is gone (e.g. the file went mixed: the
cap ack then asks for LAZYIO), or while it is still issued.  A lazy
reader of a file that goes mixed now drops its cache once before
LAZYIO arrives, instead of keeping it.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c  | 24 +++++++++++++++++++++++-
 fs/ceph/file.c  |  4 ++++
 fs/ceph/super.h |  1 +
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index ae7b62b07462..c063d3cf7d21 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1125,6 +1125,27 @@ static inline int ceph_adjust_caps_used_for_lazyio(struct ceph_inode_info *ci,
 
 #define FMODE_WAIT_BIAS 1000
 
+/*
+ * Does a lazy I/O open want LAZYIO?  A writer does, to keep buffering
+ * when the file goes mixed.  A reader whose cache is backed by CACHE
+ * gains nothing from it, and asking for it would cost a cap message to
+ * the MDS and a grant back for every open of a file that was looked up
+ * or stat'ed before: want it only once CACHE is gone, or keep it while
+ * it is still issued.
+ *
+ * Caller must hold i_ceph_lock.
+ */
+bool __ceph_lazy_wants_lazyio(struct ceph_inode_info *ci, bool write)
+{
+	int issued;
+
+	if (write)
+		return true;
+	issued = __ceph_caps_issued(ci, NULL);
+	return !(issued & CEPH_CAP_FILE_CACHE) ||
+	       (issued & CEPH_CAP_FILE_LAZYIO);
+}
+
 /*
  * wanted, by virtue of open file modes
  */
@@ -1179,7 +1200,8 @@ int __ceph_caps_file_wanted(struct ceph_inode_info *ci)
 
 		/* check lazyio only when read/write is wanted */
 		if ((bits & (CEPH_FILE_MODE_RDWR << 1)) &&
-		    ci->i_nr_by_mode[LAZY_SHIFT] > 0)
+		    ci->i_nr_by_mode[LAZY_SHIFT] > 0 &&
+		    __ceph_lazy_wants_lazyio(ci, bits & (1 << WR_SHIFT)))
 			bits |= 1 << LAZY_SHIFT;
 
 		return bits ? ceph_caps_for_mode(bits >> 1) : 0;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 856710c63765..fbdccbae0d17 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -462,6 +462,10 @@ int ceph_open(struct inode *inode, struct file *file)
 		int mds_wanted = __ceph_caps_mds_wanted(ci, true);
 		int issued = __ceph_caps_issued(ci, NULL);
 
+		if ((fmode & CEPH_FILE_MODE_LAZY) &&
+		    !__ceph_lazy_wants_lazyio(ci, fmode & CEPH_FILE_MODE_WR))
+			wanted &= ~CEPH_CAP_FILE_LAZYIO;
+
 		boutc(cl, "open %p fmode %d want %s issued %s using existing\n",
 		      inode, fmode, ceph_cap_string(wanted),
 		      ceph_cap_string(issued));
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 458fd63dd79f..cdb238d48f72 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -952,6 +952,7 @@ static inline bool __ceph_all_opens_lazy(struct ceph_inode_info *ci)
 }
 
 extern int __ceph_caps_file_wanted(struct ceph_inode_info *ci);
+extern bool __ceph_lazy_wants_lazyio(struct ceph_inode_info *ci, bool write);
 extern int __ceph_caps_wanted(struct ceph_inode_info *ci);
 
 /* what the mds thinks we want */

-- 
2.53.0


