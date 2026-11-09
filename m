Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794184047;
	b=qZsV2IPsmaJShYiS7uc352MMgVI2ejMbJkRzYtNDkdp+i4OKRkkC1uLnslqRBtkvtgOf
	 I6c6AEAU+HH9euz1+pfp2lkq+e6WwYbe0rGZ8fpSGPZSxCddWvyD2WVS/ckb91REYeLGu
	 kdU2ZiHFKWq/bhYUWapNIrbM69fGto2BIpaRKhVvU2/B3vtbbO7Kn2kQgWBk3vzDM0uis
	 QODXst33ARYw9MB4QhzDEA2Ot1rBkEfe/kfGt4RJW0h1E3qYxw+LbjDhwYL+b9Arb4cn6
	 jPj+NYhNe0j07c4l210YJ0T1DAEz7U0Un3yFl0OU9P6xyxU5LA4j3XauX4IhP4V7hdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184047;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YSNQBlnYy4Tyvhr3MfIx5hMTrcKDdnzgSLzZLIt/m6A=;
	b=OJaJtsTMVMjU/gKj9Z81C55hWnDxSP/Lnaabd3OMFwlJqsimHWVNfWLW+ccoHQKXf5w1
	 wNyiGoRBlpvL2eut5QAHQz+7qRA+G/nIOrvOIL9epYL/ktJ18ztjOwL5c6yhk2PnB8sbr
	 ogSYHnrmWrKDT3u6ALWUfSlc/2llD6n/5RvcIDgnGU380bmjKvlneau8zqEs3PjWfv86z
	 JTh7CqYjPFU2rQR7Kowr7+MKc7P0w2+OxQI5epNGONn9U8m7gO+mMomfyoKUPPA0pGIuB
	 NWzWwhxqdcfg/gx6EJusK2wE4hCM8iAfWgm1dWpY/TdgwGRGxXcvqRYiWUx9kiPsL8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXpRukcu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3614606A32A;
	Mon,  9 Nov 2026 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXpRukcu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794184046;
	b=wEQvNoKFlLe5rml0OHJh8ahPWS3saygmd79gciSI10YM/adtCgt+h9cEDtMfTWjUwrL2
	 LjnUGS/E11NGxwWP55azKTcgi2+3+hqJ2jPymoNSe7wNU7KPqFSnW+ZnhisxqzoAdYox+
	 Oy6B0cX+WecZgcgn1hQOZQNHpy3zdVpzXYAyUoZ0k+bmSOOxR+zuxfPKGclxQULkiUS6n
	 ujadZlkEnlN+bXKj0/NIh7R9ZO6pjyF5vOdLx+0c0lGUyU8UAXQrGy0MJJT3doG007FRd
	 kedQLir4KaV932nsJR6tKcefU+geVXgqEJhGQXHC7uUVlqfpmrqOT7r/NEkgkOOSzCg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794184046;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YSNQBlnYy4Tyvhr3MfIx5hMTrcKDdnzgSLzZLIt/m6A=;
	b=wP63zBqrfZX490nOZuuxDQtpncqOcAGOhfF8fTJpLd0Ocz9nr8B+7/zw0DxDpU2X1SOf
	 t1uDuRISebPZLg74rLbez55m/VZZ2BXzkB4BALNDM+xuoCJsirTXFyCFC7hJQX70xKI/w
	 wi7U0NJut2sawEZ57evv/qz+hyhY9l8MwSltF8SoTd8zBDIF1mQbrLaWN13muIbcyGuyk
	 N+Ljw/WNfgPKTbC1oPVfR4BeQ0oGHluUIKqPn4Hcvpkr9nSKuxAIWH59bCXqFO2wKIfpD
	 OwhYvo9xBLcPD2IYSRyNx9f/8T5vkNvBHc6hI7R50hk009dBO0/BaQ8pNnEuVmG7X7g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D72F01F008A1;
	Mon,  9 Nov 2026 00:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184046;
	bh=YSNQBlnYy4Tyvhr3MfIx5hMTrcKDdnzgSLzZLIt/m6A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WXpRukcuC1Y7xoCqbOd+YvtIliMEY8RtHZOTeMXUDNh4iESv87mLNQsna+QcsVtoR
	 HqfSSaBtGJKoT3ZEehlmA+u+3i+EavkMkIKUt0DXWMGjtDiW8AhXWmlHWQnEi/5bw1
	 eYl11o0l7PGbnPmGqm1XblOeoEdOWu/hOEcS0hG1zTL4plWPZyQaXt+e5Ngd6vW3Rz
	 5dSf8roCfrPB5Xv15RPIxpyeeK4kvFxwHjTuXLeRwN85nvNOUwSQ3K3wvS8UiV9w2g
	 mueKIsq6qNIP9MzZJmVvQhNZGuO14jhQhWISNBGUjo5jWTEpdAH6/aecC9jbxvSGxh
	 TNXvpQl59mt1g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5D0304819A;
	Mon,  9 Nov 2026 00:27:24 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Mon, 09 Nov 2026 01:27:19 +0100
