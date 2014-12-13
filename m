From: Loic Dachary <loic@dachary.org>
Subject: Running make check on each pull requests via jenkins
Date: Sat, 13 Dec 2014 19:56:27 +0100
Message-ID: <548C8BDB.8010806@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TRWgHrkaWie9weMeirSbnJh3Hp6sLfAdl"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52517 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751841AbaLMS4b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Dec 2014 13:56:31 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <alfredo.deza@inktank.com>, Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TRWgHrkaWie9weMeirSbnJh3Hp6sLfAdl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alfredo & Ken,

After a week of testing/fixing, I think http://workbench.dachary.org/ceph=
/ceph/blob/master/run-make-check.sh is ready to be used for CI. If I'm no=
t mistaken, the next steps are to:

a) add a jenkins slave on a machine
b) add a build script to https://github.com/ceph/ceph-build
c) schedule a new job on http://jenkins.ceph.com/ with something like htt=
ps://github.com/ceph/ceph-build/pull/35

The only part I'm unclear about is the jenkins slave. The test I did were=
 on a fedora 20 and ubuntu 14.04 and it would be better (as a first step)=
 if there was just a single slave running one of these two operating syst=
ems. It will make it easier to diagnose problems.

The build script could be something like (module the pastebinit if jenkin=
s can handle up to 100,000 lines of output).

export PATH=3D$HOME:/usr/local/bin:$PATH

author=3D$(git log -1 --pretty=3D'%ae')
if test -z "$(git log -1 --pretty=3D'%H' --author $author master)" ; then=

    git log -1
    echo "Ignored because $author has no previous commit in master"
    exit 0
fi

sudo $(which apt-get yum zypper 2>/dev/null) install -y pastebinit
if run-make-check.sh > output 2>&1 ; then
    success=3Dtrue
else
    success=3Dfalse
fi
# because of https://gitlab.com/gitlab-org/gitlab-ci/issues/71           =
                                                                         =
                                                                 =20
url=3D$(pastebinit -b http://paste.ubuntu.com/ output)
commit=3D$(git rev-parse HEAD)
if $success ; then
    message=3D"SUCCESS: make check on $commit output is $url"
else
    message=3D"FAIL: make check on $commit output is $url"
fi

$success

Cheers

http://tracker.ceph.com/issues/10046

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--TRWgHrkaWie9weMeirSbnJh3Hp6sLfAdl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSMi9sACgkQ8dLMyEl6F22R/ACfT/7GQrDwOKRHlsToUNknsIgs
r/gAnRUINX1uptg1kd26K3inleuUIKc9
=1qvc
-----END PGP SIGNATURE-----

--TRWgHrkaWie9weMeirSbnJh3Hp6sLfAdl--
