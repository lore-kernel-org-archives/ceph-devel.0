From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Tue, 26 Jun 2012 11:29:20 -0500
Message-ID: <4FE9E360.8050807@inktank.com>
References: <4FE60A65.2030800@profihost.ag> <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net> <4FE97BE8.6010603@profihost.ag> <4FE9E006.6030404@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:35165 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758502Ab2FZQ3h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 12:29:37 -0400
Received: by yhnn12 with SMTP id n12so138027yhn.10
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 09:29:37 -0700 (PDT)
In-Reply-To: <4FE9E006.6030404@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "hch@infradead.org >> Christoph Hellwig" <hch@infradead.org>

On 06/26/2012 11:15 AM, Stefan Priebe wrote:
> Am 26.06.2012 11:07, schrieb Stefan Priebe:
>> Am 26.06.2012 00:11, schrieb Sage Weil:
>>> On Sat, 23 Jun 2012, Stefan Priebe wrote:
>>>> Hi,
>>>>
>>>> i got stuck while selecting the right FS for ceph / RBD.
>>>>
>>>> XFS:
>>>> - deadlock / hung task under 3.0.34 in xfs_ilock / xfs_buf_lock while
>>>> syncfs
>>>
>>> There was an ilock fix that went into 3.4, IIRC. Have you tried vanilla
>>> 3.4? We are seeing some lockdep noise currently, but no deadlocks yet.
>>
>> Will test 3.4.4 soon.
>
> With btrfs i have 13-14.000 iops while doing random 4k writes from kvm.
> With XFS and 3.4.4 i have 814 ;-( and got a lot of slow request noise in
> ceph.log ;-( so 814 iops are not an option to me. Or is there anything
> special i've to respect while using XFS.
>
> Greets
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

Hi Stefan,

If you can, it would be really interesting to see the blktrace results 
during these tests for both xfs and btrfs.  blktrace is in the ubuntu 
repositories and can be run quite easily from the command line during 
your test.

Thanks,
Mark

