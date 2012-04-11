From: Sage Weil <sage@newdream.net>
Subject: Re: Can we have mutiple OSD in a single machine
Date: Wed, 11 Apr 2012 09:07:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204110906400.26830@cobra.newdream.net>
References: <loom.20120411T093935-734@post.gmane.org> <6626464112406899193@unknownmsgid>
 <loom.20120411T143658-450@post.gmane.org>
 <CAMvP8PD5qkfV=xYPewuPM9W2o06vqNOU_DVBdXmzyNbaB-7RpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-392032118-1334160431=:26830"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44823 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756764Ab2DKQHS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 12:07:18 -0400
In-Reply-To: <CAMvP8PD5qkfV=xYPewuPM9W2o06vqNOU_DVBdXmzyNbaB-7RpA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Paszkowski <ss7pro@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-392032118-1334160431=:26830
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Apr 2012, Tomasz Paszkowski wrote:
> Hi,
>=20
> It'll not increase overall storage system performance. Partitioning of
> single disk drive gives you no performance gains.

It will in fact slow these down, because each ceph-osd instance will by=20
doing periodic syncfs(2) calls and they will interfere.

sage

>=20
>=20
>=20
>=20
>=20
> On Wed, Apr 11, 2012 at 2:38 PM, Madhusudhana U
> <madhusudhana.u.acharya@gmail.com> wrote:
> > Tomasz Paszkowski <ss7pro <at> gmail.com> writes:
> >
> >>
> >> Hi,
> >>
> >> Please correct me if I'am wrong. You would like to partition single dr=
ive ?
> >>
> > Yes,
> > I want to create 4 partitions in a =A0single drive. This will increase =
the
> > OSD number. Will this increase in OSD also increases performance ?
> >
> > Thanks
> >
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
> --=20
> Tomasz Paszkowski
> SS7, Asterisk, SAN, Datacenter, Cloud Computing
> +48500166299
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-392032118-1334160431=:26830--
