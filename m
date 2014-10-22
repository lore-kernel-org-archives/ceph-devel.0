From: Loic Dachary <loic@dachary.org>
Subject: Can pid be reused ?
Date: Tue, 21 Oct 2014 19:55:34 -0700
Message-ID: <54471CA6.5040807@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="avl4la1K0sHWCBEc0J3uoslrINjJwtnWj"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50531 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750814AbaJVCzn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Oct 2014 22:55:43 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id B332A420A2
	for <ceph-devel@vger.kernel.org>; Wed, 22 Oct 2014 04:55:35 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--avl4la1K0sHWCBEc0J3uoslrINjJwtnWj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Something strange happens on fedora20 with linux 3.11.10-301.fc20.x86_64.=
 Running make -j8 check on https://github.com/ceph/ceph/pull/2750 a proce=
ss gets killed from time to time. For instance it shows as

TEST_erasure_crush_stripe_width: 124: stripe_width=3D4096
TEST_erasure_crush_stripe_width: 125: ./ceph osd pool create pool_erasure=
 12 12 erasure
*** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
=2E/test/mon/osd-pool-create.sh: line 120: 27557 Killed                  =
=2E/ceph osd pool create pool_erasure 12 12 erasure
TEST_erasure_crush_stripe_width: 126: ./ceph --format json osd dump
TEST_erasure_crush_stripe_width: 126: tee osd-pool-create/osd.json

in the test logs. Note the 27557 Killed . I originally thought it was bec=
ause some ulimit was crossed and set them to very generous / unlimited ha=
rd / soft thresholds.

core file size          (blocks, -c) 0                                   =
                                                 =20
data seg size           (kbytes, -d) unlimited                           =
                                                 =20
scheduling priority             (-e) 0                                   =
                                                 =20
file size               (blocks, -f) unlimited                           =
                                                 =20
pending signals                 (-i) 515069                              =
                                                 =20
max locked memory       (kbytes, -l) unlimited                           =
                                                 =20
max memory size         (kbytes, -m) unlimited                           =
                                                 =20
open files                      (-n) 400000                              =
                                                 =20
pipe size            (512 bytes, -p) 8                                   =
                                                 =20
POSIX message queues     (bytes, -q) 819200                              =
                                                 =20
real-time priority              (-r) 0                                   =
                                                 =20
stack size              (kbytes, -s) unlimited                           =
                                                 =20
cpu time               (seconds, -t) unlimited                           =
                                                 =20
max user processes              (-u) unlimited                           =
                                                 =20
virtual memory          (kbytes, -v) unlimited                           =
                                                 =20
file locks                      (-x) unlimited   =20

Benoit Canet suggested that I installed systemtap ( https://www.sourcewar=
e.org/systemtap/wiki/SystemtapOnFedora ) and ran https://sourceware.org/s=
ystemtap/examples/process/sigkill.stp to watch what was sending the kill =
signal. It showed the following:

=2E..
SIGKILL was sent to ceph-osd (pid:27557) by vstart_wrapper. uid:1001
SIGKILL was sent to python (pid:27557) by vstart_wrapper. uid:1001
=2E...

which suggests that pid 27557 used by ceph-osd was reused for the python =
script that was killed above. Because the script that kills daemons is ve=
ry agressive and kill -9 the pid to check if it really is dead

https://github.com/ceph/ceph/blob/giant/src/test/mon/mon-test-helpers.sh#=
L64

it explains the problem.

However, as Dan Mick suggests, reusing pid quickly could break a number o=
f things and it is a surprising behavior. Maybe something else is going o=
n. A loop creating processes sees their pid increasing and not being reus=
ed.

Any idea about what is going on would be much appreciated :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre



--avl4la1K0sHWCBEc0J3uoslrINjJwtnWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRHHKYACgkQ8dLMyEl6F220AwCbBw16ZLYaex2H3cSyAuzQfFqT
7OEAn3LBS8y7tIMN77cmtcxDk0KrhBYi
=vJuh
-----END PGP SIGNATURE-----

--avl4la1K0sHWCBEc0J3uoslrINjJwtnWj--
