From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] ceph: messenger: update "to" in read_partial() caller
Date: Thu, 10 May 2012 20:18:47 -0500
Message-ID: <4FAC68F7.1030508@inktank.com>
References: <4FAC4799.3010903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35045 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631Ab2EKBSt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 21:18:49 -0400
Received: by mail-ob0-f174.google.com with SMTP id tb18so2527882obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 18:18:49 -0700 (PDT)
In-Reply-To: <4FAC4799.3010903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

read_partial() always increases whatever "to" value is supplied by
adding the requested size to it.  That's the only thing it does with
that pointed-to value.

Do that pointer advance in the caller (and then only when the
updated value will be subsequently used), and change the "to"
parameter to be an in-only and non-pointer value.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  net/ceph/messenger.c |   31 ++++++++++++++++---------------
  1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 673133e..37fd2ae 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -992,11 +992,12 @@ static int prepare_read_message(struct 
ceph_connection *con)


  static int read_partial(struct ceph_connection *con,
-			int *to, int size, void *object)
+			int to, int size, void *object)
  {
-	*to += size;
-	while (con->in_base_pos < *to) {
-		int left = *to - con->in_base_pos;
+	int end = to + size;
+
+	while (con->in_base_pos < end) {
+		int left = end - con->in_base_pos;
  		int have = size - left;
  		int ret = ceph_tcp_recvmsg(con->sock, object + have, left);
  		if (ret <= 0)
@@ -1017,14 +1018,16 @@ static int read_partial_banner(struct 
ceph_connection *con)
  	dout("read_partial_banner %p at %d\n", con, con->in_base_pos);

  	/* peer's banner */
-	ret = read_partial(con, &to, strlen(CEPH_BANNER), con->in_banner);
+	ret = read_partial(con, to, strlen(CEPH_BANNER), con->in_banner);
  	if (ret <= 0)
  		goto out;
-	ret = read_partial(con, &to, sizeof(con->actual_peer_addr),
+	to += strlen(CEPH_BANNER);
+	ret = read_partial(con, to, sizeof(con->actual_peer_addr),
  			   &con->actual_peer_addr);
  	if (ret <= 0)
  		goto out;
-	ret = read_partial(con, &to, sizeof(con->peer_addr_for_me),
+	to += sizeof(con->actual_peer_addr);
+	ret = read_partial(con, to, sizeof(con->peer_addr_for_me),
  			   &con->peer_addr_for_me);
  	if (ret <= 0)
  		goto out;
@@ -1038,10 +1041,11 @@ static int read_partial_connect(struct 
ceph_connection *con)

  	dout("read_partial_connect %p at %d\n", con, con->in_base_pos);

-	ret = read_partial(con, &to, sizeof(con->in_reply), &con->in_reply);
+	ret = read_partial(con, to, sizeof(con->in_reply), &con->in_reply);
  	if (ret <= 0)
  		goto out;
-	ret = read_partial(con, &to, le32_to_cpu(con->in_reply.authorizer_len),
+	to += sizeof(con->in_reply);
+	ret = read_partial(con, to, le32_to_cpu(con->in_reply.authorizer_len),
  			   con->auth_reply_buf);
  	if (ret <= 0)
  		goto out;
@@ -1491,9 +1495,7 @@ static int process_connect(struct ceph_connection 
*con)
   */
  static int read_partial_ack(struct ceph_connection *con)
  {
-	int to = 0;
-
-	return read_partial(con, &to, sizeof(con->in_temp_ack),
+	return read_partial(con, 0, sizeof(con->in_temp_ack),
  			    &con->in_temp_ack);
  }

@@ -1638,8 +1640,7 @@ static int read_partial_message(struct 
ceph_connection *con)
  	dout("read_partial_message con %p msg %p\n", con, m);

  	/* header */
-	to = 0;
-	ret = read_partial(con, &to, sizeof (con->in_hdr), &con->in_hdr);
+	ret = read_partial(con, 0, sizeof (con->in_hdr), &con->in_hdr);
  	if (ret <= 0)
  		return ret;

@@ -1755,7 +1756,7 @@ static int read_partial_message(struct 
ceph_connection *con)

  	/* footer */
  	to = sizeof (m->hdr);
-	ret = read_partial(con, &to, sizeof (m->footer), &m->footer);
+	ret = read_partial(con, to, sizeof (m->footer), &m->footer);
  	if (ret <= 0)
  		return ret;

-- 
1.7.9.5

