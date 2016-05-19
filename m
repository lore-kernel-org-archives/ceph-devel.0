From: Sage Weil <sage@newdream.net>
Subject: Re: Initial proposal for bluestore compression control and
 statistics
Date: Thu, 19 May 2016 16:52:45 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605191649270.6221@cpach.fuggernut.com>
References: <2ec0367c-ea9e-469e-4a80-b2a242c84f0f@mirantis.com> <alpine.DEB.2.11.1605191520270.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48414 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbcESUw3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 May 2016 16:52:29 -0400
In-Reply-To: <alpine.DEB.2.11.1605191520270.6221@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 19 May 2016, Sage Weil wrote:
> On Thu, 19 May 2016, Igor Fedotov wrote:
> > Hi cephers,
> > 
> > please find my initial proposal with regard to bluestore compression control
> > and related statistics.
> > 
> > Any comments/thoughts are highly appreciated.
> > 
> > ==================================================================
> > 
> > COMPRESSION CONTROL OPTIONS
> > 
> > One can see following means to control  compression at BlueStore level.
> > 
> > 1) Per-store setting to enable/disable compression and specify default
> > compression method
> > 
> > bluestore_compression = <zlib | snappy> / <force | optional | disable>
> > 
> > E.g.
> > 
> > bluestore_compression = zlib/force
> > 
> > The first token denotes default/applied compression algorithm.
> > The second one:
> > 
> > 'force' - enables compression for any objects
> > 
> > 'optional' - burden the caller with the need to enable compression by
> > different means (see below)
> > 
> > 'disable' - unconditionally disables any compression for the store.
> > 
> > This option is definitely useful for testing/debugging and has probably
> > limited use in production.
> 
> Do we need the 'disable' option?  i.e., is there any difference between
> 
>  bluestore compression = snappy/disable
> 
> and
> 
>  bluestore compression =
> 
> Also, since we don't need to list multiple algorithms, we can probably 
> just simplify this to be
> 
>  bluestore compression algorithm = snappy
> 
> and then
> 
>  bluestore compression = force | optional | disable
> 
> or maybe just
> 
>  bluestore compression force = true/false
>  bluestore compression allow = true/false
> 
> with a check that prevents nonsensical (force + allow).  Right now we 
> don't have a enum config option type (although we perhaps should).
> 
> > 2) Per-object compression specification. One should be able to enable/disable
> > compression for specific object.
> > 
> > Following sub-option can be provided:
> > 
> >   a) Specify compression mode (along with disablement option) at object
> > creation
> > 
> >   b) Specify compression mode at arbitrary moment via specific method/ioctl
> > call. Compression to be applied for subsequent write requests
> > 
> >   c) Force object compression/decompression at arbitrary moment via specific
> > method/ioctl call. Existing object content to be compressed/decompressed and
> > appropriate mode to be set for subsequent write requests.
> > 
> >   d) Disable compression for short-lived objects if corresponding hint has
> > been provided via set_alloc_hint2 call. See PR at
> > https://github.com/ceph/ceph/pull/6208/files/306c5e148cd2f538b3b6c8c2a1a3d5f38ef8e15a#r63775941
> 
> I think a, b, and d can be address by adding two hints to the 
> set_alloc_hint2 operation:
> 
>  COMPRESSIBLE
>  INCOMPRESSBILE
> 
> The first would attempt compression if bluestore compression = allow, and 
> the second would not try even if compression = force.
> 
> Alternatively, we could have
> 
>  bluestore compression = force | aggressive | passive | disable
> 
> where aggressive would try unless INCOMPRESSIBLE and passive would not try 
> unless COMPRESSIBLE.
> 
> I would make the SHORTLIVED inference an independent heuristic that is 
> optional, and basically makes SHORTLIVED => INCOMPRESSIBLE and LONGLIVED 
> => COMPRESSIBLE.

One other thought: might we want to take LONGLIVED + IMMUTABLE or 
APPEND_ONLY to mean we should use a different, more space-efficient codec?  
While using some fast and cheap (e.g., snappy) for everything else?

Maybe an additional option

 bluestore compression longlived algorithm = zlib

to go along with bluestore_compression_algorithm...

sage
