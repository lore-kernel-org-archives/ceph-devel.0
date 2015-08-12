From: Loic Dachary <loic@dachary.org>
Subject: Re: Signed-off-by and aliases
Date: Wed, 12 Aug 2015 14:51:47 +0200
Message-ID: <55CB4163.9040504@dachary.org>
References: <55BBD384.7030703@dachary.org>	<CALe9h7fsi-UcQ3W0d=t4dCBpNy5vtL8q=sO902FbQN21yNGjQg@mail.gmail.com>	<55BFCAAB.1040707@dachary.org> <CAC6JEv-teZ0jq-t7f+==e0f5BQHAD4qrm5EOFMWJ1+g8zqLHcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="h3CVWHhpLE4HgmVNO2kQlgVf3OKumnOb8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37103 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751205AbbHLMvt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Aug 2015 08:51:49 -0400
In-Reply-To: <CAC6JEv-teZ0jq-t7f+==e0f5BQHAD4qrm5EOFMWJ1+g8zqLHcQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h3CVWHhpLE4HgmVNO2kQlgVf3OKumnOb8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/08/2015 12:54, Gregory Farnum wrote:
> On Mon, Aug 3, 2015 at 11:10 PM, Loic Dachary <loic@dachary.org> wrote:=

>>
>>
>> On 03/08/2015 21:18, John Spray wrote:
>>> On Fri, Jul 31, 2015 at 8:59 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>> Hi Ceph,
>>>>
>>>> We require that each commit has a Signed-off-by line with the name a=
nd email of the author. The general idea is that the Ceph project trusts =
each developer to understand what it entails[1]. There is no formal verif=
ication : the person submitting the patch could use a fake name or publis=
h code from someone else. In reality the odds of that happening and causi=
ng problem are so low that neither Ceph nor the Linux kernel felt the nee=
d to impose a more formal process. There is no bullet proof process anywa=
y, it's all about balancing risks and costs.
>>>>
>>>> If a contributor was using an alias that looks like a real name (for=
 instance I could contribute under the name Louis Lavile), (s)he would go=
 unnoticed and her/his contribution would be accepted as any other. If th=
e same contributor was using an alias that is obviously an alias (such as=
 A. Nonymous), it would raise the question of accepting contributions Sig=
ned-off with an alias.
>>>>
>>>> I think Ceph should accept contributions that are signed with an ali=
as because it does not make a difference.
>>>>
>>>> From a lawyer perspective, there is a difference between an alias an=
d a real name, of course. Should the author be in court, (s)he would have=
 to prove (s)he is the person behind the alias. If (s)he was using her/hi=
s real name, an ID card would be enough. And probably other differences t=
hat I don't see because IANAL. However since we already accept Signed-off=
-by that are not formally verified, we're already in a situation where we=
 implicitly accept aliases. Explicitly accepting aliases would not change=
 that, therefore it is not actually something we need to run by lawyers b=
ecause nothing changes from a legal standpoint.
>>>>
>>>> What do you think ?
>>>
>>> (Without any legal knowledge whatsoever, and speaking in general term=
s
>>> rather than about any particular code or vendor's practices or
>>> products)
>>
>> In these matters the project lead needs to make a decision that makes =
sense and then ask a lawyers to implement it. We don't need to be lawyers=
 to do that.
>>
>>>
>>> My understanding is that projects use a Signed-off-by line for the
>>> contributor to certify that they agree with the "Developer's
>>> Certificate of Origin".
>>>
>>> The purpose of a certificate or origin is that if I am distributing
>>> AcmeProject packages, and EvilCorp says "hey, we found our highly
>>> patented code in your package!" then I can say "actually this was
>>> submitted by Elizabeth Windsor <liz@buckinghampalace.org>, who
>>> certified to me that she had the rights to the code.  I can thus
>>> demonstrate that the original infringement was by her, and any
>>> infringement in my distribution of the software was accidental, I
>>> acted in good faith."
>>>
>>> OTOH if I said "That code was contributed by A.Nonymous", then
>>> EvilCorp would say "Well, that could just as easily have been one of
>>> your own developers, acting anonymously, so you have not demonstrated=

>>> that the infringement was unintentional".
>>>
>>> So in my opinion, it is necessary that any project wishing to apply a=

>>> "certificate of origin" process also needs to have a real name policy=
=2E
>>
>> If that was indeed what a Signed-off-by does, I would also be against =
using aliases. In reality a Signed-off-by is nothing more than a convenie=
nt mean to get in touch with someone who claimed to be the author of a pa=
tch.
>>
>> The companies making and distributing Free Software using Signed-off-b=
y like Ceph does, do not attempt to even verify that the person behind th=
e Signed-off-by really is who (s)he claims. I don't think that's because =
they have been careless for the past decade. I think that's because it wo=
uld not make a significant difference and that it would be a burden to th=
e project. The company lawyers would certainly claim that it would be bet=
ter to verify the identity for each Signed-off-by. But in practice they d=
on't push for it, not even for the Linux kernel who went into more legal =
troubles than any other Free Software project.
>>
>> My point is that there could already be a dozen of aliases that look l=
ike real names in the current Signed-off-by list. Explicitly accepting al=
iases that look like aliases would just be an acknowledgement of what we =
already do.
>=20
> I won't be merging any code with obvious aliases for exactly the
> reasons John mentions. Obviously IANAL, but I think you'll find law
> proceedings in the USA would look much less kindly on accepting
> obvious aliases versus having a real name policy =E2=80=94 which we do,=
 even
> if it's not diligently checked.=20

It would be more accurate to say it is not checked at all. And it is the =
same for the Linux kernel.

> Keep in mind that we generally have a
> background on our contributors to track them down even if they are
> using a non-obvious alias.

As of today the Ceph repository has 427 contributors and 96 of them autho=
red more than 10 commits. I would not be surprised if one of them was an =
alias. The only background check we do is when asking a new contributor a=
bout his affiliation to an organization (see http://tracker.ceph.com/proj=
ects/ceph/wiki/Ceph_contributors_list_maintenance_guide). 41 contributors=
 declared that they are not affiliated to any organization and we did not=
 investigate further. Nor do I think we should.

You have a point: we know the vast majority of contributors, one way or t=
he other. It is a small world :-) If a contributor you know insisted on c=
ontributing using an alias, for ethical reasons, would you turn her/him d=
own ? Wouldn't it be better for you to be able to vouch for her/him someh=
ow ?

Cheers

> -Greg
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--h3CVWHhpLE4HgmVNO2kQlgVf3OKumnOb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXLQWMACgkQ8dLMyEl6F22IlwCfdeuXGboXae9wnKZxwmKhtuMb
d1QAoLx7sndvq73Ro/ihApNerxiO2yDe
=h3sS
-----END PGP SIGNATURE-----

--h3CVWHhpLE4HgmVNO2kQlgVf3OKumnOb8--
