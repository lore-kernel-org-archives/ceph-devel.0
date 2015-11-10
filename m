From: Loic Dachary <loic@dachary.org>
Subject: Re: a home for backport snippets
Date: Tue, 10 Nov 2015 12:01:22 +0100
Message-ID: <5641CE82.7020007@dachary.org>
References: <563B5789.7050006@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2chD0Rf4dQeeqdb8jGtwEI47RBfc0lMbn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57956 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752349AbbKJLBc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Nov 2015 06:01:32 -0500
In-Reply-To: <563B5789.7050006@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>, Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2chD0Rf4dQeeqdb8jGtwEI47RBfc0lMbn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The new snippets home is at https://pypi.python.org/pypi/ceph-workbench a=
nd http://ceph-workbench.dachary.org/root/ceph-workbench.

The first snippet was merged by Nathan yesterday[1], the backport documen=
tation updated accordingly[2], and I used it after merging half a dozen h=
ammer backport that were approved a few days ago.

Integration tests should provide the best help against regression we can =
hope for (they spawn a redmine instance every time they run and use a ded=
icated github user to create and destroy projects, pull requests etc.) an=
d they are run on every merge request[3]. When integrated in ceph-workben=
ch, the snippet is documented[4] and the implementation[5] is tested in f=
ull[6]. The merits of 100% coverage are often disputed as overkill. IMHO =
it's better to remove an untested line of code rather than taking the cha=
nce that it grows into something that does not work (or possibly never wo=
rked). In the case of this snippet, there is a dozen of safe guards and f=
our lines of code to modify the issue. It would be bad to discover, after=
 modifying hundreds of issues in the Ceph tracker, that it never worked a=
s expected. I'm sure we'll find ways to *not* do the right thing even wit=
h integration tests. But we'll hopefully do the right thing more often ;-=
)

I'm not sure how much time it will take us to convert all the snippets we=
 have, but it does not matter much as we can keep doing things manually i=
n the meantime.

Cheers

P.S. We are using a GitLab instance, with an integrated CI, instead of gi=
thub with a CI on jenkins.ceph.com roughly for the same reasons puppet-ce=
ph is in https://github.com/openstack/puppet-ceph and uses the OpenStack =
gates. We have no expertise on jenkins-job-builder[7] and the learning cu=
rve is perceived as significantly higher than a GitLab with an integrated=
 CI[8]. We also want to share administrative permissions on the CI with a=
ll members of the stable release team to share the maintenance workload.

[1] backport-set-release http://ceph-workbench.dachary.org/root/ceph-work=
bench/merge_requests/8
[2] Resolving an issue http://tracker.ceph.com/projects/ceph-releases/wik=
i/HOWTO_merge_commits_from_the_integration_branch#Resolving-the-matching-=
issue
[3] Continuous integration http://ceph-workbench.dachary.org/dachary/ceph=
-workbench/builds/53
[4] Documentation http://ceph-workbench.dachary.org/root/ceph-workbench/m=
erge_requests/8/diffs#9f3ebf1fc38506b66593397f3baac514d515c496_73_75
[5] Implementation http://ceph-workbench.dachary.org/root/ceph-workbench/=
merge_requests/8/diffs#070f4537c6cef8a2dacef1911a7d39acd0ce1387_0_75
[6] Testing http://ceph-workbench.dachary.org/root/ceph-workbench/merge_r=
equests/8/diffs#66bd83c5111f0ccc884ad791c4acaa926ab52c2a_0_64
[7] Jenkins Job Builder http://docs.openstack.org/infra/jenkins-job-build=
er/=20
[8] Configuration of your builds with .gitlab-ci.yml http://doc.gitlab.co=
m/ci/yaml/README.html

On 05/11/2015 14:20, Loic Dachary wrote:
> Hi,
>=20
> Today, Nathan and I briefly discussed the idea of collecting the backpo=
rt snippets that are archived in the wiki at http://tracker.ceph.com/proj=
ects/ceph-releases/wiki/HOWTO. We all have copies on our local disks and =
although they don't diverge much, this is not very sustainable. It was re=
ally good as we established the backport workflows. And it would have bee=
n immensely painful to maintain a proper software while we were changing =
the workflow on a regular basis. But it looks like we now have something =
stable.
>=20
> Early this year ceph-workbench[1] was started with the idea of helping =
with backports. It is a mostly empty shell we can now use to collect all =
the snippets we have. Instead of adding set-release[2] to the script dire=
ctory of Ceph, it would be a subcommand of ceph-workbench, like so:
>=20
>   ceph-workbench set-release --token $github_token --key $redmine_key
>=20
> What do you think ?
>=20
> Cheers
>=20
> [1] https://pypi.python.org/pypi/ceph-workbench
> [2] https://github.com/ceph/ceph/pull/6466
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--2chD0Rf4dQeeqdb8jGtwEI47RBfc0lMbn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZBzoIACgkQ8dLMyEl6F23lrgCfVvAOCuStj3ymICZAF+8IvAkU
16IAoMWymHbRb14OedGQPnhdKvUYeddf
=h4es
-----END PGP SIGNATURE-----

--2chD0Rf4dQeeqdb8jGtwEI47RBfc0lMbn--
