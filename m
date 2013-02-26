From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling
 under very heavy write load
Date: Tue, 26 Feb 2013 12:16:47 -0700
Message-ID: <512D0A1F.30801@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
 <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
 <4F29CDAA.408@sandia.gov>
 <CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
 <4F2AABF5.6050803@sandia.gov>
 <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
 <4F47AEE3.5080305@sandia.gov>
 <alpine.DEB.2.00.1302201551580.26205@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:33783 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab3BZTRX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 14:17:23 -0500
In-Reply-To: <alpine.DEB.2.00.1302201551580.26205@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org, sri@basam.org

Hi Sage,

On 02/20/2013 05:12 PM, Sage Weil wrote:
> Hi Jim,
> 
> I'm resurrecting an ancient thread here, but: we've just observed this on 
> another big cluster and remembered that this hasn't actually been fixed.

Sorry for the delayed reply - I missed this in a backlog
of unread email...

> 
> I think the right solution is to make an option that will setsockopt on 
> SO_RECVBUF to some value (say, 256KB).  I pushed a branch that does this, 
> wip-tcp.  Do you mind checking to see if this addresses the issue (without 
> manually adjusting things in /proc)?

I'll be happy to test it out...

> 
> And perhaps we should consider making this default to 256KB...

That's the value I've been using with my /proc adjustments
since I figured out what was going on.  My servers use
a 10 GbE port for each of the cluster and public networks,
with cephfs clients using 1 GbE, and I've not detected any
issues resulting from that value.  So, it seems like a decent
starting point for a default...

-- Jim

> 
> Thanks!
> sage
> 


