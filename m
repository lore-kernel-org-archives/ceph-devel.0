From: Loic Dachary <loic@dachary.org>
Subject: Re: [Ceph] Managing crushmap
Date: Sat, 14 Jun 2014 11:05:28 +0200
Message-ID: <539C1058.9010800@dachary.org>
References: <31473_1402478241_53981EA1_31473_30_1_B9C8EFBF13B1354DB5FA000660D66DD00C122930@PEXCVZYM14.corporate.adroot.infra.ftgroup> <CAPYLRzjj7C2HhHtwFqBJ6zPUeF-pPnhVMmceZSYOgSy-cPOzwA@mail.gmail.com> <32657_1402562812_539968FC_32657_8172_1_B9C8EFBF13B1354DB5FA000660D66DD00C123181@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QtGOFbHaQL12fnxuTT9bLmipIn6InVWJA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:44061 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbaFNJFb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jun 2014 05:05:31 -0400
In-Reply-To: <32657_1402562812_539968FC_32657_8172_1_B9C8EFBF13B1354DB5FA000660D66DD00C123181@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QtGOFbHaQL12fnxuTT9bLmipIn6InVWJA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ghislain,

The error you see when you

 ceph osd pool set data crush_ruleset 50

has been fixed recently and is going to be backported ( http://tracker.ce=
ph.com/issues/8599 ) Would you have time to check the backport once it's =
ready ?

Cheers

On 12/06/2014 10:46, ghislain.chevalier@orange.com wrote:
> Hi Greg,
>=20
> the information you requested:
> dumpling platform : ceph version 0.67.9 (ba340a97c3dafc9155023da8d515ee=
cc675c619a)
>=20
> See attached the decompiled crushmap
> (created today by "ceph osd getcrushmap -o crushmap_current" and crusht=
ool -d crushmap_current -o crushmap_current.txt)
> and the result of:
> - "ceph osd crush rule dump" in order to get rule_ids
> - "ceph osd dump | grep pool" in order to get pools characteristics=20
>=20
> The ceph commands I ran
> for crushmap
> 	ceph osd getcrushmap -o crushmap_current
> 	crushtool -d crushmap_current -o crushmap_current.txt
> 	vi crushmap_current.txt =3D=3D> crushmap_V2.4.txt
> 	crushtool -c crushmap_V2.4.txt -o crushmap_V2.4
> 	ceph osd setcrushmap -i crushmap_V2.4
> =09
> the file crushmap_current provided today is hence the decompilation of =
crushmap_V2.4
>=20
> for pool
> 	rados mkpool .rgw.fastrgw
> 	ceph osd pool set .rgw.fastrgw crush_ruleset 50 =3D=3D> crush ruleset =
50 does not exist
> 	ceph osd pool set .rgw.fastrgw crush_ruleset 4 =3D=3D> set pool 47 cru=
sh_ruleset to 4c
>=20
> I notice this morning that the following command works
> 	rados mkpool testpool 0 50
>=20
> It seems that the command ceph osd pool set <pool> crush_ruleset <rules=
et_number> is not working correctly.
>=20
> To go on my tests, I will delete the pools and recreate them using "rad=
os mkpool" adding directly the right ruleset.
>=20
> For the firefly platform (ceph version 0.80.1 (a38fe1169b6d2ac98b427334=
c12d7cf81f809b74)),
> we only checked that the behavior was identical after ingesting a rule =
with a ruleset which would not be equal to the rule_id.=20
>=20
> Note:
> the pools and rules names have changed since I sent the message but the=
 behavior remains the same
