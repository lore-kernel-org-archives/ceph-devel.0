From: Loic Dachary <loic@dachary.org>
Subject: Re: New "make check" job for Ceph pull requests
Date: Wed, 23 Dec 2015 21:20:13 +0100
Message-ID: <567B01FD.4060101@dachary.org>
References: <CAC-Np1wTpq4fJBtfJow9KY5dQ2vDmd_Mi_AsLhnavkhdr21apA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FH8cXoLMwrRvSOL56jLPm1Iejkox1oBtS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54965 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751481AbbLWUUS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Dec 2015 15:20:18 -0500
In-Reply-To: <CAC-Np1wTpq4fJBtfJow9KY5dQ2vDmd_Mi_AsLhnavkhdr21apA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, sepia@ceph.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FH8cXoLMwrRvSOL56jLPm1Iejkox1oBtS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

For the record the pending issues that prevent the "make check" job (http=
s://jenkins.ceph.com/job/ceph-pull-requests/) from running can be found a=
t http://tracker.ceph.com/issues/14172

Cheers

On 23/12/2015 21:05, Alfredo Deza wrote:
> Hi all,
>=20
> As of yesterday (Tuesday Dec 22nd) we have the "make check" job
> running within our CI infrastructure, working very similarly as the
> previous check with a few differences:
>=20
> * there are no longer comments added to the pull requests
> * notifications of success (or failure) are done inline in the same
> notification box for "This branch has no conflicts with the base
> branch"
> * All members of the Ceph organization can trigger a job with the
> following comment:
>     test this please
>=20
> Changes to the job should be done following our new process: anyone can=
 open
> a pull request against the "ceph-pull-requests" job that configures/mod=
ifies
> it. This process is fairly minimal:
>=20
> 1) *Jobs no longer require to make changes in the Jenkins UI*, they
> are rather plain text YAML files that live in the ceph/ceph-build.git
> repository and have a specific structure. Job changes (including
> scripts) are made directly on that repository via pull requests.
>=20
> 2) As soon as a PR is merged the changes are automatically pushed to
> Jenkins. Regardless if this is a new or old job. All one needs for a
> new job to appear is a directory with a working YAML file (see links
> at the end on what this means)
>=20
> Below, please find a list to resources on how to make changes to a
> Jenkins Job, and examples on how mostly anyone can provide changes:
>=20
> * Format and configuration of YAML files are consumed by JJB (Jenkins
> Job builder), full docs are here:
> http://docs.openstack.org/infra/jenkins-job-builder/definition.html
> * Where does the make-check configuration lives?
> https://github.com/ceph/ceph-build/tree/master/ceph-pull-requests
> * Full documentation on Job structure and configuration:
> https://github.com/ceph/ceph-build#ceph-build
> * Everyone has READ permissions on jenkins.ceph.com (you can 'login'
> with your github account), current admin members (WRITE permissions)
> are: ktdreyer, alfredodeza, gregmeno, dmick, zmc, andrewschoen,
> ceph-jenkins, dachary, ldachary
>=20
> If you have any questions, we can help and provide guidance and feedbac=
k. We
> highly encourage contributors to take ownership on this new tool and ma=
ke it
> awesome!
>=20
> Thanks,
>=20
>=20
> Alfredo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--FH8cXoLMwrRvSOL56jLPm1Iejkox1oBtS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZ7Af0ACgkQ8dLMyEl6F23I6ACfRCYNPx9rLq52XzAfW9FBveHT
T1gAmQH6Db9qIZLZbVvPLKMj+7mOYvt+
=DjRI
-----END PGP SIGNATURE-----

--FH8cXoLMwrRvSOL56jLPm1Iejkox1oBtS--
