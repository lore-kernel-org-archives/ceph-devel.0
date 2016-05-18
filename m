From: Jianjian Huo <jianjian.huo@samsung.com>
Subject: RE: Cache Layer on NVME driver
Date: Wed, 18 May 2016 23:50:26 +0000
Message-ID: <3F3468645DC82146857A5E1C91E23F4B1B2A2780@SSIEXCH-MB3.ssi.samsung.com>
References: <CAFjGuFRBqX8CibKVA=Uu7J0cO3DXsLrA1_FVP_LBriKTLgQr3g@mail.gmail.com>
 <CACJqLyYGwhymjaVSoAGArPmPzFBmUHRrjGAtiQXKr6gEv_ZsSw@mail.gmail.com>
 <CACJqLyab+rX4e2eu3oaC-DdX-OCaBCWiM_tt79KV8Dr6ZRfL4w@mail.gmail.com>
 <alpine.DEB.2.11.1605181311080.30956@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailout1.w2.samsung.com ([211.189.100.11]:26181 "EHLO
	usmailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcESAAc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2016 20:00:32 -0400
Received: from uscpsbgex4.samsung.com
 (u125.gpu85.samsung.co.kr [203.254.195.125]) by mailout1.w2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O7E007TNCW3V650@mailout1.w2.samsung.com> for
 ceph-devel@vger.kernel.org; Wed, 18 May 2016 19:50:28 -0400 (EDT)
In-reply-to: <alpine.DEB.2.11.1605181311080.30956@cpach.fuggernut.com>
Content-language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Haomai Wang <haomai@xsky.com>
Cc: Rajath Shashidhara <rajath.shashidhara@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, May 18, 2016 at 10:19 AM, Sage Weil <sage@newdream.net> wrote:
>
> Hi Rajath!
>
> Great to hear you're interested in working with us outside of GSoC!
>
> On Wed, 18 May 2016, Haomai Wang wrote:
> > Hi Rajath,
> >
> > We are glad to see your passion, from my view, sage is planning to
> > implement a userspace cache in bluestore itself. Like
> > (https://github.com/ceph/ceph/commit/b9ac31afe5a162176f019baa25348014a77f6ab8#commitcomment-17488250).
> >
> > I guess the cache won't be a generic cache interface. Instead it will
> > be bound to specified needed object. So sage may give a brief?
>
> Part of the reason why this project wasn't at the top of our list (we got
> fewer slots than we had projects) was because the BlueStore code is in
> flux and moving quite quickly.  For the BlueStore side, we are building a
> simple buffer cache that is tied to an Onode (in-memory per-object
> metadata structure) and integrated tightly with the read and write IO
> paths.  This will eliminate our use of the block device buffer cache for
> user/object data.
>
> The other half of the picture, though, is the BlueFS layer that is
> consumed by rocksdb: it also needs caching in order for rocksdb to perform
> at all.  My hope is that the code we write for the use data can be re-used
> here as well, but it is still evolving.

When Bluestore moves away from kernel cache to its own buffer cache, RocksDB can use its own buffer cache as well. 
RocksDB has this size configurable block cache to cache uncompressed data blocks, it can serve as buffer cache, 
since Bluestore don't compress meta data in RocksDB.

Jianjian
>
> The main missing piece I'd say is a way to string Buffer objects together
> in a global(ish) LRU (or set of LRUs, or whatever we need for the caching
> policy that makes sense) so that trimming can be done safely and
> efficiently.  Right now the code is lock-free because each Onode is only
> touched under the collection rwlock, but in order to do trimming we need
> to be able to reap cold buffers from a global context.
>
> Anyway, there is no clear or ready answer here yet, but we are ready to
> discuss design/approach here on the list, and welcome your input (and
> potentially, contributions to development!).
>
> sage
>
>
> >
> > On Wed, May 18, 2016 at 9:32 PM, Haomai Wang <haomai@xsky.com> wrote:
> > >
> > >
> > > On Wed, May 18, 2016 at 2:44 PM, Rajath Shashidhara
> > > <rajath.shashidhara@gmail.com> wrote:
> > >>
> > >> Hello,
> > >>
> > >> I was a GSoC'16 applicant for the project "Implementing Cache layer on
> > >> top of NVME Driver". Unfortunately, I was not selected for the
> > >> internship.
> > >
> > >
> > > Hi Rajath,
> > >
> > > We are glad to see your passion, from my view, sage is planning to implement
> > > a userspace cache in bluestore itself. Like
> > > (https://github.com/ceph/ceph/commit/b9ac31afe5a162176f019baa25348014a77f6ab8#commitcomment-17488250).
> > >
> > > I guess the cache won't be a generic cache interface. Instead it will be
> > > bound to specified needed object. So sage may give a brief?
> > >
> > >>
> > >>
> > >> However, I would be interested in working on the project as an
> > >> independent contributor to Ceph.
> > >> I am expecting to receive the necessary support from Ceph developer
> > >> community.
> > >>
> > >> In case I missed out any important details in my project proposal or I
> > >> have the wrong understanding of the project, please help me figure out
> > >> the details.
> > >>
> > >> Looking forward to contribute!
> > >>
> > >> Thank you,
> > >> Rajath Shashidhara
> > >
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