> Using calamari to modify pool parameters, the GUI is listing the rulese=
t but it has no effect (no update, no error displayed)
> Using Inkscope to modify pool parameters, we can force the ruleset numb=
er but it has no effect (no update, no error displayed)
> We noticed that the ceph-rest-api returns 200 OK even if the update is =
not set.
>=20
> Best regards
>=20
> -----Message d'origine-----
> De : Gregory Farnum [mailto:greg@inktank.com]=20
> Envoy=C3=A9 : mercredi 11 juin 2014 19:03
> =C3=80 : CHEVALIER Ghislain IMT/OLPS
> Cc : ceph-devel@vger.kernel.org
> Objet : Re: [Ceph] Managing crushmap
>=20
> That doesn't sound right. Can you supply your decompiled CRUSH map,
> the exact commands you ran against the ceph cluster, and the exact
> version(s) you ran the test against?
> -Greg
>=20
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>=20
>=20
> On Wed, Jun 11, 2014 at 2:17 AM,  <ghislain.chevalier@orange.com> wrote=
:
>> Hi all,
>>
>> Context :
>> Lab Platform
>> Ceph dumpling and firefly
>> Ubuntu 12.04 LTS
>>
>> I encountered a strange behavior managing the crushmap on a dumpling a=
nd a firefly ceph platform.
>>
>> I built a crushmap, adding 2 specific rules (fastrule and slowrule) in=
 order to experiment tiering.
>> I used "ceph osd get|setcrushmap" and crushtool to extract and ingest =
the updated crushmap in the system.
>> I have to precise that I respectively associated 50 and 51 as ruleset =
numbers for the 2 new rules.
>> The ingestion was good; I checked it by "ceph osd crush rule dump"
>>
>> I created 2 pools (fastpool and slowpool)
>> As indicated in the doc, I tried to associate fastpool to ruleset 50 b=
y "ceph osd pool set fastpool crush_ruleset 50"
>> an error occurred : rule 50 doesn't exist
>> As the rule_id of fastrule is 4, I did "ceph osd pool set fastpool cru=
sh_ruleset 4" and it works but it's not a correct behavior.
>> If a ceph admin wants to manage the crushmap, he doesn't have to check=
 the rule_id (that he cannot set) before updating the attribute crush_rul=
eset of pools.
>> The way to manage the rules if the ruleset not the rule_id.
>>
>> I also tested that reingesting a crushmap (after for example changing =
the sequence of the rules in the decompiled file) causes a global update =
of the rule_ids.
>> I can't imagine the impacts on a platform.
>>
>> Did someone encounter this behavior?
>> Did I misunderstand how to configure a crushmap?
>>
>> Best regards
>>
>>
>>
>>
>>
>> - - - - - - - - - - - - - - - - -
>> Ghislain Chevalier
>> ORANGE/OLNC/OLPS/ASE/DAPI/CSE
>> Architecte de services de stockage
>> Storage Service Architect
>>  +33299124432
>> ghislain.chevalier@orange.com
>> =EF=81=90 Pensez =C3=A0 l'Environnement avant d'imprimer ce message !
>>
>>
>> ______________________________________________________________________=
___________________________________________________
>>
>> Ce message et ses pieces jointes peuvent contenir des informations con=
fidentielles ou privilegiees et ne doivent donc
>> pas etre diffuses, exploites ou copies sans autorisation. Si vous avez=
 recu ce message par erreur, veuillez le signaler
>> a l'expediteur et le detruire ainsi que les pieces jointes. Les messag=
es electroniques etant susceptibles d'alteration,
>> Orange decline toute responsabilite si ce message a ete altere, deform=
e ou falsifie. Merci.
>>
>> This message and its attachments may contain confidential or privilege=
d information that may be protected by law;
>> they should not be distributed, used or copied without authorisation.
>> If you have received this email in error, please notify the sender and=
 delete this message and its attachments.
>> As emails may be altered, Orange is not liable for messages that have =
been modified, changed or falsified.
>> Thank you.
>>
>=20
> _______________________________________________________________________=
__________________________________________________
>=20
> Ce message et ses pieces jointes peuvent contenir des informations conf=
identielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous avez =
recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les message=
s electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, deforme=
 ou falsifie. Merci.
>=20
> This message and its attachments may contain confidential or privileged=
 information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender and =
delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have b=
een modified, changed or falsified.
> Thank you.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--QtGOFbHaQL12fnxuTT9bLmipIn6InVWJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOcEFgACgkQ8dLMyEl6F21vngCeLcuEH4QvVCixkjclLoqQzgmC
40sAnilHDPUrXigEB9WcB4oSwPyFXubO
=fANV
-----END PGP SIGNATURE-----

--QtGOFbHaQL12fnxuTT9bLmipIn6InVWJA--
