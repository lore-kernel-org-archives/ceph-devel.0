From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] ceph: osd_client: fix endianness bug in osd_req_encode_op()
Date: Wed, 18 Apr 2012 10:18:15 -0500
Message-ID: <4F8EDB37.5000900@dreamhost.com>
References: <4F8ED911.90309@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33995 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab2DRPSR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 11:18:17 -0400
In-Reply-To: <4F8ED911.90309@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Sage Weil <sage@newdream.net>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

 From Al Viro <viro@zeniv.linux.org.uk>

Al Viro noticed that we were using a non-cpu-encoded value in
a switch statement in osd_req_encode_op().  The result would
clearly not work correctly on a big-endian machine.

Signed-off-by: Alex Elder <elder@dreamhost.com>

---
  net/ceph/osd_client.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/net/ceph/osd_client.c
===================================================================
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -278,7 +278,7 @@ static void osd_req_encode_op(struct cep
  {
  	dst->op = cpu_to_le16(src->op);

-	switch (dst->op) {
+	switch (src->op) {
  	case CEPH_OSD_OP_READ:
  	case CEPH_OSD_OP_WRITE:
  		dst->extent.offset =
