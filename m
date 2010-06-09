From: Andre Noll <maan@systemlinux.org>
Subject: Re: osd: terminate called after throwing an instance of 'std::bad_alloc'
Date: Wed, 9 Jun 2010 10:16:04 +0200
Message-ID: <20100609081604.GG9152@skl-net.de>
References: <Pine.LNX.4.64.1006011025090.14408@cobra.newdream.net> <20100602081044.GY1212@skl-net.de> <Pine.LNX.4.64.1006021115240.1269@cobra.newdream.net> <20100604084521.GO1211@skl-net.de> <Pine.LNX.4.64.1006040944331.2384@cobra.newdream.net> <20100607080754.GU1211@skl-net.de> <20100607080932.GV1211@skl-net.de> <Pine.LNX.4.64.1006071016470.20365@cobra.newdream.net> <20100608122838.GA9152@skl-net.de> <Pine.LNX.4.64.1006082246540.3595@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from systemlinux.org ([83.151.29.59]:47989 "EHLO m18s25.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752986Ab0FIIQT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 9 Jun 2010 04:16:19 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1006082246540.3595@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 22:54, Sage Weil wrote:
> Hmm, okay.  Unfortunately the logs don't have any clues.  I'm giving on u=
p=20
> solving the mystery this time around.  You can go ahead and stop all the=
=20
> daemons and re-run mkcephfs.=20

OK, there was only stress-test data on the cephfs anyway. I'll start
=66rom scratch and run another set of tests. Fortunately we haven't
told the users about the shiny new file systems yet, so we are in no
hurry ;)

> I've added a 'scripts/check_pglog.sh $osddatadir' script that will just=
=20
> look for any corruption.  Running that periodically will let you verify=
=20
> that you haven't hit the same corruption without having to restart cosd. =
=20

Goodie. I'll set up a cron job to run this automatically. Should I
do this on each osd?

> Ideally we can figure out what kind of workloads are triggering the=20
> problem, and then reproduce it with sufficient logging enabled to find=20
> where the race is taking place.
>
> If you have any details about the workload or any failure/recovery=20
> activity that may have been going on at the time that may shed some light=
=20
> on it...

Funny enough, the problem occurred while the fs was idle. I ran
some simple tests a few days earlier and these completed with no
problems. From that point on, nobody ever accessed it.

I'll let you know if I can trigger it reliably. If you have any
suggestions for a workload that is likely to trigger the race, I'm
happy to give it a try. Otherwise, I'll just use "stress" again to
write to the cephfs from a couple of clients simultaneously.

Thanks
Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFMD03EWto1QDEAkw8RAshDAJ9vRZOaxkKNHcI9isrgCWlmjyOoAwCdFa6j
2Rid6pO9ube26AOzGUjVdQY=
=xFHQ
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
