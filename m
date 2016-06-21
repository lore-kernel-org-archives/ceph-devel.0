From: Jeff Layton <jlayton@poochiereds.net>
Subject: [wireshark PATCH] ceph: distingush between client and server by checking for a second entity_addr_t
Date: Tue, 21 Jun 2016 08:09:51 -0400
Message-ID: <1466510991-7830-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33218 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbcFUMZj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2016 08:25:39 -0400
Received: by mail-yw0-f194.google.com with SMTP id i12so1539021ywa.0
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jun 2016 05:25:38 -0700 (PDT)
Received: from tlielax.poochiereds.net ([2606:a000:1125:4074:3a60:77ff:fe93:a95d])
        by smtp.googlemail.com with ESMTPSA id q7sm27665623ywg.16.2016.06.21.05.09.56
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2016 05:09:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This has been uploaded for review to the wireshark project, but I wanted
to send it here to get more ceph developer eyes on it. The wireshark
review request is here:

    https://code.wireshark.org/review/#/c/16043/

The current ceph dissector assumes that the server will always send its
initial connection negotiation first, but that's not necessarily the
case, especially with the kernel client which sends its banner as soon
as the socket is created.

So, we need a better mechanism to determine which end is client and
which is the server. The server sends its own address and then the
address of the client, but the client only sends its own address. We
can determine whether the initial negotiation message is from the client
or server by looking at the data after the first entity addr and seeing
whether it also looks like an entity addr.

This patch takes that approach. It just grabs the address family from
the second address and sees whether it's IPv4 or IPv6. If it's not one
of those, then it assumes that it's not an entity_addr_t at all and is
therefore a request from the client.

We could go farther and try to verify the port and address as well, but
that's probably overkill. The address family is at the same offset as
the host_type field in the client's Connect request, but it's big endian
and the host_type is little endian. As long as we don't end up with
host_types that are 0x200 or 0xA00, this scheme should be OK.

Change-Id: I161d02da86d978272eff95497c6df66766b02ebc
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 epan/dissectors/packet-ceph.c | 76 ++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/epan/dissectors/packet-ceph.c b/epan/dissectors/packet-ceph.c
index 41a2f31f8ac7..044b6fb533ed 100644
--- a/epan/dissectors/packet-ceph.c
+++ b/epan/dissectors/packet-ceph.c
@@ -1545,30 +1545,29 @@ c_pkt_data_init(c_pkt_data *d, packet_info *pinfo, guint off)
 	if (!d->convd) /* New conversation. */
 	{
 		d->convd = c_conv_data_new();
-
-		/* Note: Server sends banner first. */
-
-		copy_address_wmem(wmem_file_scope(), &d->convd->server.addr, &pinfo->src);
-		d->convd->server.port = pinfo->srcport;
-		copy_address_wmem(wmem_file_scope(), &d->convd->client.addr, &pinfo->dst);
-		d->convd->client.port = pinfo->destport;
 		conversation_add_proto_data(d->conv, proto_ceph, d->convd);
 	}
 
-	/*** Set up src and dst pointers correctly. ***/
-	if (addresses_equal(&d->convd->client.addr, &pinfo->src) &&
-	    d->convd->client.port == pinfo->srcport)
-	{
-		d->src = &d->convd->client;
-		d->dst = &d->convd->server;
-	}
-	else
-	{
-		d->src = &d->convd->server;
-		d->dst = &d->convd->client;
+	/*
+	 * Set up src and dst pointers correctly, if the client port is
+	 * already set. Otherwise, we need to wait until we have enough
+	 * data to determine which is which.
+	 */
+	if (d->convd->client.port != 0xFFFF) {
+		if (addresses_equal(&d->convd->client.addr, &pinfo->src) &&
+		    d->convd->client.port == pinfo->srcport)
+		{
+			d->src = &d->convd->client;
+			d->dst = &d->convd->server;
+		}
+		else
+		{
+			d->src = &d->convd->server;
+			d->dst = &d->convd->client;
+		}
+		DISSECTOR_ASSERT(d->src);
+		DISSECTOR_ASSERT(d->dst);
 	}
-	DISSECTOR_ASSERT(d->src);
-	DISSECTOR_ASSERT(d->dst);
 
 	c_header_init(&d->header);
 	d->item_root = NULL;
@@ -6918,8 +6917,41 @@ guint c_dissect_pdu(proto_tree *root,
 }
 
 static
-guint c_pdu_end(tvbuff_t *tvb, guint off, c_pkt_data *data)
+guint c_pdu_end(tvbuff_t *tvb, packet_info *pinfo, guint off, c_pkt_data *data)
 {
+	c_inet	af;
+
+	/*
+	 * If we don't already know, then figure out which end of the
+	 * connection is the client. It's icky, but the only way to know is to
+	 * see whether the info after the first entity_addr_t looks like
+	 * another entity_addr_t.
+	 */
+	if (data->convd->client.port == 0xFFFF) {
+		if (!tvb_bytes_exist(tvb, off, C_BANNER_SIZE + C_SIZE_ENTITY_ADDR + 8 + 2))
+			return C_NEEDMORE;
+
+		/* We have enough to determine client vs. server */
+		af = (c_inet)tvb_get_ntohs(tvb, off + C_BANNER_SIZE + C_SIZE_ENTITY_ADDR + 8);
+		if (af != C_IPv4 && af != C_IPv6) {
+			/* Client */
+			copy_address_wmem(wmem_file_scope(), &data->convd->client.addr, &pinfo->src);
+			data->convd->client.port = pinfo->srcport;
+			copy_address_wmem(wmem_file_scope(), &data->convd->server.addr, &pinfo->dst);
+			data->convd->server.port = pinfo->destport;
+			data->src = &data->convd->client;
+			data->dst = &data->convd->server;
+		} else {
+			/* Server */
+			copy_address_wmem(wmem_file_scope(), &data->convd->server.addr, &pinfo->src);
+			data->convd->server.port = pinfo->srcport;
+			copy_address_wmem(wmem_file_scope(), &data->convd->client.addr, &pinfo->dst);
+			data->convd->client.port = pinfo->destport;
+			data->src = &data->convd->server;
+			data->dst = &data->convd->client;
+		}
+	}
+
 	switch (data->src->state)
 	{
 	case C_STATE_NEW:
@@ -7010,7 +7042,7 @@ int dissect_ceph(tvbuff_t *tvb, packet_info *pinfo,
 		if (off)
 			c_pkt_data_save(&data, pinfo, off);
 
-		offt = c_pdu_end(tvb, off, &data);
+		offt = c_pdu_end(tvb, pinfo, off, &data);
 		if (offt == C_INVALID)
 		{
 			return 0;
-- 
2.5.5

