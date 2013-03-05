From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5] libceph: set response data fields earlier
Date: Tue, 05 Mar 2013 07:53:33 -0600
Message-ID: <5135F8DD.3030602@inktank.com>
References: <5135F859.1090606@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:53963 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab3CENxg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 08:53:36 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so6059077iac.35
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 05:53:36 -0800 (PST)
In-Reply-To: <5135F859.1090606@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When an incoming message is destined for the osd client, the
messenger calls the osd client's alloc_msg method.  That function
looks up which request has the tid matching the incoming message,
and returns the request message that was preallocated to receive the
response.  The response message is therefore known before the
request is even started.

Between the start of the request and the receipt of the response,
the request and its data fields will not change, so there's no
reason we need to hold off setting them.  In fact it's preferable
to set them just once because it's more obvious that they're
unchanging.

So set up the fields describing where incoming data is to land in a
response message at the beginning of ceph_osdc_start_request().
Define a helper function that sets these fields, and use it to
set the fields for both outgoing data in the request message and
incoming data in the response.

This resolves:
    http://tracker.ceph.com/issues/4284

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/osd_client.c |   38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index c19188a..1bb2be9 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1739,6 +1739,21 @@ bad:
 	return;
 }

+static void ceph_osdc_msg_data_set(struct ceph_msg *msg,
+				struct ceph_osd_data *osd_data)
+{
+	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
+		ceph_msg_data_set_pages(msg, osd_data->pages,
+			osd_data->num_pages, osd_data->alignment);
+#ifdef CONFIG_BLOCK
+	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
+		ceph_msg_data_set_bio(msg, osd_data->bio);
+#endif
+	} else {
+		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
+	}
+}
+
 /*
  * Register request, send initial attempt.
  */
@@ -1747,22 +1762,12 @@ int ceph_osdc_start_request(struct
ceph_osd_client *osdc,
 			    bool nofail)
 {
 	int rc = 0;
-	struct ceph_osd_data *osd_data;

-	/* Set up outgoing data */
+	/* Set up request outgoing data and response incoming data fields */

-	osd_data = &req->r_data_out;
-	if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
-		ceph_msg_data_set_pages(req->r_request, osd_data->pages,
-			osd_data->num_pages, osd_data->alignment);
-#ifdef CONFIG_BLOCK
-	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
-		ceph_msg_data_set_bio(req->r_request, osd_data->bio);
-#endif
-	} else {
-		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
-	}
+	ceph_osdc_msg_data_set(req->r_request, &req->r_data_out);
 	ceph_msg_data_set_trail(req->r_request, &req->r_trail);
+	ceph_osdc_msg_data_set(req->r_reply, &req->r_data_in);

 	register_request(osdc, req);

@@ -2126,13 +2131,6 @@ static struct ceph_msg *get_reply(struct
ceph_connection *con,
 				m = NULL;
 				goto out;
 			}
-
-			ceph_msg_data_set_pages(m, osd_data->pages,
-				osd_data->num_pages, osd_data->alignment);
-#ifdef CONFIG_BLOCK
-		} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
-			ceph_msg_data_set_bio(m, osd_data->bio);
-#endif
 		}
 	}
 	*skip = 0;
-- 
1.7.9.5

