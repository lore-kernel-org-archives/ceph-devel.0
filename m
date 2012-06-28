From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: OSD Hardware questions
Date: Thu, 28 Jun 2012 23:25:36 +0200
Message-ID: <4FECCBD0.3030909@profihost.ag>
References: <5d5b400b-c2b4-4bce-9231-b412ce1aff03@mailpro> <Pine.LNX.4.64.1206280831590.32016@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:38837 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab2F1VZi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jun 2012 17:25:38 -0400
In-Reply-To: <Pine.LNX.4.64.1206280831590.32016@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, Mark Nelson <mark.nelson@inktank.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

Am 28.06.2012 17:33, schrieb Sage Weil:
> Have you tried adjusting 'osd op threads'?  The default is 2, but bumping
> that to, say, 8, might give you better concurrency and throughput.
For me this doesn't change anything. I believe the ceph-osd processes 
are the problem. I mean i've 8 cores x 3,6Ghz and 4 ceph-osd processses 
use around 80%.

> "Mark Nelson" <mark.nelson@inktank.com> wrote:
>> It would be interesting to see where all your CPU time is being spent.
>> What benchmark are you using to do the random writes?
>
> Definitely.  Seeing perf/oprofile/whatever results for the osd under that
> workload would be very interesting!  We need to get perf going in our
> testing environment...
I have it working. But even a call graph of 10s is around 120 000 lines 
long ?!

Stefan
