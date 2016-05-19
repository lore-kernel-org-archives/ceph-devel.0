From: Sage Weil <sage@newdream.net>
Subject: RE: Cache Layer on NVME driver
Date: Thu, 19 May 2016 02:43:07 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605190242200.30956@cpach.fuggernut.com>
References: <CAFjGuFRBqX8CibKVA=Uu7J0cO3DXsLrA1_FVP_LBriKTLgQr3g@mail.gmail.com> <CACJqLyYGwhymjaVSoAGArPmPzFBmUHRrjGAtiQXKr6gEv_ZsSw@mail.gmail.com> <CACJqLyab+rX4e2eu3oaC-DdX-OCaBCWiM_tt79KV8Dr6ZRfL4w@mail.gmail.com> <alpine.DEB.2.11.1605181311080.30956@cpach.fuggernut.com>
 <3F3468645DC82146857A5E1C91E23F4B1B2A2780@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43726 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbcESGmv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 02:42:51 -0400
In-Reply-To: <3F3468645DC82146857A5E1C91E23F4B1B2A2780@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jianjian Huo <jianjian.huo@samsung.com>
Cc: Haomai Wang <haomai@xsky.com>, Rajath Shashidhara <rajath.shashidhara@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 18 May 2016, Jianjian Huo wrote:
> On Wed, May 18, 2016 at 10:19 AM, Sage Weil <sage@newdream.net> wrote:
> >
> > Hi Rajath!
> >
> > Great to hear you're interested in working with us outside of GSoC!
> >
> > On Wed, 18 May 2016, Haomai Wang wrote:
> > > Hi Rajath,
> > >
> > > We are glad to see your passion, from my view, sage is planning to
> > > implement a userspace cache in bluestore itself. Like
> > > (https://github.com/ceph/ceph/commit/b9ac31afe5a162176f019baa25348014a77f6ab8#commitcomment-17488250).
> > >
> > > I guess the cache won't be a generic cache interface. Instead it will
> > > be bound to specified needed object. So sage may give a brief?
> >
> > Part of the reason why this project wasn't at the top of our list (we got
> > fewer slots than we had projects) was because the BlueStore code is in
> > flux and moving quite quickly.  For the BlueStore side, we are building a
> > simple buffer cache that is tied to an Onode (in-memory per-object
> > metadata structure) and integrated tightly with the read and write IO
> > paths.  This will eliminate our use of the block device buffer cache for
> > user/object data.
> >
> > The other half of the picture, though, is the BlueFS layer that is
> > consumed by rocksdb: it also needs caching in order for rocksdb to perform
> > at all.  My hope is that the code we write for the use data can be re-used
> > here as well, but it is still evolving.
> 
> When Bluestore moves away from kernel cache to its own buffer cache, RocksDB can use its own buffer cache as well. 
> RocksDB has this size configurable block cache to cache uncompressed data blocks, it can serve as buffer cache, 
> since Bluestore don't compress meta data in RocksDB.

What options control this?  I was having trouble finding it the last time 
I looked.  We should switch it now (and use unbuffered IO from BlueFS) if 
we can.

Thanks!
sage
