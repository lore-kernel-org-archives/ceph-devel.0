From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 07:28:31 -0500
Message-ID: <4FCCA9EF.6080701@inktank.com>
References: <4FCB1C0A.4050504@profihost.ag> <4FCB5EED.30909@inktank.com> <4FCC5431.6070002@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41148 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab2FDM2e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 08:28:34 -0400
Received: by yenm10 with SMTP id m10so2925057yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 05:28:34 -0700 (PDT)
In-Reply-To: <4FCC5431.6070002@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 6/4/12 1:22 AM, Hannes Reinecke wrote:
> On 06/03/2012 02:56 PM, Mark Nelson wrote:
>> On 6/3/12 3:10 AM, Stefan Priebe wrote:
>>> Hi List,
>>>
>>> has anybody already tried CEPH over Infiniband 40GB?
>>>
>>> Stefan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>>> ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>> Hi Stefan,
>>
>> A couple of folks have done DDR IB.  For now you are limited to
>> ipoib though.  If you have the hardware available I'd be really
>> curious what kind of throughput/latencies you see.
>>
> Hehe.
>
> Good luck with that.
>
> We've tried on 10GigE with _disastrous_ results.
> Up to the point where 1GigE was actually _faster_.

Strange!  Do you see good results with something like iperf?  Internally 
we have 10GE on some of our test nodes and I can get up to around 
600MB/s per node during rados bench testing.

> So far we've uncovered two issues:
> - intel_idle was/is seriously broken (we've tried on 3.0-stable,
>    so might've been fixed by now)
> - osd-server is calling 'fsync' on each and every write request.
>    Does wonders for performance ...

For syncfs support, upgrade to a distro with glibc 2.13+ (ie precise). 
I've noticed a significant improvement in our spinning disk performance 
going from oneiric and kernel 3.3 to precise and kernel 3.4.  I think 
part of this is related to the raid drivers for the cards we have in our 
test boxes though.  I'm actually recording blktrace and seekwatcher 
results for all of our tests to specifically look at syncs and disk seek 
behavior...

>
> Cheers,
>
> Hannes

Mark
