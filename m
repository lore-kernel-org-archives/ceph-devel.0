Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931199;
	b=VuFcIkzZlKBUK9/yr/hsOHy/YfqOpRaIYfsgGix4DtMbeTppWGWzuchmsR/79Q2a2Q86
	 tOo7rcBlW4D22OvUKcp9/Xx5/BMMXCaE3AOisbG1kEXZFgs8ggRXVsmW66gjtrgesevYL
	 kcPC7h353VXslC0aukQJ6Oim80RfTkmjXWt1jBtucjjiJxrGK3M+eQs8nwbrXCQjY+AHh
	 7zM9rxCBwdka6Js1WnyMvwAvbEgFXk65IKVR53HXKP7zMfG2mqvGN8yiqR75Cx+L13jEO
	 snNhYbRmkUkFrpeZKdpikdrfAYJqPEeo03i/QRDQGSQ98k4iRFLavlYsV98Wq1k63+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931199;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-FangMail-Miltered:X-FangMail-Envelope:X-FangMail-Bounce-Flag:
	 X-FangMail-Outinfo:X-CLEAN:Message-Id:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=IXDbLD8+07I3K03p4PVRKPsQ8QqKTTPpkBAUsJipFic=;
	b=Y0tCiMZ8HdmUofDvfvPLzDkZvB/O6eSgFwzxxw63IsJ4hW1X2GoVSpbiWTlfx4gVNwCT
	 qVBrozJox0U4EQilX1kanG3jmf0wtuZJxqR/bJYqWQQmiT2uN+xGMf4buJgogAQmJEszp
	 DY/rIKxDNxg287UdZmcJcQK1CiLfBVfRTkD1g4SbpxYcfczSEFMzXcdZpUIio8zHrgtSa
	 mkRKLTMt2OTelhHBr1PH+jAOkED4oC9P/xXbmZGpqFEr/iI08Ql3yl+wYuQJp9yoI4W3a
	 QABTlVGniISt8oSuYCvjz8tULf7Pof/WvedcIlKOIrosThal6MX0+pevzGqo/S1cEpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98C5606A31B;
	Fri,  6 Nov 2026 02:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C98C5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jLN4k2qrnz23wX;
	Fri, 06 Nov 2026 10:13:10 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangdaolong <dlzhangak@isoftstone.com>
Subject: [PATCH] ceph: revalidate dentries under snapdir to drop stale snapshots
Date: Fri,  6 Nov 2026 10:13:10 +0800
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
X-SOURCE-IP: 221.226.109.28 unknown Fri, 06 Nov 2026 10:13:10 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AED37B6.000 by FangMail milter!
X-FangMail-Envelope: 1793931190/4jLN4k2qrnz23wX/6AED37B6.000/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1793931190.6AED37B6.000
X-FangMail-Outinfo: 1793931190/6AED37B6.000/4jLN4k2qrnz23wX/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1793931193.6AED37B6.000.4jLN4k2qrnz23wX@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AED37B6.000/4jLN4k2qrnz23wX

When a snapshot is deleted on one client node, its corresponding
'.snap/<snapname>' dentry cached in the VFS dcache on other client nodes
never gets invalidated. As a result, recreating a snapshot with the same
name on another node fails with -EEXIST, and removing it fails with
-ENOENT while still leaving the stale positive dentry in the dcache.

In ceph_d_revalidate(), the condition 'if (ceph_in_snap(dir))' matches
both immutable snapped directories (ceph_snap(dir) <= CEPH_MAXSNAP) and
the mutable virtual '.snap' directory itself (ceph_snap(dir) ==
CEPH_SNAPDIR). Because it unconditionally sets valid = 1 when dir is
CEPH_SNAPDIR, the CEPH_MDS_OP_LOOKUPSNAP revalidation path below inside
'if (!valid)' is rendered unreachable dead code.

Fix this by excluding CEPH_SNAPDIR from the unconditional trust check in
ceph_d_revalidate() so that cached dentries directly under '.snap' are
revalidated via CEPH_MDS_OP_LOOKUPSNAP. Additionally, drop the dentry in
ceph_unlink() when the MDS returns -ENOENT.

Fixes: 200fd27c8fa2 ("ceph: use lookup request to revalidate dentry")
Link: https://tracker.ceph.com/issues/81579
Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
---
 fs/ceph/dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 6eb5b1cb039b..9f84beac189e 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1475,6 +1475,8 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 		err = ceph_mdsc_do_request(mdsc, dir, req);
 		if (!err && !req->r_reply_info.head->is_dentry)
 			d_delete(dentry);
+		else if (err == -ENOENT)
+			d_drop(dentry);
 	}
 
 	ceph_mdsc_put_request(req);
@@ -2003,7 +2005,7 @@ static int ceph_d_revalidate(struct inode *dir, const struct qstr *name,
 	mdsc = ceph_sb_to_fs_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
-	if (ceph_in_snap(dir)) {
+	if (ceph_in_snap(dir) && ceph_snap(dir) != CEPH_SNAPDIR) {
 		doutc(cl, "%p '%pd' inode %p is SNAPPED\n", dentry,
 		      dentry, inode);
 		valid = 1;
-- 
2.48.1

