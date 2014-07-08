From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 10/14] rbd: rbd_obj_request_wait() should cancel the
 request if interrupted
Date: Tue, 8 Jul 2014 15:18:02 +0400
Message-ID: <CALFYKtDv7rnPjSVvzMJVPFQj7=p5PZHf6xEogXPGGS7HD3wnLQ@mail.gmail.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
	<1403716607-13535-11-git-send-email-ilya.dryomov@inktank.com>
	<53BAD0FC.5020007@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:46094 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbaGHLSE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jul 2014 07:18:04 -0400
Received: by mail-qa0-f46.google.com with SMTP id v10so164861qac.19
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jul 2014 04:18:03 -0700 (PDT)
In-Reply-To: <53BAD0FC.5020007@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@linaro.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 7, 2014 at 8:55 PM, Alex Elder <elder@linaro.org> wrote:
> On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
>> rbd_obj_request_wait() should cancel the underlying OSD request if
>> interrupted.  Otherwise libceph will hold onto it indefinitely, causing
>> assert failures or leaking the original object request.
>
> At first I didn't understand this.  Let me see if I've got
> it now, though.
>
> Each OSD request has a completion associated with it.  An
> OSD request is started via ceph_osdc_start_request(), which
> registers the request and takes a reference to it.  One can
> call ceph_osdc_wait_request() after the request has been
> successfully started.  Whether the wait succeeds or not,
> by the time ceph_osdc_wait_request() returns the request
> should have been cleaned up, back to the state it was
> in before the start_request call.  That means the request
> needs to be unregistered and its reference dropped, etc.
>
> Similarly, each RBD object request has a completion associated
> with it.  It is distinct from the OSD request associated
> with the RBD object request because there may be more to do
> for RBD request to complete than just complete one object
> request.  An RBD object request is started by a call to
> rbd_obj_request_submit(), and once that's successfully
> returned, one can wait for it to complete using a call to
> rbd_obj_request_wait().  And as above, that call should
> return state to (roughly) where it was before the submit
> call, whether the wait request succeeded or not.
>
> Now, RBD doesn't actually wait for its object requests
> to complete--all its OSD requests complete asynchronously.
> Instead, it relies on the OSD client to call the callback
> function (always rbd_osd_req_callback()) when it has
> completed.  That function will lead to the RBD request's
> completion being signaled when appropriate.
>
> So...  What happens when an interrupt occurs after
> rbd_obj_request_submit() has returned successfully?  That
> function is a simple wrapper for ceph_osdc_start_request(),
> so a successful return means the request was mapped and
> put on a target's unsent list (or the OSD client's no
> target list).  Nobody waits for the OSD request, so an
> interrupt won't get the benefit of the cleanup done in
> ceph_osdc_wait_request().  Therefore the RBD layer needs
> to be responsible for doing that.
>
> In other words, when rbd_obj_request_wait() gets an
> interrupt while waiting for the completion, it needs
> to clean up (end) the interrupted request, and
> rbd_obj_request_end() sounds right.  And what that
> cleanup function should do is basically the same
> as what ceph_osdc_wait_request() should do in that
> situation, which is call ceph_osdc_cancel_request().

That's exactly right.

>
> The only question that leaves me with is, does
> ceph_osdc_cancel_request() need to include the
> call to complete_request() that's present in
> ceph_osdc_wait_request()?

I don't think so - I mentioned it in the ceph_osdc_cancel_request()
function comment.  ceph_osdc_cancel_request() is supposed to be used by
higher layers - rbd, cephfs - and exactly because their completion
logic is decoupled from libceph completions (as you have brilliantly
explained above) it's the higher layers who should be taking care of
it.  IOW higher layers are in charge and are supposed to know what and
when they are cancelling.

Thanks,

                Ilya
