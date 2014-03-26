From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Wed, 26 Mar 2014 06:13:07 -0500
Message-ID: <5332B643.5040403@ieee.org>
References: <1395736765.2823.29.camel@localhost>			 <1395778894.2076.12.camel@localhost>	 <1395780835.2076.15.camel@localhost>				 <1395781847.2076.21.camel@localhost>				 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>				 <1395782577.2076.23.camel@localhost>				 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>				 <1395783675.2076.26.camel@localhost>				 <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>				 <1395784476.2076.28.camel@localhost>	 <1395785839.2076.30.camel@localhost>			 <5332075F.8080105@ieee.org>	 <1395788695.2076.35.camel@localhost>			 <53321896.1080606@ieee.org>	 <1395797596.2076.43.camel@localhost>		 <1395798658.2076.45.camel@localhost>	 <5332339A.8030000@ieee.org>	 <1395801625.2076.52.camel@localhost>	 <53323E
 A5.6010506@ieee.org> <1395801940.2076.54.camel@localhost>	 <53324F79.1080108@ieee.org> <1395806447.2076.70.camel@localhost> <53325F09.7000306@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54509 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbaCZLMr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Mar 2014 07:12:47 -0400
Received: by mail-ob0-f174.google.com with SMTP id wo20so2238285obc.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Mar 2014 04:12:47 -0700 (PDT)
In-Reply-To: <53325F09.7000306@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 03/26/2014 12:00 AM, Alex Elder wrote:
> I think I've got it.  I'll explain, and we'll have to look at
> the explanation more closely in the morning.
> 
> Bottom line is that I think the assertion is bogus.  Like
> the other assertion that was not done under protection of
> a lock, this one is being done in a way that's not safe.
> 
> First, here's a patch that I think might avoid the problem:
> 
> ----------------------------------
> Index: b/drivers/block/rbd.c
> ===================================================================
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2130,9 +2130,8 @@ static void rbd_img_obj_callback(struct
>  	rbd_assert(which < img_request->obj_request_count);
> 
>  	spin_lock_irq(&img_request->completion_lock);
> -	if (which > img_request->next_completion)
> +	if (which != img_request->next_completion)
>  		goto out;
> -	rbd_assert(which == img_request->next_completion);
> 
>  	for_each_obj_request_from(img_request, obj_request) {
>  		rbd_assert(more);
> ----------------------------------


After some sleep (though not a lot), I remain convinced
the above will fix the problem, for now.  But it's not
quite enough.

The problem arises out of the fact that the thread of
control that marks an object request done is not necessarily
the thread of control that processing the completion of
that object (nor its associated image) request.  There are
no duplicate requests and no duplicate responses.


Object request completions are handled sequentially, based
on the range of address space involved in the requests.
This is the model required by the Linux blk_end_request()
interface.  Let's assume we have a single image request
that has two contiguous object requests, with the "lower"
object request involving bytes ending at the point the
"higher" one begins.

These object requests can be completed by their OSDs in
any order, and we will handle their completion in the
order their acknowledgement is received.  If we process
the higher request's acknowledgement first, that will
be the first to enter rbd_img_obj_callback().  Since
we will not have completed the lower one yet, nothing
more is done.

When the lower object request completes, it will enter
rbd_img_obj_callback() and find that it *is* the
next one we want completed.  So we'll enter a loop
that calls rbd_img_obj_end_request() on this request,
followed by its successor, doing completion processing
on any request that has by now been marked done.  In
the case I've described, the higher request will be
marked done, so it is here that its completion processing
is performed.

Once the last object request has been completed, we
call rbd_img_request_complete(), which will ultimately
lead to dropping a reference on the image request,
which leads to rbd_img_request_destroy().


What's happening in Olivier's case is that the
requests are actually completing *in order*, but
nearly simultaneously.  The lower and higher request
acknowledgements from their OSDs arrive, and their
consequent calls to rbd_img_obj_end_request() occur
at the same time.  The lower request wins the race
to get the spinlock before checking if it is the
next one to complete.  So the higher request waits;
but note that both of them have been marked "done"
at this point.

The lower request enters the completion loop, and
calls rbd_imb_obj_end_request() on both requests,
and updates the next_completion value before releasing
the spinlock.  Now the higher request acquires the
lock and gets its chance to check its position against
next_completion.  Since completion of this higher
request was now been done already while processing
the lower request, next_completion has now gone
past the higher request.  Therefore its "which"
value will not be higher than "next_completion"
but neither will it be equal to it, so the old
assertion would fail.

So my proposed fix just recognizes that, and allows
only the object request matching next_completion
to enter the completion loop, without assuming any
other request must have a greater "which" value.

Hopefully that's a more complete and clear
explanation of the problem.


Now, onto why that's not sufficient.

Basically, at the instant an image object request is
marked done, it is eligible to be completed by a
call to rbd_img_obj_end_request() by a concurrent
thread processing a lower-numbered object request in
the same image request.  And at just after that
instant (essentially, because of the protection
of the completion lock), the image request itself will
be completed by a call to rbd_img_request_complete().
It's likely this will drop the last reference to the
image request, so rbd_img_request_destroy() will be
called.  And that calls rbd_img_obj_request_del() on
each of its object requests.

In other words, conceivably the higher object
request that was stuck waiting for the spinlock
in rbd_img_obj_end_request() may now be getting
deleted from its image's request list.  (It
could be worse, it may have *just* finished
getting marked done and may not have even entered
rbd_img_obj_end_request() yet.)  And in the
process of getting deleted from its image request's
object request list, an object request gets
partially reinitialized, freed, and may get reused.


So...  in order to have a complete fix we need to
do some careful work with reference counting of
image requests and object requests, and avoid
having any of their content get disturbed until
the last reference is dropped.

Right now it's not quite right.  In particular, each
object request needs to have a *reference* to its
image request (not just a pointer to it), and it
should not be dropped until the the object request
gets destroyed.  And because one thread can destroy
an object request being actively used by another,
each object request should have reference that gets
held until it is no longer needed (probably at the
end of rbd_osd_req_callback()).


I think for the time being, the simple fix I
described last night will do, and it's somewhat
unlikely--though not impossible--for the problems
due to concurrent destruction will arise.  But
we do need a fix.  I'm prepared to create it, but
for now I'd like to have another opinion on my
treatise above.

					-Alex
