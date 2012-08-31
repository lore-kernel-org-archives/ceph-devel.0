From: Gregory Farnum <greg@inktank.com>
Subject: Re: Very unbalanced storage
Date: Fri, 31 Aug 2012 09:39:36 -0700
Message-ID: <CAPYLRziEqEPphb8n5Qicj+D6Wq=R9+G4CS9ing6_1W0ztk9cMw@mail.gmail.com>
References: <50409BDC.5010006@gmail.com>
	<5040D179.5000008@aktzero.com>
	<alpine.DEB.2.00.1208310908520.1531@cobra.newdream.net>
	<5040E532.6040306@aktzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48892 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab2HaQjh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 12:39:37 -0400
Received: by ieje11 with SMTP id e11so1821116iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 09:39:36 -0700 (PDT)
In-Reply-To: <5040E532.6040306@aktzero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Thompson <andrewkt@aktzero.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 31, 2012 at 9:24 AM, Andrew Thompson <andrewkt@aktzero.com> wrote:
> On 8/31/2012 12:10 PM, Sage Weil wrote:
>>
>> On Fri, 31 Aug 2012, Andrew Thompson wrote:
>>>
>>> Have you been reweight-ing osds? I went round and round with my cluster a
>>> few days ago reloading different crush maps only to find that it
>>> re-injecting a crush map didn't seem to overwrite reweights. Take a look at
>>> `ceph osd tree` to see if the reweight column matches the weight column.
>>
>> Note that the ideal situation is for reweight to be 1, regardless of what
>> the crush weight is.  If you find the utilizations are skewed, I would
>> look for other causes before resorting to reweight-by-utilization; it is
>> meant to adjust the normal statistical variation you expect from a
>> (pseudo)random placement, but if the variance is high there is likely
>> another cause.
>
>
> So if someone(me, guilty) had been messing with reweight, will setting them
> all to 1 return it to a normal un-reweight-ed state?

Yep!
If you have OSDs with different sizes you'll want to adjust the CRUSH
weights, not the reweight values:
http://ceph.com/docs/master/ops/manage/crush/#adjusting-the-crush-weight
