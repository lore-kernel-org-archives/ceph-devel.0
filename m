From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph backports workflow update
Date: Wed, 11 Feb 2015 19:19:02 +0100
Message-ID: <54DB9D16.7090309@dachary.org>
References: <54D0CDDB.1020102@dachary.org>	<54DB866C.9020908@dachary.org> <CAC6JEv_yFPoYnio3_6DovFx7E_a7VoEn36z9x5umupsYo0wGXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uCaAg5fVbsDwQohKwhLoUQcsUgD5Vv1VN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42606 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753321AbbBKSTF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Feb 2015 13:19:05 -0500
In-Reply-To: <CAC6JEv_yFPoYnio3_6DovFx7E_a7VoEn36z9x5umupsYo0wGXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uCaAg5fVbsDwQohKwhLoUQcsUgD5Vv1VN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 11/02/2015 18:27, Gregory Farnum wrote:
> On Wed, Feb 11, 2015 at 8:42 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Ceph,
>>
>> Yesterday the dumpling & giant backport integration branches were appr=
oved by Yehuda, Sam and Josh and were handed over to QE. An interesting d=
iscussion followed and it revealed that my understanding of the intended =
workflow was significantly wrong. It took me a while to figure out someth=
ing that makes sense. There is a good chance that I'm wrong again, please=
 speak up :-)
>>
>> The workflow proposed a month ago was the following:
>>
>> 0. Developer follows normal process to land PR to master. Once complet=
e and ticket is marked Pending Backport this process initiates.
>> 1. I periodically polls Redmine to look for tickets in Pending Backpor=
t state and focus on the ones that are left unattended for too long
>> 1a. Under the supervision of the author of the original patch, I find =
the commits associated with the Redmine ticket and Cherry Pick to the bac=
kport integration branch off of the desired maintenance branch (Dumping, =
Firefly, etc).
>> 1b. I resolve any merge conflicts with the cherry-picked commit
>> 2. I merge all backports for a given branch in an integration branch
>> 3. I ask the leads of each project to review the integration
>> 4. Once satisfied with group of backported commits to integration bran=
ch, I notify QE.
>> 5. QE tests backport integration branch against appropriate suites
>> 6a. If QE is satisfied with test results, they merge backport integrat=
ion branch.
>> 6b. If QE is NOT satisfied with the test results, they indicate backpo=
rt integration branch is NOT ready to merge and return to me to work with=
 original Developer to resolve issue and return to steps 2/3
>> 7. Ticket is moved to Resolved once backport integration branch contai=
ning cherry-picked backport is merged to the desired mainteance branch(es=
)--
>>
>> I think it should be modified to something like the following: (I have=
 the role of "the backporter"):
>>
>> 0. Developer follows normal process to land PR to master. Once complet=
e and ticket is marked Pending Backport this process initiates.
>> 1. A cron job updates an inventory of the backports for each branch (s=
ee http://workbench.dachary.org/ceph/ceph-backports/wikis/firefly for ins=
tance)
>=20
> How's it updating that inventory?

I wrote a script that does cross referencing and writes this page. It's b=
een a precious tool for me to not get lost ;-) It is still in a state of =
flux http://workbench.dachary.org/dachary/ceph_workbench and will solidif=
y each time I use / update it.

>=20
>> 1a. The PR does not require integration (e.g. it changes the qa direct=
ory), it is merged in the release branch (dumpling, firefly, etc.) by the=
 reviewer
>=20
> Who are you expecting to create backport PRs? Way back when I thought
> that you were assembling branches and PRs based on tickets in the
> "Pending Backport" state, but now that looks not to be the case.

Sometime the developer does spontaneously. Sometime the developer marks t=
he "backport" field in the ticket and forgets about it. Then I look at th=
e backport, try to do it myself and if I can't I ask the developer (kindl=
y ;-) if he has time to do it. Sometime the developer will ask me "that n=
eeds backporting" and I'll update the tickets and try to backport success=
fully and only report back to the developer when the test results come ba=
ck green or red (that happened with ~15 backports for rgw). Sometime the =
lead tells me : we can't release this, we need to backport this issue (th=
at happened with rbd and Jason quickly backported the missing issue becau=
se it was the last piece of the puzzle).=20

>> 1b. The PR requires integration and the label "needs-qa" is added to i=
t by the reviewer.
>=20
> I thought the needs-qa label was a flag that it should go into a
> master integration branch (wip-sam-testing, wip-sage-testing, w/e);
> aren't the milestone LTS labels sufficient to indicate they should be
> tested in integration?

The "needs-qa" has no meaning when it comes to stable branch releases, th=
at's why I proposed to use it. The purpose is essentially the same. There=
 is a need to distinguish between PR that needs integration and the other=
s. For instance the tests suite patches that you merged in dumpling do no=
t need qa and you merged them directly. If there is no label to distingui=
sh between the two, there will be confusion and tools cannot be written t=
o pick the "needs-qa" PR.

>=20
>> 2. If the inventory page shows PR that are pending integration
>> 2a. The backporter merges them in the dumpling-backports, etc. integra=
tion branch
>> 2b. The backporter runs the rados, rgw, rbd etc. suites on the integra=
tion branch (if no rgw backports are present, rgw suite can be skipped et=
c.)
>> 2c. The backporter sorts and analyzes the test results, asking the dev=
eloper if necessary
>> 2d. If a problem is found on a PR, the backporter removes the "needs-q=
a" label from the PR and makes sure the developer is aware that integrati=
on failed and why
>> 2e. The PR successfully integrated are merged into the dumpling, firel=
fy, etc. branch
>> 3. A cron job runs various suites on the dumpling, firefly, etc. branc=
hes (AKA "the nightlies")
>> 3a. The nightlies send reports to the ceph-qa list when a suite comple=
tes
>> 3b. The leads of each component are responsible for analyzing and upda=
ting tracker.ceph.com accordingly
>=20
> Mmm. I'm happy to look at suites that get run this way but I'm
> unlikely to notice them go by on the list if I'm not poked about them
> =E2=80=94 I generally filter out anything that has a person's name in i=
t or
> whatever.

Ok. Do you look into the results for fs produced by the nightlies for the=
 stable branches ?=20

Cheers

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--uCaAg5fVbsDwQohKwhLoUQcsUgD5Vv1VN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTbnRYACgkQ8dLMyEl6F21uMwCgnu6UZS3bsvyE/KGZNGbkndGe
DvgAn3OU6rZpg+WeDWnjyORYc3ZxhJAz
=cZ55
-----END PGP SIGNATURE-----

--uCaAg5fVbsDwQohKwhLoUQcsUgD5Vv1VN--
