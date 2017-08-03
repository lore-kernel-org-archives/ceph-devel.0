From: Sage Weil <sweil@redhat.com>
Subject: Re: mgr balancer module
Date: Thu, 3 Aug 2017 15:53:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708031545131.20435@piezo.novalocal>
References: <alpine.DEB.2.11.1707280333250.21289@piezo.novalocal> <CAAXqJ+ovmFtC3dNo_5R5x9cj6smFev2Q9wgXVL_4NcHQCnA2tA@mail.gmail.com> <alpine.DEB.2.11.1707301814040.5035@piezo.novalocal> <CAAXqJ+r1CrBk1mHeHXK4_34uqLPtL9D+BBaKT=SU4s584Bk_sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdHCPx5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 3 Aug 2017 11:53:57 -0400
In-Reply-To: <CAAXqJ+r1CrBk1mHeHXK4_34uqLPtL9D+BBaKT=SU4s584Bk_sA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Spandan,

On Thu, 3 Aug 2017, Spandan Kumar Sahu wrote:
> Sage
> 
> I think it would be a good idea to include a command in the balancer
> module itself, that would optimize the crushmap using the
> python-crush, and set the optimized crushmap.
> 
> As far as I believe, uneven distributions can be majorly attributed to
> the factors:
> * using an unoptimized crushmap
> * unevenness that occurs due to the (pseudo) random nature of CRUSH
> * objects having different sizes.
> 
> If we set an optimized crushmap, at the very initial stages, we have
> to move very less data in the due course, in order to maintain a
> proper distribution. Hence the necessity of including it in the
> balancer module. Please give a look at the PR[1], I sent in this
> regard, and let me know if I am moving in the right direction.

There are a few problems with using python-crush, the main one being that 
the dependencies are problematic: it's built from a forked repo and is not 
packaged properly (has to be installed with pip).  It also may not 
match the CRUSH version being used by the cluster.

The larger issue though is that it doesn't address all of the other 
problems I highlighted in my earlier email.  The main thing it *does* to 
properly is it does the optimization based on a model; this was the main 
problem with the old reweight-by-utilization.  The new framework in 
balancer.py has all the pieces now to let you do that.

I think the main value in the python-crush optimize code is that it 
demonstrably works, which means we know that the cost/score fuction being 
used and the descent method work together.  I think the best path forward 
is to look at the core of what those two pieces are doing and port it into 
the balancer environment.  Most recently I've been working on the 
'eval' method that will generate a score for a given distribution, but I'm 
working from first principles (just calculating the layout, its deviation 
from the target, the standard deviation, etc.) but I'm not sure what 
Loic's optimizer was doing.  Also, my first attempt at a descent function 
to correct weights was pretty broken, and I know a lot of experimentation 
went into Loic's method.

Do you see any problems with that approach, or things that the 
balancer framework does not cover?

Thanks!
sage

