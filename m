From: Karol Mroz <kmroz@suse.com>
Subject: Re: logfile created with root:root ownership when "log_file" config
 option specified
Date: Fri, 5 Feb 2016 18:09:35 -0800
Message-ID: <20160206020935.GC29769@oak.lan>
References: <20160203231727.GA18601@oak.lan>
 <20160206004652.GA29769@oak.lan>
 <alpine.DEB.2.11.1602052051140.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:42050 "EHLO
	smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbcBFCJk (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 5 Feb 2016 21:09:40 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1602052051140.28396@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2016 at 09:02:58PM -0500, Sage Weil wrote:
[...]
> > The more I look at it, the more I think running conf->handle_changes(NU=
LL) from global_pre_init()
> > is not needed. Upon returning to global_init(), we invoke g_conf->call_=
all_observers() which does
> > meta variable expansion and runs _all_ observers. This should be enough=
=2E.. or am I oversimplifying
> > things? :D
>=20
> That sounds like the right thing to me.  These are dark and crufty parts=
=20
> of the code, though, so we'll have to make the change and see what=20
> breaks..
>=20
> There are only 2 global_pre_init callers: global_init (the next method=20
> down), and ceph-conf.  Presumably this was split to make ceph-conf happy.=
 =20
> So this is primarily a matter of looking through global_init to make sure=
=20
> nothing depends on metavariable expansion.  The only thing htat catches m=
y=20
> eye is g_conf->run_dir.  We can probably move that below=20
> call_all_observers?  Or, put the apply_changes just after we drop=20
> privileges.
>=20
> Take a look at
>=20
> 	https://github.com/ceph/ceph/pull/7545
>=20
> I think this does the trick, and passes my quick smoke test...

Yes, this looks good.

One thing... before the logfile is ultimately created, there are several po=
tential calls
to dout(). Is it possible these calls would be lost? Or is there some cachi=
ng that goes on?
I've not looked too deeply at the logging code.

Thanks!

--=20
Regards,
Karol

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWtVXcAAoJECp28bThgzatnVgIAI9kwSMY7q28Cn1wnsMzotgz
4eleISvyecWGl5+NbRKJWsym7g2Za3sc3Wos9VDk0qLzgeqXoeBfCJrLkweFJLd1
feNg/m47/nmj9+3xrzr4k9qZcOj0vGtaNDMjP6h7D5nwoLWZjyv+KKgu2XdLt3fH
Z/7GuANvXsFmSxtu/EKxo5/gB4t/mdLNIf9JLNHMzH2thTaztsrZqYk61qJaFPvC
iiw69H72v1sXR3vHWlGVIA1ijMrR9UrcrsZ8LmGyZMlC+mtG7823IwAS4GLGTcIE
4WKFZkwQy78BP4oGTgcE8zAkqOmZ9OvZEvnQQWRB3Hd619ZIZBFolz7SS/JoW14=
=CLNk
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
