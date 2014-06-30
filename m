From: Alexey Kurnosov <alexey@kurnosov.spb.ru>
Subject: Re: incomplete PG
Date: Mon, 30 Jun 2014 20:16:40 +0400
Message-ID: <20140630161640.GA6975@unsen.q53.spb.ru>
References: <20140606132000.GA17468@unsen.q53.spb.ru>
 <alpine.DEB.2.00.1406060856330.31587@cobra.newdream.net>
 <20140606191851.GB17468@unsen.q53.spb.ru>
 <20140609131011.GC17468@unsen.q53.spb.ru>
 <CAMm-wcLe0A_VLKoL=r8MhSO_2HG0Mp7zzmVnoWze-RcqfL2xsg@mail.gmail.com>
 <CAMm-wcJgkpmiyxBLEtfUHTTC5QDTKUaNrqqZiUdHfsq=kGr7jA@mail.gmail.com>
 <20140610095451.GH9160@unsen.q53.spb.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 94.19.218.213.pool.sknt.ru ([94.19.218.213]:58627 "EHLO
	q53.spb.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754188AbaF3QQq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Jun 2014 12:16:46 -0400
Content-Disposition: inline
In-Reply-To: <20140610095451.GH9160@unsen.q53.spb.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, ceph-users-request@lists.ceph.com


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,all.

I finally was succeded.
Maybe somebody will be intresting.
A script read the content from a fuse-rbd files (i wonder, what is actual u=
se case of fuse-rbd?) with "dd"=20
and, in a case of timeout (alarmed by a background process), killed entire =
fuse daemon, remount fuse-rbd and resumed at next block.
It is very disapointing do not have a standart method for data recovery. IM=
HO, with such a bug ceph is not production ready.


On Tue, Jun 10, 2014 at 01:54:51PM +0400, Alexey Kurnosov wrote:
> On Tue, Jun 10, 2014 at 08:58:30AM +0800, Dong Yuan wrote:
> > Sorry, the last sentence should be "You can NOT remove PG, except you
> > remove the whole Pool."
> >=20
> > On 10 June 2014 08:57, Dong Yuan <yuandong1222@gmail.com> wrote:
> > > InComplete PG means this PG can't get enough metadata (PG logs) to
> > > enter Active state. This may be because some unrepairable data damage.
>=20
> But at least there should be a method to put a incomplete PG in some more=
 reasonable state
> for a futher forensic and retrieving other data from good PGs, in which r=
bd kernel driver
> could return EIO for example, not just hang on I/O wait. Is it possible?
>=20
> > >
> > > You can remove PG, except you remove the whole Pool.
> > >
> > > On 9 June 2014 21:10, Alexey Kurnosov <alexey@kurnosov.spb.ru> wrote:
> > >>
> > >> Guys, what should i do to erase an incomplete PG?
> > >> Use special utils,  hexedit, any methods?
> > >>
> > >>
> > >> On Fri, Jun 06, 2014 at 11:18:51PM +0400, Alexey Kurnosov wrote:
> > >>> On Fri, Jun 06, 2014 at 08:57:46AM -0700, Sage Weil wrote:
> > >>> > On Fri, 6 Jun 2014, Alexey Kurnosov wrote:
> > >>> > > Hi all.
> > >>> > >
> > >>> > > Sorry for a rude offtop, but looks like nobody can help me at c=
eph-users.
> > >>> > > Here is the link to my email:
> > >>> > > http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-June/0=
40383.html
> > >>> > > Here some additional data:
> > >>> > > http://pastebin.com/Nc4y3S1U
> > >>> > >
> > >>> > > During read requests i can see in logs:
> > >>> > > 2014-06-06 13:28:08.586262 7f335f29f700 10 osd.7 21942 dequeue_=
op 0x356cb40 prio 127 cost 0 latency 0.000352 osd_op(client.11324.1:436 rb.=
0.1465.2ae8944a.000000000bb1 [read 0~131072] 4.b940a077 e21942) v4 pg pg[4.=
77( empty local-les=3D0 n=3D0 ec=3D144 les/c 19162/16786 21941/21941/21941)=
 [7,2] r=3D0 lpr=3D21941 pi=3D8764-21940/115 mlcod 0'0 incomplete]
> > >>> > >
> > >>> > >
> > >>> > > Any help would be appreciated.
> > >>> >
> > >>> > This looks like a hangup somewhere in teh osd/osd communication t=
hat is
> > >>> > preventing the peering/probing from happening.  Since you're runn=
ing
> > >>> > emperor and we stopped testing and backporting fixes there a whil=
e back
> > >>> > I'm not sure offhand what bug fix is missing.  My suggestion is t=
o upgrade
> > >>> > to 0.80.1 firefly as a first step.
> > >>> Upgrade has been performed. I do not see any changes.
> > >>>
> > >>>
> > >>> >
> > >>> > FWIW simply restartin the OSDs involved in those PGs will probabl=
y also
> > >>> > get things rolling, but this bug will still be present.
> > >>> I restarted it many times. Looks like PG copies all are incomplete.
> > >>>
> > >>>
> > >>> >
> > >>> > sage
> > >>> >
> > >>> >
> > >>> >  >
> > >>> > >
> > >>> > > (Somebody hit similar issue here: http://lists.ceph.com/piperma=
il/ceph-users-ceph.com/2014-February/007948.html)
> > >>> > >
> > >>> > > --
> > >>> > > Alexey Kurnosov
> > >>> > >
> > >>> > >
> > >>> > >
> > >>> > >
> > >>> > >
> > >>> > >
> > >>>
> > >>> --
> > >>> Alexey Kurnosov
> > >>>
> > >>
> > >>
> > >
> > >
> > >
> > > --
> > > Dong Yuan
> > > Email:yuandong1222@gmail.com
> >=20
> >=20
> >=20
> > --=20
> > Dong Yuan
> > Email:yuandong1222@gmail.com
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html



--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJTsY1nAAoJEOvtiXwvSWEqOKcH/1PqzxwHgLTcvj0ugOv1nBAv
lsVyW9cCYpMf3s0VBeYJpSk5m7Tz0xtVaq8QiDqbI6fYmzLwEJKp55FyrPWmNhfk
H16UYYeQooRq4vEQ1yVHfcbWGYZo0rOkNVXym6SwQ9P+93mI3TWcHe26CmC0q8II
W6paXq4E9lo4x6937G2lyYie1VFyizwtfJ+ZUXZRWZPU8yg0QFcJU34/tJVm1CiR
41Ww0dWWG8/mmluzn4dFWn6DBYug0cbWLjC7K64OCT9Zuy7KKfGkVpA2DQfMQZD2
XFda0J6004DPamX+l3OpphdeDcWfOR1slPbSs8gDwUJKvHOTY/1eP24YhLAetjs=
=taLS
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
