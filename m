From: Loic Dachary <loic@dachary.org>
Subject: Re: NO pg created for eruasre-coded pool
Date: Tue, 14 Oct 2014 07:44:28 -0700
Message-ID: <543D36CC.8090706@dachary.org>
References: <11821_1413277626_543CE7BA_11821_8781_1_B9C8EFBF13B1354DB5FA000660D66DD00C18C864@PEXCVZYM14.corporate.adroot.infra.ftgroup> <543CF6D7.2070204@dachary.org> <14584_1413292808_543D2308_14584_1013_1_B9C8EFBF13B1354DB5FA000660D66DD00C18CAE0@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Aci7cDdESHUGf2WTExUurexskfqn37aR6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44784 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755286AbaJNOod (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 10:44:33 -0400
In-Reply-To: <14584_1413292808_543D2308_14584_1013_1_B9C8EFBF13B1354DB5FA000660D66DD00C18CAE0@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Aci7cDdESHUGf2WTExUurexskfqn37aR6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The ruleset has

{ "op": "chooseleaf_indep",
          "num": 0,
          "type": "host"},

but it does not look like your tree has a bucket of type host in it.

Cheers

On 14/10/2014 06:20, ghislain.chevalier@orange.com wrote:
> HI,
>=20
> THX Lo=EFc for your quick reply.
>=20
> Here is the result of ceph osd tree
>=20
> As showed at the last ceph day in Paris, we have multiple root but the =
ruleset 52 entered the crushmap on root default.
>=20
> # id    weight  type name       up/down reweight
> -100    0.09998 root diskroot
> -110    0.04999         diskclass fastsata
> 0       0.009995                        osd.0   up      1
> 1       0.009995                        osd.1   up      1
> 2       0.009995                        osd.2   up      1
> 3       0.009995                        osd.3   up      1
> -120    0.04999         diskclass slowsata
> 4       0.009995                        osd.4   up      1
> 5       0.009995                        osd.5   up      1
> 6       0.009995                        osd.6   up      1
> 7       0.009995                        osd.7   up      1
> 8       0.009995                        osd.8   up      1
> 9       0.009995                        osd.9   up      1
> -5      0.2     root approot
> -50     0.09999         appclient apprgw
> -501    0.04999                 appclass fastrgw
> 0       0.009995                                osd.0   up      1
> 1       0.009995                                osd.1   up      1
> 2       0.009995                                osd.2   up      1
> 3       0.009995                                osd.3   up      1
> -502    0.04999                 appclass slowrgw
> 4       0.009995                                osd.4   up      1
> 5       0.009995                                osd.5   up      1
> 6       0.009995                                osd.6   up      1
> 7       0.009995                                osd.7   up      1
> 8       0.009995                                osd.8   up      1
> 9       0.009995                                osd.9   up      1
> -51     0.09999         appclient appstd
> -511    0.04999                 appclass faststd
> 0       0.009995                                osd.0   up      1
> 1       0.009995                                osd.1   up      1
> 2       0.009995                                osd.2   up      1
> 3       0.009995                                osd.3   up      1
> -512    0.04999                 appclass slowstd
> 4       0.009995                                osd.4   up      1
> 5       0.009995                                osd.5   up      1
> 6       0.009995                                osd.6   up      1
> 7       0.009995                                osd.7   up      1
> 8       0.009995                                osd.8   up      1
> 9       0.009995                                osd.9   up      1
> -1      0.09999 root default
> -2      0.09999         datacenter nanterre
> -3      0.09999                 platform sandbox
> -13     0.01999                         host p-sbceph13
> 0       0.009995                                        osd.0   up     =
 1
> 5       0.009995                                        osd.5   up     =
 1
> -14     0.01999                         host p-sbceph14
> 1       0.009995                                        osd.1   up     =
 1
> 6       0.009995                                        osd.6   up     =
 1
> -15     0.01999                         host p-sbceph15
> 2       0.009995                                        osd.2   up     =
 1
> 7       0.009995                                        osd.7   up     =
 1
> -12     0.01999                         host p-sbceph12
> 3       0.009995                                        osd.3   up     =
 1
> 8       0.009995                                        osd.8   up     =
 1
> -11     0.01999                         host p-sbceph11
> 4       0.009995                                        osd.4   up     =
 1
> 9       0.009995                                        osd.9   up     =
 1
>=20
> Best regards
>=20
> -----Message d'origine-----
> De : Loic Dachary [mailto:loic@dachary.org]=20
> Envoy=E9 : mardi 14 octobre 2014 12:12
> =C0 : CHEVALIER Ghislain IMT/OLPS; ceph-devel@vger.kernel.org
> Objet : Re: [Ceph-Devel] NO pg created for eruasre-coded pool
>=20
>=20
>=20
> On 14/10/2014 02:07, ghislain.chevalier@orange.com wrote:
>> Hi all,
>>
>> Context :
>> Ceph : Firefly 0.80.6
>> Sandbox Platform  : Ubuntu 12.04 LTS, 5 VM (VMware), 3 mons, 10 osd
>>
>>
>> Issue:
>> I created an erasure-coded pool using the default profile
>> --> ceph osd pool create ecpool 128 128 erasure default
>> the erasure-code rule was dynamically created and associated to the po=
ol.
>> root@p-sbceph14:/etc/ceph# ceph osd crush rule dump erasure-code {=20
>> "rule_id": 7,
>>   "rule_name": "erasure-code",
>>   "ruleset": 52,
>>   "type": 3,
>>   "min_size": 3,
>>   "max_size": 20,
>>   "steps": [
>>         { "op": "set_chooseleaf_tries",
>>           "num": 5},
>>         { "op": "take",
>>           "item": -1,
>>           "item_name": "default"},
>>         { "op": "chooseleaf_indep",
>>           "num": 0,
>>           "type": "host"},
>>         { "op": "emit"}]}
>> root@p-sbceph14:/var/log/ceph# ceph osd pool get ecpool crush_ruleset
>> crush_ruleset: 52
>=20
>> No error message was displayed at pool creation but no pgs were create=
d.
>> --> rados lspools confirms the pool is created but rados/ceph df shows=
=20
>> --> no pg for this pool
>>
>> The command  "rados -p ecpool put services /etc/services" is inactive =

