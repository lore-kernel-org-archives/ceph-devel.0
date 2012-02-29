From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/3] libceph: separate CRC calculation from byte swapping
Date: Tue, 28 Feb 2012 20:50:53 -0800
Message-ID: <4F4DAEAD.7000506@dreamhost.com>
References: <4F4DAE4E.4000903@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48785 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965408Ab2B2Euy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:50:54 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DD6D32431D
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:50:53 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id D04CD24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:50:53 -0800 (PST)
In-Reply-To: <4F4DAE4E.4000903@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Calculate CRC in a separate step from rearranging the byte order
of the result, to improve clarity and readability.

Use offsetof() to determine the number of bytes to include in the
CRC calculation.

In read_partial_message(), switch which value gets byte-swapped,
since the just-computed CRC is already likely to be in a register.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |   31 +++++++++++++++++--------------
  1 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 8ac2f33..1df7e6f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -518,6 +518,7 @@ static void prepare_write_message_footer(struct 
ceph_connection *con)
  static void prepare_write_message(struct ceph_connection *con)
  {
  	struct ceph_msg *m;
+	u32 crc;

  	ceph_con_out_kvec_reset(con);
  	con->out_kvec_is_msg = true;
@@ -566,17 +567,17 @@ static void prepare_write_message(struct 
ceph_connection *con)
  			m->middle->vec.iov_base);

  	/* fill in crc (except data pages), footer */
-	con->out_msg->hdr.crc =
-		cpu_to_le32(crc32c(0, &m->hdr,
-				      sizeof(m->hdr) - sizeof(m->hdr.crc)));
+	crc = crc32c(0, &m->hdr, offsetof(struct ceph_msg_header, crc));
+	con->out_msg->hdr.crc = cpu_to_le32(crc);
  	con->out_msg->footer.flags = CEPH_MSG_FOOTER_COMPLETE;
-	con->out_msg->footer.front_crc =
-		cpu_to_le32(crc32c(0, m->front.iov_base, m->front.iov_len));
-	if (m->middle)
-		con->out_msg->footer.middle_crc =
-			cpu_to_le32(crc32c(0, m->middle->vec.iov_base,
-					   m->middle->vec.iov_len));
-	else
+
+	crc = crc32c(0, m->front.iov_base, m->front.iov_len);
+	con->out_msg->footer.front_crc = cpu_to_le32(crc);
+	if (m->middle) {
+		crc = crc32c(0, m->middle->vec.iov_base,
+				m->middle->vec.iov_len);
+		con->out_msg->footer.middle_crc = cpu_to_le32(crc);
+	} else
  		con->out_msg->footer.middle_crc = 0;
  	con->out_msg->footer.data_crc = 0;
  	dout("prepare_write_message front_crc %u data_crc %u\n",
@@ -872,12 +873,13 @@ static int write_partial_msg_pages(struct 
ceph_connection *con)
  			    total_max_write);

  		if (do_crc && !con->out_msg_pos.did_page_crc) {
+			u32 crc;
  			void *base = kaddr + con->out_msg_pos.page_pos;
  			u32 tmpcrc = le32_to_cpu(con->out_msg->footer.data_crc);

  			BUG_ON(kaddr == NULL);
-			con->out_msg->footer.data_crc =
-				cpu_to_le32(crc32c(tmpcrc, base, len));
+			crc = crc32c(tmpcrc, base, len);
+			con->out_msg->footer.data_crc = cpu_to_le32(crc);
  			con->out_msg_pos.did_page_crc = true;
  		}
  		ret = kernel_sendpage(con->sock, page,
@@ -1647,8 +1649,9 @@ static int read_partial_message(struct 
ceph_connection *con)
  		con->in_base_pos += ret;
  		if (con->in_base_pos == sizeof(con->in_hdr)) {
  			u32 crc = crc32c(0, &con->in_hdr,
-				 sizeof(con->in_hdr) - sizeof(con->in_hdr.crc));
-			if (crc != le32_to_cpu(con->in_hdr.crc)) {
+					offsetof(struct ceph_msg_header, crc));
+
+			if (cpu_to_le32(crc) != con->in_hdr.crc) {
  				pr_err("read_partial_message bad hdr "
  				       " crc %u != expected %u\n",
  				       crc, con->in_hdr.crc);
-- 
1.7.5.4

