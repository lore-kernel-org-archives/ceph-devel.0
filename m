From: Mike Dawson <mike.dawson@scholarstack.com>
Subject: Re: final mon issues
Date: Fri, 26 Apr 2013 15:57:11 -0400
Message-ID: <517ADC17.6080206@scholarstack.com>
References: <alpine.DEB.2.00.1304261240460.13630@cobra.newdream.net> <517ADB34.1020105@42on.com> <517ADBB0.904@scholarstack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:45838 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756097Ab3DZT5L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 15:57:11 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so5506018iec.29
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 12:57:11 -0700 (PDT)
In-Reply-To: <517ADBB0.904@scholarstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Sage Weil <sage@inktank.com>, greg@inktank.com, ceph-devel@vger.kernel.org

Oops. Looks like you are already on "next".

Greg,
Perhaps the issue still exists?

- Mike

On 4/26/2013 3:55 PM, Mike Dawson wrote:
> Wido,
>
> I think you saw the same issue I did
> (http://tracker.ceph.com/issues/4793). If so, I believe there is a fix
> in "next".
>
> - Mike
>
> On 4/26/2013 3:53 PM, Wido den Hollander wrote:
>> On 04/26/2013 09:43 PM, Sage Weil wrote:
>>> I've merged the double-forward fix.  I still have one remaining problem
>>> that I can reproduce with my tests which looks like an overlap of mon
>>> overload forwarded message priorities; I'm testing two possible fixes to
>>> see which are necessary to resolve it.
>>>
>>> The memory issues with people using the gitbuilder appear to be because
>>> our gitbuilders weren't linking in tcmalloc.  The latest 'next' build
>>> *does* link it now, so if you are one of those people, please re-test!
>>>
>>> I don't think either of those problems is related to the sync issues
>>> Mike
>>> is seeing, though.  I believe that is the final outstanding issue...?
>>>
>>
>> I think I also just noticed a sync issue, reported it as:
>> http://tracker.ceph.com/issues/4837
>>
>> This e-mail and my report just crossed each other I think.
>>
>>> sage
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
