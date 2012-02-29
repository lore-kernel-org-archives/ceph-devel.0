From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/3] libceph: do crc calculations outside loop
Date: Tue, 28 Feb 2012 20:50:55 -0800
Message-ID: <4F4DAEAF.7020102@dreamhost.com>
References: <4F4DAE4E.4000903@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48792 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965408Ab2B2Eu4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:50:56 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id EF0BE24329
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:50:55 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id D94592431D
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:50:55 -0800 (PST)
In-Reply-To: <4F4DAE4E.4000903@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move blocks of code out of loops in read_partial_message_section()
and read_partial_message().  They were only was getting called at
the end of the last iteration of the loop anyway.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |   26 ++++++++++++--------------
  1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1df7e6f..693be64 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1541,10 +1541,9 @@ static int read_partial_message_section(struct 
ceph_connection *con,
  		if (ret <= 0)
  			return ret;
  		section->iov_len += ret;
-		if (section->iov_len == sec_len)
-			*crc = crc32c(0, section->iov_base,
-				      section->iov_len);
  	}
+	if (section->iov_len == sec_len)
+		*crc = crc32c(0, section->iov_base, section->iov_len);

  	return 1;
  }
@@ -1635,6 +1634,7 @@ static int read_partial_message(struct 
ceph_connection *con)
  	bool do_datacrc = con->msgr->nocrc;
  	int skip;
  	u64 seq;
+	u32 crc;

  	dout("read_partial_message con %p msg %p\n", con, m);

@@ -1647,18 +1647,16 @@ static int read_partial_message(struct 
ceph_connection *con)
  		if (ret <= 0)
  			return ret;
  		con->in_base_pos += ret;
-		if (con->in_base_pos == sizeof(con->in_hdr)) {
-			u32 crc = crc32c(0, &con->in_hdr,
-					offsetof(struct ceph_msg_header, crc));
-
-			if (cpu_to_le32(crc) != con->in_hdr.crc) {
-				pr_err("read_partial_message bad hdr "
-				       " crc %u != expected %u\n",
-				       crc, con->in_hdr.crc);
-				return -EBADMSG;
-			}
-		}
  	}
+
+	crc = crc32c(0, &con->in_hdr, offsetof(struct ceph_msg_header, crc));
+	if (cpu_to_le32(crc) != con->in_hdr.crc) {
+		pr_err("read_partial_message bad hdr "
+		       " crc %u != expected %u\n",
+		       crc, con->in_hdr.crc);
+		return -EBADMSG;
+	}
+
  	front_len = le32_to_cpu(con->in_hdr.front_len);
  	if (front_len > CEPH_MSG_MAX_FRONT_LEN)
  		return -EIO;
-- 
1.7.5.4

