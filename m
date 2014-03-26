From: Alex Elder <elder@linaro.org>
Subject: [PATCH] rbd: drop an unsafe assertion
Date: Wed, 26 Mar 2014 15:52:02 -0500
Message-ID: <1395867122-9340-1-git-send-email-elder@linaro.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:42821 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274AbaCZUvp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Mar 2014 16:51:45 -0400
Received: by mail-ie0-f169.google.com with SMTP id to1so2309744ieb.28
        for <ceph-devel@vger.kernel.org>; Wed, 26 Mar 2014 13:51:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com, ob@daevel.fr

Olivier Bonvalet reported having repeated crashes due to a failed
assertion he was hitting in rbd_img_obj_callback():

    Assertion failure in rbd_img_obj_callback() at line 2165:
	rbd_assert(which == img_request->next_completion);

With a lot of help from Olivier with reproducing the problem
we were able to determine the object and image requests had
already been completed (and often freed) at the point the
assertion failed.

There was a great deal of discussion on the ceph-devel mailing list
about this.  The problem only arose when there were two (or more)
object requests in an image request, and the problem was always
seen when the second request was being completed.

The problem is due to a race in the window between setting the
"done" flag on an object request and checking the image request's
next completion value.  When the first object request completes, it
checks to see if its successor request is marked "done", and if
so, that request is also completed.  In the process, the image
request's next_completion value is updated to reflect that both
the first and second requests are completed.  By the time the
second request is able to check the next_completion value, it
has been set to a value *greater* than its own "which" value,
which caused an assertion to fail.

Fix this problem by skipping over any completion processing
unless the completing object request is the next one expected.
Test only for inequality (not >=), and eliminate the bad
assertion.

Tested-by: Olivier Bonvalet <ob@daevel.fr>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/block/rbd.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f044fab..4c95b50 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2125,10 +2125,9 @@ static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
 	rbd_assert(which < img_request->obj_request_count);
 
 	spin_lock_irq(&img_request->completion_lock);
-	if (which > img_request->next_completion)
+	if (which != img_request->next_completion)
 		goto out;
 
-	rbd_assert(which == img_request->next_completion);
 	for_each_obj_request_from(img_request, obj_request) {
 		rbd_assert(more);
 		rbd_assert(which < img_request->obj_request_count);
-- 
1.7.9.5

