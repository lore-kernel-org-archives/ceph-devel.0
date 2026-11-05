Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793858047;
	b=SSGCaC9H3NpSju8HuFLTIy2feU4RzyE3BPWG3zh57rjoeqMMttNp3/iU8s3AkH49cle1
	 LLD4PUivASp9yJtttFWrjfxvNIzq/VYknNcedUoGa/I5dIP6QwB6b0AxzvSGcU5lnydib
	 27Lt0NsopeTVu7FlTNkwVm3qRHUk1knKrdN3RCDamxVj8E9wzKkBTbR4359iBFxByo0e6
	 tw8Ca4XWnOUzQCyEECwqxmxdsuYh8IT22PLWLVmU5ChpHyJB/JAqVBz0K6QeKTffJM7EN
	 dJje0RjvxXU04OEV8egdX8ipGGHdwnus2jRZF2IpKMbmAaSWeCY3Ln20KOmbGzCaczg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858047;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-FangMail-Miltered:X-FangMail-Envelope:X-FangMail-Bounce-Flag:
	 X-FangMail-Outinfo:X-CLEAN:Message-Id:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=VDXls04qQSI4HIp6mJhgcpmi+rXfyrJwAbauaHnqrtc=;
	b=hXighX1+TheLB/BIIpWavL8qu1pAtWNpPK5qXnxqYm7zZI2wAxRLR+hWHfll73ezVi/t
	 O8ZAbSQuj9SX9XDL0HSJVfu+3frss2NbCnf2+d9ABenPsaX641Tqh/hCjcGXypuaxNHz5
	 M9sXAchXsebiyBOfXKKxxxNe/OgZZnrNDsrGcWgCIEdSgGL3Fdl7sCxeKYfK35rj5H1HE
	 KtUmw7aI8Hnoj6GCDFLkcBuyZ7jAoOp7ZpnlD4XxjwBEC7CypquJUHeALMUoMQGYpJXU2
	 BZPzPd9BaHbeLiBJC/Ev5gbikRhGmLHwJ8/RzY7EGhOpiLHJhmAXCEaQabdh5HXEHnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738A2606A330;
	Thu,  5 Nov 2026 05:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 738A2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jKs1y00vLz3CgW;
	Thu, 05 Nov 2026 13:53:57 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangdaolong <dlzhangak@isoftstone.com>
Subject: [PATCH] ceph: fix inode and i_filelock_ref leak on file lock rollback
Date: Thu,  5 Nov 2026 13:53:57 +0800
X-Mailer: git-send-email 2.48.1
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Thu, 05 Nov 2026 13:53:58 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AEC19F5.003 by FangMail milter!
X-FangMail-Envelope: 1793858038/4jKs1y00vLz3CgW/6AEC19F5.003/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1793858038.6AEC19F5.003
X-FangMail-Outinfo: 1793858038/6AEC19F5.003/4jKs1y00vLz3CgW/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1793858040.6AEC19F5.003.4jKs1y00vLz3CgW@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEC19F5.003/4jKs1y00vLz3CgW

When ceph_lock() or ceph_flock() succeeds in acquiring a file lock on
the MDS via ceph_lock_message() but fails to install the lock locally in
VFS (for example when posix_lock_file() returns -EAGAIN or -EDEADLK, or
locks_lock_file_wait() is interrupted), it sends a CEPH_LOCK_UNLOCK
rollback request to the MDS reusing the same struct file_lock instance.

Because ceph_lock_message() unconditionally invokes
fl->fl_ops->fl_copy_lock(fl, NULL) for every CEPH_MDS_OP_SETFILELOCK
operation, the rollback call increments ci->i_filelock_ref a second time
and overwrites fl->fl_u.ceph.inode with a second igrab(inode) reference.
When the caller subsequently frees or releases the request file_lock,
ceph_fl_release_lock() only runs once, permanently leaking one
i_filelock_ref count and one inode reference per rollback and causing
'VFS: Busy inodes after unmount of ceph' on unmount.

Fix this by:
1. Skipping fl_copy_lock() in ceph_lock_message() when cmd is
   CEPH_LOCK_UNLOCK, since unlocking does not add a file_lock to the
   inode.
2. Guarding ceph_fl_copy_lock() against being called when
   dst->fl_u.ceph.inode is already set, ensuring a single file_lock
   never acquires multiple inode references across retries or rollbacks.

Fixes: 89aa59301013 ("ceph: keep auth cap when inode has flocks or posix locks")
Fixes: 8e1858710d9a ("ceph: avoid use-after-free in ceph_fl_release_lock()")
Link: https://tracker.ceph.com/issues/81372
Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
---
 fs/ceph/locks.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 677221bd64e0..17b893c234d3 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -34,6 +34,10 @@ void __init ceph_flock_init(void)
 static void ceph_fl_copy_lock(struct file_lock *dst, struct file_lock *src)
 {
 	struct inode *inode = file_inode(dst->c.flc_file);
+
+	if (dst->fl_u.ceph.inode)
+		return;
+
 	atomic_inc(&ceph_inode(inode)->i_filelock_ref);
 	dst->fl_u.ceph.inode = igrab(inode);
 }
@@ -81,7 +85,7 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 	u64 length = 0;
 	u64 owner;
 
-	if (operation == CEPH_MDS_OP_SETFILELOCK) {
+	if (operation == CEPH_MDS_OP_SETFILELOCK && cmd != CEPH_LOCK_UNLOCK) {
 		/*
 		 * increasing i_filelock_ref closes race window between
 		 * handling request reply and adding file_lock struct to
-- 
2.48.1

