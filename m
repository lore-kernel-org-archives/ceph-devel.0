From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph backports workflow update
Date: Wed, 11 Feb 2015 17:42:20 +0100
Message-ID: <54DB866C.9020908@dachary.org>
References: <54D0CDDB.1020102@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hffV3DLdDHqq7BQkc0Dc8tlHC2X3HR3u1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42542 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753680AbbBKQmX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 11:42:23 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 7DF3D42B28
	for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2015 17:42:20 +0100 (CET)
In-Reply-To: <54D0CDDB.1020102@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hffV3DLdDHqq7BQkc0Dc8tlHC2X3HR3u1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Yesterday the dumpling & giant backport integration branches were approve=
d by Yehuda, Sam and Josh and were handed over to QE. An interesting disc=
ussion followed and it revealed that my understanding of the intended wor=
kflow was significantly wrong. It took me a while to figure out something=
 that makes sense. There is a good chance that I'm wrong again, please sp=
eak up :-)

The workflow proposed a month ago was the following:

0. Developer follows normal process to land PR to master. Once complete a=
nd ticket is marked Pending Backport this process initiates.
1. I periodically polls Redmine to look for tickets in Pending Backport s=
tate and focus on the ones that are left unattended for too long
1a. Under the supervision of the author of the original patch, I find the=
 commits associated with the Redmine ticket and Cherry Pick to the backpo=
rt integration branch off of the desired maintenance branch (Dumping, Fir=
efly, etc).
1b. I resolve any merge conflicts with the cherry-picked commit
2. I merge all backports for a given branch in an integration branch
3. I ask the leads of each project to review the integration
4. Once satisfied with group of backported commits to integration branch,=
 I notify QE.
5. QE tests backport integration branch against appropriate suites
6a. If QE is satisfied with test results, they merge backport integration=
 branch.
6b. If QE is NOT satisfied with the test results, they indicate backport =
integration branch is NOT ready to merge and return to me to work with or=
iginal Developer to resolve issue and return to steps 2/3
7. Ticket is moved to Resolved once backport integration branch containin=
g cherry-picked backport is merged to the desired mainteance branch(es)--=
=20

I think it should be modified to something like the following: (I have th=
e role of "the backporter"):

0. Developer follows normal process to land PR to master. Once complete a=
nd ticket is marked Pending Backport this process initiates.
1. A cron job updates an inventory of the backports for each branch (see =
http://workbench.dachary.org/ceph/ceph-backports/wikis/firefly for instan=
ce)
1a. The PR does not require integration (e.g. it changes the qa directory=
), it is merged in the release branch (dumpling, firefly, etc.) by the re=
viewer
1b. The PR requires integration and the label "needs-qa" is added to it b=
y the reviewer.
2. If the inventory page shows PR that are pending integration
2a. The backporter merges them in the dumpling-backports, etc. integratio=
n branch
2b. The backporter runs the rados, rgw, rbd etc. suites on the integratio=
n branch (if no rgw backports are present, rgw suite can be skipped etc.)=

2c. The backporter sorts and analyzes the test results, asking the develo=
per if necessary
2d. If a problem is found on a PR, the backporter removes the "needs-qa" =
label from the PR and makes sure the developer is aware that integration =
failed and why
2e. The PR successfully integrated are merged into the dumpling, firelfy,=
 etc. branch
3. A cron job runs various suites on the dumpling, firefly, etc. branches=
 (AKA "the nightlies")
3a. The nightlies send reports to the ceph-qa list when a suite completes=
=20
3b. The leads of each component are responsible for analyzing and updatin=
g tracker.ceph.com accordingly
4. The backporter periodically asks each lead if they think it is ready f=
or the next point release
4a. If it is not ready, the backporter offers his help to make progress s=
o that PR resolving the remaining issues are eventually merged in dumplin=
g, firefly etc.  and restart at step 0.
4b. If it is ready the backporter records the SHA of the commit for the g=
iven component
5. The backporter loops back to stp 0 until all leads think the same SHA =
is ready for the next point release
6. Given the SHA agreed on by all leads, QE tests the dumpling, firefly, =
etc. branch against the appropriate suites
6a. If QE is NOT satisfied with the test results, they update the tracker=
=2Eceph.com issues accordingly and asks the backporter to make sure they =
are addressed
6b. If QE is satisfied with test results, the SHA is provided to the pers=
on responsible for publishing the next release

The main difference is that QE approval is on a SHA instead of being the =
action of merging from a branch to another. In the backport development c=
ycle there are multiple integration branches and QE is not involved at th=
is point. The continuous analysis and fixes of each dumpling, firefly, et=
c. branch currently depends on the fact that PR are merged on a regular b=
asis and the results of the nightlies also analyzed on a regular basis vi=
a the reports sent to the ceph-qa list. This workflow is in place and wor=
ks. If QE was to merge an integration branch into the release branch (dum=
pling, firefly, etc.) that would disrupt this workflow. What really matte=
rs is to figure out exactly which SHA has been properly tested according =
to QE so that the release is made on this SHA and not another.=20

