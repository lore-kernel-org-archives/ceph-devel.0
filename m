From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] ceph: messenger: use read_partial() in read_partial_message()
Date: Thu, 10 May 2012 20:18:41 -0500
Message-ID: <4FAC68F1.3070301@inktank.com>
References: <4FAC4799.3010903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35045 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab2EKBSo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 21:18:44 -0400
Received: by obbtb18 with SMTP id tb18so2527882obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 18:18:43 -0700 (PDT)
In-Reply-To: <4FAC4799.3010903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are two blocks of code in read_partial_message()--those that
read the header and footer of the message--that can be replaced by a
call to read_partial().  Do that.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |   30 ++++++++++--------------------
  1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index f0993af..673133e 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1628,7 +1628,7 @@ static int read_partial_message(struct 
ceph_connection *con)
  {
  	struct ceph_msg *m = con->in_msg;
  	int ret;
-	int to, left;
+	int to;
  	unsigned front_len, middle_len, data_len;
  	bool do_datacrc = !con->msgr->nocrc;
  	int skip;
@@ -1638,15 +1638,10 @@ static int read_partial_message(struct 
ceph_connection *con)
  	dout("read_partial_message con %p msg %p\n", con, m);

  	/* header */
-	while (con->in_base_pos < sizeof(con->in_hdr)) {
-		left = sizeof(con->in_hdr) - con->in_base_pos;
-		ret = ceph_tcp_recvmsg(con->sock,
-				       (char *)&con->in_hdr + con->in_base_pos,
-				       left);
-		if (ret <= 0)
-			return ret;
-		con->in_base_pos += ret;
-	}
+	to = 0;
+	ret = read_partial(con, &to, sizeof (con->in_hdr), &con->in_hdr);
+	if (ret <= 0)
+		return ret;

  	crc = crc32c(0, &con->in_hdr, offsetof(struct ceph_msg_header, crc));
  	if (cpu_to_le32(crc) != con->in_hdr.crc) {
@@ -1759,16 +1754,11 @@ static int read_partial_message(struct 
ceph_connection *con)
  	}

  	/* footer */
-	to = sizeof(m->hdr) + sizeof(m->footer);
-	while (con->in_base_pos < to) {
-		left = to - con->in_base_pos;
-		ret = ceph_tcp_recvmsg(con->sock, (char *)&m->footer +
-				       (con->in_base_pos - sizeof(m->hdr)),
-				       left);
-		if (ret <= 0)
-			return ret;
-		con->in_base_pos += ret;
-	}
+	to = sizeof (m->hdr);
+	ret = read_partial(con, &to, sizeof (m->footer), &m->footer);
+	if (ret <= 0)
+		return ret;
+
  	dout("read_partial_message got msg %p %d (%u) + %d (%u) + %d (%u)\n",
  	     m, front_len, m->footer.front_crc, middle_len,
  	     m->footer.middle_crc, data_len, m->footer.data_crc);
-- 
1.7.9.5

