Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444252D7DD7;
	Sat, 22 Aug 2026 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787365737; cv=none; b=Q8fsdvuNKw2YzYbm1OpYvmoAevjamrOHpkzRjvzxTVvnmX9Q3SGu6GT4EjW47fpy6bab/MB/VsCJv/3GsORmMx47G+IsuCglu/jn4CjZDbmxdp5LCUV1fm7sJb/j1vMTYFdwIUopetHywIppxEPo/TKpyH5ZMNcMnCTZ4zJUJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787365737; c=relaxed/simple;
	bh=bfVpJgfQl7Pp3msal0nhiUs6MZc0h8OoTsGkVMxXw0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AqL4axbQqB7an2nwfPS10plyoNpizs2RkzLRKYrTd0x3eVQMmAqmbs5PBhj6abvwHJ7DIi11RfIO3f5DU3aVvn44muEhCBbB33NifojkBdyT/tCv8PDgEH9AedIRwGDGdw/rJUDwLUAe3gZYn28UBPYPeyZCYosvc1RWC12kLfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC58rzw8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC58rzw8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB27BC19425;
	Sat, 22 Aug 2026 02:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787365736;
	bh=bfVpJgfQl7Pp3msal0nhiUs6MZc0h8OoTsGkVMxXw0g=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=FC58rzw80emQk1yEoN7mo0zfsvYqFazZKzpacusDGgk4EzG0npNcEal1YYkY5C8tQ
	 xQmjC2SWcpI4OP886cGiKvp2qPwRmtUven+BQfHllRQMjIUFB5ZHXZtw/u+v11WwBo
	 nlp0cJRWzl0F92TGUkLTWq5IzDjNHVEmhzoVy1vUAUGRn5UCrbVs11Ah5NIb9PKV/m
	 zwQJlL/8fMVbjZfOhq9wzjvJRzgs1A0RjpC+qH1rp08VqL3o7U0MSbLpzcWcCa0G/O
	 A6aX4PTsHmnfdvZapbU38RskitJ+JiBxzftuZDR5tm6dohbBQdJWFnjZz55ASvffHO
	 ZpRhMltceeiVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A5CC5DF94;
	Sat, 22 Aug 2026 02:28:56 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 21 Aug 2026 19:28:51 -0700
Subject: [PATCH] ceph: keep dentry in cache when inode still holds caps
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-b4-b4-ceph-dentry-caps-v1-1-ff9b77511c97@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vche3YTqFWJr2I4lHaA9VCbLhAN4
 d0tmszlO8y/kSILlO7VRhmrqLxiQXOqyE8ujmAJxWRqc61b03Bvj3mkiQPinD/sXVJ2wdrb2Qa
 49kLlnDIGef/Cj+5vXfon/HzUaN+/qvOFhnoAAAA=
X-Change-ID: 20260821-b4-b4-ceph-dentry-caps-ad44734dea85
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787365734; l=2605;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=o87BO+Zj9nfVEH3ZzSUVwdEu9iBuFdqRTUS2c5dkPxI=;
 b=FoUTAS/3UP8HD35Ara5xTQueufclkIvm1HlPU1JRHn7li0/zt04oC63/W1K9csd6RFwlj6YhL
 2Da6n6clfqhBdnGPTnS06T7z6N80pwFROnGDOZHRlT5kPThy9IqlSpp
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

ceph_d_delete() drops a dentry once its lease expires, which
releases the inode and destroys its page cache at the last close.
A buffered write that outlasts the dentry lease duration (30s by
default on the MDS side) is flushed and closed, yet the reopen
re-reads everything from the OSDs instead of the page cache, even
though the caps and the pages are still valid.

Keep the dentry when the inode still holds caps: the caps guarantee
the inode object is still valid, and the name linkage is revalidated
against the MDS by ceph_d_revalidate() on the next lookup anyway.

Keeping the dentry also keeps the inode and its page cache around
longer than before.  This is bounded: caps no longer needed by any
open file or by dirty data are released once the delayed release
window expires (caps_wanted_delay_max, 60s by default) via
ceph_check_delayed_caps(), after which the dentry is just an
ordinary cached dentry.  It is also fully reclaimable: ->d_delete()
is only consulted on the last dput (in retain_dentry()), while the
dcache shrinker (shrink_dentry_list() -> __dentry_kill()) does not
call it, so memory pressure frees these dentries like any others.

The check is deliberately racy: i_ceph_lock cannot be taken under
dentry->d_lock, but a false result only means keeping or dropping a
dentry that could have gone the other way, which is safe.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/dir.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index f4e0bf244fd2..a7d33ad9d2c7 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -2090,6 +2090,20 @@ static int ceph_d_delete(const struct dentry *dentry)
 		if (__dir_lease_try_check(dentry))
 			return 0;
 	}
+	/*
+	 * The lease has expired, but if the inode still holds caps, keep
+	 * the dentry: dropping it would release the inode and destroy its
+	 * page cache (e.g. on the last close after a long write).  The
+	 * caps guarantee the inode itself is still valid, and the name
+	 * linkage is revalidated against the MDS on the next lookup
+	 * anyway.
+	 *
+	 * This is deliberately racy: we can't take i_ceph_lock under
+	 * dentry->d_lock, but a false result only means we keep or drop a
+	 * dentry we could have done the opposite with, which is safe.
+	 */
+	if (__ceph_is_any_real_caps(ceph_inode(d_inode(dentry))))
+		return 0;
 	return 1;
 }
 

---
base-commit: 6a8322d32e2e2d3e364d31fc86c784e0e0105c08
change-id: 20260821-b4-b4-ceph-dentry-caps-ad44734dea85

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


