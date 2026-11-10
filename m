Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291332;
	b=x/uqPoikJNHLEFT5Ybew5T6n6z6z351521CjRV25lB7uMdR7Tnr14dVNyJ4A4qd38Zen
	 Vf+hSnfV5fO+OSIrmftQn23zKq6+ogSxxR23yOgQ7vlNynXZzvZVKlog5TOOH85K0gxGy
	 GAcjI8hT2pwPK1IoiUE6ykfo3gqEMAVDJpgEkAYcDAC9SjCS7G2T7ynh0gb5R5aV6zqCb
	 YW9cQCZFaMls5B5K/jK9X1K+elsdvub6Uan9x62WqnC0+VJHWgzi3SbRI8yEdy0h0XU6X
	 GTd6YFees53S7Qq1Jgion5prEXEQvRqImVVY6/49evKR1M/ED0q2ZQdCiwopfOjIb3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291332;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-FangMail-Miltered:X-FangMail-Envelope:
	 X-FangMail-Bounce-Flag:X-FangMail-Outinfo:X-CLEAN:Message-Id:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=85od8xelAuMtSdRpPQfSyU6RHml/ulrI0FnwARIs0KY=;
	b=uECAh0zOjWcBblNJtpa48QfrQHwFpDBwq4hBM3Sy3t0uvf32aIa98pHm8zlBXkHNllXR
	 X63J4gNX/EVpSv4ccq+7NQ6UsSP9EWLyQCIVsWhh3tLrfQ/Zln1FyNA9R97rAxLGCgyVa
	 SXYuyxrlu1wYX0jzMISigdeXrCQwbNlan278dhG3ZrdbVhs/BRvelAE4U3SxfknCiQgVh
	 4GiL+Hg4PV1S4qtBIwCQrZpHcU/rqGTgDZVkskmAa22EiGPQZt4CbrF/88x1GoVPzLdm5
	 pR8SoxujRxMuY7qB/OlcArAXzRNz3cFpUP+Y9/S7z0jHCVEioMA4dnU//cAJTF01xlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3A606A31C;
	Tue, 10 Nov 2026 06:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDE3A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jNxGL3VPpzc8B;
	Tue, 10 Nov 2026 14:15:22 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Xiubo Li <xiubli@kernel.org>,
	Xiubo Li <xiubo.li@clyso.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangdaolong <dlzhangak@isoftstone.com>
Subject: [PATCH v2] ceph: drop stale dentry when ceph_unlink() gets -ENOENT
Date: Tue, 10 Nov 2026 14:15:22 +0800
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAOuZWzy9ro0r4RhYqKEBVPLnjNueQGCAV9bTGpN_PtArbY6soA@mail.gmail.com>
References: <CAOuZWzy9ro0r4RhYqKEBVPLnjNueQGCAV9bTGpN_PtArbY6soA@mail.gmail.com>
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
X-SOURCE-IP: 221.226.109.28 unknown Tue, 10 Nov 2026 14:15:22 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AF2B67A.000 by FangMail milter!
X-FangMail-Envelope: 1794291322/4jNxGL3VPpzc8B/6AF2B67A.000/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1794291322.6AF2B67A.000
X-FangMail-Outinfo: 1794291322/6AF2B67A.000/4jNxGL3VPpzc8B/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1794291322.6AF2B67A.000.4jNxGL3VPpzc8B@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF2B67A.000/4jNxGL3VPpzc8B

Dentries under .snap do not have MDS leases. If a snapshot is removed
in the window between d_revalidate() and the synchronous RMSNAP request
in ceph_unlink(), the MDS replies with -ENOENT and no dentry trace.

Because ceph_fill_trace() only invalidates the parent directory when
result == 0 and neither ceph_unlink() nor the VFS layer unhashes the
dentry on error, the stale positive snapshot dentry remains hashed in
the dcache. Subsequent stat on .snap/<snap> still finds the deleted
snapshot and mkdir .snap/<snap> fails with -EEXIST.

For regular files and directories, a concurrent unlink by another client
revokes the local dentry lease and parent Fs caps, so dropping the
dentry and clearing parent completeness on -ENOENT serves as hardening
that matches what ceph_async_unlink_cb() already does on failure.

Fix the stale .snap dentry issue and harden ceph_unlink() by calling
ceph_dir_clear_complete(dir) and d_drop(dentry) when
ceph_mdsc_do_request() returns -ENOENT.

Suggested-by: Xiubo Li <xiubli@kernel.org>
Tested-by: Xiubo Li <xiubo.li@clyso.com>
Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
---
v2:
- Narrow down the commit message to explain the .snap race window and
  describe the regular file/dir part as hardening (Xiubo Li).
- Add Tested-by and Reviewed-by tags from Xiubo Li.

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

