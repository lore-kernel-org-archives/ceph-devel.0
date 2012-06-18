From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/6] libceph: don't mark footer complete before it is
Date: Mon, 18 Jun 2012 10:33:19 -0500
Message-ID: <4FDF4A3F.4040909@inktank.com>
References: <4FDF4948.10306@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:52024 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2FRPdU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 11:33:20 -0400
Received: by gglu4 with SMTP id u4so3769760ggl.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 08:33:20 -0700 (PDT)
In-Reply-To: <4FDF4948.10306@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a nit, but prepare_write_message() sets the FOOTER_COMPLETE
flag before the CRC for the data portion (recorded in the footer)
has been completely computed.  Hold off setting the complete flag
until we've decided it's ready to send.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -616,6 +616,8 @@ static void prepare_write_message_footer
 	struct ceph_msg *m = con->out_msg;
 	int v = con->out_kvec_left;

+	m->footer.flags |= CEPH_MSG_FOOTER_COMPLETE;
+
 	dout("prepare_write_message_footer %p\n", con);
 	con->out_kvec_is_msg = true;
 	con->out_kvec[v].iov_base = &m->footer;
@@ -689,7 +691,7 @@ static void prepare_write_message(struct
 	/* fill in crc (except data pages), footer */
 	crc = crc32c(0, &m->hdr, offsetof(struct ceph_msg_header, crc));
 	con->out_msg->hdr.crc = cpu_to_le32(crc);
-	con->out_msg->footer.flags = CEPH_MSG_FOOTER_COMPLETE;
+	con->out_msg->footer.flags = 0;

 	crc = crc32c(0, m->front.iov_base, m->front.iov_len);
 	con->out_msg->footer.front_crc = cpu_to_le32(crc);

