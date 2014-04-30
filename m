From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: osd systemtap initial steps
Date: Wed, 30 Apr 2014 16:18:55 -0500
Message-ID: <536168BF.2030207@inktank.com>
References: <CA+4uBUbt8SikqyznV1q17UyqdAVyNM7fG7n5k5i4uSjSFuL8pg@mail.gmail.com>	<CACJqLybakktJy0ewWdV4TMe63_9_XuxxgfCHze2N4LDzK+q6Vg@mail.gmail.com>	<5360F860.20902@bisect.de> <CA+4uBUYHUuRV0CtxtLmkga1fyB6StULfj19v0yhicWn3iEBZYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:52101 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964937AbaD3VS4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Apr 2014 17:18:56 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so2623576ieb.27
        for <ceph-devel@vger.kernel.org>; Wed, 30 Apr 2014 14:18:55 -0700 (PDT)
In-Reply-To: <CA+4uBUYHUuRV0CtxtLmkga1fyB6StULfj19v0yhicWn3iEBZYg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>, Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Marc Koderer <marckoderer@gmail.com>

Have I mentioned how exciting that is?

Mark

On 04/30/2014 04:14 PM, Samuel Just wrote:
> Cool.  Looks like we read the same guide on the autotools bit :P.  I'm
> focusing on instrumenting the OSD op life cycle.
> -Sam
>
> On Wed, Apr 30, 2014 at 6:19 AM, Danny Al-Gaaf <danny.al-gaaf@bisect.de> wrote:
>> Am 30.04.2014 04:21, schrieb Haomai Wang:
>>> So cool!
>>>
>>> I remember a telekomcloud guy is also worked for it since last summit.
>>
>> Correct ... our initial version is/was this:
>> https://github.com/dalgaaf/ceph/commits/wip-master-bp-systemtap
>>
>> Danny
>>
>>> On Wed, Apr 30, 2014 at 6:17 AM, Samuel Just <sam.just@inktank.com> wrote:
>>>> I'm starting on adding systemtap trace points to the osd.
>>>>
>>>> https://github.com/athanatos/ceph/tree/wip-osd-stap
>>>>
>>>> has some initial build changes and a single tracepoint in OSD::handle_op.
>>>>
>>>> I'll ping the list when I've got more.
>>>> -Sam
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

