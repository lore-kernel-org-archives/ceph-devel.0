From: Sage Weil <sage@newdream.net>
Subject: Re: support for multiple data placement policies
Date: Wed, 1 Sep 2010 13:28:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009011320280.9613@cobra.newdream.net>
References: <AANLkTin8GVQfPmV0d3xGThEMPYeRMKYuCR1b6Fk5XPre@mail.gmail.com>
 <AANLkTi=K3ASGMoN1DTkQu-hqMzXm43eVyb64LhEqgxRC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40710 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab0IAU16 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Sep 2010 16:27:58 -0400
In-Reply-To: <AANLkTi=K3ASGMoN1DTkQu-hqMzXm43eVyb64LhEqgxRC@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: H Chang <heracles@gmail.com>, ceph-devel@vger.kernel.org

On Wed, 1 Sep 2010, Gregory Farnum wrote:

> On Wed, Sep 1, 2010 at 11:33 AM, H Chang <heracles@gmail.com> wrote:
> > Hi Ceph team,
> >
> > I'm a newbie in Ceph, so please bear with me if my question sounds stupid.
> >
> > I'd like to explore the possibility to support multiple placement
> > policies in Ceph.

Some of the infrastructure is there for this.  Each file has a layout, 
which specifies the striping strategy and which storage pool the file data 
gets stored.  Each pool has a field specifying which CRUSH rule set to use 
(they can share).

> > For example, suppose each user using Ceph has its own placement policy
> > which may be different from one user to another.

Creating a pool for each user may be overkill, however.  The intention was 
for pools and/or crush rules to be defined for things like "fast sas 
disks", "slow sata pool", that sort of thing.  Currently everything is 
thrown in a single data pool.

Currently the default file layout is compiled in and applies to all new 
files.  There is an open bug/issue for specifying the default file layouts 
on a directory basis (e.g, everthing in /home goes into this pool, 
everything in /scratch goes in that pool).  See

	http://tracker.newdream.net/issues/185

In any case, creating per-user pools means pushing more awareness of users 
into the file system, autocreating pools, and that sort of thing.  As 
things stand, the layout policy is something an administrator has to 
set up.

> But it will require changing several pretty low-level structs and
> modifying the metadata server and both versions of the client to
> enable, so it's not a good introductory project and you shouldn't
> expect it soon. :(

...for per-user pools, at least.  Something along the lines of issue #185 
above is more doable (and on the roadmap).

sage

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
