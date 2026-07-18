Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A81A6805;
	Sat, 18 Jul 2026 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341793; cv=none; b=n9gl8s25dHkZ8lFs2nfjq5ejLngrbxyT3/zlQjIrMFbq7PDqZzoBmjgK5qZCN90ruic2ftIt9NFXDfjspX5CYeEZT826kQsPOXjffLOEFNLzTaDwVJPeh/OubTacWs0cqXK9LNH9NyzNtwHaVqVnGa1mwxYge0fCq4QKQ3yBYJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341793; c=relaxed/simple;
	bh=b0tBTNCM0IiwZLpv/YYPldfR+GnBW5wS1uL1tVEREFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a9Mjasj7wmj55peROJpFc3Z+z3g3Reh/wXPyKKyRO2I0AEMHucaCkRdOe2n6Jc2/XVlCITDSSZst9kOzMQLYViSNRewOq4pOesmNdDWt/FPUo0eUSfwdaRYQT+qqmV/iu8niE6kZJ573iFLRSoD+0ZbIDAvufHT14q7gs42+cMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McC/z1Re; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McC/z1Re"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCB70C2BCB8;
	Sat, 18 Jul 2026 02:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784341792;
	bh=b0tBTNCM0IiwZLpv/YYPldfR+GnBW5wS1uL1tVEREFY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=McC/z1Re6Px6Ydi//RsiqWLnBZ8R907hmrxSxYEubuhGW5aqfH+Pz1YUW33Zdc93n
	 8yxLiwAp1CR+fgxzyG3XvCnqpHYzEpNmApuqIcrO/6Q4A9DlgMh855hS4L7+rUWI/M
	 5tXanhQnTVeHUOiJchTouqM6g/jQ2uANjKxuuF2TakKDsCaLFS0Fzclm1OY8D92KGI
	 2utgF7fSTmLej6xD0Pr7p9gPPyI3oVakXxtOQsIkg5J+n+cse9IYV2JN7Rw9M3dkcm
	 dxChYYJswUcojRD5aBOSJCYKMKe+aZs/VJaTfI6fGR/ZkWvX/H6WjaMhxbHTcI3NCU
	 zz9kDcbXj4d6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F66C44515;
	Sat, 18 Jul 2026 02:29:52 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Sat, 18 Jul 2026 10:29:48 +0800
Subject: [PATCH v2] ceph: revalidate ki_pos for O_APPEND writes after cap
 acquisition
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-ceph-append-fix-v2-1-88dcc4f8371f@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBBEf4Xs2TVtiRQ8+R+GQ1lWqVHatEgkp
 P9uwbPHN5l5s0LkYDnCuVgh8GyjdWMGdSiABjPeGW2fGZRQldBSI7Ef0HjPY483+8GmVoLLThp
 dE+SVD5zj3Xhtfxzf3YNp2jRbY7BxcmHZL2e59f7bZ4kS6SQboQ3VXFYXei7RHcm9oE0pfQG1O
 etKwAAAAA==
X-Change-ID: 20260717-ceph-append-fix-9820e3b1a78c
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784341791; l=3519;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=4gyxWWukSVVylN8aTt8ukM2xS92PDXN0uFkXnfmDBdc=;
 b=S7It9ZgfjWgUD8UvMSnDfwa4xlMFLYd7HECVSLi1hgUzfq4B9wX3OdD0y8veivISz/SI1xRA9
 RBYWU5tgEnMB14cIJNwe0EHe6RCzX1KOt2nD8QvqaOSjC3bXVehUHMP
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

For O_APPEND writes, ki_pos is set to the current EOF via
generic_write_checks() after fetching i_size from the MDS.  However,
ceph_get_caps() may need to wait for Fwx exclusive caps if the write
extends the file (endoff > i_max_size).  While waiting for Fwx, the
previous Fwx holder (another client) may have already extended the
file.  When the MDS grants us Fwx, the cap grant message updates the
local i_size, but ki_pos remains at the old EOF, causing the append
write to land at a stale offset and overwrite data from the other
client.

Fix by re-reading i_size_read(inode) after ceph_get_caps() returns.
At this point we hold Fwx exclusive caps, no other client can modify
the file, and i_size reflects the true EOF from the MDS cap grant.
No extra MDS round-trip is needed.  Only adjust ki_pos when the EOF
has actually changed.

After adjusting ki_pos forward, the write range [pos, pos+count) may
now exceed the i_max_size that was validated by ceph_get_caps() for
the old range.  Re-check against i_max_size and truncate the write
if necessary to stay within the MDS-granted limit.

Fixes: 8e4473bb50a1 ("ceph: do not execute direct write in parallel if O_APPEND is specified")
Link: https://tracker.ceph.com/issues/7333
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
Changes in v2:
- Re-check write range against i_max_size after adjusting ki_pos forward, and truncate if it exceeds the MDS-granted limit.(Viacheslav Dubeyko)
- Link to v1: https://patch.msgid.link/20260717-ceph-append-fix-v1-1-c51907ac8e36@clyso.com
---
 fs/ceph/file.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 9d89d7fc1095..a2b4d261e23c 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2491,6 +2491,48 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (err < 0)
 		goto out;
 
+	/*
+	 * For O_APPEND writes we may have waited for Fwx exclusive caps
+	 * while the previous Fwx holder (another client) extended the
+	 * file.  i_size has been updated via the cap grant message from
+	 * the MDS, but ki_pos is still the old EOF.  Re-read i_size here
+	 * (no extra MDS round-trip needed) and adjust ki_pos to the true
+	 * EOF.  Since we hold Fwx, no other client can change the file.
+	 */
+	if (iocb->ki_flags & IOCB_APPEND) {
+		loff_t cur_eof = i_size_read(inode);
+
+		if (cur_eof != pos) {
+			doutc(cl,
+			      "%p %llx.%llx O_APPEND: pos adjusted %lld -> %lld\n",
+			      inode, ceph_vinop(inode), pos, cur_eof);
+			iocb->ki_pos = cur_eof;
+			pos = cur_eof;
+			if (pos >= limit) {
+				err = -EFBIG;
+				goto out_caps;
+			}
+			iov_iter_truncate(from, limit - pos);
+			count = iov_iter_count(from);
+
+			/*
+			 * ceph_get_caps() validated the old endoff
+			 * against i_max_size; adjusting ki_pos forward
+			 * may have shifted the write range beyond the
+			 * granted max_size.  Re-check and truncate if
+			 * necessary.
+			 */
+			if (pos + count > (loff_t)ci->i_max_size) {
+				if (pos >= (loff_t)ci->i_max_size) {
+					err = -EFBIG;
+					goto out_caps;
+				}
+				iov_iter_truncate(from, ci->i_max_size - pos);
+				count = iov_iter_count(from);
+			}
+		}
+	}
+
 	err = file_update_time(file);
 	if (err)
 		goto out_caps;

---
base-commit: df47791ab9f12cd9144aca477ddae195f68072a5
change-id: 20260717-ceph-append-fix-9820e3b1a78c

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


