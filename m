From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: rgw: new multisite update
Date: Fri, 15 Apr 2016 12:59:51 +0200
Message-ID: <87lh4fyw60.fsf@suse.com>
References: <CADRKj5ToZVUoP4qAro9ZnmTJTXS4vzMs++2S4-2Vk9U=_3pXwA@mail.gmail.com> <CADr68Wa6OrmMRp2Rp-uRMyZorEt7+nLv--=1B-DG0d2SS_9mog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:54477 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbcDOLAK (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 15 Apr 2016 07:00:10 -0400
In-reply-to: <CADr68Wa6OrmMRp2Rp-uRMyZorEt7+nLv--=1B-DG0d2SS_9mog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jens Rosenboom <j.rosenboom@x-ion.de>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Jens Rosenboom writes:

> 2015-12-05 7:34 GMT+01:00 Yehuda Sadeh-Weinraub <yehuda@redhat.com>:
> ...
>> We're aiming at having it in Jewel.
> ...
>> Documentation is almost non existent.
>
> So it looks like the code now is indeed in Jewel, but the
> documentation still seems missing, implying that setting up a new RGW
> deployment will only be possible for people who find this email, do
> you intend to change that for the release? Or did I not search well
> enough for updated docs?

There is a PR for a basic doc on multisite at
https://github.com/ceph/ceph/pull/8281 it is still awaiting review,
hopefully should be merged soon


=2D-
Abhishek Lekshmanan
SUSE Linux GmbH
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N=
=C3=BCrnberg)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXEMmoAAoJEPnwZB8bZe1fL6IIAK5Inkf5dgbox+NfdbIqoCo9
7eKmi+yMMHUOOTsVC2EWLEnysm1Ewjal0hbsV4egiex2SD6Vj/FSQSvCFeLiOjeV
cTElV+X+r8GNpQk17uCN3hVtez7mjHP9tg/x+ef4/6ZP+dJ+7BYABbKEZkyg5wKg
MfBIrgHExoMqKsy0ZaW9cJSChL02tGpx8ME/7sY+ZkTx64Z9gpMcNLm4tAEO13Hr
An8gre5FP5/G7H/+08UvcIYnXeGNgub1YtFewv5vazUTh0Ih9NtnfIUdfuXBQvbq
X1Z4tds1Jg6K/0kL3dqJ39fWoFWBvxIE7K42p0W8m5ars8Ldn0J4nkOwrfDF4wY=
=E0ub
-----END PGP SIGNATURE-----
--=-=-=--
