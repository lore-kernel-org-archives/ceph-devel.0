From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: OSD Hardware questions
Date: Fri, 29 Jun 2012 06:37:20 -0500
Message-ID: <4FED9370.5030700@inktank.com>
References: <5d5b400b-c2b4-4bce-9231-b412ce1aff03@mailpro> <Pine.LNX.4.64.1206280831590.32016@cobra.newdream.net> <4FECCBD0.3030909@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39710 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab2F2LhW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 07:37:22 -0400
Received: by yenl2 with SMTP id l2so2576917yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 04:37:21 -0700 (PDT)
In-Reply-To: <4FECCBD0.3030909@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On 6/28/12 4:25 PM, Stefan Priebe wrote:
> Am 28.06.2012 17:33, schrieb Sage Weil:
>> Have you tried adjusting 'osd op threads'? The default is 2, but bumping
>> that to, say, 8, might give you better concurrency and throughput.
> For me this doesn't change anything. I believe the ceph-osd processes
> are the problem. I mean i've 8 cores x 3,6Ghz and 4 ceph-osd processses
> use around 80%.
>
>> "Mark Nelson" <mark.nelson@inktank.com> wrote:
>>> It would be interesting to see where all your CPU time is being spent.
>>> What benchmark are you using to do the random writes?
>>
>> Definitely. Seeing perf/oprofile/whatever results for the osd under that
>> workload would be very interesting! We need to get perf going in our
>> testing environment...
> I have it working. But even a call graph of 10s is around 120 000 lines
> long ?!
>
> Stefan

What tool did you use to do the profiling?

Mark
