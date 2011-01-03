From: Sage Weil <sage@newdream.net>
Subject: Re: Errors on compiling master-backport of ceph-client-standalone
Date: Mon, 3 Jan 2011 13:58:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101031356280.7281@cobra.newdream.net>
References: <AANLkTinCdTdR5Fk6EJO-C2VAnR_CiskqRX41DUp2QNjn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42555 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab1ACVwM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jan 2011 16:52:12 -0500
In-Reply-To: <AANLkTinCdTdR5Fk6EJO-C2VAnR_CiskqRX41DUp2QNjn@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 29 Dec 2010, Henry Chang wrote:
> > Sigh... this one is going to be a pain to surround with kernel version
> > #ifdefs.  The commit that needs to be conditional on the version is Al's,
> > ff8a8d20.  Any takers?
> 
> Fixed by two patches:
> 1. include version.h for kernel version checking
> https://github.com/tcloud/ceph-client-standalone/commit/c1696dc02658ae98f2d8c94f03624b18acc8a20a
> 
> 2. backport mount pre 2.6.37
> https://github.com/tcloud/ceph-client-standalone/commit/704ba2ce3aac60fbdc7d10e229f8d93ffe87389f

Thanks!  These are applied.

There are two new patches in unstable now that need backports, too :(... 
the create_workqueue cleanups from Tejun.  The backport essentially needs 
to revert the patch (keep the QUEUED/BUSY bits in place) for older 
kernels.

sage