Subject: [PATCH 2/2] ceph: drop the dirty folios that a shut down mount
 cannot write back
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
Message-Id: <20261109-ceph-shutdown-dirty-folios-v1-2-34600e8dab20@clyso.com>
References: <20261109-ceph-shutdown-dirty-folios-v1-0-34600e8dab20@clyso.com>
In-Reply-To: <20261109-ceph-shutdown-dirty-folios-v1-0-34600e8dab20@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184042; l=3297;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=apUGUAugMMqkzlDQq7ZBOtMNcuBWkirzNCz7wqu3KjU=;
 b=azC8ejpzs7pUV5FvwNmYgF0qXFQc6onGrB/Eo8qFBp+qNRpyI9JMZiVibAw0v0H918RqrmJgy
 VPFIEa1hU1OANkmw04/+oFXbnlsfL4bn9DDtmxH0i3vV+8XKzg6soOz
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

When the MDS closes the session of a client (e.g. it evicts it), the
caps go, with any dirty cap state, but the dirty folios stay in the
page cache: the inode is not shut down then, so ceph_purge_inode_cap()
does not have them invalidated, and they are left for writeback.  If
the mount is then shut down by a forced umount before they were written
back, they never are: ceph_writepages_start() only sets -EIO on the
mapping and returns, so they stay dirty for good.  Each keeps its count
in mdsc->dirty_folios and its Fb cap ref, which holds a reference to
the inode, so umount waits until mount_timeout and then finds the inode
busy:

  ceph: ... dropping dirty Fw state for ... 10000000001.fffffffffffffffe
  ceph: ... 10000000001.fffffffffffffffe 1099511627777 forced umount
  ceph: ... umount timed out, 0
  VFS: Busy inodes after unmount of ceph (ceph)
  kernel BUG at fs/super.c:731!

Have the page cache of such an inode invalidated there instead, which
for a shut down inode truncates it, as ceph_purge_inode_cap() does.
That has to happen from the inode work, not from writeback: putting the
last Fb cap ref may put the last reference to the inode, and evicting
it would wait for the writeback that does it.  Then ceph_kill_sb()
flushes the inode work after syncing the fs, so that the folios and
their references are gone before the inodes are evicted.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/addr.c  | 14 ++++++++++++++
 fs/ceph/super.c |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2abed478a4ad..2202906f4e18 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2097,6 +2097,20 @@ static int ceph_writepages_start(struct address_space *mapping,
 	      (wbc->sync_mode == WB_SYNC_ALL ? "ALL" : "HOLD"));
 
 	if (is_forced_umount(mapping)) {
+		/*
+		 * What is dirty here can never be written back now.  Left
+		 * dirty, each folio keeps its Fb cap ref, which holds the
+		 * inode, and its count in the dirty folios that umount
+		 * waits for.  ceph_purge_inode_cap() has them invalidated
+		 * when it removes the caps of a shut down inode, but the
+		 * session may have been closed (the client evicted), and
+		 * the caps removed, before the shut down.  Have them
+		 * dropped now, but not from here: putting the last Fb cap
+		 * ref may put the last reference to the inode, and its
+		 * eviction would wait for this writeback.
+		 */
+		if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
+			ceph_queue_invalidate(inode);
 		ceph_blog_exit(&__ji);
 		return -EIO;
 	}
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 40be4b16e486..bb5591c1e154 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1634,6 +1634,14 @@ static void ceph_kill_sb(struct super_block *s)
 	 */
 	sync_filesystem(s);
 
+	/*
+	 * A shut down mount can't write back its dirty folios, and
+	 * writeback queued their invalidation instead: let it drop them,
+	 * and the references they hold to the inodes, before the inodes
+	 * get evicted.
+	 */
+	flush_workqueue(fsc->inode_wq);
+
 	if (atomic64_read(&mdsc->dirty_folios) > 0) {
 		wait_queue_head_t *wq = &mdsc->flush_end_wq;
 		long timeleft = wait_event_killable_timeout(*wq,

-- 
2.53.0


