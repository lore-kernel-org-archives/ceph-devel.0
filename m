From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 09/14] libceph: introduce ceph_osdc_cancel_request()
Date: Tue, 8 Jul 2014 15:15:54 +0400
Message-ID: <CALFYKtDS+H99cCs9rgBj7qmwQ5KGZv9zqPac5iBoOHexAAra8g@mail.gmail.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
	<1403716607-13535-10-git-send-email-ilya.dryomov@inktank.com>
	<53B16887.2090309@ieee.org>
	<CALFYKtB4oCa71L+pOO+jkROKRr-wLWCds_MY6zbk+P4b987y8A@mail.gmail.com>
	<53BAA501.5030901@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:53509 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbaGHLPz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jul 2014 07:15:55 -0400
Received: by mail-qg0-f49.google.com with SMTP id f51so4753288qge.22
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jul 2014 04:15:54 -0700 (PDT)
In-Reply-To: <53BAA501.5030901@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 7, 2014 at 5:47 PM, Alex Elder <elder@ieee.org> wrote:
> On 06/30/2014 09:34 AM, Ilya Dryomov wrote:
>> On Mon, Jun 30, 2014 at 5:39 PM, Alex Elder <elder@ieee.org> wrote:
>>> On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
>>>> Introduce ceph_osdc_cancel_request() intended for canceling requests
>>>> from the higher layers (rbd and cephfs).  Because higher layers are in
>>>> charge and are supposed to know what and when they are canceling, the
>>>> request is not completed, only unref'ed and removed from the libceph
>>>> data structures.
>>>
>>> This seems reasonable.
>>>
>>> But you make two changes here that I'd like to see a little
>>> more explanation on.  They seem significant enough to warrant
>>> a little more attention in the commit description.
>>>
>>> - __cancel_request() is no longer called when
>>>   ceph_osdc_wait_request() fails due to an
>>>   an interrupt.  This is my main concern, and I
>>>   plan to work through it but I'm in a small hurry
>>>   right now.
>>
>> Perhaps it should have been a separate commit.  __unregister_request()
>> revokes r_request, so I opted for not trying to do it twice.  As for
>
> OK, that makes sense--revoking the request is basically all
> __cancel_request() does anyway.  You ought to have mentioned
> that in the description anyway, even if it wasn't a separate
> commit.

I have added the explanation to the commit message.

>
>> the r_sent condition and assignment, it doesn't seem to make much of
>> a difference, given that the request is about to be unregistered
>> anyway.
>
> If the request is getting canceled (from a caller outside libceph)
> it can't take into account whether it was sent or not.  As you said,
> it is getting revoked unconditionally by __unregister_request().
> To be honest though, *that* revoke call should have been zeroing
> the r_sent value also.  It apparently won't matter, but I think it's
> wrong.  The revoke drops a reference, it doesn't necessarily free
> the structure (though I expect it may always do so anyway).
>
>>> - __unregister_linger_request() is now called when
>>>   a request is canceled, but it wasn't before.  (Since
>>>   we're consistent about setting the r_linger flag
>>>   this should be fine, but it *is* a behavior change.)
>>
>> The general goal here is to make ceph_osdc_cancel_request() cancel
>> *any* request correctly, so if r_linger is set, which means that the
>> request in question *could* be lingering, __unregister_linger_request()
>> is called.
>
> The goal is good.  Note that __unregister_linger_request() drops
> a reference to the request though.  There are three other callers
> of this function.  Two of them drop a reference that had just been
> added by a call to __register_request().  The other one is in
> ceph_osdc_unregister_linger_request(), initiated by a higher layer.
> In that last case, r_linger will be zeroed, so calling it again
> should be harmless.

Yeah, ceph_osdc_unregister_linger_request() is removed in favor of
ceph_osdc_cancel_request() later in the series.  r_linger is now
treated is a sort of immutable field - it's never zeroed after it's
been set.  It's still safe to call __unregister_linger_request()
at any point in time though, because unless the request is *actually*
lingering it won't do a thing.

Are you OK with your Reviewed-by for this patch?

Thanks,

                Ilya
