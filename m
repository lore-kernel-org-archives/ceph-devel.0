From: Loic Dachary <loic@dachary.org>
Subject: Proposal for a Backport tracker
Date: Thu, 21 May 2015 13:24:48 +0200
Message-ID: <555DC080.8050508@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="H12bnv3C0G8LC49uAi54iAlw88F7XIRvI"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48304 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754504AbbEULYv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 07:24:51 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 5638F42AF8
	for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 13:24:48 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H12bnv3C0G8LC49uAi54iAlw88F7XIRvI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

When an issue such as http://tracker.ceph.com/issues/9806 needs backporti=
ng,=20

 * its status is changed to Pending Backport
 * the backport field is modified to contain the target stable releases
 * the severity field is modified to reflect the urgency of the backport

(see also http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_sched=
ule_an_issue_for_backporting). When a backport is ready for a given stabl=
e release, a comment is added with something like:

  * firefly backport https://github.com/ceph/ceph/pull/XXX is added to th=
e issue

(either manually or in a semi automated way, see http://tracker.ceph.com/=
projects/ceph-releases/wiki/HOWTO_backport_commits).=20

=46rom time to time the Pending Backport issues are scrubbed to resolve t=
hose that have been successfully backported to all the desired stable rel=
eases (see http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_reso=
lve_issues_that_are_Pending_Backport for details).

This is not too complicated to explain and not too tedious to maintain. T=
he only pain point is that we use the original bug report to track backpo=
rts. It would probably be easier to have a separate issue, in a separate =
tracker to followup on the backports. It could go like this:

When an issue such as http://tracker.ceph.com/issues/9806 needs backporti=
ng,=20

  * its status is changed to Pending Backport
  * the backport field is modified to contain the target stable releases
  * a backport issue is created in the "Backport" tracker and is "Related=
" to the original issue (probably using a script parsing the content of t=
he backport field and not manually)
    * the issue is assigned to the backporter who will work on it
    * the release field of the backport issue is set to the target stable=
 release (hammer, firefly, ...)
    * the Priority field is modified to reflect the urgency of the backpo=
rt (it may be urgent for hammer and not for firefly, a distinction that i=
s currently lost and using the severity field is kind of confusing becaus=
e most if not all developers and predefined queries are looking at the va=
lue of the Priority field, not the severity field)
=20
When a backport is ready for a given stable release:

  * the "Backport URL" field of the backport issue is set to the correspo=
nding pull request or commit (sometime backports are not via a pull reque=
st, but all backports do have at least one URL)
  * when the backport is merged the issue is closed

=46rom time to time, the "Pending Backport" issues for which all related =
issues from the Backport tracker have been closed are also closed. This s=
tep could even be entirely automated.

An additional benefit of having this separate tracker is that issues that=
 require a non trivial backport could be assigned to a developer instead =
of a backporter and be discussed during bug scrub when reviewing http://t=
racker.ceph.com/projects/rbd/issues?query_id=3D27. There only are a handf=
ull of them: for instance http://tracker.ceph.com/issues/9806 could be as=
signed to Josh and during bug scrub it would show to be from the Backport=
 tracker.

The developer would not have to create issues to schedule a backport: (s)=
he would just update the backport field as (s)he currently does. The back=
porter will then be in charge of creating the issues. Most likely with a =
script creating the issues based on the content of the backport field ins=
tead of doing it manually. Having the developer create one issue per back=
port would not be good for two reasons : it would require explaining and =
it would be more work.

The justification for having a different tracker instead of using an exis=
ting one for the backport issues is primarily because the tracker shows i=
n a number of pre-existing custom queries such as http://tracker.ceph.com=
/projects/rbd/issues?query_id=3D27. It's a easy way to convey the informa=
tion: this issue is about backporting. A secondary benefit is that it's p=
ossible to define a workflow specific to a tracker, which could be intere=
sting in the future because the backport workflow is not the same as the =
bug fixing workflow.

This is just an idea and I did not think this through. I like it right no=
w but it just occurred to me this morning, after reading a mail from Josh=
 who suggested we need a way for issues such as #9806 to be visible durin=
g bug scrub. Feel free to criticize bluntly, I won't be offended ;-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--H12bnv3C0G8LC49uAi54iAlw88F7XIRvI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVdwIAACgkQ8dLMyEl6F23u+ACeMvRBRozQOtoM3J2wcKQxCrd8
330AoLdAt3sBSJRgCggTEcnFwJTgSCZO
=J4sI
-----END PGP SIGNATURE-----

--H12bnv3C0G8LC49uAi54iAlw88F7XIRvI--
