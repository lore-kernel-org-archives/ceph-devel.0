From: Sage Weil <sage@newdream.net>
Subject: Re: Minor error in the firefly release notes
Date: Tue, 6 Oct 2015 11:35:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510061135150.32037@cobra.newdream.net>
References: <56140E48.40603@filoo.de> <CAAZbbf0UPa-mmMChiUJmX+khJA=7+Zw8aAtnZ6cJ=eBA9O3Dgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-211531467-1444156519=:32037"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34323 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbbJFSfU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Oct 2015 14:35:20 -0400
In-Reply-To: <CAAZbbf0UPa-mmMChiUJmX+khJA=7+Zw8aAtnZ6cJ=eBA9O3Dgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <pmcgarry@redhat.com>
Cc: "Dr. Christopher Kunz" <chris@filoo.de>, Ceph Devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-211531467-1444156519=:32037
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Fixed in 5e9cf8e

On Tue, 6 Oct 2015, Patrick McGarry wrote:

> Thanks for pointing this out. Probably a good thing to have on the
> list for broader note though. Guessing Sage or someone is better
> equipped to make changes to the release notes.
>=20
>=20
> On Tue, Oct 6, 2015 at 2:09 PM, Dr. Christopher Kunz <chris@filoo.de> w=
rote:
> > Hey,
> >
> > https://ceph.com/releases/v0-80-9-firefly-released/ contains a
> > mini-howto to determine how much reweighting will eventually be cause=
d
> > by the switch from straw1 to straw2. This line:
> > "Divide the total number of lines in /tmp/a with the number of lines
> > changed.  We've found that most clusters are under 10%."
> >
> > should probably read: "divide the number of lines changed with the to=
tal
> > number of lines in /tmp/a", no?
> >
> >
> > Gru=C3=9F,
> >
> > --ck
> >
> > --
> > filoo GmbH
> > Dr. Christopher Kunz
> >
> > E-Mail: chris@filoo.de
> > Tel.: (+49) 0 52 41 8 67 30 -0
> > Fax: (+49) 0 52 41 / 8 67 30 -20
> >
> > Please sign & encrypt mail wherever possible, my key:
> > C882 8ED1 7DD1 9011 C088 EA50 5CFA 2EEB 397A CAC1
> >
> > Moltkestra=C3=9Fe 25a
> > 33330 G=C3=BCtersloh
> >
> > HRB4355, AG G=C3=BCtersloh
> > Gesch=C3=A4ftsf=C3=BChrer: Jens Rehp=C3=B6hler, Dr. Christopher Kunz
> >
> > Filoo im Web: http://www.filoo.de/
> > Folgen Sie uns auf Twitter: http://twitter.com/filoogmbh
> > Werden Sie unser Fan auf Facebook: http://facebook.com/filoogmbh
>=20
>=20
>=20
> --=20
>=20
> Best Regards,
>=20
> Patrick McGarry
> Director Ceph Community || Red Hat
> http://ceph.com  ||  http://community.redhat.com
> @scuttlemonkey || @ceph
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-211531467-1444156519=:32037--
