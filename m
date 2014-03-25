From: Alex Elder <elder@ieee.org>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 07:51:14 -0500
Message-ID: <53317BC2.9010700@ieee.org>
References: <1395736765.2823.29.camel@localhost>	<CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>	<53316D18.7040103@ieee.org> <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34658 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaCYMu4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 08:50:56 -0400
Received: by mail-qg0-f47.google.com with SMTP id 63so1179592qgz.6
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 05:50:56 -0700 (PDT)
In-Reply-To: <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Olivier Bonvalet <ceph.list@daevel.fr>, Ceph Development <ceph-devel@vger.kernel.org>

On 03/25/2014 07:34 AM, Ilya Dryomov wrote:
>> On 03/25/2014 04:04 AM, Ilya Dryomov wrote:
>>> On Tue, Mar 25, 2014 at 10:39 AM, Olivier Bonvalet <ceph.list@daevel.fr> wrote:
>>>> Hi,
>>>>
>>>> what can/should I do to help fix that problem ?
>>>>
>>>> for now, RBD kernel client hang on :
>>>>         Assertion failure in rbd_img_obj_callback() at line 2131:
>>>>            rbd_assert(which >= img_request->next_completion);
>>
>> If you can build your own kernel as Ilya says I'd like to
>> see the values of which and img_request->next_completion
>> here.
> 
> Looks like which was 1, which means that next_completion had to be 2 or
> greater.  I miss solaris crash dumps ...
> 
> On a different note, why are we asserting next_completion outside of
> a spinlock which is supposed to protect next_completion?

That's a very good point (which could be easily remedied by moving
the assertion down a couple lines).  The image object request (#1)
in this case will have been marked done at this point; it's possible
that request #2 (or later) was concurrently getting handled by the
for_each_obj_request_from() loop below in that same function, but
may not have updated next_completion yet.

So that *could* explain the tripped assertion.  The assertion
should be moved in any case, it's a bug.

That being said, it doesn't explain the other assertion:
        rbd_assert(img_request != NULL);
So there's at least one other thing going on.

					-Alex

> Thanks,
> 
>                 Ilya
> 

