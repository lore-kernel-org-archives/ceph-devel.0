From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libcephfs: return error when not mounted
Date: Mon, 14 May 2012 10:05:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205141005070.11722@cobra.newdream.net>
References: <6E886DEA-B266-4677-8206-C817595BBA86@cs.ucsc.edu>
 <CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1582781184-1337015130=:11722"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56867 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826Ab2ENRFd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 May 2012 13:05:33 -0400
In-Reply-To: <CADvuQRENXm=5O+uZ8-UwGidSgbn3KvV212sPkUam9uzOyLrvMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel@vger.kernel.org, Greg Farnum <gregory.farnum@dreamhost.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1582781184-1337015130=:11722
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 14 May 2012, Tommi Virtanen wrote:
> On Fri, May 11, 2012 at 6:21 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote=
:
> > Return an error rather than a segfault if a client uses the interface
> > when unmounted. The Java bindings were explicitly enforcing the
> > mounted state, but this was overly complicated, uncommon, and better
> > handled with a simple exception that can be checked at libcephfs level.
> ...
> > + =A0if (!cmount->is_mounted())
> > + =A0 =A0return -EDOM;
>=20
> Noah, this is not really about your patch, as existing code already
> has return -EDOM, but... oh boy does the API abuse POSIX errors.
>=20
> "Numerical argument out of domain".

"Transport endpoint not connected"?


--557981400-1582781184-1337015130=:11722--
