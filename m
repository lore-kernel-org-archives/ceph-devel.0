From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: OSD Hardware questions
Date: Fri, 29 Jun 2012 14:35:07 +0200
Message-ID: <4FEDA0FB.9010401@profihost.ag>
References: <5d5b400b-c2b4-4bce-9231-b412ce1aff03@mailpro> <Pine.LNX.4.64.1206280831590.32016@cobra.newdream.net> <4FECCBD0.3030909@profihost.ag> <4FED9370.5030700@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:40612 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab2F2MfN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 08:35:13 -0400
In-Reply-To: <4FED9370.5030700@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org


Am 29.06.2012 13:37, schrieb Mark Nelson:
> On 6/28/12 4:25 PM, Stefan Priebe wrote:
>> Am 28.06.2012 17:33, schrieb Sage Weil:
>>> Have you tried adjusting 'osd op threads'? The default is 2, but bumping
>>> that to, say, 8, might give you better concurrency and throughput.
>> For me this doesn't change anything. I believe the ceph-osd processes
>> are the problem. I mean i've 8 cores x 3,6Ghz and 4 ceph-osd processses
>> use around 80%.
>>
>>> "Mark Nelson" <mark.nelson@inktank.com> wrote:
>>>> It would be interesting to see where all your CPU time is being spent.
>>>> What benchmark are you using to do the random writes?
>>>
>>> Definitely. Seeing perf/oprofile/whatever results for the osd under that
>>> workload would be very interesting! We need to get perf going in our
>>> testing environment...
>> I have it working. But even a call graph of 10s is around 120 000 lines
>> long ?!
>>
>> Stefan
>
> What tool did you use to do the profiling?

i used the perf tool bundled with the kernel source. I can send you the 
perf.data file if you want. But i don't see anything interesting. But 
maybe i've just used perf the wrong way.

Stefan
