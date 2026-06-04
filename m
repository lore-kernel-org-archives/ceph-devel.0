Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328742DFF1;
	Thu,  4 Jun 2026 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581772; cv=none; b=TRvWRdW484Raqr1cqY/NIqn3p9rHuQykJm0RNYu8sQw8P2fviEYZtRtcTsdWUDJ4XfLNIHPdYsiengMJmEUBtFAeQnmJgnxlobaIWGahW2ucYMhqFcVdYDYwAEMMHt6uZsmCMHn/srhrdLwJQvnkWxlReOgPdmyiFcEUB/go83g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581772; c=relaxed/simple;
	bh=J9IsqTty8n2zTP4ly0p5XZKmjS2l25ZJ0xTIfWjQ95I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwbANkF9ysSgKPpElSSCWp0ou7DvuBYCeY4ogDaypxY+cqt+mgIQJm3XAsi0ypKMzGaHofFcwyqSRVcU05WZcXwdObFvgu6DCLeAIgPef96gsPGdL3NrFsrPqbKwtOdQmzaB1/tp/r4AMYfuJ9JGLWT75dITlzBlaD6oPZpaIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 16D5D8093B;
	Thu, 04 Jun 2026 16:02:41 +0200 (CEST)
From: Kefu Chai <k.chai@proxmox.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	linux-kernel@vger.kernel.org,
	Kefu Chai <k.chai@proxmox.com>
Subject: [PATCH v2] libceph: tolerate addrvecs with multiple entries of the same type
Date: Thu,  4 Jun 2026 22:02:31 +0800
Message-ID: <20260604140231.2759025-1-k.chai@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423100904.2336750-1-k.chai@proxmox.com>
References: <20260423100904.2336750-1-k.chai@proxmox.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1780581722107

ceph_decode_entity_addrvec() rejects any addrvec containing more than
one entry that matches the requested msgr type (LEGACY or MSGR2),
logging "another match of type N in addrvec" and returning -EINVAL.

Some admin tooling (e.g. pveceph mon create from Proxmox VE) generates
addrvecs with multiple same-type entries when public_network lists more
than one CIDR: it picks one local IP per subnet and emits both a v2 and
a v1 entry for each IP.  Monmaps shaped this way cause:

  libceph: mon0 (1)10.10.10.15:6789 session established
  libceph: another match of type 1 in addrvec
  libceph: problem decoding monmap, -22

No Ceph code uses the extra entries: since Nautilus, the userspace
messenger (AsyncMessenger) unconditionally picks the first address of
the requested type and ignores any subsequent matches.

Match that behavior: use the first matching entry and silently skip any
subsequent ones.  This is a compatibility fix for existing deployments
and does not enable dual-stack or multi-subnet address selection.

Link: https://bugzilla.proxmox.com/show_bug.cgi?id=7518
Signed-off-by: Kefu Chai <k.chai@proxmox.com>
---
Changes since v1:
- Rewrite commit message to frame as compatibility fix; drop dual-stack/
  multi-subnet framing and the two ceph tracker links
- Simplify comment in ceph_decode_entity_addrvec()

Tested by reproducing the Proxmox BZ 7518 scenario against a vstart
cluster whose mon addrvec was edited to contain two v1 + two v2 entries:

    ceph mon set-addrs a \
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

 net/ceph/decode.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/ceph/decode.c b/net/ceph/decode.c
index bc109a1a4616..18f0a7c71950 100644
--- a/net/ceph/decode.c
+++ b/net/ceph/decode.c
@@ -87,8 +87,9 @@ ceph_decode_entity_addr(void **p, void *end, struct ceph_entity_addr *addr)
 EXPORT_SYMBOL(ceph_decode_entity_addr);
 
 /*
- * Return addr of desired type (MSGR2 or LEGACY) or error.
- * Make sure there is only one match.
+ * Return addr of desired type (MSGR2 or LEGACY) or error.  If multiple
+ * entries of the desired type are present, use the first one for
+ * compatibility with existing deployments.
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


