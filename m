From: Mykola Golub <to.my.trociny@gmail.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Mon, 19 Jan 2015 21:32:23 +0200
Message-ID: <20150119193217.GA2175@gmail.com>
References: <54B7D2D6.4020503@42on.com>
 <CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com>
 <alpine.DEB.2.00.1501150918110.26676@cobra.newdream.net>
 <101AEAEE-F428-4425-87CE-A20B3030FF55@enovance.com>
 <54B8EE3B.70506@42on.com>
 <alpine.DEB.2.00.1501160643370.8527@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:53614 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbbASTc1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jan 2015 14:32:27 -0500
Received: by mail-lb0-f178.google.com with SMTP id u14so29827471lbd.9
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jan 2015 11:32:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1501160643370.8527@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Wido den Hollander <wido@42on.com>, Sebastien Han <sebastien.han@enovance.com>, Yehuda Sadeh <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jan 16, 2015 at 06:46:31AM -0800, Sage Weil wrote:
> On Fri, 16 Jan 2015, Wido den Hollander wrote:
> >
> > Something like that per pool seems better to me as well. But I'd then
> > opt for a 'feature' which can be set on a pool.
> > 
> > ceph osd pool set foo nodelete
> > ceph osd pool set foo nopgchange
> > ceph osd pool set foo nosizechange
> 
> I like this since it fits into the current flags nicely.  The downside is 
> we don't grandfather existing pools on upgrade.  Not sure if people think 
> that's a good idea.
> 
> > > The good thing with that is that owners of the pool (or admin), will be able to set this flag or remove it.
> > > We stick with the "ceph osd pool delete foo foo ?yes?.? command as well, so we don?t change too much things.
> > > 
> > > Moreover we can also make use of a config option to protect all new created pools by default:
> > > 
> > > mon protect pool default = true
> > > 
> > > This automatically set the protected flag to a new pool.
> > > 
> > > What do you think?
> > > 
> > 
> > Setting a nodelete flag or something like that by default is fine with
> > me. Like Sage mentioned earlier, almost nobody will have ephemeral pools
> > in their cluster. You don't want to loose data because you accidentally
> > removed a pool.
> 
> We should mirror this option:
> 
> OPTION(osd_pool_default_flag_hashpspool, OPT_BOOL, true)   // use new pg 
> hashing to prevent pool/pg overlap
> 
> So,
> 
> osd_pool_default_flag_nodelete = true
> osd_pool_default_flag_nopgchange = true
> osd_pool_default_flag_nosizechange = true
> 
> The big question for me is should we enable these by default in hammer?

Please see https://github.com/ceph/ceph/pull/3409

I have not enabled any by default.

Also, I have not mirrored CEPH_FEATURE_OSDHASHPSPOOL, should I?

-- 
Mykola Golub
