From: Daniel Hofmann <daniel@trvx.org>
Subject: Re: Forcing Ceph into mapping all objects to a single PG
Date: Fri, 25 Jul 2014 14:26:33 +0200
Message-ID: <53D24CF9.8080803@trvx.org>
References: <53CD93B4.6020500@trvx.org> <CAPYLRzj4tzBCSrGPCsaLvy1+7ac4=Um1EHDeZhLsCpuZZy7miA@mail.gmail.com> <lqmpg2$chu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trvx.org ([46.38.250.125]:60580 "EHLO mail.trvx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbaGYM0n (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 25 Jul 2014 08:26:43 -0400
In-Reply-To: <lqmpg2$chu$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>, ceph-devel@vger.kernel.org

The main issue however is not the hash's strength, but the fact that
once pre-computed, I'm able to use preimages on **every Ceph cluster out
there**. (As the hash functions's output is a deterministic function of
the object's name only)

I agree in that the general issue is inherent in hash-placement systems.

But what I don't agree with is the following:

Why do I have to be able to calculate my object's placement for **every
Ceph cluster** out there?

Why does it not suffice for me to be able to calculate the placement
only for the cluster I'm currently accessing?

From a logical standpoint it seems reasonable. Why then, are we not able
to constrain the placement calculation in that regard?


If the placement is bound to a specific cluster it should suffice to
derive e.g. a key for SipHash based on cluster specifics.

Is this doable from an implementation point of view?


Note: I only did this as a proof-of-concept for the object store.
Think about the implications, if you're able to do this e.g. for every
RadosGW out there and servies using RadosGW.
