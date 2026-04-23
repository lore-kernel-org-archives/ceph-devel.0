Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191B3E1224;
	Thu, 23 Apr 2026 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939552; cv=none; b=WjxpqnuOCU4Pdn7Ctq7KhsQ8A1TBhbG5lGecZJyjyg0Y4sIb41S9LvIdJk2Gmtifefqv2t3PM44p1hEiBCHX1v+8mlhiRuuVwq+Fk70KiJAneYWT+81LNiaMcoDp8uNnzyzMkGeTPFM33XWCUEtWxQ2CfSPr7gx7KfCcsbbHiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939552; c=relaxed/simple;
	bh=feTfHguK6IgPbsUNExx1LIyM5T3DVA/nZsftLrgp+qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gyn2L2I8iRAufBnQkG0cSIja6B4utUWGm58oWXKhZxBj3qlVKhzvAfqdUhZH66JgouTiL6oC0iOs8zt8YmDcf7TWdzrrZ9cxfqsw82rQbz0p0J2qGGmHD5zWcRJ8PoGMRKL+ntYB9TCHVgWmXDyUrslat0JLF38UINYkG3dyppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id AE30BC5766;
	Thu, 23 Apr 2026 12:09:14 +0200 (CEST)
From: Kefu Chai <k.chai@proxmox.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	linux-kernel@vger.kernel.org,
	Kefu Chai <k.chai@proxmox.com>
Subject: [PATCH] libceph: accept addrvecs with multiple entries of the same type
Date: Thu, 23 Apr 2026 18:09:04 +0800
Message-ID: <20260423100904.2336750-1-k.chai@proxmox.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1776938864932

ceph_decode_entity_addrvec() rejects any addrvec containing more than
one entry that matches the requested msgr type (LEGACY or MSGR2),
logging "another match of type N in addrvec" and returning -EINVAL.
This breaks legitimate deployments where a daemon advertises multiple
addresses of the same type, most notably dual-stack (IPv4 + IPv6)
clusters and multi-subnet deployments where tooling picks one address
per listed public_network.

The monmap decoder fails, the client enters a reconnect loop:

  libceph: mon0 (1)10.10.10.15:6789 session established
  libceph: another match of type 1 in addrvec
  libceph: problem decoding monmap, -22

Match the userspace messenger, which since Nautilus picks the first
entry of the requested type and silently tolerates subsequent entries.

Link: https://tracker.ceph.com/issues/49581
Link: https://tracker.ceph.com/issues/64068
Link: https://bugzilla.proxmox.com/show_bug.cgi?id=7518
Signed-off-by: Kefu Chai <k.chai@proxmox.com>
---

Tested by reproducing the Proxmox BZ 7518 scenario against a vstart
cluster whose mon addrvec was edited to contain two v1 + two v2 entries:

    ceph mon set-addrs a \\
        '[v2:$ip1:$p2/0,v1:$ip1:$p1/0,v2:$ip2:$p2/0,v1:$ip2:$p1/0]'

A Debian VM booted with the patched kernel via 'qemu -kernel' then
ran 'mount -t ceph ...:$p1:/ /mnt -o name=admin'.  Pre-patch kernels
fail at monmap decode with "another match of type 1 in addrvec"
(-EINVAL).  Post-patch, decode succeeds and the mount proceeds to
the auth / MDS-discovery stages.

Also verified the decoder logic on the monmap.bin attached to BZ 7518
using a userspace port of ceph_decode_entity_addrvec(): the pre-patch
form returns -EINVAL on both msgr1 and msgr2 lookups; the post-patch
form returns 0 and picks the first matching entry.

 net/ceph/decode.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/ceph/decode.c b/net/ceph/decode.c
index bc109a1a4616..b17bc082b4fc 100644
--- a/net/ceph/decode.c
+++ b/net/ceph/decode.c
@@ -88,7 +88,8 @@ EXPORT_SYMBOL(ceph_decode_entity_addr);
 
 /*
  * Return addr of desired type (MSGR2 or LEGACY) or error.
- * Make sure there is only one match.
+ * If multiple entries of the desired type are present, use the
+ * first one.
  *
  * Assume encoding with MSG_ADDR2.
  */
@@ -120,13 +121,7 @@ int ceph_decode_entity_addrvec(void **p, void *end, bool msgr2,
 			return ret;
 
 		dout("%s i %d addr %s\n", __func__, i, ceph_pr_addr(&tmp_addr));
-		if (tmp_addr.type == my_type) {
-			if (found) {
-				pr_err("another match of type %d in addrvec\n",
-				       le32_to_cpu(my_type));
-				return -EINVAL;
-			}
-
+		if (tmp_addr.type == my_type && !found) {
 			memcpy(addr, &tmp_addr, sizeof(*addr));
 			found = true;
 		}
-- 
2.47.3


