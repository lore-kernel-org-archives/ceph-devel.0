From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph backports
Date: Tue, 06 Jan 2015 19:28:08 +0100
Message-ID: <54AC2938.5060802@dachary.org>
References: <54AA7B46.6090706@dachary.org>	<CAGd4Wr2aw1ODd=06dQa7HQzbFu6sYZeQGTOV5Vn6VW+j6dK63g@mail.gmail.com>	<54AA80AD.2010901@dachary.org>	<CAC6JEv94h5edyT68UcseSbYLSnT+eFMsUOxo84sVLw1T1f446g@mail.gmail.com>	<54AB2887.8000503@dachary.org>	<CAC6JEv-uzfzEtLb5X29ne2ME7gTDeysByG0DDJRNZxBQ2WCUEg@mail.gmail.com>	<54AB9F2B.1020700@dachary.org> <CAC6JEv_UJoLmvkr0kyBaxV=hfU9u4t8tCjXsUydg86Z+xNz08w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="33GT2pk5pNQr1W3epgTAieiIfr3o3nmOm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34431 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755972AbbAFS2K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jan 2015 13:28:10 -0500
In-Reply-To: <CAC6JEv_UJoLmvkr0kyBaxV=hfU9u4t8tCjXsUydg86Z+xNz08w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--33GT2pk5pNQr1W3epgTAieiIfr3o3nmOm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 06/01/2015 19:21, Gregory Farnum wrote:
> On Tue, Jan 6, 2015 at 12:39 AM, Loic Dachary <loic@dachary.org> wrote:=

>>
>>
>> On 06/01/2015 01:22, Gregory Farnum wrote:
>>> On Mon, Jan 5, 2015 at 4:12 PM, Loic Dachary <loic@dachary.org> wrote=
:
>>>> :-) This process is helpful if it allows me to help a little more th=
an I currently do with the backport process. It would be a loss if the en=
d result is that everyone cares less about backports. My primary incentiv=
e for sending this mail is to start the conversation and avoid that kind =
of unintended drawback.
>>>
>>> Why do you want to get involved with other people's backports at all?=

>>
>> Just in case there is a need for more workforce.
>>
>>> I don't mean that to sound possessive, but having the patch's primary=

>>> author responsible for getting backports done at least has the
>>> singular merit of sharding the work up into manageable pieces. ;)
>>
>> Absolutely.
>>>
>>>>
>>>>> I am 100% on board with making QE responsible for gating backports,=
 so
>>>>> thank you for starting down that path. :) But I'm not at all sure h=
ow
>>>>> this scales for you. Right now backports are nominally run through =
two
>>>>> important checks:
>>>>> 1) Is it suitable for backport (decided by author or tech lead, mar=
ked
>>>>> via the Pending Backport tag)
>>>>> 2) Has it been through sufficient validation in master to be safe t=
o
>>>>> backport (not marked in the system anywhere, just by somebody actua=
lly
>>>>> doing the backport).
>>>>>
>>>>> Knowing if something has been through sufficient validation to
>>>>> backport requires a fair bit of attention to the details of the tic=
ket
>>>>> and the patches involved. How do you plan to keep up on that?
>>>>
>>>> I can't do that all by myself.
>>>>
>>>>> Similarly, while point releases are largely ad-hoc, we are trying t=
o
>>>>> involve all the leads in the time-to-go decision. A lot of those
>>>>> decisions rest on whether specific backports have been performed ye=
t,
>>>>> whether there are very new backports we want to run through testing=

>>>>> for a little longer, etc. That sounds like a lot of communications
>>>>> overhead between the backport gates and the leads when making these=

