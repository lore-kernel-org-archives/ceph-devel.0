From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: drop declaration of ceph_con_get()
Date: Tue, 26 Jun 2012 14:47:41 -0700
Message-ID: <4FEA2DFD.1060308@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59718 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821Ab2FZVrn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 17:47:43 -0400
Received: by dady13 with SMTP id y13so464133dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 14:47:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

For some reason the declaration of ceph_con_get() and
ceph_con_put() did not get deleted in this commit:
     d59315ca libceph: drop ceph_con_get/put helpers and nref member

Clean that up.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  include/linux/ceph/messenger.h |    2 --
  1 file changed, 2 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index cb9d38f..478f814 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -244,8 +244,6 @@ extern void ceph_msg_revoke(struct ceph_msg *msg);
  extern void ceph_msg_revoke_incoming(struct ceph_msg *msg);

  extern void ceph_con_keepalive(struct ceph_connection *con);
-extern struct ceph_connection *ceph_con_get(struct ceph_connection *con);
-extern void ceph_con_put(struct ceph_connection *con);

  extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
  				     bool can_fail);
-- 
1.7.9.5

