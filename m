Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793084466;
	b=e1bX4H+8YmV/eR6ohvuOr8bxtfkyO+UMskR3xaDKbyrid+D6TxR6Z3kZCHEshalR67lj
	 t+/YmJO/dIfddL7jsk7HLKGoWi94hi/Q0D5q09CZ59Pi7JnXT7GDAUnBTKp0wyq+wOC0t
	 YZ2h6XQD0O9jmRS68eOEuhqnI4lFQh3D6Czdml7Kxmh89Xw0liQt0o/l5PWwFSyLgxxX6
	 sOtHay2FKZqI5Yn9mVi/rQHWN75PtjJOUs/oLIAydXvGRWDAdmGfof0S3HlUnrXoB5/xN
	 Vl8JM4nT1eG1WFRJ6uyxeNoRwDwwp1PEhcokGQhIqbL2Nzx0VjpMOjc0DmbZSawGI+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084466;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	b=XgLv9C28N7FkswGE1CifJTBnJ86EG+ySh34dCIgvXQeWGpbmJ94swNnP2nAmQK/bedms
	 o3lD2ShOC/pzPtx8rea4ZY42LlI8R6GSFa0ZJGb83MafyvcDKQu03iDgi5YKsk7CIo32N
	 rhjNHv+DS4fdsbjxowh8twlKpJ129Ne/6CW+gafblhdEHxiyd3mJVpVVRTBYtaUJMumXv
	 +WJBeXzY/hfE3dcwgsXxY64wfeWD1zNp4zUuwY74KuQELFy4GinoJTOMxbSzGOHz1HF+t
	 PsKZ/vvdN9XvRZ3ggpIHoC3iIuhG3fLR/a5iLtA8B6jhS8dNdXslurXg8JKy5yxX6zA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cf5Ope4K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F25606A327;
	Tue, 27 Oct 2026 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cf5Ope4K
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793084465;
	b=NI7a5IFwYZTpQH0B4ih6zOYJRqjZheq5KpDcanEgJWnAEk+A1Ys+zsjZoPcvk0J7cN2x
	 9lGhRYbhcRBVLJjv8/ck0AXDcYkekWbDHzFySmJq2+tI5FmCKe3XkXNHUv+eHyThAsVLB
	 b7ygHT+uIBykdXlcevBCwPEKTqvOr0Oemxacc7tAviLuDzvh4eHo8ccaXKeZA88+Ew/i5
	 s0z6CDv6qiEZ8qMg/YqJJTCAWefNfwMwg4CeasKM6tEDVG/thObqFuPgBseIWSSwK9YmS
	 nzxy4hFEImpfw6G3k2T2nb9af0sTRTr304F+J4df1hx5I6MxfTvuAWIUN6fInD7ziWw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793084465;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	b=QA+cC1yIqUxqGAt2dH6tCv6Jay1EfrTSTYybsczq5P271+AM4b3KYvDjRZ6R9TW1yZmJ
	 kqCZHBhiFnyIviFn37YbVxk0Bbz7lFsVONRujKSgcKhXk1VKcAMEcSy84AQAg5DHPB0Ja
	 taXdoWN+dZHkYstOzUZrCvr+rMklj0VQ0/xzhZuvbOVF10Tt4Bs/iiv6mSQbX+ZdgnFod
	 U2vebIjjzb1NGYcInqo8gG6zuM4pOwwb8WrsTl47mvtrS4ZOyx8yu155nEt1F57AbCmVr
	 sH2oXwb27o2Kyxx7Tv2DnbPUp6ONCxq+abHmrBGYXM/qGZ1VKyoSiS5s2A2SFBGb62Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B2BF51F031E1;
	Tue, 27 Oct 2026 07:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793084465;
	bh=C0iJcqqk6oOrRTvCA/BwoONwNFwLIPbYAm75cysG2Zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cf5Ope4Kjpc245XTpOzQ90EAuJAyEZ6m2f+oL5Fkz+3Glg0IlWcRCeOx00qTg2Ugt
	 e1JNRDsIFcxbaos0YRhrCgSucUQE0o8xWRwutQQb1z7EVLozhPY2D0jNIVZjKZXoVv
	 vW4++Y+p8tQrMNiSHi/hXAK0p+JQe11hcQ3vR+BL8jrZzVeDSH15i3p52toAyW/ya8
	 Yu0ZskVBTpo2cArfeQTsqdSzdnrwhqRz2FJfC0D+kuCeVCX7EIiNmjaEVVbG1BXYi0
	 An5VemlxzAftXchu6X5Iti/VHaVTgcOglwt3iu5bqzz4aE6VYLekgZHbIXbeXzc+9X
	 FhqwI2qziM02Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 26AA744FF8;
	Tue, 27 Oct 2026 07:01:03 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 27 Oct 2026 08:00:46 +0100
Subject: [PATCH v3 2/5] ceph: do not ask for LAZYIO for a lazy reader that
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
Message-Id: <20261027-b4-wip-ceph-lazyio-fix-v3-2-df2926c30867@clyso.com>
References: <20261027-b4-wip-ceph-lazyio-fix-v3-0-df2926c30867@clyso.com>
In-Reply-To: <20261027-b4-wip-ceph-lazyio-fix-v3-0-df2926c30867@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793084460; l=3495;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=9pCeVzQYSDJ5vZuuue3pphdfQCNRxqQXpuIHp+vghK8=;
 b=GmDw3voH5lOrEjEHCCJz0bTrZG4uXDy1ktpgizr71WCyiFtlv/GG0ZyvRMCFKPmv9TyLUCDMr
 KFJ1R4FFbekB3Q4aiXuFKxF3ujtahCcnCG6jVON0KHKGcdWkiCDGKia
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


