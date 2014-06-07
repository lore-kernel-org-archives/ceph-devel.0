From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: osd systemtap initial steps
Date: Sat, 07 Jun 2014 14:24:08 +0200
Message-ID: <53930468.6030203@bisect.de>
References: <CA+4uBUbt8SikqyznV1q17UyqdAVyNM7fG7n5k5i4uSjSFuL8pg@mail.gmail.com>	<CACJqLybakktJy0ewWdV4TMe63_9_XuxxgfCHze2N4LDzK+q6Vg@mail.gmail.com>	<5360F860.20902@bisect.de>	<CA+4uBUYHUuRV0CtxtLmkga1fyB6StULfj19v0yhicWn3iEBZYg@mail.gmail.com>	<536168BF.2030207@inktank.com> <CACJqLybMfGkEtTwP9Yz64992CqHFSj2TuubW1j4-_SJONvvPDQ@mail.gmail.com>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:40474 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752563AbaFGMYN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Jun 2014 08:24:13 -0400
In-Reply-To: <CACJqLybMfGkEtTwP9Yz64992CqHFSj2TuubW1j4-_SJONvvPDQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>, Mark Nelson <mark.nelson@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Marc Koderer <marckoderer@gmail.com>

Hi,

I will take a look at it and push the stuff I have already to a git
branch. We can then add more hooks.

Danny

Am 07.06.2014 14:15, schrieb Haomai Wang:
> May I asked the status of this bp?
> 
> Maybe we can push this further
> 
> On Thu, May 1, 2014 at 5:18 AM, Mark Nelson <mark.nelson@inktank.com> wrote:
>> Have I mentioned how exciting that is?
>>
>> Mark
>>
>>
>> On 04/30/2014 04:14 PM, Samuel Just wrote:
>>>
>>> Cool.  Looks like we read the same guide on the autotools bit :P.  I'm
>>> focusing on instrumenting the OSD op life cycle.
>>> -Sam
>>>
>>> On Wed, Apr 30, 2014 at 6:19 AM, Danny Al-Gaaf <danny.al-gaaf@bisect.de>
>>> wrote:
>>>>
>>>> Am 30.04.2014 04:21, schrieb Haomai Wang:
>>>>>
>>>>> So cool!
>>>>>
>>>>> I remember a telekomcloud guy is also worked for it since last summit.
>>>>
>>>>
>>>> Correct ... our initial version is/was this:
>>>> https://github.com/dalgaaf/ceph/commits/wip-master-bp-systemtap
>>>>
>>>> Danny
>>>>
>>>>> On Wed, Apr 30, 2014 at 6:17 AM, Samuel Just <sam.just@inktank.com>
>>>>> wrote:
>>>>>>
>>>>>> I'm starting on adding systemtap trace points to the osd.
>>>>>>
>>>>>> https://github.com/athanatos/ceph/tree/wip-osd-stap
>>>>>>
>>>>>> has some initial build changes and a single tracepoint in
>>>>>> OSD::handle_op.
>>>>>>
>>>>>> I'll ping the list when I've got more.
>>>>>> -Sam
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> 
> 
> 

