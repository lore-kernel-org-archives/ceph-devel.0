From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 09/14] libceph: introduce ceph_osdc_cancel_request()
Date: Mon, 07 Jul 2014 08:47:45 -0500
Message-ID: <53BAA501.5030901@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>	<1403716607-13535-10-git-send-email-ilya.dryomov@inktank.com>	<53B16887.2090309@ieee.org> <CALFYKtB4oCa71L+pOO+jkROKRr-wLWCds_MY6zbk+P4b987y8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:57852 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbaGGNrp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 09:47:45 -0400
Received: by mail-ig0-f170.google.com with SMTP id h15so10424195igd.1
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jul 2014 06:47:44 -0700 (PDT)
In-Reply-To: <CALFYKtB4oCa71L+pOO+jkROKRr-wLWCds_MY6zbk+P4b987y8A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 06/30/2014 09:34 AM, Ilya Dryomov wrote:
> On Mon, Jun 30, 2014 at 5:39 PM, Alex Elder <elder@ieee.org> wrote:
>> On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
>>> Introduce ceph_osdc_cancel_request() intended for canceling requests
>>> from the higher layers (rbd and cephfs).  Because higher layers are in
>>> charge and are supposed to know what and when they are canceling, the
>>> request is not completed, only unref'ed and removed from the libceph
>>> data structures.
>>
>> This seems reasonable.
>>
>> But you make two changes here that I'd like to see a little
>> more explanation on.  They seem significant enough to warrant
>> a little more attention in the commit description.
>>
>> - __cancel_request() is no longer called when
>>   ceph_osdc_wait_request() fails due to an
>>   an interrupt.  This is my main concern, and I
>>   plan to work through it but I'm in a small hurry
>>   right now.
> 
> Perhaps it should have been a separate commit.  __unregister_request()
> revokes r_request, so I opted for not trying to do it twice.  As for

OK, that makes sense--revoking the request is basically all
__cancel_request() does anyway.  You ought to have mentioned
that in the description anyway, even if it wasn't a separate
commit.

> the r_sent condition and assignment, it doesn't seem to make much of
> a difference, given that the request is about to be unregistered
> anyway.

If the request is getting canceled (from a caller outside libceph)
it can't take into account whether it was sent or not.  As you said,
it is getting revoked unconditionally by __unregister_request().
To be honest though, *that* revoke call should have been zeroing
the r_sent value also.  It apparently won't matter, but I think it's
wrong.  The revoke drops a reference, it doesn't necessarily free
the structure (though I expect it may always do so anyway).

>> - __unregister_linger_request() is now called when
>>   a request is canceled, but it wasn't before.  (Since
>>   we're consistent about setting the r_linger flag
>>   this should be fine, but it *is* a behavior change.)
> 
> The general goal here is to make ceph_osdc_cancel_request() cancel
> *any* request correctly, so if r_linger is set, which means that the
> request in question *could* be lingering, __unregister_linger_request()
> is called.

The goal is good.  Note that __unregister_linger_request() drops
a reference to the request though.  There are three other callers
of this function.  Two of them drop a reference that had just been
added by a call to __register_request().  The other one is in
ceph_osdc_unregister_linger_request(), initiated by a higher layer.
In that last case, r_linger will be zeroed, so calling it again
should be harmless.

I guess I'm going to move on...  I expect all of this discussion
will be moot and you will have made everything work right and
better by the time I get to the end of the series.

					-Alex

> 
> Thanks,
> 
>                 Ilya
> 

