From: Loic Dachary <loic@dachary.org>
Subject: Re: fixing jenkins builds on pull requests
Date: Wed, 23 Dec 2015 12:28:57 +0100
Message-ID: <567A8579.4040404@dachary.org>
References: <567A6551.7030209@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nK3gnHq9PHXAmmA7kAmO0xpeAPpQo93QC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54742 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755610AbbLWL27 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Dec 2015 06:28:59 -0500
In-Reply-To: <567A6551.7030209@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nK3gnHq9PHXAmmA7kAmO0xpeAPpQo93QC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I triaged the jenkins related failures (from #24 to #49):

CentOS 6 not supported:

  https://jenkins.ceph.com/job/ceph-pull-requests/26/console
  https://jenkins.ceph.com/job/ceph-pull-requests/28/console
  https://jenkins.ceph.com/job/ceph-pull-requests/29/console
  https://jenkins.ceph.com/job/ceph-pull-requests/34/console
  https://jenkins.ceph.com/job/ceph-pull-requests/38/console
  https://jenkins.ceph.com/job/ceph-pull-requests/44/console
  https://jenkins.ceph.com/job/ceph-pull-requests/46/console
  https://jenkins.ceph.com/job/ceph-pull-requests/48/console
  https://jenkins.ceph.com/job/ceph-pull-requests/49/console

Ubuntu 12.04 not supported:

  https://jenkins.ceph.com/job/ceph-pull-requests/27/console
  https://jenkins.ceph.com/job/ceph-pull-requests/36/console

Failure to fetch from github

  https://jenkins.ceph.com/job/ceph-pull-requests/35/console

I've not been able to analyze more failures because it looks like only 30=
 jobs are kept. Here is an updated summary:

 * running on unsupported operating systems (CentOS 6, precise and maybe =
others)
 * leftovers from a previous test (which should be removed when a new sla=
ve is provisionned for each test)
 * keep the last 300 jobs for forensic analysis (about one week worth)
 * disable reporting to github pull requests until the above are resolved=
 (all failures were false negative).

Cheers

On 23/12/2015 10:11, Loic Dachary wrote:
> Hi Alfredo,
>=20
> I forgot to mention that the ./run-make-check.sh run currently has no k=
nown false negative on CentOS 7. By that I mean that if run on master 100=
 times, it will succeed 100 times. This is good to debug the jenkins buil=
ds on pull requests as we know all problems either come from the infrastr=
ucture or the pull request. We do not have to worry about random errors d=
ue to race conditions in the tests or things like that.
>=20
> I'll keep an eye on the test results and analyse each failure. For now =
it would be best to disable reporting failures as they are almost entirel=
y false negative and will confuse the contributor. The failures come from=
:
>=20
>  * running on unsupported operating systems (CentOS 6 and maybe others)=

>  * leftovers from a previous test (which should be removed when a new s=
lave is provisionned for each test)
>=20
> I'll add to this thread when / if I find more.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nK3gnHq9PHXAmmA7kAmO0xpeAPpQo93QC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZ6hXkACgkQ8dLMyEl6F23zmACfZITplYctlJfb/ytKObn5GPfW
zrQAoLf4T14Pa8rXGO5nYHJKZtGd91/u
=3n7h
-----END PGP SIGNATURE-----

--nK3gnHq9PHXAmmA7kAmO0xpeAPpQo93QC--