>> (stalled) and the following message is encountered in ceph.log
>> 2014-10-14 10:36:50.189432 osd.5 10.192.134.123:6804/21505 799 : [WRN]=
=20
>> slow request 960.230073 seconds old, received at 2014-10-14=20
>> 10:20:49.959255: osd_op(client.1192643.0:1 services [writefull=20
>> 0~19281] 100.5a48a9c2 ondisk+write e11869) v4 currently waiting for pg=
=20
>> to exist locally
>>
>> I don't know if I missed something or if the problem is somewhere else=
=2E.
>=20
> The erasure-code rule displayed will need at least three hosts. If ther=
e are not enough hosts with OSDs the mapping will fail and put will hang =
until an OSD becomes available to complete the mapping of OSDs to the PGs=
=2E What does your ceph osd tree shows ?
>=20
> Cheers
>=20
>>
>> Best regards
>> =20
>> =20
>> =20
>>
>>
>>
>>
>>
>>
>> ______________________________________________________________________=

>> ___________________________________________________
>>
>> Ce message et ses pieces jointes peuvent contenir des informations=20
>> confidentielles ou privilegiees et ne doivent donc pas etre diffuses, =

>> exploites ou copies sans autorisation. Si vous avez recu ce message=20
>> par erreur, veuillez le signaler a l'expediteur et le detruire ainsi q=
ue les pieces jointes. Les messages electroniques etant susceptibles d'al=
teration, Orange decline toute responsabilite si ce message a ete altere,=
 deforme ou falsifie. Merci.
>>
>> This message and its attachments may contain confidential or=20
>> privileged information that may be protected by law; they should not b=
e distributed, used or copied without authorisation.
>> If you have received this email in error, please notify the sender and=
 delete this message and its attachments.
>> As emails may be altered, Orange is not liable for messages that have =
been modified, changed or falsified.
>> Thank you.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =

>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--Aci7cDdESHUGf2WTExUurexskfqn37aR6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ9NswACgkQ8dLMyEl6F20ANwCglOqNHF+ZBj6+TO7v5F2pxeQO
5x0AnRwEONe7iitifAW7uM6H7+pAf0FL
=JdiS
-----END PGP SIGNATURE-----

--Aci7cDdESHUGf2WTExUurexskfqn37aR6--
