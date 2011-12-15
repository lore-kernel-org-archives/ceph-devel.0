From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 16:45:56 +0100
Message-ID: <3807778.ycpoZxnZL4@pc10>
References: <1404301.on6okQVZ04@pc10> <4EEA1309.9030602@grnet.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:47158 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578Ab1LOPp7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Dec 2011 10:45:59 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 8192010C866
	for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2011 16:45:57 +0100 (CET)
In-Reply-To: <4EEA1309.9030602@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Donnerstag, 15. Dezember 2011, 17:32:25 schrieben Sie:
> On 12/15/2011 05:07 PM, Guido Winkelmann wrote:
> > Hi,
> > 
> > I've got a small ceph cluster with one mon, one mds and two osds (all on
> > the same machine, for now), that I want to use as a block- and file
> > storage backend for qemu machine virtualisation.
> > 
> > I found that read access to some of the rbd images, or parts of some of
> > them sometimes blocks indefinitely, usually after the image has been
> > sitting around untouched for a while, for example over night. This has
> > the effect that virtual machines that try to access their disks as well
> > as rbd commands like "rbd cp" will just hang indefinitely.
> > 
> >  I found that these blocks can usually be "fixed" by restarting one of
> >  the> 
> > osds.
> > 
> > The last time this happened, ceph -s reported one of the osds to be in
> > state "active+clean+scrubbing". (I'm afraid I don't have the complete
> > output from ceph -s anymore.)
> > 
> > Does anybody have any idea what could be going wrong here?
> 
> I think it's fixed in v0.39

I'm already using 0.39, so, no. (Should have mentioned that to start with...)

        Guido
