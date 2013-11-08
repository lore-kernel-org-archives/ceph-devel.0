From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: emperor leftovers
Date: Thu, 7 Nov 2013 20:47:41 -0500 (EST)
Message-ID: <1292843520.361.1383875261715.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <07C71F0C-A305-4E20-A2ED-4F28D13BF7C9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3998 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756056Ab3KHBrq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 20:47:46 -0500
In-Reply-To: <07C71F0C-A305-4E20-A2ED-4F28D13BF7C9@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: Patrick McGarry <patrick@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Cesar Mello <cmello@gmail.com>

Hi,

Mingw can do posix -threads-, nowadays it has something internal, but
probably better is a standalone winpthread.h one-file shim (depending o=
n
what level of conformance you care about, perhaps not much).
But yes, doesn't provide a posix env (which generally is not a going
to lead to a first class port).

MSVC is the default windows env.  It's probably the ideal, despite most
requirement for moving furthest towards the windows mindset.  It has be=
tter
open source tool support than you might expect.

Matt

----- "Noah Watkins" <noahwatkins@gmail.com> wrote:

> Oh, my ignorance of Windows development is enormous :) So there are
> cygwin, mingw, and msvc. And mingw =E2=80=9Cmore=E2=80=9D native than=
 cygwin, but
> doesn=E2=80=99t try to do posix, and msvc just the default/native win=
dows
> development env?
>=20
> On Nov 7, 2013, at 5:34 PM, Matt W. Benjamin <matt@linuxbox.com>
> wrote:
>=20
> > Or, MSVC, frankly.
> >=20
> > ----- "Matt W. Benjamin" <matt@linuxbox.com> wrote:
> >=20
> >> Yes.  But you may wish to think about mingwXX porting rather than
> >> Cygwin,
> >> if you prefer native results.
> >>=20
> >> Matt
> >>=20
> >> ----- "Noah Watkins" <noah.watkins@inktank.com> wrote:
> >>=20
> >>> On Thu, Nov 7, 2013 at 5:15 PM, Sage Weil <sage@inktank.com>
> wrote:
> >>>=20
> >>>> curious if the discussion on windows portability is relevant
> here
> >> or
> >>> if
> >>>> it's better treated as a separate but related effort.
> >>>=20
> >>> The kernel space talk that's been tossed around probably isn't
> >>> relevant, but I'd be nice to learn about cygwin porting if anyone
> >> has
> >>> knowledge in this area.
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe
> >> ceph-devel"
> >>> in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at=20
> http://vger.kernel.org/majordomo-info.html
> >>=20
> >> --=20
> >> Matt Benjamin
> >> The Linux Box
> >> 206 South Fifth Ave. Suite 150
> >> Ann Arbor, MI  48104
> >>=20
> >> http://linuxbox.com
> >>=20
> >> tel.  734-761-4689=20
> >> fax.  734-769-8938=20
> >> cel.  734-216-5309=20
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> ceph-devel"
> >> in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
> > --=20
> > Matt Benjamin
> > The Linux Box
> > 206 South Fifth Ave. Suite 150
> > Ann Arbor, MI  48104
> >=20
> > http://linuxbox.com
> >=20
> > tel.  734-761-4689=20
> > fax.  734-769-8938=20
> > cel.  734-216-5309

--=20
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689=20
fax.  734-769-8938=20
cel.  734-216-5309=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
