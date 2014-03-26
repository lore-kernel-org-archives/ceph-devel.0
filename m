From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Wed, 26 Mar 2014 00:00:57 -0500
Message-ID: <53325F09.7000306@ieee.org>
References: <1395736765.2823.29.camel@localhost>			 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>				 <1395778894.2076.12.camel@localhost>	 <1395780835.2076.15.camel@localhost>				 <1395781847.2076.21.camel@localhost>				 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>				 <1395782577.2076.23.camel@localhost>				 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>				 <1395783675.2076.26.camel@localhost>				 <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>				 <1395784476.2076.28.camel@localhost>	 <1395785839.2076.30.camel@localhost>			 <5332075F.8080105@ieee.org>	 <1395788695.2076.35.camel@localhost>			 <53321896.1080606@ieee.org>	 <1395797596.2076.43.camel@localhost>		 <1395798658.2076.45.camel@localhost>	 <
 5332339A.8030000@ieee.org>	 <1395801625.2076.52.camel@localhost>	 <53323EA5.6010506@ieee.org> <1395801940.2076.54.camel@localhost>	 <53324F79.1080108@ieee.org> <1395806447.2076.70.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:47401 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbaCZFAi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Mar 2014 01:00:38 -0400
Received: by mail-qa0-f41.google.com with SMTP id j5so1730765qaq.28
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 22:00:37 -0700 (PDT)
In-Reply-To: <1395806447.2076.70.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

I think I've got it.  I'll explain, and we'll have to look at
the explanation more closely in the morning.

Bottom line is that I think the assertion is bogus.  Like
the other assertion that was not done under protection of
a lock, this one is being done in a way that's not safe.

First, here's a patch that I think might avoid the problem:

----------------------------------
Index: b/drivers/block/rbd.c
===================================================================
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2130,9 +2130,8 @@ static void rbd_img_obj_callback(struct
 	rbd_assert(which < img_request->obj_request_count);

 	spin_lock_irq(&img_request->completion_lock);
-	if (which > img_request->next_completion)
+	if (which != img_request->next_completion)
 		goto out;
-	rbd_assert(which == img_request->next_completion);

 	for_each_obj_request_from(img_request, obj_request) {
 		rbd_assert(more);
----------------------------------




Here's what I think is happening.  I'll annotate the function,
below.

First, we enter this function when an object request has
been marked "done."  In the case we're looking at, we
have an image request with two (or more) object requests.

static void rbd_img_obj_callback(struct rbd_obj_request *obj_request)
{
	struct rbd_img_request *img_request;
	u32 which = obj_request->which;
	bool more = true;

	rbd_assert(obj_request_img_data_test(obj_request));
	img_request = obj_request->img_request;

	dout("%s: img %p obj %p\n", __func__, img_request, obj_request);
	rbd_assert(img_request != NULL);
	rbd_assert(img_request->obj_request_count > 0);
	rbd_assert(which != BAD_WHICH);
	rbd_assert(which < img_request->obj_request_count);

Up to here, all is fine.  Well, *maybe*...  Anyway, I'll
work through that in the morning.  In any case, we are
examining fairly static fields in the object request.

	spin_lock_irq(&img_request->completion_lock);
	if (which > img_request->next_completion)
		goto out;

At this point we decide whether the object request now
completing is the next one.  If it's not, we're done;
whenever an earlier request (the first one) completes
it will ensure this one will get completed as well,
below.

But that's a problem.  In the loop below, the only condition
we're testing in order to account the completion of the
current *and subsequent* requests is whether each request
is marked "done."

What that means is that while the second request is waiting
to get the spinlock, the first one might be concurrently
going through the loop below.  It finds the second one "done"
and records that fact.  When it finishes the loop, it
updates the next_completion value and releases the lock.

The second request then enters the protected area, and
finds that its "which" value is *not* greater than the
next completion value.  It's in fact *less* than the
next_completion value, because the completion of this
second request has already been processed.

The problem got worse when we moved the spinlock (i.e.,
added protection around checking the next_completion
field) because now the second thread is actually waiting
before checking, so it's pretty much guaranteed it will
trigger the failure.

OK, back to bed.

					-Alex

	rbd_assert(which == img_request->next_completion);

	for_each_obj_request_from(img_request, obj_request) {
		rbd_assert(more);
		rbd_assert(which < img_request->obj_request_count);

		if (!obj_request_done_test(obj_request))
			break;
		more = rbd_img_obj_end_request(obj_request);
		which++;
	}

	rbd_assert(more ^ (which == img_request->obj_request_count));
	img_request->next_completion = which;
out:
	spin_unlock_irq(&img_request->completion_lock);

	if (!more)
		rbd_img_request_complete(img_request);
}
