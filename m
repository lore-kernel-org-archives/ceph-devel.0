From: Sage Weil <sage@newdream.net>
Subject: Re: librados aio completion
Date: Mon, 16 Apr 2012 12:00:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204161157440.10153@cobra.newdream.net>
References: <Pine.LNX.4.64.1204152141160.14018@cobra.newdream.net>
 <CAC-hyiFiL=a6dRaE-UkJ-egj1hJTSWQD-6GUitcmRiXvNrEUEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1692799430-1334602833=:10153"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44402 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab2DPTAn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 15:00:43 -0400
In-Reply-To: <CAC-hyiFiL=a6dRaE-UkJ-egj1hJTSWQD-6GUitcmRiXvNrEUEA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1692799430-1334602833=:10153
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 15 Apr 2012, Yehuda Sadeh Weinraub wrote:
> On Sun, Apr 15, 2012 at 9:44 PM, Sage Weil <sage@newdream.net> wrote:
> > We just switched the completion callbacks so that they are called
> > asynchronously from another thread. =A0This makes the locking less weir=
d for
> > certain callers and lets you call back into librados in your callback
> > safely.
> >
> > This breaks one of the functional tests, which sets a bool in the
> > callback, does wait_for_complete() on the aio handle, and then asserts
> > that the bool is set. =A0There's now a race between the caller's thread=
 and
> > the completion thread.
> >
> > Do we just call this a broken test, or do we want some way of blocking =
on
> > the aio handle until the completion has been called?
>=20
> I'd expect wait_for_complete() to wait until the completion completed.
> We can add some other wait_for_foo() for the current case.

I pushed a wip-2301 that does this.  The downside to this approach is that=
=20
the is_safe() and is_complete() methods will return false until after the=
=20
callback returns, which includes the callback itself.  So a callback that=
=20
assumes that is_complete() will return true will be wrong.

If that's not okay, the alternative is to make the wait_for_complete()=20
actually be a wait_for_complete_and_callback_has_returned().  That drops=20
the symmetry between wait_for_complete() and is_complete(), which is=20
awkward.

sage
--557981400-1692799430-1334602833=:10153--
