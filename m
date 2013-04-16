From: Sage Weil <sage@inktank.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Tue, 16 Apr 2013 06:59:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304160654270.20759@cobra.newdream.net>
References: <loom.20130412T055215-88@post.gmane.org> <51683184.9010301@inktank.com> <CAJH6TXgurT4yUshaH4QOgUKOaB3DqQd1-=HPshp+eH5HB7p3Hg@mail.gmail.com> <516C7E55.1050801@inktank.com> <516C8168.40402@inktank.com>
 <CAJH6TXhRtWQ1ypEb5JOwzp9T3Nd7A=J_6Dn0M25vXjYMg8j7fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47197 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935143Ab3DPN7G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 09:59:06 -0400
In-Reply-To: <CAJH6TXhRtWQ1ypEb5JOwzp9T3Nd7A=J_6Dn0M25vXjYMg8j7fQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Kampe <mark.kampe@inktank.com>, Matthias Urlichs <matthias@urlichs.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 16 Apr 2013, Gandalf Corvotempesta wrote:
> 2013/4/16 Mark Kampe <mark.kampe@inktank.com>:
> > The entire web is richly festooned with cache servers whose
> > sole raison d'etre is to solve precisely this problem.  They
> > are so good at it that back-bone providers often find it more
> > cash-efficient to buy more cache servers than to lay more
> > fiber.  Cache servers don't merely save disk I/O, they catch
> > these requests before they reach the server (or even the
> > backbone).
> 
> Mine was just an example, there are many other cases where a frotnend
> cache is not possible.
> I think that ceph should spread reads across the whole clusters by
> default (like a big RAID-1), to archieve bandwidth improvement.
> 
> Glusters does this, and also MooseFS.
> 
> What happens in case of a big file (for example, 100MB) with multiple
> chunks? Is ceph smart enough to read multiple chunks from multiple
> servers simultaneously or the whole file will be served by just an OSD
> ?

Yes.  The readahead window grows to include a few objects to take 
advantage of parallelism for reads.

The problem with reading from random/multiple replicas by default is cache 
efficiency.  If every reader picks a random replica, then there are 
effectively N locations that may hae an object cached in RAM (instead of 
on disk), and the caches for each OSD will be about 1/Nth as effective.  
The only time in makes sense to read from replicas is when you are CPU or 
network limited; the rest of the time it is better to read from the 
primary's cache than a replica's disk.

Unfortunately at the librados level, the client doesn't generally know 
that.  The infrastructure is in place for the MDS (or librados user) to 
indicate when reads from replicas are safe, but a bit more work is needed 
to make the client code utilize that information.  It's not a difficult 
improvement, and loadiness could also be communicated back to clients on a 
per-osd session basis, but it's not implemented yet.

sage

