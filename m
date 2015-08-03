From: Loic Dachary <loic@dachary.org>
Subject: Re: Signed-off-by and aliases
Date: Mon, 03 Aug 2015 22:10:19 +0200
Message-ID: <55BFCAAB.1040707@dachary.org>
References: <55BBD384.7030703@dachary.org> <CALe9h7fsi-UcQ3W0d=t4dCBpNy5vtL8q=sO902FbQN21yNGjQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="RCuDk0sJqSI5BcL8G5cR7C0WPO5aoK2bm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60818 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755352AbbHCUKV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 16:10:21 -0400
In-Reply-To: <CALe9h7fsi-UcQ3W0d=t4dCBpNy5vtL8q=sO902FbQN21yNGjQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RCuDk0sJqSI5BcL8G5cR7C0WPO5aoK2bm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/08/2015 21:18, John Spray wrote:
> On Fri, Jul 31, 2015 at 8:59 PM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Ceph,
>>
>> We require that each commit has a Signed-off-by line with the name and=
 email of the author. The general idea is that the Ceph project trusts ea=
ch developer to understand what it entails[1]. There is no formal verific=
ation : the person submitting the patch could use a fake name or publish =
code from someone else. In reality the odds of that happening and causing=
 problem are so low that neither Ceph nor the Linux kernel felt the need =
to impose a more formal process. There is no bullet proof process anyway,=
 it's all about balancing risks and costs.
>>
>> If a contributor was using an alias that looks like a real name (for i=
nstance I could contribute under the name Louis Lavile), (s)he would go u=
nnoticed and her/his contribution would be accepted as any other. If the =
same contributor was using an alias that is obviously an alias (such as A=
=2E Nonymous), it would raise the question of accepting contributions Sig=
ned-off with an alias.
>>
>> I think Ceph should accept contributions that are signed with an alias=
 because it does not make a difference.
>>
>> From a lawyer perspective, there is a difference between an alias and =
a real name, of course. Should the author be in court, (s)he would have t=
o prove (s)he is the person behind the alias. If (s)he was using her/his =
real name, an ID card would be enough. And probably other differences tha=
t I don't see because IANAL. However since we already accept Signed-off-b=
y that are not formally verified, we're already in a situation where we i=
mplicitly accept aliases. Explicitly accepting aliases would not change t=
hat, therefore it is not actually something we need to run by lawyers bec=
ause nothing changes from a legal standpoint.
>>
>> What do you think ?
>=20
> (Without any legal knowledge whatsoever, and speaking in general terms
> rather than about any particular code or vendor's practices or
> products)

In these matters the project lead needs to make a decision that makes sen=
se and then ask a lawyers to implement it. We don't need to be lawyers to=
 do that.

>=20
> My understanding is that projects use a Signed-off-by line for the
> contributor to certify that they agree with the "Developer's
> Certificate of Origin".
>=20
> The purpose of a certificate or origin is that if I am distributing
> AcmeProject packages, and EvilCorp says "hey, we found our highly
> patented code in your package!" then I can say "actually this was
> submitted by Elizabeth Windsor <liz@buckinghampalace.org>, who
> certified to me that she had the rights to the code.  I can thus
> demonstrate that the original infringement was by her, and any
> infringement in my distribution of the software was accidental, I
> acted in good faith."
>=20
> OTOH if I said "That code was contributed by A.Nonymous", then
> EvilCorp would say "Well, that could just as easily have been one of
> your own developers, acting anonymously, so you have not demonstrated
> that the infringement was unintentional".
>=20
> So in my opinion, it is necessary that any project wishing to apply a
> "certificate of origin" process also needs to have a real name policy.

If that was indeed what a Signed-off-by does, I would also be against usi=
ng aliases. In reality a Signed-off-by is nothing more than a convenient =
mean to get in touch with someone who claimed to be the author of a patch=
=2E

The companies making and distributing Free Software using Signed-off-by l=
ike Ceph does, do not attempt to even verify that the person behind the S=
igned-off-by really is who (s)he claims. I don't think that's because the=
y have been careless for the past decade. I think that's because it would=
 not make a significant difference and that it would be a burden to the p=
roject. The company lawyers would certainly claim that it would be better=
 to verify the identity for each Signed-off-by. But in practice they don'=
t push for it, not even for the Linux kernel who went into more legal tro=
ubles than any other Free Software project.

My point is that there could already be a dozen of aliases that look like=
 real names in the current Signed-off-by list. Explicitly accepting alias=
es that look like aliases would just be an acknowledgement of what we alr=
eady do.=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--RCuDk0sJqSI5BcL8G5cR7C0WPO5aoK2bm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlW/yqsACgkQ8dLMyEl6F22RhwCgm+U0YbMqwpIM0bDEquz8SQ7J
/oUAnRnVpR6tsUKewmyaDjI8QJJq8lkQ
=L7gr
-----END PGP SIGNATURE-----

--RCuDk0sJqSI5BcL8G5cR7C0WPO5aoK2bm--
