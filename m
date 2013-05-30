From: Sage Weil <sage@inktank.com>
Subject: Re: ceph gets stopped but never started...
Date: Thu, 30 May 2013 08:46:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305300845230.18453@cobra.newdream.net>
References: <51A7383D.4060309@profihost.ag> <CAF6-1L70z8xpZVQtDXJj4h+SY7TxrN2rAz-OAR-BXkJR_4DjxQ@mail.gmail.com> <51A74D9F.7000206@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43605 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361Ab3E3Pqf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 11:46:35 -0400
In-Reply-To: <51A74D9F.7000206@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sylvain Munaut <s.munaut@whatever-company.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 30 May 2013, Stefan Priebe - Profihost AG wrote:
> Am 30.05.2013 14:57, schrieb Sylvain Munaut:
> > Hi
> > 
> >> since commit 85fb422a084785176af3b694882964841e02195d in cuttle fish
> >> cherry-picked from 2f193fb931ed09d921e6fa5a985ab87aa4874589 ceph gets
> >> stopped on debian while upgrading but it never gets started again??
> >>
> >> Does this really makes sense?
> >>
> >> Should the admin handle the stop / start / restart on upgrade?
> > 
> > Yes, personally I think so.
> > 
> > I mean , I usually restart osd sequentially "by hand" while the
> > upgrade is usually done cluster wide by some automation but for the
> > service to stay up, the restart needs to be handled manually.
> 
> Same for me.

This was unintentional.  The goal is for the daemons to get stopped when 
the package is uninstalled, not on upgrade.  Will fix this up 
immediately.

Thanks!
sage

