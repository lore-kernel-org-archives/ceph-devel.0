From: Sage Weil <sage@newdream.net>
Subject: Re: deep-scrub and .rgw.index pool
Date: Thu, 11 Feb 2016 08:35:43 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602110832310.28396@cpach.fuggernut.com>
References: <CADr68WaQW0-MY60qyN-B8bRufJ1odG7GZ9DL5q7pGtzLQFfBrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54214 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbcBKNfY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Feb 2016 08:35:24 -0500
In-Reply-To: <CADr68WaQW0-MY60qyN-B8bRufJ1odG7GZ9DL5q7pGtzLQFfBrg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jens Rosenboom <j.rosenboom@x-ion.de>
Cc: Ceph <ceph-devel@vger.kernel.org>

On Thu, 11 Feb 2016, Jens Rosenboom wrote:
> Does the digest of an object also include its metadata? Or is possibly
> deep-scrubbing a pool full of objects of size 0 completely pointless?

It includes the omap (key/value) data stored in an object, which isn't 
reflected in the object size.
 
> I'm asking because we are seeing lot of blocked requests during
> deep-scrubs for one particular PG in our index pool for a cluster
> containing around 200M objects. The scrub also takes a couple of
> minutes instead of a couple of seconds that we see for all the other
> PGs in that pool, but I haven't yet found out what makes this
> particular PG so special.

You probably have a large RGW bucket whose index object happens to live in 
that PG.  The scrub iterates over its keys and values to compare 
checksums, which can take a while.

There's a bucket sharding capability that should be used when you know a 
bucket will grow very large.  Big index objects can cause other annoying 
behavior besides just scrub.  For example, recovery can be very slow and 
block index operations if one of the replicas drops out of the PG and 
needs to be brought back in sync.

Unfortunately there's no [automatic] resharding capability yet in RGW... 
that will need to be tackled sooner or later (hopefully sooner!).

sage
