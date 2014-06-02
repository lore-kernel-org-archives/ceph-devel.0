From: Sage Weil <sage@inktank.com>
Subject: Re: Librbd licensing
Date: Mon, 2 Jun 2014 10:22:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406021021080.19902@cobra.newdream.net>
References: <loom.20140530T192820-478@post.gmane.org> <alpine.DEB.2.00.1405301042200.11044@cobra.newdream.net> <CADXiVcpM8GJcCbDkdOPWzXPoJrDdyiQn0-q4nDH6o0zpg_u8gg@mail.gmail.com> <538CAE14.4060602@dachary.org>
 <CADXiVcrSf4WgMUJ1d6FRSFqUOEeeGVDTTw5VvY6gSdDsQObJZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35968 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbaFBRWy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jun 2014 13:22:54 -0400
In-Reply-To: <CADXiVcrSf4WgMUJ1d6FRSFqUOEeeGVDTTw5VvY6gSdDsQObJZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steve Taylor <steveftaylor@gmail.com>, josh.durgin@inktank.com
Cc: Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>

Ideally the change comes from Josh, who originally put the notice there, 
but I think it shouldn't matter.  We relicensed rbd.cc as LGPL2 a while 
back (it was GPL due to a header we used?) and got confirmations from all 
authors.  It might be worth doing a quick check to make sure there aren't 
committers for the affected headers that we didn't contact earlier.

For reference, the license change commit is 
2206f55761c675b31078dea4e7dd66f2666d7d03.

sage


On Mon, 2 Jun 2014, Steve Taylor wrote:

> Fair enough. Thanks for clearing it up. Is this something anyone cares
> to fix? I'm personally happy to accept it as is with this email chain
> as reference, but I will also be happy to add the "Lesser" and submit
> a pull request if you want it. I'm not big on changing other peoples'
> copyright headers unless they ask for it though. :-)
> 
> Steve
> 
> On Mon, Jun 2, 2014 at 11:02 AM, Loic Dachary <loic@dachary.org> wrote:
> > Hi,
> >
> > The missing "Lesser" is a nice typo :-) There has never been a GPLv2.1 ( https://en.wikipedia.org/wiki/GNU_General_Public_License#Version_2 ) and I guess it helps disambiguate the interpretation.
> >
> > Cheers
> >
> > On 02/06/2014 18:15, Steve Taylor wrote:
> >> Sorry, my previous reply was rejected by the list because it wasn't in
> >> plain text. Let's try again.
> >>
> >> librbd.cc:
> >> /*
> >>  * Ceph - scalable distributed file system
> >>  *
> >>  * Copyright (C) 2011 New Dream Network
> >>  *
> >>  * This is free software; you can redistribute it and/or
> >>  * modify it under the terms of the GNU General Public
> >>  * License version 2.1, as published by the Free Software
> >>  * Foundation.  See file COPYING.
> >>  *
> >>  */
> >>
> >> librbd.h:
> >> /*
> >>  * Ceph - scalable distributed file system
> >>  *
> >>  * Copyright (C) 2011 New Dream Network
> >>  *
> >>  * This is free software; you can redistribute it and/or
> >>  * modify it under the terms of the GNU General Public
> >>  * License version 2.1, as published by the Free Software
> >>  * Foundation.  See file COPYING.
> >>  *
> >>  */
> >>
> >> librbd.hpp:
> >> /*
> >>  * Ceph - scalable distributed file system
> >>  *
> >>  * Copyright (C) 2011 New Dream Network
> >>  *
> >>  * This is free software; you can redistribute it and/or
> >>  * modify it under the terms of the GNU General Public
> >>  * License version 2.1, as published by the Free Software
> >>  * Foundation.  See file COPYING.
> >>  *
> >>  */
> >>
> >> These are the three that I've noticed poking around librbd so far. My
> >> understanding from COPYING is that they should be LGPL, but these
> >> copyright headers obviously state GPL instead. I'm just trying to
> >> understand definitely which it is. :)
> >>
> >> If a change is in order, of course I'll be happy to make the change
> >> myself and submit a pull request if you like.
> >>
> >> Steve
> >>
> >> On Fri, May 30, 2014 at 11:43 AM, Sage Weil <sage@inktank.com> wrote:
> >>> Hi Steve,
> >>>
> >>> On Fri, 30 May 2014, Steve Taylor wrote:
> >>>> I am working with a company that wants to utilize librbd in a project to
> >>>> interact with Ceph storage. For the purposes of this integration,
> >>>> LGPL-licensed open source code is acceptable, but GPL-licensed code is not.
> >>>> Well, at least not without other changes to the project, which can be
> >>>> accomplished if necessary.
> >>>>
> >>>> The COPYING file distributed with the Ceph source code seems to indicate
> >>>> that librbd would fall under LGPL 2.1, but some of the source files in
> >>>> librbd reference GPL 2.1 in their copyright headers.
> >>>
> >>> Which files?  If there are disparities we should correct them. To the best
> >>> of my knowledge everything in librbd is LGPL.
> >>>
> >>> Thanks!
> >>> sage
> >>>
> >>>
> >>>>
> >>>> >From what I have found so far, it appears to me that the sources in
> >>>> question were probably originally LGPL, but were switched to GPL a few
> >>>> years back to comply with FUSE licensing, which is GPL. Is my understanding
> >>>> correct that these librbd source files are now GPL? If so and FUSE is the
> >>>> reason behind it, is it possible to dual-license those files so they could
> >>>> be LGPL when not used with FUSE?
> >>>>
> >>>> I just want to make sure I understand the licensing properly. I apologize
> >>>> if this has been discussed previously. I am new to the list and can't seem
> >>>> to get the archive search feature to work.
> >>>>
> >>>> Steve
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>
> >>>>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> > --
> > Lo?c Dachary, Artisan Logiciel Libre
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
