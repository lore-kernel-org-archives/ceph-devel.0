Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012C360EF9;
	Thu, 23 Jul 2026 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788109; cv=none; b=GXHq6uytgW89QcbNb+xnR/sOiE7l91OFjP+lxuSgogph6SoRwyhX2VzKiTkvXcd2NnBWwFMy8CM+AkUV/G3QHFciwGce2A5z75Tk5Oja6eMmhY2Cp1djpVPr2FsBhazg8N1JBuPsRFglEa9kZT63dgQRywmJwhfEgDrH1rwLM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788109; c=relaxed/simple;
	bh=WhnvhWPWA+Kq8KAb9UrMrQFpAxTGdQPNUMT5OyBW28A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I4k9oU7Bk9vulF7MWmLkh798nmZKqFXdsqvsmLZCkNr1CP3v7tCtmSa1ICRRG30ywHqLJ0ekFOddw6tzBtmHpK+B47hxDGBPPiYIciE7sWzmwNEZrtbxdCNhGpg26bJMPGTFJh9a3f69u/YVEDcDCgl5CeMYeV8aJl78v4KphkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXACyEwf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXACyEwf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71918C2BCC6;
	Thu, 23 Jul 2026 06:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784788108;
	bh=WhnvhWPWA+Kq8KAb9UrMrQFpAxTGdQPNUMT5OyBW28A=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZXACyEwf8mrl+/XqIbm6jmJCUJr68gj7CRAYtdVDcKnKn5RMQ4tqRDJaSmQTH3eQr
	 GnWp6Eq83fh/wAdQED8xPi2XjBTO9zf5Bqs2XG9tUYG++eus9mrwQr0z9FiPmlprhF
	 e4FWW4ALoUlpO9rH8aBE0mh4pBUKELFVoLM9HuY+vLV6qRrm4NK+qho7IaeemkmouS
	 OJ3mF4+pWM6JE2jofZgjPMtXOAsaJYizhKpT0JjtW6BhUvFeUNR8lU6tDdUsQ87csl
	 qPCejyQ58KvTdl94eVGtUJt/Lr/ZM2z+aFOjGa8AN0eciyj6MFYOjyDXgsd177nEUp
	 DBn8VbtKeSRhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3A7C531C7;
	Thu, 23 Jul 2026 06:28:28 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Thu, 23 Jul 2026 14:28:19 +0800
Subject: [PATCH] ceph: do not cache negative dentries for snapped
 directories
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260723-b4-snap-negative-dentry-v1-1-c78178117929@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTsJbdBGr2JctPCD42IknUI0h
 Ltbdfkt3tvIkAVGl2ajjFVMnlrhDg3196gTWIZq8q0/tcF7Th2bxpkVUyyyggdoyW9OaQxdcOf
 ojo5qPWeM8vqdr7e/bUkP9OW7o33/AFn5CKd7AAAA
X-Change-ID: 20260722-b4-snap-negative-dentry-bbf74719a151
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Dhairya Parmar <dparmar@redhat.com>, ceph-devel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andras Pataki <apataki@flatironinstitute.org>, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784788106; l=2717;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=IQw0JIRgW0RO39xXG7APolmM9Qi7REzbCEwy1oF6S94=;
 b=m9Tub+llkZehLKdx+aCcduZk/0So1CxY8W2Hh2pvcvjNpsg7qlC6UJfBcoePtsmY9Z7qUP0vo
 d6+eWxdPGJbBkPkf7KXtYmqQx6nb0eI1aZClCJ+mCHSOlXy+oabsX18
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

When a LOOKUP/LOOKUPSNAP in a snapped directory returns ENOENT
without a trace, ceph_finish_lookup() creates a negative dentry
via d_add(dentry, NULL).  For live directories this is fine — the
dentry naturally expires.  But for snapped directories,
ceph_d_revalidate() unconditionally trusts all cached dentries
(valid = 1), so a negative dentry created by a transient error
persists forever, hiding entries that genuinely exist in the
snapshot.

Only cache negative dentries for live (non-snapshotted) parent
directories.  For snapped parents, skip the negative dentry so
that VFS retries the lookup on the next access.  Since the
conditions that trigger a negative dentry (MDS transient error,
local ENOENT shortcut, or MDS null dentry lease) are all rare in
snapped directories, the performance impact of this change is
negligible.

Reported-by: Andras Pataki <apataki@flatironinstitute.org>
Closes: https://tracker.ceph.com/issues/78529
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/dir.c   | 10 ++++++++--
 fs/ceph/inode.c |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index b4b541a1180c..d5d8f935fb62 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -774,8 +774,13 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 				d_drop(dentry);
 				err = -ENOENT;
 			} else {
-				if (d_unhashed(dentry))
-					d_add(dentry, NULL);
+				if (d_unhashed(dentry)) {
+					struct inode *parent =
+						d_inode(dentry->d_parent);
+					if (!parent ||
+					    ceph_snap(parent) == CEPH_NOSNAP)
+						d_add(dentry, NULL);
+				}
 			}
 		}
 	}
@@ -840,6 +845,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 			    dentry->d_name.len) &&
 		    !is_root_ceph_dentry(dir, dentry) &&
 		    ceph_test_mount_opt(fsc, DCACHE) &&
+		    ceph_snap(dir) == CEPH_NOSNAP &&
 		    __ceph_dir_is_complete(ci) &&
 		    __ceph_caps_issued_mask_metric(ci, CEPH_CAP_FILE_SHARED, 1)) {
 			__ceph_touch_fmode(ci, mdsc, CEPH_FILE_MODE_RD);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 61d7c0b8161f..d52e2b389e0b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1814,7 +1814,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 				ceph_dir_clear_ordered(dir);
 				d_delete(dn);
 			} else if (have_lease) {
-				if (d_unhashed(dn))
+				if (d_unhashed(dn) &&
+				    ceph_snap(dir) == CEPH_NOSNAP)
 					d_add(dn, NULL);
 			}
 

---
base-commit: 602bb4525c8146865b7f6e44c81d54bf97861aed
change-id: 20260722-b4-snap-negative-dentry-bbf74719a151

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


