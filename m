From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Slow request warnings on 0.48
Date: Thu, 5 Jul 2012 13:21:34 -0700
Message-ID: <CACLRD_3BhUe2otUki+a8g8-zXRjUWjf4AMUkRN_Erw7cLdNixA@mail.gmail.com>
References: <44469a6e-79a3-4eaa-be25-c47192c8fc80@mailpro>
	<4FF5D5C3.80207@inktank.com>
	<45F11B42CB5830479EF0E56A27F4E68D7F4E54@exchange1.ad.100it.net>
	<4FF5EFBD.1060603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39490 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab2GEUVf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jul 2012 16:21:35 -0400
Received: by bkwj10 with SMTP id j10so3850302bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 Jul 2012 13:21:34 -0700 (PDT)
In-Reply-To: <4FF5EFBD.1060603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: David Blundell <David.Blundell@100percentit.com>, Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

David,

Could you try rados -p data bench 60 write -t 16 -b 4096?

rados bench defaults to 4MB objects, this'll give us results for 4k objects.

If you could give me the latency too, that would help.
-Sam

On Thu, Jul 5, 2012 at 12:49 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
> On 07/05/2012 01:43 PM, David Blundell wrote:
>>>
>>> Hi David and Alexandre,
>>>
>>> Does this only happen with random writes or also sequential writes?  If
>>> it
>>> happens with sequential writes as well, does it happen with rados bench?
>>>
>>> --
>>> Mark Nelson
>>> Performance Engineer
>>> Inktank
>>
>>
>> Hi Mark,
>>
>> I just ran "rados -p data bench 60 write -t 16" and a few dd tests with no
>> problems at all so at the moment it looks like only random IO triggers the
>> slow writes.
>>
>> Please do let me know if there are any other tests that I can do to help
>> track down the cause.
>>
>> David
>
>
> Thanks David!  We've got some people internally taking a look at this. I'll
> let you guys know if there is anything else we need!
>
> Thanks,
> Mark
>
>
> --
> Mark Nelson
> Performance Engineer
> Inktank
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
