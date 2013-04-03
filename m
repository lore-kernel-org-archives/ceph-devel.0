From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Trouble getting a new file system to start, for v0.59 and
 newer
Date: Wed, 3 Apr 2013 11:09:06 -0600
Message-ID: <515C6232.4070204@sandia.gov>
References: <515C4EC4.5040602@sandia.gov>
 <alpine.DEB.2.00.1304030857480.12367@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:40183 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762172Ab3DCRJn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 13:09:43 -0400
In-Reply-To: <alpine.DEB.2.00.1304030857480.12367@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

On 04/03/2013 09:58 AM, Sage Weil wrote:
> Hi Jim,
> 
> What happens if you change 'osd mon ack timeout = 300' (from the 
> default of 30)?  I suspect part of the problem is that the mons are just 
> slow enough that the osd's resend the same thing again and it snowballs 
> into more work for the monitor.

Thanks, that helped.  My OSDs aren't reconnecting to the mon any more,
and the new filesystem started up as expected.

Hmmm, it occurs to me that I upgraded my mon hosts to 10 GbE NICs at
about the same time I started testing v0.59.  Perhaps before the upgrade
I was running right at the edge of that timeout.  After the NIC upgrade 
the PGStat messages come flooding in at startup, and they bunch up
enough that working through the backlog pushed me over the timeout cliff?

Is there any downside to using a large 'osd mon ack timeout', assuming I
run more than one mon?  If so, I expect I'll work my way back from
'osd mon ack timeout = 300' to see how big it needs to be to stay reliable
for my configuration.

Sorry for the noise about paxos.  At least it was useful
to help Joao find that debug log message that was more expensive
than expected....

Thanks -- Jim

> 
> sage


