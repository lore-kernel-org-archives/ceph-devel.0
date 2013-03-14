From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Direct IO on CephFS for blocks larger than 8MB
Date: Thu, 14 Mar 2013 10:51:21 -0500
Message-ID: <5141F1F9.1030509@inktank.com>
References: <5A908216FB901F499F602F4F9CEF5B380FEA68C3@SHSMSX102.ccr.corp.intel.com> <alpine.DEB.2.00.1303140819420.11175@cobra.newdream.net> <1868F843065B483E80E7B83A24F389D2@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42728 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933985Ab3CNPvW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 11:51:22 -0400
Received: by mail-ie0-f176.google.com with SMTP id k13so3147137iea.7
        for <ceph-devel@vger.kernel.org>; Thu, 14 Mar 2013 08:51:21 -0700 (PDT)
In-Reply-To: <1868F843065B483E80E7B83A24F389D2@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: "Huang, Xiwei" <xiwei.huang@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 03/14/2013 10:44 AM, Greg Farnum wrote:
> On Thursday, March 14, 2013 at 8:20 AM, Sage Weil wrote:
>> On Thu, 14 Mar 2013, Huang, Xiwei wrote:
>>> Hi, all,
>>> I noticed that CephFS fails to support Direct IO for blocks larger than 8MB, say:
>>> sudo dd if=/dev/zero of=mnt/cephfs/foo bs=16M count=1 oflag=direct
>>> dd: writing `mnt/cephfs/foo: Bad address
>>> 1+0 records in
>>> 0+0 records out
>>> 0 bytes (0 B) copied, 0.213948 s, 0.0 kB/s
>>> My version Ceph is 0.56.1.
>>> ??I also found the bug has been already reported as Bug #2657.
>>> Is this fixed in the new 0.58 version?
>>
>>
>>
>> I'm pretty sure this is a problem on the kernel client side of things, not
>> the server side (which by default handles writes up to ~100MB or so). I
>> suspect it isn't terribly difficult to fix, but hasn't been prioritized...
>>
>> sage
> My guess too. Are direct IO writes of that size a common thing or of great import to you?
> Either way, a comment on the tracker saying you've run into it will promote it up when we're doing bug scrubs and backlog reviews. :)
> -Greg

I imagine we'll see some applications doing large direct IO writes like 
this in the HPC space.

Mark

>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

