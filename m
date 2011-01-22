From: Matthias Urlichs <matthias@urlichs.de>
Subject: Re: Ceph distributed over slow link: possible?
Date: Sat, 22 Jan 2011 11:06:31 +0000 (UTC)
Message-ID: <ihednn$bal$2@dough.gmane.org>
References: <ihcobl$bal$1@dough.gmane.org>
	<AANLkTi=1R9-BA9-iw2mJSNC8dfHE6AswZEW+MEcsLVa5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:45530 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849Ab1AVLGo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 22 Jan 2011 06:06:44 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1PgbIp-00005z-B2
	for ceph-devel@vger.kernel.org; Sat, 22 Jan 2011 12:06:43 +0100
Received: from netz.smurf.noris.de ([213.95.21.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 22 Jan 2011 12:06:43 +0100
Received: from matthias by netz.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 22 Jan 2011 12:06:43 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
> * I don't think it's possible to control where clients go for reads -
> Ceph is pretty much optimized to the case where all nodes are in a
> single datacenter, over a more or less homogeneous network.

So, what piece(s) of code decides which replica is read from?

Note that even in the single-datacenter case, I'd want to avoid crossing
rack boundaries if my client is in the same rack as one of the possible
OSDs.

> For writes,
> though, you'd be stuck with WAN speeds no matter what, because the data
> has to go out to all replicas before the writes complete.

Hmm. Too bad; I'd be more than happy with writing to one or two replicas,
and trusting CEPH to manage the rest of the copying in the background.

-- 
-- Matthias Urlichs

