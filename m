From: Loic Dachary <loic@dachary.org>
Subject: Analyzing the nightlies
Date: Sat, 09 May 2015 11:31:03 +0200
Message-ID: <554DD3D7.7090407@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="B3MW97GCsmTO29jdx12NH1vnsMfICbehK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60351 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751473AbbEIJbF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 May 2015 05:31:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B3MW97GCsmTO29jdx12NH1vnsMfICbehK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

It would be useful to add more information bout how the nightlies are ana=
lyzed at

   http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_monitor_the_=
automated_tests_AKA_nightlies

At this point my understanding is that you look over all of them and you =
carry the burden of=20

* sorting out the environmental noise
* creating new bugs for errors for which there is no match in the tracker=

* add a link to the failed job in pre-existing issues found in the tracke=
r (useful to figure out the frequency and helps with debug when there are=
 multiple outputs / logs)

You do so by using tools such as https://github.com/jcsp/scrape/blob/mast=
er/scrape.py and maybe others and you also format your mail messages so t=
hat they can be parsed by a program (although such a program does not exi=
st yet, it could go over all your messages and build a database from the =
mails you sent).

In the http://lists.ceph.com/private.cgi/ceph-qa-ceph.com/ archives, I se=
e that Greg also regularly goes over the errors and other developers also=
 do. What I'm not sure about is if it's best effort ? Is there a time lik=
e bug scrubbing or sprint planning when developers say "Let's analyze QA =
results and dig bugs" ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--B3MW97GCsmTO29jdx12NH1vnsMfICbehK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVN09cACgkQ8dLMyEl6F21k8gCfQrWoN75pHiNLKkBy+MQwotDB
75QAn0ymBrQ6Q5e2fxWIschBBK1QdR79
=QOVm
-----END PGP SIGNATURE-----

--B3MW97GCsmTO29jdx12NH1vnsMfICbehK--
