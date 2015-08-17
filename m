From: Loic Dachary <loic@dachary.org>
Subject: Re: Signed-off-by and aliases
Date: Mon, 17 Aug 2015 22:44:00 +0200
Message-ID: <55D24790.4010703@dachary.org>
References: <55BBD384.7030703@dachary.org> <CALe9h7fsi-UcQ3W0d=t4dCBpNy5vtL8q=sO902FbQN21yNGjQg@mail.gmail.com> <55BFCAAB.1040707@dachary.org> <CAC6JEv-teZ0jq-t7f+==e0f5BQHAD4qrm5EOFMWJ1+g8zqLHcQ@mail.gmail.com> <55CB4163.9040504@dachary.org> <55CDABB2.4080401@suse.de> <55CDC978.20304@dachary.org> <mqtfkc$ic7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rgQxGQuHPh6gPQLl6GFacVdfW9EWixD1r"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39366 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750942AbbHQUoD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Aug 2015 16:44:03 -0400
In-Reply-To: <mqtfkc$ic7$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rgQxGQuHPh6gPQLl6GFacVdfW9EWixD1r
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On 17/08/2015 22:19, Alex Elsayed wrote:
> Loic Dachary wrote:
>=20
>> Hi Joao,
> <snipping quite a bit>
>=20
>> It is quite impossible for us (non lawyers) to draw the line that
>> separates parano=C3=AFa and common sense. Reason why most discussions =
on these
>> topics turn short. I cannot dismiss the scenario you describe and I'm
>> quite sure asking a lawyer would not clarify anything. Mostly because
>> whatever the question, the lawyer answer will always be : "maybe" and
>> never "yes" or "no" ;-)

That reminds me of an amusing talk in the FOSDEM legal track a few years =
back, specifically on that topic :-)

<snip>--<snip>

>> So, how can one make an opinion on a topic (s)he does not fully unders=
tand
>> ? I chose to decide based on facts I have and favor what give us (the =
Ceph
>> project community) more flexibility. I don't think anyone has any fact=

>> regarding legal troubles related to contributor using aliases. And sin=
ce
>> we don't verify contributor backgrounds anyway, acknowledging that we
>> already accept aliases makes sense to me.
>=20
> This is where I see a subtle, but meaningful distinction: Accepting fro=
m=20
> aliases *which have submitted a DCO* means that the person behind the a=
lias,=20
> even if we don't know their name, has bound themselves to a standard ov=
=20
> behavior.
>=20
> Accepting from arbitrary aliases does _not_ carry that meaning.

Yes. Although we don't do formal background checks, we make sure that eac=
h commit is Signed-off-by: the author as required by https://github.com/c=
eph/ceph/blob/master/SubmittingPatches#L22 which is linked from the https=
://github.com/ceph/ceph/blob/master/CONTRIBUTING.rst document that shows =
whenever someone submits a pull request.

I also believe this is an important distinction and I would feel uncomfor=
table if Ceph accepted contributions (aliases or not) that are not Signed=
-off one way or the other.

Cheers

>=20
>> The value of this thread is more about how we collectively form a
>> consensus on a topic that has legal implications than the question of
>> accepting aliases or not. As Greg mentioned, all developers/organizati=
ons
>> holding a significant part of the Ceph copyright know each other. What=
ever
>> is decided regarding aliases, it is not going to have any actual legal=

>> impact. But it would be great if we can somehow come up with a consens=
us.
>> Ultimately the decision is not for us to make anyway: we're not a
>> democracy. But it's not because a community has no power to decide tha=
t it
>> must not have an opinion ;-)
>=20
> Entirely agreed.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--rgQxGQuHPh6gPQLl6GFacVdfW9EWixD1r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXSR5AACgkQ8dLMyEl6F2005QCfXqEPUGp663xASCF//98e8A2b
6J0An2pWzo0+IRKxvZLquHTb6eRQzL6B
=1bpC
-----END PGP SIGNATURE-----

--rgQxGQuHPh6gPQLl6GFacVdfW9EWixD1r--
