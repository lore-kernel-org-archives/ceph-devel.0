From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Question about librados
Date: Mon, 4 Apr 2011 09:09:19 -0700
Message-ID: <BANLkTi=-9ESbE5uaMZYBH2X9Q5y-gPtW7w@mail.gmail.com>
References: <incab7$gnn$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52101 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1DDQJV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2011 12:09:21 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6922AC066
	for <ceph-devel@vger.kernel.org>; Mon,  4 Apr 2011 09:09:21 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 189B6C063
	for <ceph-devel@vger.kernel.org>; Mon,  4 Apr 2011 09:09:20 -0700 (PDT)
Received: by ewy4 with SMTP id 4so1763732ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Apr 2011 09:09:19 -0700 (PDT)
In-Reply-To: <incab7$gnn$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Apr 4, 2011 at 4:33 AM, Rutger ter Borg <rutger@terborg.net> wrote:
>
> Hello,
>
> I'm in the progress of evaluating librados as an object store. I'm using
> Debian's latest packages as of today, and noted that I need to define
> NO_ATOMIC_OPS to get something compiled that includes librados.hpp.
Hmmm, that's not right! Can you elaborate? It just doesn't build
librados.hpp unless you define NO_ATOMIC_OPS? Is there a build error
at some point?

> My actual question: is there a requirement/optimum on the relation between
> number of objects and number of pools? Or may this be chosen to be something
> completely arbitrary?
There's no optimal relationship at all between the number of objects
and the number of pools.Pools are logical groupings that have very
little impact on performance.
Placement groups are rather more important to performance, but again
the number of objects/PG isn't terribly significant as long as
#objects >> #PGs (for optimal performance you want ~100 PGs/OSD, but
this number can vary significantly before it becomes a problem).

> I.e., is it a problem to have a couple of hundred
> IoCtxs active in one process?
Not at all!

> What is a reasonable/performance-wise-good object-size?
Hmm, that depends on your specific hardware configuration. Ceph itself
uses 4MB objects by default. In general the size of objects can vary a
great deal without issue. There may still be some issues with very
large objects (where object size is in the same order of magnitude as
the OSD's RAM) but I think these have all been dealt with.
In general the thing to be aware of is that objects are the atomic
unit as far as librados and CRUSH are concerned -- placement within
the cluster is pseudo-random by object, but if the size of your
objects varies dramatically then the disk utilization can vary a lot
without RADOS becoming aware of it. (There are mechanisms to deal with
overloaded OSDs so it's not a dealbreaker, just something to be aware
of.) Also, recovery and rebalancing and such, while logically handled
by placement group, are largely dependent on the objects -- so if you
have very large objects you may get strange behavior during recovery
since the throttling and such are designed for objects in the
several-MB range.
-Greg
