From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: [PATCH 2/2] libceph: validate timespec conversions
Date: Mon, 22 Apr 2013 12:12:03 -0400 (EDT)
Message-ID: <2011602102.65.1366647123451.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <alpine.DEB.2.00.1304220907140.15710@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1491 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645Ab3DVQMI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Apr 2013 12:12:08 -0400
In-Reply-To: <alpine.DEB.2.00.1304220907140.15710@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

I was thinking about the seconds component.

----- "Sage Weil" <sage@inktank.com> wrote:

> On Mon, 22 Apr 2013, Matt W. Benjamin wrote:
> > 
> > ----- "Alex Elder" <elder@inktank.com> wrote:
> > 
> > > A ceph timespec contains 32-bit unsigned values for its seconds
> and
> > > nanoseconds components.  For a standard timespec, both fields are
> > > signed, and the seconds field is almost surely 64 bits.
> > 
> > Is the Ceph timespec going to change at some point?
> 
> I don't think so.  32-bits is enough for the billion nanoseconds in a
> 
> second.  And I'm not sure if the signedness is used/useful... the ceph
> 
> utime_t code always normalizes the ns result to be in [0, 1 billion).
> 
> sage


-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
