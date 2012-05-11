From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] ceph: messenger: change read_partial() to take "end"
 arg
Date: Thu, 10 May 2012 20:18:55 -0500
Message-ID: <4FAC68FF.9020406@inktank.com>
References: <4FAC4799.3010903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35045 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136Ab2EKBS5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 21:18:57 -0400
Received: by mail-ob0-f174.google.com with SMTP id tb18so2527882obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 18:18:57 -0700 (PDT)
In-Reply-To: <4FAC4799.3010903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Make the second argument to read_partial() be the ending input byte
position rather than the beginning offset it now represents.  This
amounts to moving the addition "to + size" into the caller.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |   59 
++++++++++++++++++++++++++++++++------------------
  1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 37fd2ae..364c902 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -992,10 +992,8 @@ static int prepare_read_message(struct 
ceph_connection *con)


  static int read_partial(struct ceph_connection *con,
-			int to, int size, void *object)
+			int end, int size, void *object)
  {
-	int end = to + size;
-
  	while (con->in_base_pos < end) {
  		int left = end - con->in_base_pos;
  		int have = size - left;
@@ -1013,40 +1011,52 @@ static int read_partial(struct ceph_connection *con,
   */
  static int read_partial_banner(struct ceph_connection *con)
  {
-	int ret, to = 0;
+	int size;
+	int end;
+	int ret;

  	dout("read_partial_banner %p at %d\n", con, con->in_base_pos);

  	/* peer's banner */
-	ret = read_partial(con, to, strlen(CEPH_BANNER), con->in_banner);
+	size = strlen(CEPH_BANNER);
+	end = size;
+	ret = read_partial(con, end, size, con->in_banner);
  	if (ret <= 0)
  		goto out;
-	to += strlen(CEPH_BANNER);
-	ret = read_partial(con, to, sizeof(con->actual_peer_addr),
-			   &con->actual_peer_addr);
+
+	size = sizeof (con->actual_peer_addr);
+	end += size;
+	ret = read_partial(con, end, size, &con->actual_peer_addr);
  	if (ret <= 0)
  		goto out;
-	to += sizeof(con->actual_peer_addr);
-	ret = read_partial(con, to, sizeof(con->peer_addr_for_me),
-			   &con->peer_addr_for_me);
+
+	size = sizeof (con->peer_addr_for_me);
+	end += size;
+	ret = read_partial(con, end, size, &con->peer_addr_for_me);
  	if (ret <= 0)
  		goto out;
+
  out:
  	return ret;
  }

  static int read_partial_connect(struct ceph_connection *con)
  {
-	int ret, to = 0;
+	int size;
+	int end;
+	int ret;

  	dout("read_partial_connect %p at %d\n", con, con->in_base_pos);

-	ret = read_partial(con, to, sizeof(con->in_reply), &con->in_reply);
+	size = sizeof (con->in_reply);
+	end = size;
+	ret = read_partial(con, end, size, &con->in_reply);
  	if (ret <= 0)
  		goto out;
-	to += sizeof(con->in_reply);
-	ret = read_partial(con, to, le32_to_cpu(con->in_reply.authorizer_len),
-			   con->auth_reply_buf);
+
+	size = le32_to_cpu(con->in_reply.authorizer_len);
+	end += size;
+	ret = read_partial(con, end, size, con->auth_reply_buf);
  	if (ret <= 0)
  		goto out;

@@ -1495,8 +1505,10 @@ static int process_connect(struct ceph_connection 
*con)
   */
  static int read_partial_ack(struct ceph_connection *con)
  {
-	return read_partial(con, 0, sizeof(con->in_temp_ack),
-			    &con->in_temp_ack);
+	int size = sizeof (con->in_temp_ack);
+	int end = size;
+
+	return read_partial(con, end, size, &con->in_temp_ack);
  }


@@ -1629,6 +1641,8 @@ static int read_partial_message_bio(struct 
ceph_connection *con,
  static int read_partial_message(struct ceph_connection *con)
  {
  	struct ceph_msg *m = con->in_msg;
+	int size;
+	int end;
  	int ret;
  	int to;
  	unsigned front_len, middle_len, data_len;
@@ -1640,7 +1654,9 @@ static int read_partial_message(struct 
ceph_connection *con)
  	dout("read_partial_message con %p msg %p\n", con, m);

  	/* header */
-	ret = read_partial(con, 0, sizeof (con->in_hdr), &con->in_hdr);
+	size = sizeof (con->in_hdr);
+	end = size;
+	ret = read_partial(con, end, size, &con->in_hdr);
  	if (ret <= 0)
  		return ret;

@@ -1755,8 +1771,9 @@ static int read_partial_message(struct 
ceph_connection *con)
  	}

  	/* footer */
-	to = sizeof (m->hdr);
-	ret = read_partial(con, to, sizeof (m->footer), &m->footer);
+	size = sizeof (m->footer);
+	end += size;
+	ret = read_partial(con, end, size, &m->footer);
  	if (ret <= 0)
  		return ret;

-- 
1.7.9.5

