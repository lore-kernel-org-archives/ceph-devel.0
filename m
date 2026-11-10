Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274315;
	b=0KqT3D6mEc6hZNM59G7bGeGxixqiHP//C+4QNYv69c6iFygthat1KdexMFx6hBcZ0WLp
	 lSiutxIYEnbzc/ew1xrwwhiz5y3Lj6HLvyqKrh1d8orKBxb5ZEkdLb46BGkkVqZnoBpPs
	 Pb/8WJCIj64SFahVc1QcKACbjInFxteh0DaypXaCHEAuWGpbGQIKRp9pRjgnRn7t9ylTV
	 ZozkkWYr9l8Yfc1fG9PXLok10LvuqO2zw6rKukofTdXG3/EBcptdGhqksO7uncPU//rtW
	 pMnzyVdVqJGHUOqyS0pnoM+Iqwr4RQwR929Uq09QxhMvLK1HFKead2GND7iXq3dISSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274315;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-FangMail-Miltered:X-FangMail-Envelope:X-FangMail-Bounce-Flag:
	 X-FangMail-Outinfo:X-CLEAN:Message-Id:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=6yjptxu7ifZxr/BTi9zWLLipH5BFJe2V0T54ray4/OI=;
	b=2bhBC0Qj2yD8Gq7vagZ+ERo8vriazenp5WxlslGKWXR4wSzTHj2GTdPD+sgaQpp4fYVP
	 g/TGCh/tsld+TlcMQOGwHxuGfejNTol5W+wjBcjDtLmza78ZM/m7VcA2uI82Te3iplL8e
	 lCcj2lGychTGiNTNNzKulziyN0dGUzhh8TTIK/BXmkTvi80jFtnVYRQ88BkTrIGMj3sq3
	 hx9hH+Ffn6JGQC6u7VqWVgX28mXMzX1UKE7bX/JuDtWc2kEJMBTaOngYx21dejXLQRHsP
	 q+tQDueTxgZ72YRiTbo6ZgDOdtaLMDS37JWAro5ktI8vw4Sp2mg5U3kWvoH6AjSlxtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6C606A31C;
	Tue, 10 Nov 2026 01:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jNpzB4CVLzch9;
	Tue, 10 Nov 2026 09:31:50 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Xiubo Li <xiubli@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangdaolong <dlzhangak@isoftstone.com>
Subject: [PATCH] ceph: drop stale dentry when ceph_unlink() gets -ENOENT
Date: Tue, 10 Nov 2026 09:31:50 +0800
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
X-SOURCE-IP: 221.226.109.28 unknown Tue, 10 Nov 2026 09:31:50 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AF27406.001 by FangMail milter!
X-FangMail-Envelope: 1794274310/4jNpzB4CVLzch9/6AF27406.001/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1794274310.6AF27406.001
X-FangMail-Outinfo: 1794274310/6AF27406.001/4jNpzB4CVLzch9/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1794274310.6AF27406.001.4jNpzB4CVLzch9@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF27406.001/4jNpzB4CVLzch9

When a synchronous unlink, rmdir, or rmsnap request in ceph_unlink()
fails with -ENOENT (for example, because the target was already removed
on the MDS by another client or a snapshot was already purged before
the request reached the MDS), the MDS replies without a dentry trace.

Currently, ceph_fill_trace() only invalidates the parent directory when
result == 0, and neither ceph_unlink() nor the VFS layer unhashes the
dentry on error. As a result, the stale positive dentry remains hashed
in the dcache and the parent directory may retain CEPH_I_COMPLETE.

Fix this by clearing the parent directory's completeness and calling
d_drop(dentry) when ceph_mdsc_do_request() returns -ENOENT in
ceph_unlink().

Suggested-by: Xiubo Li <xiubli@kernel.org>
Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
---
 fs/ceph/dir.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 6eb5b1cb039b..f4c0521f3bcc 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1473,8 +1473,12 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	} else {
 		set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
 		err = ceph_mdsc_do_request(mdsc, dir, req);
-		if (!err && !req->r_reply_info.head->is_dentry)
+		if (!err && !req->r_reply_info.head->is_dentry) {
 			d_delete(dentry);
+		} else if (err == -ENOENT) {
+			ceph_dir_clear_complete(dir);
+			d_drop(dentry);
+		}
 	}
 
 	ceph_mdsc_put_request(req);
-- 
2.48.1

