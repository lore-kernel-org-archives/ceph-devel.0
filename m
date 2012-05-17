From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: avoid unregistering osd request when not registered
Date: Thu, 17 May 2012 08:21:06 -0500
Message-ID: <4FB4FB42.30201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47311 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966270Ab2EQNVF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 09:21:05 -0400
Received: by yenm10 with SMTP id m10so1739986yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 06:21:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

(Sending this on behalf of Sage, because I'm about to commit it
for testing and I wanted the list to have better visibility.)

There is a race between two __unregister_request() callers: the
reply path and the ceph_osdc_wait_request().  If we get a reply
*and* the timeout expires at roughly the same time, both callers
will try to unregister the request, and the second one will do bad
things.

Simply check if the request is still already unregistered; if so,
return immediately and do nothing.

Fixes http://tracker.newdream.net/issues/2420

Signed-off-by: Sage Weil <sage@inktank.com>
Reviewed-by: Alex Elder <elder@inktank.com>
---
  net/ceph/osd_client.c |    6 ++++++
  1 file changed, 6 insertions(+)

Index: b/net/ceph/osd_client.c
===================================================================
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -841,6 +841,12 @@ static void register_request(struct ceph
  static void __unregister_request(struct ceph_osd_client *osdc,
  				 struct ceph_osd_request *req)
  {
+	if (RB_EMPTY_NODE(&req->r_node)) {
+		dout("__unregister_request %p tid %lld not registered\n",
+			req, req->r_tid);
+		return;
+	}
+
  	dout("__unregister_request %p tid %lld\n", req, req->r_tid);
  	rb_erase(&req->r_node, &osdc->requests);
  	osdc->num_requests--;
