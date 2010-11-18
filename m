From: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Subject: FW: [ceph-commit] ceph-client.git branch master updated.
	v2.6.34-20640-ge99fe63
Date: Thu, 18 Nov 2010 11:03:24 +0100
Message-ID: <14C7F4F06DB5814AB0DE29716C4F6D671720BA1D@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smail2.alcatel.fr ([64.208.49.57]:43200 "EHLO smail2.alcatel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754904Ab0KRKDe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Nov 2010 05:03:34 -0500
Received: from FRMRSSXCHHUB02.dc-m.alcatel-lucent.com (FRMRSSXCHHUB02.dc-m.alcatel-lucent.com [135.120.45.62])
	by smail2.alcatel.fr (8.14.3/8.14.3/ICT) with ESMTP id oAIA3O5q018969
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 18 Nov 2010 11:03:32 +0100
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Verified fix for #549.

- Jan
 

-----Original Message-----
From: ceph-commit-bounces@lists.ceph.newdream.net [mailto:ceph-commit-bounces@lists.ceph.newdream.net] On Behalf Of Sage Weil
Sent: donderdag 18 november 2010 1:11
To: ceph-commit@lists.ceph.newdream.net
Subject: [ceph-commit] ceph-client.git branch master updated. v2.6.34-20640-ge99fe63

The branch, master has been updated
       via  e99fe63ef2b59ff58d6ed556db911037cf7562c7 (commit)
      from  7b88dadc13e0004947de52df128dbd5b0754ed0a (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

http://ceph.newdream.net/git/?p=ceph.git;a=commit;h=e99fe63ef2b59ff58d6ed556db911037cf7562c7

- Log -----------------------------------------------------------------
commit e99fe63ef2b59ff58d6ed556db911037cf7562c7
Author: Sage Weil <sage@newdream.net>
Date:   Wed Nov 17 16:14:25 2010 -0800

    ceph: fix readdir EOVERFLOW on 32-bit archs
    
    One of the readdir filldir_t callers was passing the raw ceph 64-bit ino
    instead of the hashed 32-bit one, producing an EOVERFLOW in the filler
    callback.  Fix this by calling the ceph_vino_to_ino() helper to do the
    conversion.
    
    Reported-by: Jan Smets <jan.smets@alcatel-lucent.com>
    Signed-off-by: Sage Weil <sage@newdream.net>

---

 fs/ceph/dir.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 5f67728..7d447af 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -358,18 +358,22 @@ more:
 		u64 pos = ceph_make_fpos(frag, off);
 		struct ceph_mds_reply_inode *in =
 			rinfo->dir_in[off - fi->offset].in;
+		struct ceph_vino vino;
+		ino_t ino;
+
 		dout("readdir off %d (%d/%d) -> %lld '%.*s' %p\n",
 		     off, off - fi->offset, rinfo->dir_nr, pos,
 		     rinfo->dir_dname_len[off - fi->offset],
 		     rinfo->dir_dname[off - fi->offset], in);
 		BUG_ON(!in);
 		ftype = le32_to_cpu(in->mode) >> 12;
+		vino.ino = le64_to_cpu(in->ino);
+		vino.snap = le64_to_cpu(in->snapid);
+		ino = ceph_vino_to_ino(vino);
 		if (filldir(dirent,
 			    rinfo->dir_dname[off - fi->offset],
 			    rinfo->dir_dname_len[off - fi->offset],
-			    pos,
-			    le64_to_cpu(in->ino),
-			    ftype) < 0) {
+			    pos, ino, ftype) < 0) {
 			dout("filldir stopping us...\n");
 			return 0;
 		}
_______________________________________________
Ceph-commit mailing list
Ceph-commit@lists.ceph.newdream.net
http://lists.ceph.newdream.net/listinfo.cgi/ceph-commit-ceph.newdream.net
