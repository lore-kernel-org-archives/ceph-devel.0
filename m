From: Sage Weil <sage@inktank.com>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling under
 very heavy write load
Date: Tue, 26 Feb 2013 11:36:24 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302261135190.4819@cobra.newdream.net>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov> <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com> <4F29CDAA.408@sandia.gov> <CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com> <4F2AABF5.6050803@sandia.gov>
 <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com> <4F47AEE3.5080305@sandia.gov> <alpine.DEB.2.00.1302201551580.26205@cobra.newdream.net> <512D0A1F.30801@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51508 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706Ab3BZTgZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 14:36:25 -0500
In-Reply-To: <512D0A1F.30801@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org, sri@basam.org

On Tue, 26 Feb 2013, Jim Schutt wrote:
> > I think the right solution is to make an option that will setsockopt on 
> > SO_RECVBUF to some value (say, 256KB).  I pushed a branch that does this, 
> > wip-tcp.  Do you mind checking to see if this addresses the issue (without 
> > manually adjusting things in /proc)?
> 
> I'll be happy to test it out...

That would be great!  It's branch wip-tcp, and the setting is 'ms tcp 
rcvbuf'.

Thanks!
sage
