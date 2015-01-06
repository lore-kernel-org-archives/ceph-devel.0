From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph backports
Date: Tue, 06 Jan 2015 01:12:55 +0100
Message-ID: <54AB2887.8000503@dachary.org>
References: <54AA7B46.6090706@dachary.org>	<CAGd4Wr2aw1ODd=06dQa7HQzbFu6sYZeQGTOV5Vn6VW+j6dK63g@mail.gmail.com>	<54AA80AD.2010901@dachary.org> <CAC6JEv94h5edyT68UcseSbYLSnT+eFMsUOxo84sVLw1T1f446g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="H3pi7ErFhbvd9rx2CIwkLQJkftf9GiTWM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33941 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753300AbbAFAM7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 19:12:59 -0500
In-Reply-To: <CAC6JEv94h5edyT68UcseSbYLSnT+eFMsUOxo84sVLw1T1f446g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H3pi7ErFhbvd9rx2CIwkLQJkftf9GiTWM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 06/01/2015 00:24, Gregory Farnum wrote:
> On Mon, Jan 5, 2015 at 4:16 AM, Loic Dachary <loic@dachary.org> wrote:
>>
>>
>> On 05/01/2015 13:03, John Spray wrote:
>>> Sounds sane -- is the new plan to always do backports via this
>>> process?  i.e. if I see a backport PR which has not been through
>>> integration testing, should I refrain from merging it?
>>
>> I think that's the idea, indeed. QE does the merge, when and if tests =
are green.
>>
>>>
>>> John
>>>
>>> On Mon, Jan 5, 2015 at 11:53 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>> Hi Ceph,
>>>>
>>>> I'm going to spend time to care for the Ceph backports (i.e. help re=
duce the time they stay in pull requests or redmine tickets). It should r=
oughly go as follows:
>>>>
>>>> 0. Developer follows normal process to land PR to master. Once compl=
ete and ticket is marked Pending Backport this process initiates.
>>>> 1. I periodically polls Redmine to look for tickets in Pending Backp=
ort state
>>>> 2. I find commit associated with Redmine ticket and Cherry Picks it =
to backport integration branch off of desired maintenance branch (Dumping=
, Firefly, etc). (Note - patch may require backport to multiple branches)=

>>>> 3. I resolve any merge conflicts with the cherry-picked commit
>>>> 4. Once satisfied with group of backported commits to integration br=
anch, I notifies QE.
>>>> 5. QE tests backport integration branch against appropriate suites
>>>> 6a. If QE is satisfied with test results, they merge backport integr=
ation branch.
>>>> 6b. If QE is NOT satisfied with the test results, they indicate back=
port integration branch is NOT ready to merge and return to me to work wi=
th original Developer to resolve issue and return to steps 2/3
>>>> 7. Ticket is moved to Resolved once backport integration branch cont=
aining cherry-picked backport is merged to the desired mainteance branch(=
es)
>>>>
>>>> I'll first try to implement this semi manually and document / script=
 when convenient. If anyone has ideas to improve this tentative process, =
now is the time :-)
>=20
>=20
> Okay, I've got a bunch of questions. In your first email it sounds
> like you're saying this is how you're going to voluntarily handle some
> backports. But in response to John's email it sounds like you want to
> gate all backports through yourself and this process. Is this a
> request that everybody else stops performing backports, and have you
> checked with enough usual suspects to make sure they'll respect the
> process? ;)

:-) This process is helpful if it allows me to help a little more than I =
currently do with the backport process. It would be a loss if the end res=
ult is that everyone cares less about backports. My primary incentive for=
 sending this mail is to start the conversation and avoid that kind of un=
intended drawback.

> I am 100% on board with making QE responsible for gating backports, so
> thank you for starting down that path. :) But I'm not at all sure how
> this scales for you. Right now backports are nominally run through two
> important checks:
> 1) Is it suitable for backport (decided by author or tech lead, marked
> via the Pending Backport tag)
> 2) Has it been through sufficient validation in master to be safe to
> backport (not marked in the system anywhere, just by somebody actually
> doing the backport).
>=20
> Knowing if something has been through sufficient validation to
> backport requires a fair bit of attention to the details of the ticket
> and the patches involved. How do you plan to keep up on that?

I can't do that all by myself.

> Similarly, while point releases are largely ad-hoc, we are trying to
> involve all the leads in the time-to-go decision. A lot of those
> decisions rest on whether specific backports have been performed yet,
> whether there are very new backports we want to run through testing
> for a little longer, etc. That sounds like a lot of communications
> overhead between the backport gates and the leads when making these
> kinds of decisions and I'm not sure how that should happen; is there a
> plan? (We can look at ticket status for things which are pending
> backport, but that doesn't facilitate prioritizing their backports;
> and in the opposite direction there's not a good way to say "this
> relatively large backport needs to go through at least three test runs
> before a release".)

Could you point me to a mail thread / IRC conversation that is representa=
tive of this process ?

Here is a revised process which is hopefully more realistic:

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
g cherry-picked backport is merged to the desired mainteance branch(es)

What do you think ?

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


--H3pi7ErFhbvd9rx2CIwkLQJkftf9GiTWM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSrKIcACgkQ8dLMyEl6F221WwCfRYjnin3mJTWOAdS7VsXCdW9B
tJcAn3zyvApQWKYiZrjKq0Jdp4jZa4Xk
=kuPy
-----END PGP SIGNATURE-----

--H3pi7ErFhbvd9rx2CIwkLQJkftf9GiTWM--
