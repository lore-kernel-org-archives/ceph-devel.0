From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 09/14] libceph: introduce ceph_osdc_cancel_request()
Date: Mon, 30 Jun 2014 18:34:39 +0400
Message-ID: <CALFYKtB4oCa71L+pOO+jkROKRr-wLWCds_MY6zbk+P4b987y8A@mail.gmail.com>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com>
	<1403716607-13535-10-git-send-email-ilya.dryomov@inktank.com>
	<53B16887.2090309@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:41471 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbaF3Oek (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 10:34:40 -0400
Received: by mail-qc0-f176.google.com with SMTP id w7so7037126qcr.7
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 07:34:39 -0700 (PDT)
In-Reply-To: <53B16887.2090309@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 30, 2014 at 5:39 PM, Alex Elder <elder@ieee.org> wrote:
> On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
>> Introduce ceph_osdc_cancel_request() intended for canceling requests
>> from the higher layers (rbd and cephfs).  Because higher layers are in
>> charge and are supposed to know what and when they are canceling, the
>> request is not completed, only unref'ed and removed from the libceph
>> data structures.
>
> This seems reasonable.
>
> But you make two changes here that I'd like to see a little
> more explanation on.  They seem significant enough to warrant
> a little more attention in the commit description.
>
> - __cancel_request() is no longer called when
>   ceph_osdc_wait_request() fails due to an
>   an interrupt.  This is my main concern, and I
>   plan to work through it but I'm in a small hurry
>   right now.

Perhaps it should have been a separate commit.  __unregister_request()
revokes r_request, so I opted for not trying to do it twice.  As for
the r_sent condition and assignment, it doesn't seem to make much of
a difference, given that the request is about to be unregistered
anyway.

> - __unregister_linger_request() is now called when
>   a request is canceled, but it wasn't before.  (Since
>   we're consistent about setting the r_linger flag
>   this should be fine, but it *is* a behavior change.)

The general goal here is to make ceph_osdc_cancel_request() cancel
*any* request correctly, so if r_linger is set, which means that the
request in question *could* be lingering, __unregister_linger_request()
is called.

Thanks,

                Ilya
