From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Kernel RBD Readahead
Date: Tue, 13 Oct 2015 13:36:10 +0200
Message-ID: <1444736170.22653.19.camel@daevel.fr>
References: <3dc364a7.9Ro.9Gf.13.ic3ciX@mailjet.com>
	 <CAOi1vP8Tvcdh8Xy+eJKJdoHWDO2=OmVXqfxH9KzoJQQE645Rww@mail.gmail.com>
	 <590a725d.9Ro.9Gf.1M.icIth1@mailjet.com>
	 <CAOi1vP9=47yYPpJVwSUnZmoK1jv81s_4TmoaxJ=MxMtQ3-7nXQ@mail.gmail.com>
	 <CAOi1vP-zmOCAfWQVS2JknOX7QyKwHy8REeHkpKrAYcUJPwJ8Rw@mail.gmail.com>
	 <bd4da65e.9Ro.9Gf.13.idFHtU@mailjet.com>
	 <CAOi1vP-5bF6zCCaddvpF-TeMs66CLq6KtOL-_POJ6Ayxi-V6EA@mail.gmail.com>
	 <b1744442.9Ro.9Gf.1X.idQDIl@mailjet.com>
	 <CAOi1vP8V2wknnzS5Rx7reAaQiZk9XHOjRc7o2ZmVQWZyhbCWuQ@mail.gmail.com>
	 <32c2ce0c.9Ro.9Gf.1Z.ieeVCT@mailjet.com>
	 <CAOi1vP9Rrgn0RVAOdjrqHNRBHNZQXs4tpQ8jKDtz6R6ttqLsmA@mail.gmail.com>
	 <cba722de.9Ro.9Gf.13.ieH9GN@mailjet.com>
	 <CAOi1vP8rM6UTMOVm9fDXqjnyvmvAXpApW_LghV9ZS4vZVZBsxg@mail.gmail.com>
	 <1444728831.22653.18.camel@daevel.fr>
	 <CAOi1vP_7geoX-CRFTiWgYohQG=xQ=B9sx6QVof=WG=eRV0Fs=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:56229 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbbJMLgO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 07:36:14 -0400
In-Reply-To: <CAOi1vP_7geoX-CRFTiWgYohQG=xQ=B9sx6QVof=WG=eRV0Fs=g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Nick Fisk <nick@fisk.me.uk>, Ceph Development <ceph-devel@vger.kernel.org>

Le mardi 13 octobre 2015 =C3=A0 12:20 +0200, Ilya Dryomov a =C3=A9crit =
:
> On Tue, Oct 13, 2015 at 11:33 AM, Olivier Bonvalet <
> ceph.list@daevel.fr> wrote:
> > Le mardi 25 ao=C3=BBt 2015 =C3=A0 17:50 +0300, Ilya Dryomov a =C3=A9=
crit :
> > > > Ok. I might try and create a 4.1 kernel with the blk-mq queue
> > > depth/IO size + readahead +max_segments fixes in as I'm think the
> > > TCP_NODELAY bug will still be present in my old 3.14 kernel.
> > >=20
> > > I can build 4.2-rc8 + readahead patch on gitbuilders for you.
> >=20
> >=20
> > Hi,
> >=20
> > are thoses patches available in 4.3 kernel ?
>=20
> 4.3 isn't released yet.
>=20
> Everything but a readahead fix will be in 4.3.  AFAICT readahead
> patch
> was picked up by Andrew for 4.4 [1] - the problem is not in rbd, so
> we
> have no direct control over it.
>=20
> [1] http://comments.gmane.org/gmane.linux.kernel.commits.mm/96124
>=20
> Thanks,
>=20
>                 Ilya
>=20

Great, thanks !
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
