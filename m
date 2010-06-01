From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: [PATCH] ceph: fix d_subdirs ordering problem
Date: Tue, 1 Jun 2010 18:47:07 +0800
Message-ID: <AANLkTikAPg1pVfpnH_BSQFyQn2BzUNiGB3tVC2104Ts1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45409 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab0FAKrJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jun 2010 06:47:09 -0400
Received: by vws11 with SMTP id 11so836654vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Jun 2010 03:47:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We misused list_move_tail() to order the dentry in d_subdirs.
This will screw up the d_subdirs order.

This bug can be reliably reproduced by:
1. mount ceph fs.
2. on ceph fs, git clone git://ceph.newdream.net/git/ceph.git
3. Run autogen.sh in ceph directory.
(Note: Errors only occur at the first time you run autogen.sh.)

Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>
---
 inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/inode.c b/inode.c
index a81b8b6..72903a1 100644
--- a/inode.c
+++ b/inode.c
@@ -827,7 +827,7 @@ static void ceph_set_dentry_offset(struct dentry *dn)

        spin_lock(&dcache_lock);
        spin_lock(&dn->d_lock);
-       list_move_tail(&dir->d_subdirs, &dn->d_u.d_child);
+       list_move(&dn->d_u.d_child, &dir->d_subdirs);
        dout("set_dentry_offset %p %lld (%p %p)\n", dn, di->offset,
             dn->d_u.d_child.prev, dn->d_u.d_child.next);
        spin_unlock(&dn->d_lock);
--
1.6.5.2
