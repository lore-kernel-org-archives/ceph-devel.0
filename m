From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Make libcephfs return error when unmounted?
Date: Wed, 11 Apr 2012 15:43:34 -0700
Message-ID: <DC088163E5B34011990FE53B1D45EBC0@dreamhost.com>
References: <71CC6D8F-361D-4C00-AED1-C0C928CDAB9F@cs.ucsc.edu>
 <CAC-hyiGhR-ayeffsT6ZTAS4aozr_Ub_YJQN8L5Hs9zM3zWBS5g@mail.gmail.com>
 <20E3E083-D1C5-4D86-9709-95515538C1BA@cs.ucsc.edu>
 <CE79CB0202FC4C04ACB4EBAC3A0C1232@dreamhost.com>
 <CAC-hyiF=AHeLjF8kOj9rW-G3bU_8oQWjGZdFa6y=CbtUi7yf4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51627 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab2DKWng (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 18:43:36 -0400
Received: by mail-ob0-f174.google.com with SMTP id tb18so1828393obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Apr 2012 15:43:36 -0700 (PDT)
In-Reply-To: <CAC-hyiF=AHeLjF8kOj9rW-G3bU_8oQWjGZdFa6y=CbtUi7yf4Q@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel@vger.kernel.org



On Wednesday, April 11, 2012 at 3:34 PM, Yehuda Sadeh Weinraub wrote:

> On Wed, Apr 11, 2012 at 3:13 PM, Greg Farnum
> <gregory.farnum@dreamhost.com (mailto:gregory.farnum@dreamhost.com)> wrote:
> > On Wednesday, April 11, 2012 at 2:59 PM, Noah Watkins wrote:
> > > 
> > > On Apr 11, 2012, at 11:22 AM, Yehuda Sadeh Weinraub wrote:
> > > 
> > > > Also need to check that cmount is initialized. I'd add a helper:
> > > > 
> > > > Client *ceph_get_client(struct ceph_mount_info *cmont)
> > > > {
> > > > if (cmount && cmount->is_mounted())
> > > > return cmount->get_client();
> > > > 
> > > > return NULL;
> > > > }
> > > 
> > > 
> > > 
> > > 
> > > 
> > > How useful is checking cmount != NULL here? This defensive check depends on users initializing their cmount pointers to NULL, but the API doesn't do anything to require this initialization assumption.
> > > 
> > > - Noah
> > I had a whole email going until I realized you were just right. So, yeah, that wouldn't do anything since a cmount they forgot to have the API initialize is just going to hold random data. Urgh.
> 
> 
> 
> There's no destructor either, maybe it's a good time to add one?
> 
> Yehuda 
Actually, there is. The problem is that to the client it's an opaque pointer under many(most?) circumstances, so that it can be used by C users. 
-Greg

