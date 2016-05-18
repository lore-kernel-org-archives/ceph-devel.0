From: Sage Weil <sage@newdream.net>
Subject: Re: Cache Layer on NVME driver
Date: Wed, 18 May 2016 13:19:34 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605181311080.30956@cpach.fuggernut.com>
References: <CAFjGuFRBqX8CibKVA=Uu7J0cO3DXsLrA1_FVP_LBriKTLgQr3g@mail.gmail.com> <CACJqLyYGwhymjaVSoAGArPmPzFBmUHRrjGAtiQXKr6gEv_ZsSw@mail.gmail.com> <CACJqLyab+rX4e2eu3oaC-DdX-OCaBCWiM_tt79KV8Dr6ZRfL4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39967 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbcERRTS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2016 13:19:18 -0400
In-Reply-To: <CACJqLyab+rX4e2eu3oaC-DdX-OCaBCWiM_tt79KV8Dr6ZRfL4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Rajath Shashidhara <rajath.shashidhara@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Rajath!

Great to hear you're interested in working with us outside of GSoC!

On Wed, 18 May 2016, Haomai Wang wrote:
> Hi Rajath,
> 
> We are glad to see your passion, from my view, sage is planning to
> implement a userspace cache in bluestore itself. Like
> (https://github.com/ceph/ceph/commit/b9ac31afe5a162176f019baa25348014a77f6ab8#commitcomment-17488250).
> 
> I guess the cache won't be a generic cache interface. Instead it will
> be bound to specified needed object. So sage may give a brief?

Part of the reason why this project wasn't at the top of our list (we got 
fewer slots than we had projects) was because the BlueStore code is in 
flux and moving quite quickly.  For the BlueStore side, we are building a 
simple buffer cache that is tied to an Onode (in-memory per-object 
metadata structure) and integrated tightly with the read and write IO
paths.  This will eliminate our use of the block device buffer cache for 
user/object data.

The other half of the picture, though, is the BlueFS layer that is 
consumed by rocksdb: it also needs caching in order for rocksdb to perform 
at all.  My hope is that the code we write for the use data can be re-used 
here as well, but it is still evolving.

The main missing piece I'd say is a way to string Buffer objects together 
in a global(ish) LRU (or set of LRUs, or whatever we need for the caching 
policy that makes sense) so that trimming can be done safely and 
efficiently.  Right now the code is lock-free because each Onode is only 
touched under the collection rwlock, but in order to do trimming we need 
to be able to reap cold buffers from a global context.

Anyway, there is no clear or ready answer here yet, but we are ready to 
discuss design/approach here on the list, and welcome your input (and 
potentially, contributions to development!).

sage


> 
> On Wed, May 18, 2016 at 9:32 PM, Haomai Wang <haomai@xsky.com> wrote:
> >
> >
> > On Wed, May 18, 2016 at 2:44 PM, Rajath Shashidhara
> > <rajath.shashidhara@gmail.com> wrote:
> >>
> >> Hello,
> >>
> >> I was a GSoC'16 applicant for the project "Implementing Cache layer on
> >> top of NVME Driver". Unfortunately, I was not selected for the
> >> internship.
> >
> >
> > Hi Rajath,
> >
> > We are glad to see your passion, from my view, sage is planning to implement
> > a userspace cache in bluestore itself. Like
> > (https://github.com/ceph/ceph/commit/b9ac31afe5a162176f019baa25348014a77f6ab8#commitcomment-17488250).
> >
> > I guess the cache won't be a generic cache interface. Instead it will be
> > bound to specified needed object. So sage may give a brief?
> >
> >>
> >>
> >> However, I would be interested in working on the project as an
> >> independent contributor to Ceph.
> >> I am expecting to receive the necessary support from Ceph developer
> >> community.
> >>
> >> In case I missed out any important details in my project proposal or I
> >> have the wrong understanding of the project, please help me figure out
> >> the details.
> >>
> >> Looking forward to contribute!
> >>
> >> Thank you,
> >> Rajath Shashidhara
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
