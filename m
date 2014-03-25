From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 14:57:57 +0200
Message-ID: <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
References: <1395736765.2823.29.camel@localhost>
	<CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
	<53316D18.7040103@ieee.org>
	<CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
	<53317BC2.9010700@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:64314 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbaCYM56 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 08:57:58 -0400
Received: by mail-qa0-f54.google.com with SMTP id w8so380913qac.41
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 05:57:57 -0700 (PDT)
In-Reply-To: <53317BC2.9010700@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Olivier Bonvalet <ceph.list@daevel.fr>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Mar 25, 2014 at 2:51 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/25/2014 07:34 AM, Ilya Dryomov wrote:
>>> On 03/25/2014 04:04 AM, Ilya Dryomov wrote:
>>>> On Tue, Mar 25, 2014 at 10:39 AM, Olivier Bonvalet <ceph.list@daevel.fr> wrote:
>>>>> Hi,
>>>>>
>>>>> what can/should I do to help fix that problem ?
>>>>>
>>>>> for now, RBD kernel client hang on :
>>>>>         Assertion failure in rbd_img_obj_callback() at line 2131:
>>>>>            rbd_assert(which >= img_request->next_completion);
>>>
>>> If you can build your own kernel as Ilya says I'd like to
>>> see the values of which and img_request->next_completion
>>> here.
>>
>> Looks like which was 1, which means that next_completion had to be 2 or
>> greater.  I miss solaris crash dumps ...
>>
>> On a different note, why are we asserting next_completion outside of
>> a spinlock which is supposed to protect next_completion?
>
> That's a very good point (which could be easily remedied by moving
> the assertion down a couple lines).  The image object request (#1)
> in this case will have been marked done at this point; it's possible
> that request #2 (or later) was concurrently getting handled by the
> for_each_obj_request_from() loop below in that same function, but
> may not have updated next_completion yet.
>
> So that *could* explain the tripped assertion.  The assertion
> should be moved in any case, it's a bug.
>
> That being said, it doesn't explain the other assertion:
>         rbd_assert(img_request != NULL);
> So there's at least one other thing going on.

Yeah, exactly my thoughts.

Thanks,

                Ilya