The other difference is about updating the tracker to change the tickets =
from Pending Backport to Resolved. In this workflow the developer and bac=
kporter are responsible for changing the state, as they do when working o=
n master. The inventory of the backport effort provides a list of all iss=
ues addressed by the PR merged into the dumpling, firefly, etc. branch. I=
nstead of batch updating the tickets, QE can use the inventory to check i=
f all issues have been addressed. The former workflow required discipline=
 by developers and if a ticket was accidentally set to Resolved, QE would=
 have a difficulties finding it. The inventory (e.g. http://workbench.dac=
hary.org/ceph/ceph-backports/wikis/firefly) automates the issue discovery=
 process and QE will see all issues related to the pending release, regar=
less of their status.

I think this process is actually simpler than the former one, requires le=
ss changes in the habits of everyone invovled, improves the visibility of=
 the ongoing backport effort and I'm happy about it.

Feel free to criticize bluntly, now is the time :-)

On 03/02/2015 14:32, Loic Dachary wrote:
> Hi Ceph,
>=20
> A month ago the following workflow was posted and I began to implement =
it.
>=20
>> 0. Developer follows normal process to land PR to master. Once complet=
e and ticket is marked Pending Backport this process initiates.
>=20
> There were a few inconsistencies but they were easy to fix. When the ta=
g is missing I update it manually (the redmine API is broken http://track=
er.ceph.com/issues/10727 otherwise I would probably have written a script=
 to semi-manually do that).
>=20
>> 1. I periodically polls Redmine to look for tickets in Pending Backpor=
t state and focus on the ones that are left unattended for too long
>=20
> I focused on giant and dumpling and was able to help with a few backpor=
ts. However, I've not yet visited the majority of the issues that need at=
tention ( see http://workbench.dachary.org/ceph/ceph-backports/wikis/dump=
ling#issues-that-need-backporting for dumpling and http://workbench.dacha=
ry.org/ceph/ceph-backports/wikis/giant#issues-that-need-backporting for g=
iant ).
>=20
>> 1a. Under the supervision of the author of the original patch, I find =
the commits associated with the Redmine ticket and Cherry Pick to the bac=
kport integration branch off of the desired maintenance branch (Dumping, =
Firefly, etc).
>> 1b. I resolve any merge conflicts with the cherry-picked commit
>=20
> It turns out that finding the relevant commits in almost all backports =
is made possible by the cross references between pull requests, commits a=
nd issues. I was able to backport commits that are trivial. Most of the o=
ther backports were done by the original author of the patch because I di=
d not understand enough of the context to be helpful.=20
>=20
>> 2. I merge all backports for a given branch in an integration branch
>=20
> It is done with something like
>=20
> git merge --strategy octopus backports/pull/3439/head backports/pull/35=
52/head backports/pull/3489/head
>=20
> and there currently are two integration branches:
>=20
> * pull requests in dumpling-backports http://workbench.dachary.org/ceph=
/ceph-backports/wikis/dumpling#included-and-tested-in-integration-branch
> * pull requests in giant-backports http://workbench.dachary.org/ceph/ce=
ph-backports/wikis/giant#included-and-tested-in-integration-branch
>=20
> Only once did I face a merge conflict. It was trivial and I resolved it=
=2E I should go back to the author of the patch and warn him about this c=
onflict so that it does not create difficulties when all branches are fin=
ally merged.
>=20
>> 3. I ask the leads of each project to review the integration
>=20
> I did not do that. If I had been able to backport the non trivial commi=
ts, it may have been necessary. But I've been in contact with the leads r=
egarding the individual backports and reviewing the set of commits being =
integrated seemed redundant.=20
>=20
>> 4. Once satisfied with group of backported commits to integration bran=
ch, I notify QE.
>=20
> Running rbd, rados, rgw and is the bulkd of the work. The progress of t=
he test runs and analysis are:
>=20
> * dumpling http://tracker.ceph.com/issues/10560
> * giant http://tracker.ceph.com/issues/10501
>=20
> This is usually done as a mail thread in the ceph-qa mailing list but I=
 did not want to disturb the list with the backports. In addition I felt =
the need to see the past analysis on a single page to remember where I wa=
s after a few days doing something else. The mail thread format did not p=
rovide that and I prefered to create a ticket for that purpose. It's prov=
en both useful and cumbersome, I'll try to figure out something that show=
s the same information without so much manual maintenance.
>=20
>> 5. QE tests backport integration branch against appropriate suites
>> 6a. If QE is satisfied with test results, they merge backport integrat=
ion branch.
>> 6b. If QE is NOT satisfied with the test results, they indicate backpo=
rt integration branch is NOT ready to merge and return to me to work with=
 original Developer to resolve issue and return to steps 2/3
>> 7. Ticket is moved to Resolved once backport integration branch contai=
ning cherry-picked backport is merged to the desired mainteance branch(es=
)
>=20
> I've not yet reached this point, to be continued :-)
>=20
> Cheers
>=20
> P.S. Manually investigating each backport proved to be extremely tediou=
s and repetitive. Fortunately there are patterns that allowed me to grow =
a script that creates an inventory for each branch to be backported ( htt=
p://workbench.dachary.org/ceph/ceph-backports/wikis/dumpling etc. ) that =
I use as my landing page when working on backports.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--hffV3DLdDHqq7BQkc0Dc8tlHC2X3HR3u1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTbhmwACgkQ8dLMyEl6F22RigCfT/2EM89InxQeVbSQHLPTJv8z
5BEAn16QSX3E2vcBvI59Bw6/TukQKtwg
=9k1V
-----END PGP SIGNATURE-----

--hffV3DLdDHqq7BQkc0Dc8tlHC2X3HR3u1--
