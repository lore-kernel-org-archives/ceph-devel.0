From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 22:54:36 +0100
Message-ID: <1395784476.2076.28.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
	 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
	 <53316D18.7040103@ieee.org>
	 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
	 <53317BC2.9010700@ieee.org>
	 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
	 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>
	 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>
	 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>
	 <5331D2E8.6060002@ieee.org>
	 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>
	 <1395778894.2076.12.camel@localhost> <1395780835.2076.15.camel@localhost>
	 <1395781847.2076.21.camel@localhost>
	 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>
	 <1395782577.2076.23.camel@localhost>
	 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>
	 <1395783675.2076.26.camel@localhost>
	 <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:42853 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbaCYVyj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 17:54:39 -0400
In-Reply-To: <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>

Le mardi 25 mars 2014 =C3=A0 23:49 +0200, Ilya Dryomov a =C3=A9crit :
> On Tue, Mar 25, 2014 at 11:41 PM, Olivier Bonvalet <ceph.list@daevel.=
fr> wrote:
> > mmm the cluster seems to be in a really bad state now : all hosts a=
re
> > hanging. Is it possible that mounting images without the rbd_assert=
(0)
> > broke some images ?
> >
>=20
> I don't think so.  As far as I can tell all occurrences that you
> reported tripped over one of the asserts.  It's probably just that fo=
r
> some reason you are now hitting this bug much more frequently than on=
ce
> a week.
>=20
> Thanks,
>=20
>                 Ilya
> --

Ok thanks, I'm =C2=ABreassured=C2=BB.

At reboot VM are much more I/O loaded, because of cache flush. It's
probably the reason why it now hang often.

I have to wait a little between starting each VM.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
