From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Slow request in XFS
Date: Thu, 31 Jan 2013 13:41:20 -0700
Message-ID: <510AD6F0.7020700@sandia.gov>
References: <6F3FA899187F0043BA1827A69DA2F7CC5EA81F@SHSMSX102.ccr.corp.intel.com>
 <alpine.DEB.2.00.1301310441590.11107@cobra.newdream.net>
 <510A8AA0.6000508@sandia.gov>
 <alpine.DEB.2.00.1301311159460.807@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:49010 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114Ab3AaUlr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 15:41:47 -0500
In-Reply-To: <alpine.DEB.2.00.1301311159460.807@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/31/2013 01:00 PM, Sage Weil wrote:
> On Thu, 31 Jan 2013, Jim Schutt wrote:
>> On 01/31/2013 05:43 AM, Sage Weil wrote:
>>> Hi-
>>>
>>> Can you reproduce this with logs?  It looks like there are a few ops that 
>>> are hanging for a very long time, but there isn't enough information here 
>>> except to point to osds 610, 612, 615, and 68...
>>
>> FWIW, I have a small pile of disks with bad sections in
>> them - these sections aren't bad enough that writes fail,
>> but they are bad enough that throughput drops by a factor
>> of ~20.
>>
>> Do OSDs already collect statistics on, say, op commit
>> elapsed time (assuming that's the statistic most directly
>> related to slow writes on only some sections of a disk),
>> in a way that could be used to diagnose such disks?
>>
>> If not, is there enough structure already in place that
>> it would be easy to add?
> 
> They're tracking it internally, but it gets averaged into the totals 
> before a user gets to see any per-request latencies.  The per-daemon 
> totals are available via the admin socket 'perf dump' command.  Have you 
> looked at that information yet?

Not yet - thanks for the pointer.

I'll take a look, and see what happens when I 
put one of my questionable disks back in.

Thanks!

-- Jim

> 
> sage
> 
> 


