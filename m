From: Matthew Via <via@matthewvia.info>
Subject: Re: 0.55 init script Issue?
Date: Wed, 5 Dec 2012 20:34:50 -0500
Message-ID: <20121206013449.GH6375@blade.matthewvia.info>
References: <50BF7314.2020809@gammacode.com>
 <50BFA354.7040308@inktank.com>
 <50BFABE5.1020904@ubuntu.com>
 <CAPYLRzjme=UxScsKDXdKPAWJyfxB1hNQGRJWT7QyJk+ET3dFHQ@mail.gmail.com>
 <alpine.DEB.2.00.1212051610560.16078@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.matthewvia.info ([95.170.88.43]:47447 "EHLO
	smtp2.matthewvia.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab2LFBm3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 20:42:29 -0500
Received: from localhost (70-89-236-241-va.richmond.hfc.comcastbusiness.net [70.89.236.241])
	by smtp2.matthewvia.info (Postfix) with ESMTPSA id CC21E3A147
	for <ceph-devel@vger.kernel.org>; Wed,  5 Dec 2012 20:34:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1212051610560.16078@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On the subject of init script problems, for the 0.55 Ceph release on EL6,=
=20
the init script has what looks like a typo on line 280, and in=20
/sbin/mkcephfs on line 328:
  fs_type =3D "btrfs"

As far as I know, shell variable assignments must have not have a space
between variable and the =3D -- the init script and mkcephfs will not run
as is.  It'd be nice to have this fixed in .55.1 if released.

Thanks, Matthew

On 16:11 Wed 05 Dec     , Sage Weil wrote:
> On Wed, 5 Dec 2012, Gregory Farnum wrote:
> > On Wed, Dec 5, 2012 at 12:17 PM, James Page <james.page@ubuntu.com> wro=
te:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA256
> > >
> > > On 05/12/12 19:41, Dan Mick wrote:
> > >> The story as best I know it is that we're trying to transition to
> > >> and use upstart where possible, but that the upstart config does
> > >> not (yet?) try to do what the init.d config did.  That is, it
> > >> doesn't support options to the one script, but rather separates
> > >> daemons into separate services, and does not reach out to remote
> > >> machines to start daemons, etc.
> > >>
> > >> The intent is that init.d/ceph is left for non-Upstart distros,
> > >> AFAICT.
> > >>
> > >> Tv had some design notes here:
> > >>
> > >> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg09314.html
> > >>
> > >>  We need better documentation/rationale here at least.
> > >
> > > Maybe it might be better if the ceph init script and the ceph upstart
> > > configuration did not namespace clash; how about shifting the name of
> > > the ceph upstart configuration to ceph-all?
> >=20
> > Yeah, this or something very similar is definitely the correct
> > solution. Sage recently added the "ceph" upstart job, and we didn't
> > put it through sufficient verification prior to release in order to
> > notice this issue. Users who aren't using upstart (I expect that's all
> > of them) should just delete the job after running the package install.
> > We'll certainly sort this out prior to the next release; I'm not sure
> > if we want to roll a v0.55.1 right away or not.
>=20
> Let's push it to the testing branch, but make sure any other fixes are=20
> there before rolling a .1.. maybe tomorrow?
>=20
> Thanks!
> sage
>=20
>=20
> > -Greg
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (OpenBSD)

iQEcBAEBAgAGBQJQv/Y5AAoJEEIMaoItRZ/E6owIAJgMrGPtG6oNdXDgcH+hLMgv
tHddQxrn9ks0gcleFVxZD6ajpsv1bcRPMITUu6q7Jp/eb/yy5lxhj0E6j7qx2YQZ
osTvwHs5lHmKd0081XzXA+q3xCKMbLW/+H+Jg+BV4sgdTyGTTrAP12OOjXcyOi5H
gRM4UFmIMUUU8QwvKn69A/G8VH0XL0R7RougfDJ10tbqhD4u7Q0B+iwFmse7Htwt
WzwhR4HozTaNHBuP/nPS0y5v1Q2o1KOBLlI2L9SIys98H+WyfrATSSMeWmj3hWmo
NOnEb4Rtt1mXeXc+v426nx7yMYvesyVLPNylmJ80og/RuHllCJAX5kNy7uYio0U=
=/SWF
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
