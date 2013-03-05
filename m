From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/5] ceph: only set message data pointers if non-empty
Date: Tue, 05 Mar 2013 07:53:14 -0600
Message-ID: <5135F8CA.1010706@inktank.com>
References: <5135F859.1090606@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38798 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608Ab3CENxR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 08:53:17 -0500
Received: by mail-ie0-f177.google.com with SMTP id 16so7838219iea.36
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 05:53:17 -0800 (PST)
In-Reply-To: <5135F859.1090606@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The ceph file system doesn't typically send information in the
data portion of a message.  (It relies on some functionality
exported by the osd client to read and write page data.)

There are two spots it does send data though.  The value assigned to
an extended attribute is held in one or more pages allocated by
ceph_sync_setxattr().  Eventually those pages are assigned to a
request message in create_request_message().

The second spot is when sending a reconnect message, where a
ceph pagelist is used to build up an array of snaprealm_reconnect
structures to send to the mds.

Change it so we only assign the outgoing data information for
these messages if there is outgoing data to send.

This is related to:
    http://tracker.ceph.com/issues/4284

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/mds_client.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 42400ce..ae83aa9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1718,7 +1718,12 @@ static struct ceph_msg
*create_request_message(struct ceph_mds_client *mdsc,
 	msg->front.iov_len = p - msg->front.iov_base;
 	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);

-	ceph_msg_data_set_pages(msg, req->r_pages, req->r_num_pages, 0);
+	if (req->r_num_pages) {
+		/* outbound data set only by ceph_sync_setxattr() */
+		BUG_ON(!req->r_pages);
+		ceph_msg_data_set_pages(msg, req->r_pages,
+				req->r_num_pages, 0);
+	}

 	msg->hdr.data_len = cpu_to_le32(req->r_data_len);
 	msg->hdr.data_off = cpu_to_le16(0);
@@ -2599,10 +2604,13 @@ static void send_mds_reconnect(struct
ceph_mds_client *mdsc,
 			goto fail;
 	}

-	ceph_msg_data_set_pagelist(reply, pagelist);
 	if (recon_state.flock)
 		reply->hdr.version = cpu_to_le16(2);
-	reply->hdr.data_len = cpu_to_le32(pagelist->length);
+	if (pagelist->length) {
+		/* set up outbound data if we have any */
+		reply->hdr.data_len = cpu_to_le32(pagelist->length);
+		ceph_msg_data_set_pagelist(reply, pagelist);
+	}
 	ceph_con_send(&session->s_con, reply);

 	mutex_unlock(&session->s_mutex);
-- 
1.7.9.5

