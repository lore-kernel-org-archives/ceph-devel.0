From: Sage Weil <sweil@redhat.com>
Subject: Re: Metadata vs UserData caching in BlueStore
Date: Thu, 15 Dec 2016 19:12:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612151911120.10615@piezo.novalocal>
References: <1ay8egnm4o8nt6xsykro2124.1481828743103@email.android.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-355860281-1481829154=:10615"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbcLOTMf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Dec 2016 14:12:35 -0500
In-Reply-To: <1ay8egnm4o8nt6xsykro2124.1481828743103@email.android.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-355860281-1481829154=:10615
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 15 Dec 2016, Igor Fedotov wrote:
> Yeah, 0.9 is much better than 0.5.
> Another/additional option to consider might be forcing clients that need
> caching to request that explicitly. E.g. by specifying a need_cache flag for
> reads. And doesn't do it by default.

This is pretty close to what happens now.  There are 
bluestore_defautl_buffered_{read,write} options that default to true for 
read and false for write.

sage

> 
> 
> 
> 
> Sent from Samsung tablet.
> 
> 
> -------- Original message --------
> From: Sage Weil
> Date:2016/12/15 21:11 (GMT+03:00)
> To: Igor Fedotov
> Cc: Mark Nelson ,ceph-devel
> Subject: Re: Metadata vs UserData caching in BlueStore
> 
> On Thu, 15 Dec 2016, Igor Fedotov wrote:
> > On 15.12.2016 20:34, Mark Nelson wrote:
> > >
> > >
> > > On 12/15/2016 11:24 AM, Igor Fedotov wrote:
> > > > Sage et al,
> > > >
> > > > shouldn't we have bluestore_cache_metadata_ratio set to 1 by default?
> To
> > > > concentrate on metadata caching..
> > >
> > > I would contend that it should be high (we've already bumped it up, I'd
> go
> > > higher still), but isn't 1 a little excessive? Ultimately this should
> all be
> > > automatic based on heuristics imho.
> > >
> > Well, Mark - what's the use case for user data caching? It means that user
> > either retrieves just written data or reads them repeatedly or in an
> unaligned
> > manner. Or there are multiple users working with the same object.
> > Any of that is IMHO a corner case... That can be handled by using that
> ratio
> > setting if needed.
> 
> The main one is RGW.  The gateways don't do their own caching, and even
> if they did you often have several of them.  CephFS multiclient
> scenarios can exercise the cache too.
> 
> I agree, though.  How about .8 or .9?
> 
> sage
> 
> 
--8323329-355860281-1481829154=:10615--
