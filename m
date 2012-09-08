From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: issues with adjusting the crushmap in 0.51
Date: Sat, 8 Sep 2012 09:08:42 +0100
Message-ID: <20120908080842.GB7184@tchpc.tcd.ie>
References: <20120906175821.GA32205@tchpc.tcd.ie> <CAPYLRzggLqcgvMJWFDYOsHvQNK2oOvHmmTEnufK60R4=mdEQNw@mail.gmail.com> <20120906185104.GA6518@tchpc.tcd.ie> <sfid-H20120906-213138-+033.83-1@marduk.tchpc.tcd.ie> <CADvuQRFz9oZr3BGRdzUhG4xhdYUu69v7UxKDuS4d0-kTisrr6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:48708 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab2IHIIn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Sep 2012 04:08:43 -0400
Content-Disposition: inline
In-Reply-To: <CADvuQRFz9oZr3BGRdzUhG4xhdYUu69v7UxKDuS4d0-kTisrr6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2012 at 01:31:15PM -0700, Tommi Virtanen wrote:
> On Thu, Sep 6, 2012 at 11:51 AM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
> > Also, the "ceph osd setcrushmap..." command doesn't up when a ceph
> > --help is run in the 0.51 release, however it is documented on the
> > wiki as far as I recall. It'd be real nice if the applications emitted
> > all the available commands, it would make experimenting much nicer and
> > fun.
>=20
> "ceph" is just a client app that sends (most of) the commands to
> ceph-mon for execution; it's --help is problematic to keep up to
> date.. We're trying to do better. Patches appreciated, see ticket at
> the end..
>=20
> Background:
> http://www.spinics.net/lists/ceph-devel/msg08471.html
> http://www.spinics.net/lists/ceph-devel/msg08472.html
> http://www.tracker.newdream.net/issues/2894
>=20

I was just looking at that, there's a few places where I have noticed
to have in-accurate "help" messages. I will go over my notes and see
if I can provide a few patches.

Jimmy

--=20
Jimmy Tang
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAlBK/QoACgkQmRvHlXBDSyl+XgCcCs7DW8GhQmAUtMK1RLcvYcEk
am4AoOkaLhJaMkja9k6u2h9dM9JML0o4
=nQOb
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
