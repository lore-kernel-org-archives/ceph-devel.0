From: Gregory Farnum <greg@inktank.com>
Subject: Re: final mon issues
Date: Fri, 26 Apr 2013 12:58:50 -0700
Message-ID: <CAPYLRzigHQxzVQDHK-iC==Tc5TdFEMWqBM8tqRUFroZP3=E5=Q@mail.gmail.com>
References: <alpine.DEB.2.00.1304261240460.13630@cobra.newdream.net>
	<517ADB34.1020105@42on.com>
	<517ADBB0.904@scholarstack.com>
	<517ADC17.6080206@scholarstack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:48993 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757135Ab3DZT6v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 15:58:51 -0400
Received: by mail-qc0-f170.google.com with SMTP id d42so2312787qca.29
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 12:58:50 -0700 (PDT)
In-Reply-To: <517ADC17.6080206@scholarstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@scholarstack.com>
Cc: Wido den Hollander <wido@42on.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Yeah, looking again... (and at your logs, too).
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Fri, Apr 26, 2013 at 12:57 PM, Mike Dawson
<mike.dawson@scholarstack.com> wrote:
> Oops. Looks like you are already on "next".
>
> Greg,
> Perhaps the issue still exists?
>
> - Mike
>
>
> On 4/26/2013 3:55 PM, Mike Dawson wrote:
>>
>> Wido,
>>
>> I think you saw the same issue I did
>> (http://tracker.ceph.com/issues/4793). If so, I believe there is a fix
>> in "next".
>>
>> - Mike
>>
>> On 4/26/2013 3:53 PM, Wido den Hollander wrote:
>>>
>>> On 04/26/2013 09:43 PM, Sage Weil wrote:
>>>>
>>>> I've merged the double-forward fix.  I still have one remaining problem
>>>> that I can reproduce with my tests which looks like an overlap of mon
>>>> overload forwarded message priorities; I'm testing two possible fixes to
>>>> see which are necessary to resolve it.
>>>>
>>>> The memory issues with people using the gitbuilder appear to be because
>>>> our gitbuilders weren't linking in tcmalloc.  The latest 'next' build
>>>> *does* link it now, so if you are one of those people, please re-test!
>>>>
>>>> I don't think either of those problems is related to the sync issues
>>>> Mike
>>>> is seeing, though.  I believe that is the final outstanding issue...?
>>>>
>>>
>>> I think I also just noticed a sync issue, reported it as:
>>> http://tracker.ceph.com/issues/4837
>>>
>>> This e-mail and my report just crossed each other I think.
>>>
>>>> sage
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>>
>
