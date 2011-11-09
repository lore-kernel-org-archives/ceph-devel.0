From: Sage Weil <sage@newdream.net>
Subject: Re: [patch RFC] client: return stripe address replicas
Date: Wed, 9 Nov 2011 13:12:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111091311060.31435@cobra.newdream.net>
References: <1771502131.44602.1320808517281.JavaMail.root@mail-01.cse.ucsc.edu>
 <Pine.LNX.4.64.1111091255150.31435@cobra.newdream.net>
 <CAB2gnbXG0X2NDkhVAHZD0AzU5owp+aPndN0G-y2=+fbFDmqPqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2038713625-1320873160=:31435"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47366 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab1KIVMn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2011 16:12:43 -0500
In-Reply-To: <CAB2gnbXG0X2NDkhVAHZD0AzU5owp+aPndN0G-y2=+fbFDmqPqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <gregory.farnum@dreamhost.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2038713625-1320873160=:31435
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 9 Nov 2011, Noah Watkins wrote:
> On Wed, Nov 9, 2011 at 12:56, Sage Weil <sage@newdream.net> wrote:
> > On Tue, 8 Nov 2011, Noah Watkins wrote:
> >
> > The only issue with this is that, in the event that you don't guess a
> > sufficiently large array on the first call, you may need to call again,
> > and in some cases that may mean multiple MDS requests. =A0Normally that=
's
> > not the case. =A0And a smart caller should guess 4 and only pass 0 and =
then
> > N if 4 failed. =A0But a naive caller will always make two calls, first =
with
> > 0 and then with N, and in some cases that's actually slower.
>=20
> The code I'm using makes a large guess, and an alternative is for the
> user to cache the replication factor for a file? A similar approach using
> ERANGE is used by listxattr (well, it communicates ERANGE via errno).
> In any case, even with Tommi's *naddr_out approach, a certain amount
> of precise documentation on it's semantics is needed.

Actually, I take it back, the 0 query will never need an additional MDS=20
request because the file_layout is immutable for the lifetime of the file=
=20
(currently at least; and even if it weren't it should very rarely change).

And yeah, I like the consistency wrt listxattr.

Ok!
sage

--557981400-2038713625-1320873160=:31435--
