From: Sage Weil <sage@newdream.net>
Subject: Re: Logging braindump
Date: Thu, 22 Mar 2012 13:39:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1203221332520.25117@cobra.newdream.net>
References: <CAORUGqCqK0WUEGiXyM+6KYfWswPrW_eV=qp8Q2CCAUSXguYdDA@mail.gmail.com>
 <CA+qbEUPQcVqmUgNYXu6+U4+QCUjxsSkq9pVQ98=Es8rKscT12Q@mail.gmail.com>
 <4F6B6CB0.1000400@dreamhost.com> <CAORUGqBQ=EKHfSFwRO65wLfJBRT4Oh=OFoXKdvG9uwYRisuJJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1719851930-1332448762=:25117"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40548 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758619Ab2CVUjW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Mar 2012 16:39:22 -0400
In-Reply-To: <CAORUGqBQ=EKHfSFwRO65wLfJBRT4Oh=OFoXKdvG9uwYRisuJJA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Mark Kampe <Mark.Kampe@dreamhost.com>, Colin McCabe <cmccabe@alumni.cmu.edu>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1719851930-1332448762=:25117
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Mar 2012, Tommi Virtanen wrote:
> > =A0 =A0 =A0 =A0If we are logging a lot, buffer management has the poten=
tial
> > =A0 =A0 =A0 =A0to become a bottle-neck ... so we need to be able to all=
ocate
> > =A0 =A0 =A0 =A0a record of the required size from the circular buffer
> > =A0 =A0 =A0 =A0with atomic instructions (at least in non-wrap situation=
s).
> >
> > =A0 =A0 =A0 =A0But if records are allocated and then filled, we have to
> > =A0 =A0 =A0 =A0consider how to handle the case where the filling is
> > =A0 =A0 =A0 =A0delayed, and the reader catches up with an incomplete
> > =A0 =A0 =A0 =A0log record (e.g. skip it, wait how long, ???).
> >
> > =A0 =A0 =A0 =A0And while we hope this will never happen, we have to dea=
l
> > =A0 =A0 =A0 =A0with what happens when the writer catches up with the
> > =A0 =A0 =A0 =A0reader, or worse, an incomplete log block ... where we m=
ight
> > =A0 =A0 =A0 =A0have to determine whether or not the owner is deceased (=
making
> > =A0 =A0 =A0 =A0it safe to break his record lock) ... or should we simpl=
y take
> > =A0 =A0 =A0 =A0down the service at that point (on the assumption that s=
omething
> > =A0 =A0 =A0 =A0has gone very wrong).
>=20
> The Disruptor design handles all these, is simple in the sense of
> "that's what I would have built", and looks good.

My only problem with the disrupter stuff was that, as i was reading it, it=
=20
was very much like "yeah, given the limitations of Java, that's what you=20
would do," but we're in a slightly different boat.  i.e., they use a=20
ringbuffer of pointers to preallocated objects.

My guess is that the best bet would be preallocated Entry objects (either=
=20
in a flat buffer or on the heap) with a preallocated per-entry buffer=20
(say, 80 chars) that will spill over into something slow/simple when=20
necessary.  And something disrupter-like to claim slots in the ringbuffer.

But in any case, I think the key is first measuring how much time we spend

 - rendering the current entries
 - queueing each entry

under varying levels of concurrency.  With the current code, for instance,=
=20
I think most time is spent convering crap into strings and waiting for a=20
blocking flush.  We aren't logging millions of items, only hundreds.

--

Ignoring the nitty gitty of the log queueing, though... does the basic=20
framework make sense?  That is,

 - a set of predefined subsystems, each with their own log levels
 - a level to control which entries are gathered/rendered, with a fast=20
   contitional check (in, say, dout macro)
 - a level to control which entries are logged d
 - a dump on crash (or other event) of everything we have

?

sage
--557981400-1719851930-1332448762=:25117--