>>>>> kinds of decisions and I'm not sure how that should happen; is ther=
e a
>>>>> plan? (We can look at ticket status for things which are pending
>>>>> backport, but that doesn't facilitate prioritizing their backports;=

>>>>> and in the opposite direction there's not a good way to say "this
>>>>> relatively large backport needs to go through at least three test r=
uns
>>>>> before a release".)
>>>>
>>>> Could you point me to a mail thread / IRC conversation that is repre=
sentative of this process ?
>>>
>>> No; that's pretty much all done in video chats. :/
>>>
>>>>
>>>> Here is a revised process which is hopefully more realistic:
>>>>
>>>> 0. Developer follows normal process to land PR to master. Once compl=
ete and ticket is marked Pending Backport this process initiates.
>>>> 1. I periodically polls Redmine to look for tickets in Pending Backp=
ort state and focus on the ones that are left unattended for too long
>>>> 1a. Under the supervision of the author of the original patch, I fin=
d the commits associated with the Redmine ticket and Cherry Pick to the b=
ackport integration branch off of the desired maintenance branch (Dumping=
, Firefly, etc).
>>>> 1b. I resolve any merge conflicts with the cherry-picked commit
>>>> 2. I merge all backports for a given branch in an integration branch=

>>>> 3. I ask the leads of each project to review the integration
>>>> 4. Once satisfied with group of backported commits to integration br=
anch, I notify QE.
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
>>>> What do you think ?
>>>
>>> I think if we're going to add a process to anything it should be
>>> followed by everybody involved. I really would love for everything to=

>>> be gated by QE before it goes into a backport branch, but if you're
>>> going off and building integration branches and QE is testing them, I=

>>> think other people are going to keep backporting as we have been and
>>> trip all over each other. We've periodically used "firefly-next"
>>> branches and related things, but it's always been ad-hoc.
>>>
>>> Something more realistic might involve locking down the stable
>>> branches so they can only be merged into by QE or some approved group=
,
>>> and then letting people do their own backports onto a
>>> <stable-branch>-next that is periodically taken up and
>>> integration-tested prior to merge into the LTS proper. That ensures
>>> that only patches which have all been tested together get into a
>>> stable branch without forcing each individual backport into a lot of
>>> process.
>>
>> Let me rephrase to make sure I understand what you're suggesting.
>>
>> At the moment, as far as I can tell, developers do the backport of the=
ir patches if / when necessary and make sure they are green / yellow in g=
itbuilder. The integration itself happens on the stable branch, when such=
 backports are merged: there is no integration branch (with the exception=
 of an occasional XXX-next) nor someone focusing on integration. At some =
point in time the leads of each component get together and check if the c=
urrent set of patches in the not-yet-released stable branch would make a =
sensible point release. The teuthology test suites are run, the results a=
re analysed, the errors fixed and the release published.
>>
>> My past experience is that once the backport is merged in the stable b=
ranch my task is done as a developer. I'm not required when the release t=
ime comes and integration is something I'm mostly unaware of.
>>
>> You propose that developers do some of the integration work. Instead o=
f merging into the stable branch one backport at a time, they would first=
 merge their backports into their own integration branch. These individua=
l integration branches would then be taken (by me for instance or someone=
 else willing to do that), put together, and sent to QE for testing. If i=
t turns out that a developer did not create an integration branch, the pe=
nding backports would be merged as they currently are.
>=20
> I'm just trying to understand how things scale past one developer. I
> gather that Sam and Sage do a lot more backports than I do and are
> already not getting them done, so simply having somebody poke at
> backports is an improvement? If that's all you're after then this is
> sensible =E2=80=94 I just don't want to have backports of my own and do=
 the
> wrong thing with them. If you want to pick a process and tell me where
> I stick my nose in I'm happy to try it out. :)

Cool :-). Things are a little vague at the moment so I just went ahead an=
d try to semi-manually collect backports and cross check the informations=
 I found here and there. I guess making it clear where we're at is alread=
y a help.=20

Cheers

> -Greg
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--33GT2pk5pNQr1W3epgTAieiIfr3o3nmOm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSsKTgACgkQ8dLMyEl6F20EvwCfS0dOdD2Dbvva8Ty90zaCR36T
q08An2vfrzaUeE3z9S9LGCWfL9PG7XKb
=vpjd
-----END PGP SIGNATURE-----

--33GT2pk5pNQr1W3epgTAieiIfr3o3nmOm--
