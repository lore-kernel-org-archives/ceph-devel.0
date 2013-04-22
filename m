From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 2/2] libceph: validate timespec conversions
Date: Mon, 22 Apr 2013 09:22:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304220922120.15710@cobra.newdream.net>
References: <2011602102.65.1366647123451.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33970 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab3DVQWu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 12:22:50 -0400
In-Reply-To: <2011602102.65.1366647123451.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

On Mon, 22 Apr 2013, Matt W. Benjamin wrote:
> I was thinking about the seconds component.

Oh, right.. that's the unix epoch(alypse) in 2038 or something?

That we should probably fix.  :)

s

> 
> ----- "Sage Weil" <sage@inktank.com> wrote:
> 
> > On Mon, 22 Apr 2013, Matt W. Benjamin wrote:
> > > 
> > > ----- "Alex Elder" <elder@inktank.com> wrote:
> > > 
> > > > A ceph timespec contains 32-bit unsigned values for its seconds
> > and
> > > > nanoseconds components.  For a standard timespec, both fields are
> > > > signed, and the seconds field is almost surely 64 bits.
> > > 
> > > Is the Ceph timespec going to change at some point?
> > 
> > I don't think so.  32-bits is enough for the billion nanoseconds in a
> > 
> > second.  And I'm not sure if the signedness is used/useful... the ceph
> > 
> > utime_t code always normalizes the ns result to be in [0, 1 billion).
> > 
> > sage
> 
> 
> -- 
> Matt Benjamin
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
> 
> http://linuxbox.com
> 
> tel.  734-761-4689 
> fax.  734-769-8938 
> cel.  734-216-5309 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
