From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph backports
Date: Tue, 06 Jan 2015 09:39:07 +0100
Message-ID: <54AB9F2B.1020700@dachary.org>
References: <54AA7B46.6090706@dachary.org>	<CAGd4Wr2aw1ODd=06dQa7HQzbFu6sYZeQGTOV5Vn6VW+j6dK63g@mail.gmail.com>	<54AA80AD.2010901@dachary.org>	<CAC6JEv94h5edyT68UcseSbYLSnT+eFMsUOxo84sVLw1T1f446g@mail.gmail.com>	<54AB2887.8000503@dachary.org> <CAC6JEv-uzfzEtLb5X29ne2ME7gTDeysByG0DDJRNZxBQ2WCUEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uKbG6q6i3KIwxhJLJhDcf5B6EaJhsUk1i"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34089 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751426AbbAFIjJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 03:39:09 -0500
In-Reply-To: <CAC6JEv-uzfzEtLb5X29ne2ME7gTDeysByG0DDJRNZxBQ2WCUEg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uKbG6q6i3KIwxhJLJhDcf5B6EaJhsUk1i
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 06/01/2015 01:22, Gregory Farnum wrote:
> On Mon, Jan 5, 2015 at 4:12 PM, Loic Dachary <loic@dachary.org> wrote:
>> :-) This process is helpful if it allows me to help a little more than=
 I currently do with the backport process. It would be a loss if the end =
result is that everyone cares less about backports. My primary incentive =
for sending this mail is to start the conversation and avoid that kind of=
 unintended drawback.
>=20
> Why do you want to get involved with other people's backports at all?

Just in case there is a need for more workforce.

> I don't mean that to sound possessive, but having the patch's primary
> author responsible for getting backports done at least has the
> singular merit of sharding the work up into manageable pieces. ;)

Absolutely.=20
>=20
>>
>>> I am 100% on board with making QE responsible for gating backports, s=
o
>>> thank you for starting down that path. :) But I'm not at all sure how=

>>> this scales for you. Right now backports are nominally run through tw=
o
>>> important checks:
>>> 1) Is it suitable for backport (decided by author or tech lead, marke=
d
>>> via the Pending Backport tag)
>>> 2) Has it been through sufficient validation in master to be safe to
>>> backport (not marked in the system anywhere, just by somebody actuall=
y
>>> doing the backport).
>>>
>>> Knowing if something has been through sufficient validation to
>>> backport requires a fair bit of attention to the details of the ticke=
t
>>> and the patches involved. How do you plan to keep up on that?
>>
>> I can't do that all by myself.
>>
>>> Similarly, while point releases are largely ad-hoc, we are trying to
>>> involve all the leads in the time-to-go decision. A lot of those
>>> decisions rest on whether specific backports have been performed yet,=

>>> whether there are very new backports we want to run through testing
>>> for a little longer, etc. That sounds like a lot of communications
>>> overhead between the backport gates and the leads when making these
>>> kinds of decisions and I'm not sure how that should happen; is there =
a
>>> plan? (We can look at ticket status for things which are pending
>>> backport, but that doesn't facilitate prioritizing their backports;
>>> and in the opposite direction there's not a good way to say "this
>>> relatively large backport needs to go through at least three test run=
s
>>> before a release".)
>>
>> Could you point me to a mail thread / IRC conversation that is represe=
ntative of this process ?
>=20
> No; that's pretty much all done in video chats. :/
>=20
>>
>> Here is a revised process which is hopefully more realistic:
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
)
>>
>> What do you think ?
>=20
> I think if we're going to add a process to anything it should be
> followed by everybody involved. I really would love for everything to
> be gated by QE before it goes into a backport branch, but if you're
> going off and building integration branches and QE is testing them, I
> think other people are going to keep backporting as we have been and
> trip all over each other. We've periodically used "firefly-next"
> branches and related things, but it's always been ad-hoc.
>=20
> Something more realistic might involve locking down the stable
> branches so they can only be merged into by QE or some approved group,
> and then letting people do their own backports onto a
> <stable-branch>-next that is periodically taken up and
> integration-tested prior to merge into the LTS proper. That ensures
> that only patches which have all been tested together get into a
> stable branch without forcing each individual backport into a lot of
> process.

Let me rephrase to make sure I understand what you're suggesting.=20

At the moment, as far as I can tell, developers do the backport of their =
patches if / when necessary and make sure they are green / yellow in gitb=
uilder. The integration itself happens on the stable branch, when such ba=
ckports are merged: there is no integration branch (with the exception of=
 an occasional XXX-next) nor someone focusing on integration. At some poi=
nt in time the leads of each component get together and check if the curr=
ent set of patches in the not-yet-released stable branch would make a sen=
sible point release. The teuthology test suites are run, the results are =
analysed, the errors fixed and the release published.=20

My past experience is that once the backport is merged in the stable bran=
ch my task is done as a developer. I'm not required when the release time=
 comes and integration is something I'm mostly unaware of.

You propose that developers do some of the integration work. Instead of m=
erging into the stable branch one backport at a time, they would first me=
rge their backports into their own integration branch. These individual i=
ntegration branches would then be taken (by me for instance or someone el=
se willing to do that), put together, and sent to QE for testing. If it t=
urns out that a developer did not create an integration branch, the pendi=
ng backports would be merged as they currently are.

Am I following ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--uKbG6q6i3KIwxhJLJhDcf5B6EaJhsUk1i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSrnysACgkQ8dLMyEl6F20MQACgmc5IQBkwDp47lnNTPyvcZ/V9
iewAnietpSJ1IRv0rcP61G5z2YNkdkAc
=JBPE
-----END PGP SIGNATURE-----

--uKbG6q6i3KIwxhJLJhDcf5B6EaJhsUk1i--
