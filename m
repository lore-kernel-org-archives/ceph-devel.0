From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: RADOS translator for GlusterFS
Date: Mon, 5 May 2014 17:37:22 +0200
Message-ID: <5367B032.9030901@cern.ch>
References: <355696287.706122.1399303290204.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:8430 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865AbaEEPhH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 May 2014 11:37:07 -0400
In-Reply-To: <355696287.706122.1399303290204.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Darcy <jdarcy@redhat.com>, ceph-devel@vger.kernel.org
Cc: gluster-devel@gluster.org

Hi,

On 05/05/14 17:21, Jeff Darcy wrote:
> Now that we're all one big happy family, I've been mulling over
> different ways that the two technology stacks could work together.  One
> idea would be to use some of the GlusterFS upper layers for their
> interface and integration possibilities, but then falling down to RADOS
> instead of GlusterFS's own distribution and replication.  I must
> emphasize that I don't necessarily think this is The Right Way for
> anything real, but I think it's an important experiment just to see what
> the problems are and how well it performs.  So here's what I'm thinking.
>
> For the Ceph folks, I'll describe just a tiny bit of how GlusterFS
> works.  The core concept in GlusterFS is a "translator" which accepts
> file system requests and generates file system requests in exactly the
> same form.  This allows them to be stacked in arbitrary orders, moved
> back and forth across the server/client divide, etc.  There are several
> broad classes of translators:
>
> * Some, such as FUSE or GFAPI, inject new requests into the translator
>    stack.
>
> * Some, such as "posix", satisfy requests by calling a server-local FS.
>
> * The "client" and "server" translators together get requests from one
>    machine to another.
>
> * Some translators *route* requests (one in to one of several out).
>
> * Some translators *fan out* requests (one in to all of several out).
>
> * Most are one in, one out, to add e.g. locks or caching etc.
>
> Of particular interest here are the DHT (routing/distribution) and AFR
> (fan-out/replication) translators, which mirror functionality in RADOS.
> My idea is to cut out everything from these on below, in favor of a
> translator based on librados instead.  How this works is pretty obvious
> for file data - just read and write to RADOS objects instead of to
> files.  It's a bit less obvious for metadata, especially directory
> entries.  One really simple idea is to store metadata as data, in some
> format defined by the translator itself, and have it handle the
> read/modify/write for adding/deleting entries and such.  That would be
> enough to get some basic performance tests done.  A slightly more
> sophisticated idea might be to use OSD class methods to do the
> read/modify/write, but I don't know much about that mechanism so I'm not
> sure that's even feasible.
>
> This is not something I'm going to be working on as part of my main job,
> but I'd like to get the experiment started in some of my "spare" time.
> Is there anyone else interested in collaborating, or are there any other
> obvious ideas I'm missing?

Regarding obvious ideas, FWIW, I've been testing GlusterFS volumes which 
distribute over a few VMs with locally attached RBDs. That seems to be 
usable today, and shouldn't lose data but I guess would do something bad 
while individual VM/RBDs go down.
I'm very new to gluster, but I can't think of a way to make this HA 
without either replication at the gluster level (expensive) or making 
gluster speak to RADOS directly.

Cheers, Dan

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

