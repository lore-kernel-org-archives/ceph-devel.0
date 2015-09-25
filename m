From: Sage Weil <sweil@redhat.com>
Subject: Re: Pool setting for recovery priority
Date: Fri, 25 Sep 2015 07:09:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509250708531.13265@cobra.newdream.net>
References: <BLU175-W30B038F9EE84A31BF7D842DF5B0@phx.gbl> <alpine.DEB.2.00.1509160920120.14342@cobra.newdream.net> <20150921133218.GB23240@gmail.com> <20150925114440.GA30636@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-405161035-1443190196=:13265"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51926 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756266AbbIYOJ5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 25 Sep 2015 10:09:57 -0400
In-Reply-To: <20150925114440.GA30636@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: GuangYang <yguang11@outlook.com>, "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, David Zafman <dzafman@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-405161035-1443190196=:13265
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT

Hi Mykola,

On Fri, 25 Sep 2015, Mykola Golub wrote:
> Hi,
> 
> On Mon, Sep 21, 2015 at 04:32:19PM +0300, Mykola Golub wrote:
> > On Wed, Sep 16, 2015 at 09:23:07AM -0700, Sage Weil wrote:
> > > On Wed, 16 Sep 2015, GuangYang wrote:
> > > > Hi Sam,
> > > > As part of the effort to solve problems similar to issue #13104 (http://tracker.ceph.com/issues/13104), do you think it is appropriate to add some parameters to pool setting:
> > > > š š1. recovery priority of the pool - we have a customized pool recovery priority (like process's nice value) to favor some pools over others. For example, the bucket index pool is usually much much smaller but important to recover first (e.g. might affect write latency as like issue #13104).
> > > > š š2. pool level recovery op priority - currently we have a low priority for recovery op (by default it is 10 while client io's priority is 63), is it possible to have a pool setting to customized the priority on pool level.
> > > > 
> > > > The purpose is to give some flexibility in terms of favor some pools over others when doing recovery, in our case using radosgw, we would like to favor bucket index pool as that is on the write path for all requests.
> > > 
> > > I think this makes sense, and is analogous to
> > > 
> > > 	https://github.com/ceph/ceph/pull/5922
> > > 
> > > which does per-pool scrub settings.  I think the only real question is 
> > > whether pg_pool_t is the right place to keep piling these parameters in, 
> > > or whether we want some unstructured key/value settings or something.
> > 
> > I aggree that adding a bunch of new rarely used fields to pg_pool_t
> > might not be a very good idea. Still storing these options here looks
> > convenient (accessing, updating...). What do you think if I add
> > something like this in pg_pool_t instead?
> > 
> >   typedef boost::variant<string,int,double> pool_opt_value_t;
> >   typedef std::map<pool_opt_key_t,pool_opt_value_t> opts_t;
> >   opts_t opts;
> > 
> > (in reality I suppose it will be more compicated but will have
> > something like this in base).
> > 
> > Usually opts will be empty or have only one or two settings, so it
> > will not consume much space.
> 
> What do you think about this implementation, which adds a dictionary
> for pool options to pg_pool_t?
> 
> https://github.com/ceph/ceph/pull/6081
> 
> Although #5922 has already been merged to master, I think it is still
> not late to change scrub intervals to be stored in options?

Yeah, I agree that something along these lines is better.  It's too late 
to add this to infernalis, though.. I think we should revert the scrub 
interval options and then use the dictionary (post-infernalis).

How does that sound?
sage


> 
> > 
> > Or where do you suggest to store them instead?
> > 
> > BTW, I see we already have in pg_pool_t:
> > 
> >   map<string,string> properties;  ///< OBSOLETE
> > 
> > I wonder what it was supposed to be used for and why it is marked
> > obsolete?
> > 
> > -- 
> > Mykola Golub
> 
> -- 
> Mykola Golub
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--557981400-405161035-1443190196=:13265--
