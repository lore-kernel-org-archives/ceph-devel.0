From: Loic Dachary <loic@dachary.org>
Subject: Ceph backports workflow update
Date: Tue, 03 Feb 2015 14:32:11 +0100
Message-ID: <54D0CDDB.1020102@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Ghjf0RBvAdf1wNrJSRC0NcjIj7FNjNrRQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51955 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753986AbbBCNcO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 08:32:14 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id F39DA42B2C
	for <ceph-devel@vger.kernel.org>; Tue,  3 Feb 2015 14:32:11 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ghjf0RBvAdf1wNrJSRC0NcjIj7FNjNrRQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

A month ago the following workflow was posted and I began to implement it=
=2E

> 0. Developer follows normal process to land PR to master. Once complete=
 and ticket is marked Pending Backport this process initiates.

There were a few inconsistencies but they were easy to fix. When the tag =
is missing I update it manually (the redmine API is broken http://tracker=
=2Eceph.com/issues/10727 otherwise I would probably have written a script=
 to semi-manually do that).

> 1. I periodically polls Redmine to look for tickets in Pending Backport=
 state and focus on the ones that are left unattended for too long

I focused on giant and dumpling and was able to help with a few backports=
=2E However, I've not yet visited the majority of the issues that need at=
tention ( see http://workbench.dachary.org/ceph/ceph-backports/wikis/dump=
ling#issues-that-need-backporting for dumpling and http://workbench.dacha=
ry.org/ceph/ceph-backports/wikis/giant#issues-that-need-backporting for g=
iant ).

> 1a. Under the supervision of the author of the original patch, I find t=
he commits associated with the Redmine ticket and Cherry Pick to the back=
port integration branch off of the desired maintenance branch (Dumping, F=
irefly, etc).
> 1b. I resolve any merge conflicts with the cherry-picked commit

It turns out that finding the relevant commits in almost all backports is=
 made possible by the cross references between pull requests, commits and=
 issues. I was able to backport commits that are trivial. Most of the oth=
er backports were done by the original author of the patch because I did =
not understand enough of the context to be helpful.=20

> 2. I merge all backports for a given branch in an integration branch

It is done with something like

git merge --strategy octopus backports/pull/3439/head backports/pull/3552=
/head backports/pull/3489/head

and there currently are two integration branches:

* pull requests in dumpling-backports http://workbench.dachary.org/ceph/c=
eph-backports/wikis/dumpling#included-and-tested-in-integration-branch
* pull requests in giant-backports http://workbench.dachary.org/ceph/ceph=
-backports/wikis/giant#included-and-tested-in-integration-branch

Only once did I face a merge conflict. It was trivial and I resolved it. =
I should go back to the author of the patch and warn him about this confl=
ict so that it does not create difficulties when all branches are finally=
 merged.

> 3. I ask the leads of each project to review the integration

I did not do that. If I had been able to backport the non trivial commits=
, it may have been necessary. But I've been in contact with the leads reg=
arding the individual backports and reviewing the set of commits being in=
tegrated seemed redundant.=20

> 4. Once satisfied with group of backported commits to integration branc=
h, I notify QE.

Running rbd, rados, rgw and is the bulkd of the work. The progress of the=
 test runs and analysis are:

* dumpling http://tracker.ceph.com/issues/10560
* giant http://tracker.ceph.com/issues/10501

This is usually done as a mail thread in the ceph-qa mailing list but I d=
id not want to disturb the list with the backports. In addition I felt th=
e need to see the past analysis on a single page to remember where I was =
after a few days doing something else. The mail thread format did not pro=
vide that and I prefered to create a ticket for that purpose. It's proven=
 both useful and cumbersome, I'll try to figure out something that shows =
the same information without so much manual maintenance.

> 5. QE tests backport integration branch against appropriate suites
> 6a. If QE is satisfied with test results, they merge backport integrati=
on branch.
> 6b. If QE is NOT satisfied with the test results, they indicate backpor=
t integration branch is NOT ready to merge and return to me to work with =
original Developer to resolve issue and return to steps 2/3
> 7. Ticket is moved to Resolved once backport integration branch contain=
ing cherry-picked backport is merged to the desired mainteance branch(es)=


I've not yet reached this point, to be continued :-)

Cheers

P.S. Manually investigating each backport proved to be extremely tedious =
and repetitive. Fortunately there are patterns that allowed me to grow a =
script that creates an inventory for each branch to be backported ( http:=
//workbench.dachary.org/ceph/ceph-backports/wikis/dumpling etc. ) that I =
use as my landing page when working on backports.

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Ghjf0RBvAdf1wNrJSRC0NcjIj7FNjNrRQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTQzdsACgkQ8dLMyEl6F21YPgCeKSUjJm3vHviF/+ddbwFR4shE
dD4An3r445az9ZHCtH9VqeLJ1MIDNwit
=oQMw
-----END PGP SIGNATURE-----

--Ghjf0RBvAdf1wNrJSRC0NcjIj7FNjNrRQ--
