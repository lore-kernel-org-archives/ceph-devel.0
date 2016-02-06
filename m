From: Karol Mroz <kmroz@suse.com>
Subject: Re: logfile created with root:root ownership when "log_file" config
 option specified
Date: Fri, 5 Feb 2016 16:46:52 -0800
Message-ID: <20160206004652.GA29769@oak.lan>
References: <20160203231727.GA18601@oak.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:46195 "EHLO
	smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbcBFAq5 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 5 Feb 2016 19:46:57 -0500
Content-Disposition: inline
In-Reply-To: <20160203231727.GA18601@oak.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 03, 2016 at 03:17:27PM -0800, Karol Mroz wrote:
[...]
> From a quick glance, removing changed.count("log_file"...) from
> LogObs::handle_conf_changes() would skip over the early logfile creation =
in this observer.
> A more invasive option would be to remove conf->apply_changes() from glob=
al_pre_init(),
> thus delaying running the observers for the first time until after the pe=
rmissions drop.
> However, I suspect there may be valid reason why conf->apply_changes() is=
 needed in
> global_pre_init()? As I'm not familiar with the nuances here, a comment f=
rom someone more
> familiar with this would be appreciated.

Removing the changed.count("log_file") section in LogObs::handle_conf_chang=
es() I think would kill
the possibility of changing the logfile via injectargs. I'd say that's a no=
-go.

The more I look at it, the more I think running conf->handle_changes(NULL) =
=66rom global_pre_init()
is not needed. Upon returning to global_init(), we invoke g_conf->call_all_=
observers() which does
meta variable expansion and runs _all_ observers. This should be enough... =
or am I oversimplifying
things? :D

--=20
Regards,
Karol

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWtUJ6AAoJECp28bThgzatQ2AIAIX4eBy7gFslI8pOKMxBB19l
vCRP8qgWAtUxLk0xdzo7HAMEX3HQkf4Kx0hupPBo5+xZcqo6LPtsHpwbAeAzAE4l
7OSxk2BFerOQngRCY+hR/I5GDiXDrHlNwOpmJ7WpL6XJYOR0sOjsyzjO7oY1gqXg
Mm3oSjHzPh+BmCeZzQrx3GYwLot4ImsA26oi9pAE8YwVMP/dyGey0kx9zoRuHCaj
jVq5MPCup6oai1DW25jbarus8q+sO+BsTTQ3P2f888kHMr9p2iJjG436I59p/SQ3
haohWkrvrATkwbqddttcVWxUprt8Sslqg4LxPrvK3o7Y1nrWBH66w5+OM7AGEJM=
=amcQ
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
