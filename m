From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 2/2] libceph: validate timespec conversions
Date: Mon, 22 Apr 2013 09:08:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304220907140.15710@cobra.newdream.net>
References: <221013945.45.1366642844097.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33770 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab3DVQId (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 12:08:33 -0400
In-Reply-To: <221013945.45.1366642844097.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

On Mon, 22 Apr 2013, Matt W. Benjamin wrote:
> 
> ----- "Alex Elder" <elder@inktank.com> wrote:
> 
> > A ceph timespec contains 32-bit unsigned values for its seconds and
> > nanoseconds components.  For a standard timespec, both fields are
> > signed, and the seconds field is almost surely 64 bits.
> 
> Is the Ceph timespec going to change at some point?

I don't think so.  32-bits is enough for the billion nanoseconds in a 
second.  And I'm not sure if the signedness is used/useful... the ceph 
utime_t code always normalizes the ns result to be in [0, 1 billion).

sage

> 
> > 
> > Add some explicit casts so the fact that this conversion is taking
> > place is obvious.  Also trip a bug if we ever try to put out of
> > range (negative or too big) values into a ceph timespec.
> > 
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
