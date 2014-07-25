From: Sage Weil <sweil@redhat.com>
Subject: Re: Forcing Ceph into mapping all objects to a single PG
Date: Fri, 25 Jul 2014 07:12:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407250709480.18917@cobra.newdream.net>
References: <53CD93B4.6020500@trvx.org> <CAPYLRzj4tzBCSrGPCsaLvy1+7ac4=Um1EHDeZhLsCpuZZy7miA@mail.gmail.com> <lqmpg2$chu$1@ger.gmane.org> <53D24CF9.8080803@trvx.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56875 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbaGYOMX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 10:12:23 -0400
In-Reply-To: <53D24CF9.8080803@trvx.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Hofmann <daniel@trvx.org>
Cc: Alex Elsayed <eternaleye@gmail.com>, ceph-devel@vger.kernel.org

On Fri, 25 Jul 2014, Daniel Hofmann wrote:
> The main issue however is not the hash's strength, but the fact that
> once pre-computed, I'm able to use preimages on **every Ceph cluster out
> there**. (As the hash functions's output is a deterministic function of
> the object's name only)
> 
> I agree in that the general issue is inherent in hash-placement systems.
> 
> But what I don't agree with is the following:
> 
> Why do I have to be able to calculate my object's placement for **every
> Ceph cluster** out there?
> 
> Why does it not suffice for me to be able to calculate the placement
> only for the cluster I'm currently accessing?
> 
> >From a logical standpoint it seems reasonable. Why then, are we not able
> to constrain the placement calculation in that regard?
> 
> 
> If the placement is bound to a specific cluster it should suffice to
> derive e.g. a key for SipHash based on cluster specifics.
> 
> Is this doable from an implementation point of view?
> 
> 
> Note: I only did this as a proof-of-concept for the object store.
> Think about the implications, if you're able to do this e.g. for every
> RadosGW out there and servies using RadosGW.

It would be really easy to add a random salt to the pg_pool_t and feed 
that into the object -> pg hash mapping.  Note, by the way, that for new 
clusters the pool id is already fed in here, so there is a *tiny* bit of 
variation depending on what orders the pools were created in (although 
probably not enough to meaningfully improve security).

We could also add a new hash type that is more secure.  Rjenkins is used 
by default but the choice of hash is already parameterized.

sage
