From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: Forcing Ceph into mapping all objects to a single PG
Date: Fri, 25 Jul 2014 11:14:24 -0700
Message-ID: <lqu6q0$sgc$1@ger.gmane.org>
References: <53CD93B4.6020500@trvx.org> <CAPYLRzj4tzBCSrGPCsaLvy1+7ac4=Um1EHDeZhLsCpuZZy7miA@mail.gmail.com> <lqmpg2$chu$1@ger.gmane.org> <53D24CF9.8080803@trvx.org> <alpine.DEB.2.00.1407250709480.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53843 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbaGYSOn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 25 Jul 2014 14:14:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1XAk0s-0000yo-Fh
	for ceph-devel@vger.kernel.org; Fri, 25 Jul 2014 20:14:38 +0200
Received: from 50.245.141.77 ([50.245.141.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 20:14:38 +0200
Received: from eternaleye by 50.245.141.77 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 20:14:38 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil wrote:

> On Fri, 25 Jul 2014, Daniel Hofmann wrote:
>> The main issue however is not the hash's strength, but the fact that
>> once pre-computed, I'm able to use preimages on **every Ceph cluster out
>> there**. (As the hash functions's output is a deterministic function of
>> the object's name only)
>> 
>> I agree in that the general issue is inherent in hash-placement systems.
>> 
>> But what I don't agree with is the following:
>> 
>> Why do I have to be able to calculate my object's placement for **every
>> Ceph cluster** out there?
>> 
>> Why does it not suffice for me to be able to calculate the placement
>> only for the cluster I'm currently accessing?
>> 
>> >From a logical standpoint it seems reasonable. Why then, are we not able
>> to constrain the placement calculation in that regard?
>> 
>> 
>> If the placement is bound to a specific cluster it should suffice to
>> derive e.g. a key for SipHash based on cluster specifics.
>> 
>> Is this doable from an implementation point of view?
>> 
>> 
>> Note: I only did this as a proof-of-concept for the object store.
>> Think about the implications, if you're able to do this e.g. for every
>> RadosGW out there and servies using RadosGW.
> 
> It would be really easy to add a random salt to the pg_pool_t and feed
> that into the object -> pg hash mapping.  Note, by the way, that for new
> clusters the pool id is already fed in here, so there is a *tiny* bit of
> variation depending on what orders the pools were created in (although
> probably not enough to meaningfully improve security).

I just had a thought - is the FSID a parameter? If it is, then there's 
actually no need for a further salt: FSID is per cluster, preventing cross-
cluster precomputation, and if the pool ID is fed in then each pool needs 
collisions calculated separately as well. In other words, the (fsid, poolid) 
tuple is almost certainly sufficient salt in and of itself.

> We could also add a new hash type that is more secure.  Rjenkins is used
> by default but the choice of hash is already parameterized.
> 
> sage



