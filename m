From: Loic Dachary <loic@dachary.org>
Subject: Re: Signed-off-by and aliases
Date: Fri, 14 Aug 2015 12:56:56 +0200
Message-ID: <55CDC978.20304@dachary.org>
References: <55BBD384.7030703@dachary.org>	<CALe9h7fsi-UcQ3W0d=t4dCBpNy5vtL8q=sO902FbQN21yNGjQg@mail.gmail.com>	<55BFCAAB.1040707@dachary.org> <CAC6JEv-teZ0jq-t7f+==e0f5BQHAD4qrm5EOFMWJ1+g8zqLHcQ@mail.gmail.com> <55CB4163.9040504@dachary.org> <55CDABB2.4080401@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lBB4j0dFqTDc6TK8ItI9dKPc66pSqmIpo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38107 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753903AbbHNK47 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Aug 2015 06:56:59 -0400
In-Reply-To: <55CDABB2.4080401@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lBB4j0dFqTDc6TK8ItI9dKPc66pSqmIpo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Joao,

On 14/08/2015 10:49, Joao Eduardo Luis wrote:
> On 08/12/2015 01:51 PM, Loic Dachary wrote:
>>
>>
>> On 12/08/2015 12:54, Gregory Farnum wrote:
>>> I won't be merging any code with obvious aliases for exactly the
>>> reasons John mentions. Obviously IANAL, but I think you'll find law
>>> proceedings in the USA would look much less kindly on accepting
>>> obvious aliases versus having a real name policy =E2=80=94 which we d=
o, even
>>> if it's not diligently checked.=20
>>
>> It would be more accurate to say it is not checked at all. And it is t=
he same for the Linux kernel.
>>
>>> Keep in mind that we generally have a
>>> background on our contributors to track them down even if they are
>>> using a non-obvious alias.
>>
>> As of today the Ceph repository has 427 contributors and 96 of them au=
thored more than 10 commits. I would not be surprised if one of them was =
an alias. The only background check we do is when asking a new contributo=
r about his affiliation to an organization (see http://tracker.ceph.com/p=
rojects/ceph/wiki/Ceph_contributors_list_maintenance_guide). 41 contribut=
ors declared that they are not affiliated to any organization and we did =
not investigate further. Nor do I think we should.
>>
>> You have a point: we know the vast majority of contributors, one way o=
r the other. It is a small world :-) If a contributor you know insisted o=
n contributing using an alias, for ethical reasons, would you turn her/hi=
m down ? Wouldn't it be better for you to be able to vouch for her/him so=
mehow ?
>=20
> Call me paranoid if you must, but if we were considering liability
> exposure of the project in case of IP violation, then this could be bad=

> for the one person merging the code knowingly a given contributor was
> using an alias.
>=20
> Say this contributor did contribute something that he shouldn't have. I=
f
> he did ask someone to use an alias instead, and this someone went on
> with 'okay, let's do this' and merged the code, I can't stop wondering
> whether a lawyer would not take advantage of it, arguing the developer
> performing the merge was complicit in the IP violation. He did know thi=
s
> one person was under an alias, he did know who this person was, made
> sure this person was not identified - "he most certainly knew something=

> bad was happening, AND DID NOTHING!"
>=20
> Also, what would the developer be expected to do if a court asked him
> who was the real author of a merge containing patches that violated
> someone's IP rights? Lying to protect the integrity of an alias doesn't=

> seem like the obvious choice.
>=20
> If someone is indeed interested in contributing under an alias, they
> should just get a sensible alias that would be assumed to be the real
> deal. And everyone can go on with their lives without having to be
> exposed, at some point, to the nastiness of IP litigation if things go
> sower, or having to lie to cover someone else's track if they cannot
> avoid being exposed to it.

It is quite impossible for us (non lawyers) to draw the line that separat=
es parano=C3=AFa and common sense. Reason why most discussions on these t=
opics turn short. I cannot dismiss the scenario you describe and I'm quit=
e sure asking a lawyer would not clarify anything. Mostly because whateve=
r the question, the lawyer answer will always be : "maybe" and never "yes=
" or "no" ;-)

Yet, we are to decide what makes sense and what does not. If you ask the =
OpenStack community, the majority agree that it is necessary to have a CL=
A. If you ask the Linux kernel community, the consensus seems to be that =
there is no need for a CLA. etc.

So, how can one make an opinion on a topic (s)he does not fully understan=
d ? I chose to decide based on facts I have and favor what give us (the C=
eph project community) more flexibility. I don't think anyone has any fac=
t regarding legal troubles related to contributor using aliases. And sinc=
e we don't verify contributor backgrounds anyway, acknowledging that we a=
lready accept aliases makes sense to me.

The value of this thread is more about how we collectively form a consens=
us on a topic that has legal implications than the question of accepting =
aliases or not. As Greg mentioned, all developers/organizations holding a=
 significant part of the Ceph copyright know each other. Whatever is deci=
ded regarding aliases, it is not going to have any actual legal impact. B=
ut it would be great if we can somehow come up with a consensus. Ultimate=
ly the decision is not for us to make anyway: we're not a democracy. But =
it's not because a community has no power to decide that it must not have=
 an opinion ;-)

Cheers

>=20
>   -Joao
>=20
>>
>> Cheers
>>
>>> -Greg
>>>
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--lBB4j0dFqTDc6TK8ItI9dKPc66pSqmIpo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXNyXgACgkQ8dLMyEl6F22fTgCcCcMAPGMk97yzYmujVajnaQpG
AAAAoJGqaleNXSVAmIdI+BS3neVgeI84
=oaU4
-----END PGP SIGNATURE-----

--lBB4j0dFqTDc6TK8ItI9dKPc66pSqmIpo--
