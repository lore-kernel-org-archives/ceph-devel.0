From: Sage Weil <sage@newdream.net>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Thu, 15 Jan 2015 09:24:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net>
References: <54B7D2D6.4020503@42on.com> <CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45825 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132AbbAORYV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 12:24:21 -0500
In-Reply-To: <CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 15 Jan 2015, Yehuda Sadeh wrote:
> On Thu, Jan 15, 2015 at 6:46 AM, Wido den Hollander <wido@42on.com> wrote:
> > Hi,
> >
> > Although the userland tools like 'ceph' and 'rados' have a safeguard
> > against fat fingers when it comes to removing a pool there is no such
> > safeguard when using native librados.
> >
> > The danger still exists that by accident you remove a pool which is then
> > completely gone, no way to restore it.
> >
> > This is still something I find quite dangerous, so I was thinking about
> > a additional 'Immutable bit' which could be set on a pool before
> > rados_pool_delete() allows this pool to be removed.
> >
> > Is it a sane thing to look at 'features' which pools could have? Other
> > features which might be set on a pool:
> >
> > - Read Only (all write operations return -EPERM)
> > - Delete Protected
> >
> > It's just that looking at a 20TB RBD pool and thinking that just one API
> > call could remove this pool make me a bit scared.
> >
> > Am I the only one or is this something worth looking in to?
> 
> I completely agree. A while back I opened an issue for that, #9792,
> with some suggestions:
> 
> - require a special key for this command

The original version of the --yes-i-really-really-mean-it patch actually 
did something like this, but it was complicated and a huge pain to script 
all of the tests so we went with the simpler path (specify pool name twice 
and a scary option).

> - pool removal doesn't apply immediately, but rather first switches
> pool to 'pending removal'
> - pending removal state reflected in the cluster status
> - operation can be cancelled when pending

This amounts of a two stage process, which I think makes a lot of sense.  
I see two reasonably simple options:

1) Add a 'nodelete' pool flag, so that you have to do

 ceph osd pool set foo nodelete false
 ceph osd pool delete foo foo --yes-i-swear-i-etc

Then the question is whether we implicitly set this flag on all existing 
pools.. meh.  But we won't break any current users of the API that create 
and destroy pools.

2) Add a 'allow-delete' flag as Yehuda suggests, so you have

 ceph osd pool set foo allow-delete true
 ceph osd pool delete foo ...

Then secondary question is whether the cluster should implicitly clear the 
allow-delete after some time period (maybe 'pending-delete' would make 
more sense in that case), or whether we deny IO during that period.  Seems 
perhaps too complicated.

The downside here is that there will be huge patchset that fixes all the
tests to do this.  Probably worth it though if it avoids a very bad day 
for some poor admin...

sage

