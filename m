From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: be explicit in masking bottom 16 bits
Date: Fri, 29 Mar 2013 16:05:59 -0500
Message-ID: <51560237.2040000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:48279 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077Ab3C2VGD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 17:06:03 -0400
Received: by mail-ve0-f171.google.com with SMTP id b10so886824vea.16
        for <ceph-devel@vger.kernel.org>; Fri, 29 Mar 2013 14:06:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In ceph_osdc_build_request() there is a call to cpu_to_le16() which
provides a 64-bit value as its argument.  Because of the implied
byte swapping going on it looked pretty suspect to me.

At the moment it turns out the behavior is well defined, but masking
off those bottom bits explicitly eliminates this distraction, and is
in fact more directly related to the purpose of the message header's
data_off field.

This resolves:
    http://tracker.ceph.com/issues/4125

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 3b6657f..015bf9f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -419,8 +419,18 @@ void ceph_osdc_build_request(struct
ceph_osd_request *req,
 	p += 4;

 	/* data */
-	if (flags & CEPH_OSD_FLAG_WRITE)
-		req->r_request->hdr.data_off = cpu_to_le16(off);
+	if (flags & CEPH_OSD_FLAG_WRITE) {
+		u16 data_off;
+
+		/*
+		 * The header "data_off" is a hint to the receiver
+		 * allowing it to align received data into its
+		 * buffers such that there's no need to re-copy
+		 * it before writing it to disk (direct I/O).
+		 */
+		data_off = (u16) (off & 0xffff);
+		req->r_request->hdr.data_off = cpu_to_le16(data_off);
+	}
 	req->r_request->hdr.data_len = cpu_to_le32(data_len);

 	BUG_ON(p > msg->front.iov_base + msg->front.iov_len);
-- 
1.7.9.5

