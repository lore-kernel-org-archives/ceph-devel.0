From: Sage Weil <sage@newdream.net>
Subject: Re: object class capability semantics
Date: Mon, 21 Mar 2016 15:30:58 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603211527350.23875@cpach.fuggernut.com>
References: <CAB2gnbVFypTbHREtJAb6od1bC9ZpRtCz04BHg=6Yqmi5eEtP2A@mail.gmail.com> <CAJ4mKGY4VMk+dbF59RWmY+LkvG_26d-X0xADHFpYyZqOJnkNqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45376 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415AbcCUTbT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 15:31:19 -0400
In-Reply-To: <CAJ4mKGY4VMk+dbF59RWmY+LkvG_26d-X0xADHFpYyZqOJnkNqA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Noah Watkins <noahwatkins@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sjust@redhat.com>

On Mon, 21 Mar 2016, Gregory Farnum wrote:
> On Mon, Mar 21, 2016 at 8:55 AM, Noah Watkins <noahwatkins@gmail.com> wrote:
> > # Class Execute Capabilities
> >
> > Purpose: wire up class capabilities and add an option to specify the
> > names of object classes are allowed to be used without explicit
> > capabilities.
> >
> > ## Default Object Class List
> >
> > Format: `osd class default list = * | [class[ class[ ...]]`
> >    1) * any class may be loaded
> >    2) list of class names allowed
> >
> > Interpretation of this option is described below.
> >
> > ## Enabling Class Capabilities
> >
> > It looks like currently in OSDCap::is_capable() that 'x' and class
> > read/write capabilities are checked. The first change would be to
> > cross reference these checks with the `osd class default list` to
> > ensure that the class is on the allowed list.
> 
> Woah, no way. These are capabilities, and are additive. We and our
> users are going to be very unhappy if the security meaning of one cap
> changes depending on others.

I'm not following.  The meaning changes based on the config, not another 
cap.
 
> So I take it you mean for those execute and load capabilities to be
> applied to clients, not the OSD or class methods or something? In that
> case we can just stick them as additional clauses within the class
> cap, and I guess take the missing clause to be "all" or the default
> set or something.

The problem is that 'x' means any class, but that was a bad idea on our 
part.  Users should really specify which classes they mean going forward, 
but for existing clusters that isn't being done, and we can't break 
those, nor should we give them access to any random new class 
that shows up on the system.

This changes it to mean 'any class in the configured list of default 
classes, as specified by ceph.conf'...

sage
