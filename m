From: <ghislain.chevalier@orange.com>
Subject: RE: NO pg created for erasure-coded pool
Date: Tue, 14 Oct 2014 15:14:49 +0000
Message-ID: <495_1413299690_543D3DEA_495_10637_1_B9C8EFBF13B1354DB5FA000660D66DD00C18CBCE@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_B9C8EFBF13B1354DB5FA000660D66DD00C18CBCEPEXCVZYM14corpo_"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias92.francetelecom.com ([193.251.215.92]:44157 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932147AbaJNPOx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Oct 2014 11:14:53 -0400
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--_002_B9C8EFBF13B1354DB5FA000660D66DD00C18CBCEPEXCVZYM14corpo_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Here is the list of the types. host is type 1
  "types": [
        { "type_id": 0,
          "name": "osd"},
        { "type_id": 1,
          "name": "host"},
        { "type_id": 2,
          "name": "platform"},
        { "type_id": 3,
          "name": "datacenter"},
        { "type_id": 4,
          "name": "root"},
        { "type_id": 5,
          "name": "appclient"},
        { "type_id": 10,
          "name": "diskclass"},
        { "type_id": 50,
          "name": "appclass"}],

And there are 5 hosts with 2 osds each at the end of the tree.

Best regards
-----Message d'origine-----
De=A0: Loic Dachary [mailto:loic@dachary.org]=20
Envoy=E9=A0: mardi 14 octobre 2014 16:44
=C0=A0: CHEVALIER Ghislain IMT/OLPS; ceph-devel@vger.kernel.org
Objet=A0: Re: [Ceph-Devel] NO pg created for eruasre-coded pool

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
> As showed at the last ceph day in Paris, we have multiple root but the ru=
leset 52 entered the crushmap on root default.
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
> 0       0.009995                                        osd.0   up      1
> 5       0.009995                                        osd.5   up      1
> -14     0.01999                         host p-sbceph14
> 1       0.009995                                        osd.1   up      1
> 6       0.009995                                        osd.6   up      1
> -15     0.01999                         host p-sbceph15
> 2       0.009995                                        osd.2   up      1
> 7       0.009995                                        osd.7   up      1
> -12     0.01999                         host p-sbceph12
> 3       0.009995                                        osd.3   up      1
> 8       0.009995                                        osd.8   up      1
> -11     0.01999                         host p-sbceph11
> 4       0.009995                                        osd.4   up      1
> 9       0.009995                                        osd.9   up      1
>=20
> Best regards
>=20
> -----Message d'origine-----
> De : Loic Dachary [mailto:loic@dachary.org] Envoy=E9 : mardi 14 octobre=
=20
> 2014 12:12 =C0 : CHEVALIER Ghislain IMT/OLPS; ceph-devel@vger.kernel.org=
=20
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
>> the erasure-code rule was dynamically created and associated to the pool.
>> root@p-sbceph14:/etc/ceph# ceph osd crush rule dump erasure-code {
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
>> No error message was displayed at pool creation but no pgs were created.
>> --> rados lspools confirms the pool is created but rados/ceph df=20
>> --> shows no pg for this pool
>>
>> The command  "rados -p ecpool put services /etc/services" is inactive
>> (stalled) and the following message is encountered in ceph.log
>> 2014-10-14 10:36:50.189432 osd.5 10.192.134.123:6804/21505 799 :=20
>> [WRN] slow request 960.230073 seconds old, received at 2014-10-14
>> 10:20:49.959255: osd_op(client.1192643.0:1 services [writefull=20
>> 0~19281] 100.5a48a9c2 ondisk+write e11869) v4 currently waiting for=20
>> pg to exist locally
>>
>> I don't know if I missed something or if the problem is somewhere else..
>=20
> The erasure-code rule displayed will need at least three hosts. If there =
are not enough hosts with OSDs the mapping will fail and put will hang unti=
l an OSD becomes available to complete the mapping of OSDs to the PGs. What=
 does your ceph osd tree shows ?
>=20
> Cheers
>=20
>>
>> Best regards
>>=20=20
>>=20=20
>>=20=20
>>
>>
>>
>>
>>
>>
>> _____________________________________________________________________
>> _ ___________________________________________________
>>
>> Ce message et ses pieces jointes peuvent contenir des informations=20
>> confidentielles ou privilegiees et ne doivent donc pas etre diffuses,=20
>> exploites ou copies sans autorisation. Si vous avez recu ce message=20
>> par erreur, veuillez le signaler a l'expediteur et le detruire ainsi que=
 les pieces jointes. Les messages electroniques etant susceptibles d'altera=
tion, Orange decline toute responsabilite si ce message a ete altere, defor=
me ou falsifie. Merci.
>>
>> This message and its attachments may contain confidential or=20
>> privileged information that may be protected by law; they should not be =
distributed, used or copied without authorisation.
>> If you have received this email in error, please notify the sender and d=
elete this message and its attachments.
>> As emails may be altered, Orange is not liable for messages that have be=
en modified, changed or falsified.
>> Thank you.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20
> ______________________________________________________________________
> ___________________________________________________
>=20
> Ce message et ses pieces jointes peuvent contenir des informations=20
> confidentielles ou privilegiees et ne doivent donc pas etre diffuses,=20
> exploites ou copies sans autorisation. Si vous avez recu ce message=20
> par erreur, veuillez le signaler a l'expediteur et le detruire ainsi que =
les pieces jointes. Les messages electroniques etant susceptibles d'alterat=
ion, Orange decline toute responsabilite si ce message a ete altere, deform=
e ou falsifie. Merci.
>=20
> This message and its attachments may contain confidential or=20
> privileged information that may be protected by law; they should not be d=
istributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender and de=
lete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have bee=
n modified, changed or falsified.
> Thank you.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20

--
Lo=EFc Dachary, Artisan Logiciel Libre


___________________________________________________________________________=
______________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confiden=
tielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu=
 ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages el=
ectroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme ou =
falsifie. Merci.

This message and its attachments may contain confidential or privileged inf=
ormation that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and dele=
te this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been =
modified, changed or falsified.
Thank you.


--_002_B9C8EFBF13B1354DB5FA000660D66DD00C18CBCEPEXCVZYM14corpo_
Content-Type: text/plain; name="crushdump.txt"
Content-Description: crushdump.txt
Content-Disposition: attachment; filename="crushdump.txt"; size=14799;
	creation-date="Tue, 14 Oct 2014 15:07:58 GMT";
	modification-date="Tue, 14 Oct 2014 15:06:26 GMT"
Content-Transfer-Encoding: base64

eyAiZGV2aWNlcyI6IFsNCiAgICAgICAgeyAiaWQiOiAwLA0KICAgICAgICAgICJuYW1lIjogIm9z
ZC4wIn0sDQogICAgICAgIHsgImlkIjogMSwNCiAgICAgICAgICAibmFtZSI6ICJvc2QuMSJ9LA0K
ICAgICAgICB7ICJpZCI6IDIsDQogICAgICAgICAgIm5hbWUiOiAib3NkLjIifSwNCiAgICAgICAg
eyAiaWQiOiAzLA0KICAgICAgICAgICJuYW1lIjogIm9zZC4zIn0sDQogICAgICAgIHsgImlkIjog
NCwNCiAgICAgICAgICAibmFtZSI6ICJvc2QuNCJ9LA0KICAgICAgICB7ICJpZCI6IDUsDQogICAg
ICAgICAgIm5hbWUiOiAib3NkLjUifSwNCiAgICAgICAgeyAiaWQiOiA2LA0KICAgICAgICAgICJu
YW1lIjogIm9zZC42In0sDQogICAgICAgIHsgImlkIjogNywNCiAgICAgICAgICAibmFtZSI6ICJv
c2QuNyJ9LA0KICAgICAgICB7ICJpZCI6IDgsDQogICAgICAgICAgIm5hbWUiOiAib3NkLjgifSwN
CiAgICAgICAgeyAiaWQiOiA5LA0KICAgICAgICAgICJuYW1lIjogIm9zZC45In1dLA0KICAidHlw
ZXMiOiBbDQogICAgICAgIHsgInR5cGVfaWQiOiAwLA0KICAgICAgICAgICJuYW1lIjogIm9zZCJ9
LA0KICAgICAgICB7ICJ0eXBlX2lkIjogMSwNCiAgICAgICAgICAibmFtZSI6ICJob3N0In0sDQog
ICAgICAgIHsgInR5cGVfaWQiOiAyLA0KICAgICAgICAgICJuYW1lIjogInBsYXRmb3JtIn0sDQog
ICAgICAgIHsgInR5cGVfaWQiOiAzLA0KICAgICAgICAgICJuYW1lIjogImRhdGFjZW50ZXIifSwN
CiAgICAgICAgeyAidHlwZV9pZCI6IDQsDQogICAgICAgICAgIm5hbWUiOiAicm9vdCJ9LA0KICAg
ICAgICB7ICJ0eXBlX2lkIjogNSwNCiAgICAgICAgICAibmFtZSI6ICJhcHBjbGllbnQifSwNCiAg
ICAgICAgeyAidHlwZV9pZCI6IDEwLA0KICAgICAgICAgICJuYW1lIjogImRpc2tjbGFzcyJ9LA0K
ICAgICAgICB7ICJ0eXBlX2lkIjogNTAsDQogICAgICAgICAgIm5hbWUiOiAiYXBwY2xhc3MifV0s
DQogICJidWNrZXRzIjogWw0KICAgICAgICB7ICJpZCI6IC0xLA0KICAgICAgICAgICJuYW1lIjog
ImRlZmF1bHQiLA0KICAgICAgICAgICJ0eXBlX2lkIjogNCwNCiAgICAgICAgICAidHlwZV9uYW1l
IjogInJvb3QiLA0KICAgICAgICAgICJ3ZWlnaHQiOiA2NTUzLA0KICAgICAgICAgICJhbGciOiAi
c3RyYXciLA0KICAgICAgICAgICJoYXNoIjogInJqZW5raW5zMSIsDQogICAgICAgICAgIml0ZW1z
IjogWw0KICAgICAgICAgICAgICAgIHsgImlkIjogLTIsDQogICAgICAgICAgICAgICAgICAid2Vp
Z2h0IjogNjU1MywNCiAgICAgICAgICAgICAgICAgICJwb3MiOiAwfV19LA0KICAgICAgICB7ICJp
ZCI6IC0yLA0KICAgICAgICAgICJuYW1lIjogIm5hbnRlcnJlIiwNCiAgICAgICAgICAidHlwZV9p
ZCI6IDMsDQogICAgICAgICAgInR5cGVfbmFtZSI6ICJkYXRhY2VudGVyIiwNCiAgICAgICAgICAi
d2VpZ2h0IjogNjU1MywNCiAgICAgICAgICAiYWxnIjogInN0cmF3IiwNCiAgICAgICAgICAiaGFz
aCI6ICJyamVua2luczEiLA0KICAgICAgICAgICJpdGVtcyI6IFsNCiAgICAgICAgICAgICAgICB7
ICJpZCI6IC0zLA0KICAgICAgICAgICAgICAgICAgIndlaWdodCI6IDY1NTMsDQogICAgICAgICAg
ICAgICAgICAicG9zIjogMH1dfSwNCiAgICAgICAgeyAiaWQiOiAtMywNCiAgICAgICAgICAibmFt
ZSI6ICJzYW5kYm94IiwNCiAgICAgICAgICAidHlwZV9pZCI6IDIsDQogICAgICAgICAgInR5cGVf
bmFtZSI6ICJwbGF0Zm9ybSIsDQogICAgICAgICAgIndlaWdodCI6IDY1NTAsDQogICAgICAgICAg
ImFsZyI6ICJzdHJhdyIsDQogICAgICAgICAgImhhc2giOiAicmplbmtpbnMxIiwNCiAgICAgICAg
ICAiaXRlbXMiOiBbDQogICAgICAgICAgICAgICAgeyAiaWQiOiAtMTMsDQogICAgICAgICAgICAg
ICAgICAid2VpZ2h0IjogMTMxMCwNCiAgICAgICAgICAgICAgICAgICJwb3MiOiAwfSwNCiAgICAg
ICAgICAgICAgICB7ICJpZCI6IC0xNCwNCiAgICAgICAgICAgICAgICAgICJ3ZWlnaHQiOiAxMzEw
LA0KICAgICAgICAgICAgICAgICAgInBvcyI6IDF9LA0KICAgICAgICAgICAgICAgIHsgImlkIjog
LTE1LA0KICAgICAgICAgICAgICAgICAgIndlaWdodCI6IDEzMTAsDQogICAgICAgICAgICAgICAg
ICAicG9zIjogMn0sDQogICAgICAgICAgICAgICAgeyAiaWQiOiAtMTIsDQogICAgICAgICAgICAg
ICAgICAid2VpZ2h0IjogMTMxMCwNCiAgICAgICAgICAgICAgICAgICJwb3MiOiAzfSwNCiAgICAg
ICAgICAgICAgICB7ICJpZCI6IC0xMSwNCiAgICAgICAgICAgICAgICAgICJ3ZWlnaHQiOiAxMzEw
LA0KICAgICAgICAgICAgICAgICAgInBvcyI6IDR9XX0sDQogICAgICAgIHsgImlkIjogLTUsDQog
ICAgICAgICAgIm5hbWUiOiAiYXBwcm9vdCIsDQogICAgICAgICAgInR5cGVfaWQiOiA0LA0KICAg
ICAgICAgICJ0eXBlX25hbWUiOiAicm9vdCIsDQogICAgICAgICAgIndlaWdodCI6IDEzMTA2LA0K
ICAgICAgICAgICJhbGciOiAic3RyYXciLA0KICAgICAgICAgICJoYXNoIjogInJqZW5raW5zMSIs
DQogICAgICAgICAgIml0ZW1zIjogWw0KICAgICAgICAgICAgICAgIHsgImlkIjogLTUwLA0KICAg
ICAgICAgICAgICAgICAgIndlaWdodCI6IDY1NTMsDQogICAgICAgICAgICAgICAgICAicG9zIjog
MH0sDQogICAgICAgICAgICAgICAgeyAiaWQiOiAtNTEsDQogICAgICAgICAgICAgICAgICAid2Vp
Z2h0IjogNjU1MywNCiAgICAgICAgICAgICAgICAgICJwb3MiOiAxfV19LA0KICAgICAgICB7ICJp
ZCI6IC0xMSwNCiAgICAgICAgICAibmFtZSI6ICJwLXNiY2VwaDExIiwNCiAgICAgICAgICAidHlw
ZV9pZCI6IDEsDQogICAgICAgICAgInR5cGVfbmFtZSI6ICJob3N0IiwNCiAgICAgICAgICAid2Vp
Z2h0IjogMTMxMCwNCiAgICAgICAgICAiYWxnIjogInN0cmF3IiwNCiAgICAgICAgICAiaGFzaCI6
ICJyamVua2luczEiLA0KICAgICAgICAgICJpdGVtcyI6IFsNCiAgICAgICAgICAgICAgICB7ICJp
ZCI6IDQsDQogICAgICAgICAgICAgICAgICAid2VpZ2h0IjogNjU1LA0KICAgICAgICAgICAgICAg
ICAgInBvcyI6IDB9LA0KICAgICAgICAgICAgICAgIHsgImlkIjogOSwNCiAgICAgICAgICAgICAg
ICAgICJ3ZWlnaHQiOiA2NTUsDQogICAgICAgICAgICAgICAgICAicG9zIjogMX1dfSwNCiAgICAg
ICAgeyAiaWQiOiAtMTIsDQogICAgICAgICAgIm5hbWUiOiAicC1zYmNlcGgxMiIsDQogICAgICAg
ICAgInR5cGVfaWQiOiAxLA0KICAgICAgICAgICJ0eXBlX25hbWUiOiAiaG9zdCIsDQogICAgICAg
ICAgIndlaWdodCI6IDEzMTAsDQogICAgICAgICAgImFsZyI6ICJzdHJhdyIsDQogICAgICAgICAg
Imhhc2giOiAicmplbmtpbnMxIiwNCiAgICAgICAgICAiaXRlbXMiOiBbDQogICAgICAgICAgICAg
ICAgeyAiaWQiOiAzLA0KICAgICAgICAgICAgICAgICAgIndlaWdodCI6IDY1NSwNCiAgICAgICAg
ICAgICAgICAgICJwb3MiOiAwfSwNCiAgICAgICAgICAgICAgICB7ICJpZCI6IDgsDQogICAgICAg
ICAgICAgICAgICAid2VpZ2h0IjogNjU1LA0KICAgICAgICAgICAgICAgICAgInBvcyI6IDF9XX0s
DQogICAgICAgIHsgImlkIjogLTEzLA0KICAgICAgICAgICJuYW1lIjogInAtc2JjZXBoMTMiLA0K
ICAgICAgICAgICJ0eXBlX2lkIjogMSwNCiAgICAgICAgICAidHlwZV9uYW1lIjogImhvc3QiLA0K
ICAgICAgICAgICJ3ZWlnaHQiOiAxMzEwLA0KICAgICAgICAgICJhbGciOiAic3RyYXciLA0KICAg
ICAgICAgICJoYXNoIjogInJqZW5raW5zMSIsDQogICAgICAgICAgIml0ZW1zIjogWw0KICAgICAg
ICAgICAgICAgIHsgImlkIjogMCwNCiAgICAgICAgICAgICAgICAgICJ3ZWlnaHQiOiA2NTUsDQog
ICAgICAgICAgICAgICAgICAicG9zIjogMH0sDQogICAgICAgICAgICAgICAgeyAiaWQiOiA1LA0K
ICAgICAgICAgICAgICAgICAgIndlaWdodCI6IDY1NSwNCiAgICAgICAgICAgICAgICAgICJwb3Mi
OiAxfV19LA0KICAgICAgICB7ICJpZCI6IC0xNCwNCiAgICAgICAgICAibmFtZSI6ICJwLXNiY2Vw
aDE0IiwNCiAgICAgICAgICAidHlwZV9pZCI6IDEsDQogICAgICAgICAgInR5cGVfbmFtZSI6ICJo
b3N0IiwNCiAgICAgICAgICAid2VpZ2h0IjogMTMxMCwNCiAgICAgICAgICAiYWxnIjogInN0cmF3
IiwNCiAgICAgICAgICAiaGFzaCI6ICJyamVua2luczEiLA0KICAgICAgICAgICJpdGVtcyI6IFsN
CiAgICAgICAgICAgICAgICB7ICJpZCI6IDEsDQogICAgICAgICAgICAgICAgICAid2VpZ2h0Ijog
NjU1LA0KICAgICAgICAgICAgICAgICAgInBvcyI6IDB9LA0KICAgICAgICAgICAgICAgIHsgImlk
IjogNiwNCiAgICAgICAgICAgICAgICAgICJ3ZWlnaHQiOiA2NTUsDQogICAgICAgICAgICAgICAg
ICAicG9zIjogMX1dfSwNCiAgICAgICAgeyAiaWQiOiAtMTUsDQogICAgICAgICAgIm5hbWUiOiAi
cC1zYmNlcGgxNSIsDQogICAgICAgICAgInR5cGVfaWQiOiAxLA0KICAgICAgICAgICJ0eXBlX25h
bWUiOiAiaG9zdCIsDQogICAgICAgICAgIndlaWdodCI6IDEzMTAsDQogICAgICAgICAgImFsZyI6
ICJzdHJhdyIsDQogICAgICAgICAgImhhc2giOiAicmplbmtpbnMxIiwNCiAgICAgICAgICAiaXRl
bXMiOiBbDQogICAgICAgICAgICAgICAgeyAiaWQiOiAyLA0KICAgICAgICAgICAgICAgICAgIndl
aWdodCI6IDY1NSwNCiAgICAgICAgICAgICAgICAgICJwb3MiOiAwfSwNCiAgICAgICAgICAgICAg
ICB7ICJpZCI6IDcsDQogICAgICAgICAgICAgICAgICAid2VpZ2h0IjogNjU1LA0KICAgICAgICAg
ICAgICAgICAgInBvcyI6IDF9XX0sDQogICAgICAgIHsgImlkIjogLTUwLA0KICAgICAgICAgICJu
YW1lIjogImFwcHJndyIsDQogICAgICAgICAgInR5cGVfaWQiOiA1LA0KICAgICAgICAgICJ0eXBl
X25hbWUiOiAiYXBwY2xpZW50IiwNCiAgICAgICAgICAid2VpZ2h0IjogNjU1MiwNCiAgICAgICAg
ICAiYWxnIjogInN0cmF3IiwNCiAgICAgICAgICAiaGFzaCI6ICJyamVua2luczEiLA0KICAgICAg
ICAgICJpdGVtcyI6IFsNCiAgICAgICAgICAgICAgICB7ICJpZCI6IC01MDEsDQogICAgICAgICAg
ICAgICAgICAid2VpZ2h0IjogMzI3NiwNCiAgICAgICAgICAgICAgICAgICJwb3MiOiAwfSwNCiAg
ICAgICAgICAgICAgICB7ICJpZCI6IC01MDIsDQogICAgICAgICAgICAgICAgICAid2VpZ2h0Ijog
MzI3NiwNCiAgICAgICAgICAgICAgICAgICJwb3MiOiAxfV19LA0KICAgICAgICB7ICJpZCI6IC01
MSwNCiAgICAgICAgICAibmFtZSI6ICJhcHBzdGQiLA0KICAgICAgICAgICJ0eXBlX2lkIjogNSwN
CiAgICAgICAgICAidHlwZV9uYW1lIjogImFwcGNsaWVudCIsDQogICAgICAgICAgIndlaWdodCI6
IDY1NTIsDQogICAgICAgICAgImFsZyI6ICJzdHJhdyIsDQogICAgICAgICAgImhhc2giOiAicmpl
bmtpbnMxIiwNCiAgICAgICAgICAiaXRlbXMiOiBbDQogICAgICAgICAgICAgICAgeyAiaWQiOiAt
NTExLA0KICAgICAgICAgICAgICAgICAgIndlaWdodCI6IDMyNzYsDQogICAgICAgICAgICAgICAg
ICAicG9zIjogMH0sDQogICAgICAgICAgICAgICAgeyAiaWQiOiAtNTEyLA0KICAgICAgICAgICAg
ICAgICAgIndlaWdodCI6IDMyNzYsDQogICAgICAgICAgICAgICAgICAicG9zIjogMX1dfSwNCiAg
ICAgICAgeyAiaWQiOiAtMTAwLA0KICAgICAgICAgICJuYW1lIjogImRpc2tyb290IiwNCiAgICAg
ICAgICAidHlwZV9pZCI6IDQsDQogICAgICAgICAgInR5cGVfbmFtZSI6ICJyb290IiwNCiAgICAg
ICAgICAid2VpZ2h0IjogNjU1MiwNCiAgICAgICAgICAiYWxnIjogInN0cmF3IiwNCiAgICAgICAg
ICAiaGFzaCI6ICJyamVua2luczEiLA0KICAgICAgICAgICJpdGVtcyI6IFsNCiAgICAgICAgICAg
ICAgICB7ICJpZCI6IC0xMTAsDQogICAgICAgICAgICAgICAgICAid2VpZ2h0IjogMzI3NiwNCiAg
ICAgICAgICAgICAgICAgICJwb3MiOiAwfSwNCiAgICAgICAgICAgICAgICB7ICJpZCI6IC0xMjAs
DQogICAgICAgICAgICAgICAgICAid2VpZ2h0IjogMzI3NiwNCiAgICAgICAgICAgICAgICAgICJw
b3MiOiAxfV19LA0KICAgICAgICB7ICJpZCI6IC0xMTAsDQogICAgICAgICAgIm5hbWUiOiAiZmFz
dHNhdGEiLA0KICAgICAgICAgICJ0eXBlX2lkIjogMTAsDQogICAgICAgICAgInR5cGVfbmFtZSI6
ICJkaXNrY2xhc3MiLA0KICAgICAgICAgICJ3ZWlnaHQiOiAyNjIwLA0KICAgICAgICAgICJhbGci
OiAic3RyYXciLA0KICAgICAgICAgICJoYXNoIjogInJqZW5raW5zMSIsDQogICAgICAgICAgIml0
ZW1zIjogWw0KICAgICAgICAgICAgICAgIHsgImlkIjogMCwNCiAgICAgICAgICAgICAgICAgICJ3
ZWlnaHQiOiA2NTUsDQogICAgICAgICAgICAgICAgICAicG9zIjogMH0sDQogICAgICAgICAgICAg
ICAgeyAiaWQiOiAxLA0KICAgICAgICAgICAgICAgICAgIndlaWdodCI6IDY1NSwNCiAgICAgICAg
ICAgICAgICAgICJwb3MiOiAxfSwNCiAgICAgICAgICAgICAgICB7ICJpZCI6IDIsDQogICAgICAg
ICAgICAgICAgICAid2VpZ2h0IjogNjU1LA0KICAgICAgICAgICAgICAgICAgInBvcyI6IDJ9LA0K
ICAgICAgICAgICAgICAgIHsgImlkIjogMywNCiAgICAgICAgICAgICAgICAgICJ3ZWlnaHQiOiA2
NTUsDQogICAgICAgICAgICAgICAgICAicG9zIjogM31dfSwNCiAgICAgICAgeyAiaWQiOiAtMTIw
LA0KICAgICAgICAgICJuYW1lIjogInNsb3dzYXRhIiwNCiAgICAgICAgICAidHlwZV9pZCI6IDEw
LA0KICAgICAgICAgICJ0eXBlX25hbWUiOiAiZGlza2NsYXNzIiwNCiAgICAgICAgICAid2VpZ2h0
IjogMzkzMCwNCiAgICAgICAgICAiYWxnIjogInN0cmF3IiwNCiAgICAgICAgICAiaGFzaCI6ICJy
amVua2luczEiLA0KICAgICAgICAgICJpdGVtcyI6IFsNCiAgICAgICAgICAgICAgICB7ICJpZCI6
IDQsDQogICAgICAgICAgICAgICAgICAid2VpZ2h0IjogNjU1LA0KICAgICAgICAgICAgICAgICAg
InBvcyI6IDB9LA0KICAgICAgICAgICAgICAgIHsgImlkIjogNSwNCiAgICAgICAgICAgICAgICAg
ICJ3ZWlnaHQiOiA2NTUsDQogICAgICAgICAgICAgICAgICAicG9zIjogMX0sDQogICAgICAgICAg
ICAgICAgeyAiaWQiOiA2LA0KICAgICAgICAgICAgICAgICAgIndlaWdodCI6IDY1NSwNCiAgICAg
ICAgICAgICAgICAgICJwb3MiOiAyfSwNCiAgICAgICAgICAgICAgICB7ICJpZCI6IDcsDQogICAg
ICAgICAgICAgICAgICAid2VpZ2h0IjogNjU1LA0KICAgICAgICAgICAgICAgICAgInBvcyI6IDN9
LA0KICAgICAgICAgICAgICAgIHsgImlkIjogOCwNCiAgICAgICAgICAgICAgICAgICJ3ZWlnaHQi
OiA2NTUsDQogICAgICAgICAgICAgICAgICAicG9zIjogNH0sDQogICAgICAgICAgICAgICAgeyAi
aWQiOiA5LA0KICAgICAgICAgICAgICAgICAgIndlaWdodCI6IDY1NSwNCiAgICAgICAgICAgICAg
ICAgICJwb3MiOiA1fV19LA0KICAgICAgICB7ICJpZCI6IC01MDEsDQogICAgICAgICAgIm5hbWUi
OiAiZmFzdHJndyIsDQogICAgICAgICAgInR5cGVfaWQiOiA1MCwNCiAgICAgICAgICAidHlwZV9u
YW1lIjogImFwcGNsYXNzIiwNCiAgICAgICAgICAid2VpZ2h0IjogMjYyMCwNCiAgICAgICAgICAi
YWxnIjogInN0cmF3IiwNCiAgICAgICAgICAiaGFzaCI6ICJyamVua2luczEiLA0KICAgICAgICAg
ICJpdGVtcyI6IFsNCiAgICAgICAgICAgICAgICB7ICJpZCI6IDAsDQogICAgICAgICAgICAgICAg
ICAid2VpZ2h0IjogNjU1LA0KICAgICAgICAgICAgICAgICAgInBvcyI6IDB9LA0KICAgICAgICAg
ICAgICAgIHsgImlkIjogMSwNCiAgICAgICAgICAgICAgICAgICJ3ZWlnaHQiOiA2NTUsDQogICAg
ICAgICAgICAgICAgICAicG9zIjogMX0sDQogICAgICAgICAgICAgICAgeyAiaWQiOiAyLA0KICAg
ICAgICAgICAgICAgICAgIndlaWdodCI6IDY1NSwNCiAgICAgICAgICAgICAgICAgICJwb3MiOiAy
fSwNCiAgICAgICAgICAgICAgICB7ICJpZCI6IDMsDQogICAgICAgICAgICAgICAgICAid2VpZ2h0
IjogNjU1LA0KICAgICAgICAgICAgICAgICAgInBvcyI6IDN9XX0sDQogICAgICAgIHsgImlkIjog
LTUwMiwNCiAgICAgICAgICAibmFtZSI6ICJzbG93cmd3IiwNCiAgICAgICAgICAidHlwZV9pZCI6
IDUwLA0KICAgICAgICAgICJ0eXBlX25hbWUiOiAiYXBwY2xhc3MiLA0KICAgICAgICAgICJ3ZWln
aHQiOiAzOTMwLA0KICAgICAgICAgICJhbGciOiAic3RyYXciLA0KICAgICAgICAgICJoYXNoIjog
InJqZW5raW5zMSIsDQogICAgICAgICAgIml0ZW1zIjogWw0KICAgICAgICAgICAgICAgIHsgImlk
IjogNCwNCiAgICAgICAgICAgICAgICAgICJ3ZWlnaHQiOiA2NTUsDQogICAgICAgICAgICAgICAg
ICAicG9zIjogMH0sDQogICAgICAgICAgICAgICAgeyAiaWQiOiA1LA0KICAgICAgICAgICAgICAg
ICAgIndlaWdodCI6IDY1NSwNCiAgICAgICAgICAgICAgICAgICJwb3MiOiAxfSwNCiAgICAgICAg
ICAgICAgICB7ICJpZCI6IDYsDQogICAgICAgICAgICAgICAgICAid2VpZ2h0IjogNjU1LA0KICAg
ICAgICAgICAgICAgICAgInBvcyI6IDJ9LA0KICAgICAgICAgICAgICAgIHsgImlkIjogNywNCiAg
ICAgICAgICAgICAgICAgICJ3ZWlnaHQiOiA2NTUsDQogICAgICAgICAgICAgICAgICAicG9zIjog
M30sDQogICAgICAgICAgICAgICAgeyAiaWQiOiA4LA0KICAgICAgICAgICAgICAgICAgIndlaWdo
dCI6IDY1NSwNCiAgICAgICAgICAgICAgICAgICJwb3MiOiA0fSwNCiAgICAgICAgICAgICAgICB7
ICJpZCI6IDksDQogICAgICAgICAgICAgICAgICAid2VpZ2h0IjogNjU1LA0KICAgICAgICAgICAg
ICAgICAgInBvcyI6IDV9XX0sDQogICAgICAgIHsgImlkIjogLTUxMSwNCiAgICAgICAgICAibmFt
ZSI6ICJmYXN0c3RkIiwNCiAgICAgICAgICAidHlwZV9pZCI6IDUwLA0KICAgICAgICAgICJ0eXBl
X25hbWUiOiAiYXBwY2xhc3MiLA0KICAgICAgICAgICJ3ZWlnaHQiOiAyNjIwLA0KICAgICAgICAg
ICJhbGciOiAic3RyYXciLA0KICAgICAgICAgICJoYXNoIjogInJqZW5raW5zMSIsDQogICAgICAg
ICAgIml0ZW1zIjogWw0KICAgICAgICAgICAgICAgIHsgImlkIjogMCwNCiAgICAgICAgICAgICAg
ICAgICJ3ZWlnaHQiOiA2NTUsDQogICAgICAgICAgICAgICAgICAicG9zIjogMH0sDQogICAgICAg
ICAgICAgICAgeyAiaWQiOiAxLA0KICAgICAgICAgICAgICAgICAgIndlaWdodCI6IDY1NSwNCiAg
ICAgICAgICAgICAgICAgICJwb3MiOiAxfSwNCiAgICAgICAgICAgICAgICB7ICJpZCI6IDIsDQog
ICAgICAgICAgICAgICAgICAid2VpZ2h0IjogNjU1LA0KICAgICAgICAgICAgICAgICAgInBvcyI6
IDJ9LA0KICAgICAgICAgICAgICAgIHsgImlkIjogMywNCiAgICAgICAgICAgICAgICAgICJ3ZWln
aHQiOiA2NTUsDQogICAgICAgICAgICAgICAgICAicG9zIjogM31dfSwNCiAgICAgICAgeyAiaWQi
OiAtNTEyLA0KICAgICAgICAgICJuYW1lIjogInNsb3dzdGQiLA0KICAgICAgICAgICJ0eXBlX2lk
IjogNTAsDQogICAgICAgICAgInR5cGVfbmFtZSI6ICJhcHBjbGFzcyIsDQogICAgICAgICAgIndl
aWdodCI6IDM5MzAsDQogICAgICAgICAgImFsZyI6ICJzdHJhdyIsDQogICAgICAgICAgImhhc2gi
OiAicmplbmtpbnMxIiwNCiAgICAgICAgICAiaXRlbXMiOiBbDQogICAgICAgICAgICAgICAgeyAi
aWQiOiA0LA0KICAgICAgICAgICAgICAgICAgIndlaWdodCI6IDY1NSwNCiAgICAgICAgICAgICAg
ICAgICJwb3MiOiAwfSwNCiAgICAgICAgICAgICAgICB7ICJpZCI6IDUsDQogICAgICAgICAgICAg
ICAgICAid2VpZ2h0IjogNjU1LA0KICAgICAgICAgICAgICAgICAgInBvcyI6IDF9LA0KICAgICAg
ICAgICAgICAgIHsgImlkIjogNiwNCiAgICAgICAgICAgICAgICAgICJ3ZWlnaHQiOiA2NTUsDQog
ICAgICAgICAgICAgICAgICAicG9zIjogMn0sDQogICAgICAgICAgICAgICAgeyAiaWQiOiA3LA0K
ICAgICAgICAgICAgICAgICAgIndlaWdodCI6IDY1NSwNCiAgICAgICAgICAgICAgICAgICJwb3Mi
OiAzfSwNCiAgICAgICAgICAgICAgICB7ICJpZCI6IDgsDQogICAgICAgICAgICAgICAgICAid2Vp
Z2h0IjogNjU1LA0KICAgICAgICAgICAgICAgICAgInBvcyI6IDR9LA0KICAgICAgICAgICAgICAg
IHsgImlkIjogOSwNCiAgICAgICAgICAgICAgICAgICJ3ZWlnaHQiOiA2NTUsDQogICAgICAgICAg
ICAgICAgICAicG9zIjogNX1dfV0sDQogICJydWxlcyI6IFsNCiAgICAgICAgeyAicnVsZV9pZCI6
IDAsDQogICAgICAgICAgInJ1bGVfbmFtZSI6ICJkYXRhIiwNCiAgICAgICAgICAicnVsZXNldCI6
IDAsDQogICAgICAgICAgInR5cGUiOiAxLA0KICAgICAgICAgICJtaW5fc2l6ZSI6IDEsDQogICAg
ICAgICAgIm1heF9zaXplIjogMTAsDQogICAgICAgICAgInN0ZXBzIjogWw0KICAgICAgICAgICAg
ICAgIHsgIm9wIjogInRha2UiLA0KICAgICAgICAgICAgICAgICAgIml0ZW0iOiAtNTEyLA0KICAg
ICAgICAgICAgICAgICAgIml0ZW1fbmFtZSI6ICJzbG93c3RkIn0sDQogICAgICAgICAgICAgICAg
eyAib3AiOiAiY2hvb3NlbGVhZl9maXJzdG4iLA0KICAgICAgICAgICAgICAgICAgIm51bSI6IDAs
DQogICAgICAgICAgICAgICAgICAidHlwZSI6ICJvc2QifSwNCiAgICAgICAgICAgICAgICB7ICJv
cCI6ICJlbWl0In1dfSwNCiAgICAgICAgeyAicnVsZV9pZCI6IDEsDQogICAgICAgICAgInJ1bGVf
bmFtZSI6ICJtZXRhZGF0YSIsDQogICAgICAgICAgInJ1bGVzZXQiOiAxLA0KICAgICAgICAgICJ0
eXBlIjogMSwNCiAgICAgICAgICAibWluX3NpemUiOiAxLA0KICAgICAgICAgICJtYXhfc2l6ZSI6
IDEwLA0KICAgICAgICAgICJzdGVwcyI6IFsNCiAgICAgICAgICAgICAgICB7ICJvcCI6ICJ0YWtl
IiwNCiAgICAgICAgICAgICAgICAgICJpdGVtIjogLTUxMiwNCiAgICAgICAgICAgICAgICAgICJp
dGVtX25hbWUiOiAic2xvd3N0ZCJ9LA0KICAgICAgICAgICAgICAgIHsgIm9wIjogImNob29zZWxl
YWZfZmlyc3RuIiwNCiAgICAgICAgICAgICAgICAgICJudW0iOiAwLA0KICAgICAgICAgICAgICAg
ICAgInR5cGUiOiAib3NkIn0sDQogICAgICAgICAgICAgICAgeyAib3AiOiAiZW1pdCJ9XX0sDQog
ICAgICAgIHsgInJ1bGVfaWQiOiAyLA0KICAgICAgICAgICJydWxlX25hbWUiOiAicmJkIiwNCiAg
ICAgICAgICAicnVsZXNldCI6IDIsDQogICAgICAgICAgInR5cGUiOiAxLA0KICAgICAgICAgICJt
aW5fc2l6ZSI6IDEsDQogICAgICAgICAgIm1heF9zaXplIjogMTAsDQogICAgICAgICAgInN0ZXBz
IjogWw0KICAgICAgICAgICAgICAgIHsgIm9wIjogInRha2UiLA0KICAgICAgICAgICAgICAgICAg
Iml0ZW0iOiAtNTExLA0KICAgICAgICAgICAgICAgICAgIml0ZW1fbmFtZSI6ICJmYXN0c3RkIn0s
DQogICAgICAgICAgICAgICAgeyAib3AiOiAiY2hvb3NlbGVhZl9maXJzdG4iLA0KICAgICAgICAg
ICAgICAgICAgIm51bSI6IDAsDQogICAgICAgICAgICAgICAgICAidHlwZSI6ICJvc2QifSwNCiAg
ICAgICAgICAgICAgICB7ICJvcCI6ICJlbWl0In1dfSwNCiAgICAgICAgeyAicnVsZV9pZCI6IDMs
DQogICAgICAgICAgInJ1bGVfbmFtZSI6ICJ0ZXN0IiwNCiAgICAgICAgICAicnVsZXNldCI6IDMs
DQogICAgICAgICAgInR5cGUiOiAxLA0KICAgICAgICAgICJtaW5fc2l6ZSI6IDEsDQogICAgICAg
ICAgIm1heF9zaXplIjogMTAsDQogICAgICAgICAgInN0ZXBzIjogWw0KICAgICAgICAgICAgICAg
IHsgIm9wIjogInRha2UiLA0KICAgICAgICAgICAgICAgICAgIml0ZW0iOiAtMTEwLA0KICAgICAg
ICAgICAgICAgICAgIml0ZW1fbmFtZSI6ICJmYXN0c2F0YSJ9LA0KICAgICAgICAgICAgICAgIHsg
Im9wIjogImNob29zZWxlYWZfZmlyc3RuIiwNCiAgICAgICAgICAgICAgICAgICJudW0iOiAyLA0K
ICAgICAgICAgICAgICAgICAgInR5cGUiOiAib3NkIn0sDQogICAgICAgICAgICAgICAgeyAib3Ai
OiAiZW1pdCJ9LA0KICAgICAgICAgICAgICAgIHsgIm9wIjogInRha2UiLA0KICAgICAgICAgICAg
ICAgICAgIml0ZW0iOiAtMTIwLA0KICAgICAgICAgICAgICAgICAgIml0ZW1fbmFtZSI6ICJzbG93
c2F0YSJ9LA0KICAgICAgICAgICAgICAgIHsgIm9wIjogImNob29zZWxlYWZfZmlyc3RuIiwNCiAg
ICAgICAgICAgICAgICAgICJudW0iOiAtMiwNCiAgICAgICAgICAgICAgICAgICJ0eXBlIjogIm9z
ZCJ9LA0KICAgICAgICAgICAgICAgIHsgIm9wIjogImVtaXQifV19LA0KICAgICAgICB7ICJydWxl
X2lkIjogNCwNCiAgICAgICAgICAicnVsZV9uYW1lIjogImZhc3RyZ3ciLA0KICAgICAgICAgICJy
dWxlc2V0IjogNTAsDQogICAgICAgICAgInR5cGUiOiAxLA0KICAgICAgICAgICJtaW5fc2l6ZSI6
IDEsDQogICAgICAgICAgIm1heF9zaXplIjogMTAsDQogICAgICAgICAgInN0ZXBzIjogWw0KICAg
ICAgICAgICAgICAgIHsgIm9wIjogInRha2UiLA0KICAgICAgICAgICAgICAgICAgIml0ZW0iOiAt
NTAxLA0KICAgICAgICAgICAgICAgICAgIml0ZW1fbmFtZSI6ICJmYXN0cmd3In0sDQogICAgICAg
ICAgICAgICAgeyAib3AiOiAiY2hvb3NlbGVhZl9maXJzdG4iLA0KICAgICAgICAgICAgICAgICAg
Im51bSI6IDAsDQogICAgICAgICAgICAgICAgICAidHlwZSI6ICJvc2QifSwNCiAgICAgICAgICAg
ICAgICB7ICJvcCI6ICJlbWl0In1dfSwNCiAgICAgICAgeyAicnVsZV9pZCI6IDUsDQogICAgICAg
ICAgInJ1bGVfbmFtZSI6ICJzbG93cmd3IiwNCiAgICAgICAgICAicnVsZXNldCI6IDUxLA0KICAg
ICAgICAgICJ0eXBlIjogMSwNCiAgICAgICAgICAibWluX3NpemUiOiAxLA0KICAgICAgICAgICJt
YXhfc2l6ZSI6IDEwLA0KICAgICAgICAgICJzdGVwcyI6IFsNCiAgICAgICAgICAgICAgICB7ICJv
cCI6ICJ0YWtlIiwNCiAgICAgICAgICAgICAgICAgICJpdGVtIjogLTUwMiwNCiAgICAgICAgICAg
ICAgICAgICJpdGVtX25hbWUiOiAic2xvd3JndyJ9LA0KICAgICAgICAgICAgICAgIHsgIm9wIjog
ImNob29zZWxlYWZfZmlyc3RuIiwNCiAgICAgICAgICAgICAgICAgICJudW0iOiAwLA0KICAgICAg
ICAgICAgICAgICAgInR5cGUiOiAib3NkIn0sDQogICAgICAgICAgICAgICAgeyAib3AiOiAiZW1p
dCJ9XX0sDQogICAgICAgIHsgInJ1bGVfaWQiOiA2LA0KICAgICAgICAgICJydWxlX25hbWUiOiAi
Y2FjaGVkYXRhIiwNCiAgICAgICAgICAicnVsZXNldCI6IDMwLA0KICAgICAgICAgICJ0eXBlIjog
MSwNCiAgICAgICAgICAibWluX3NpemUiOiAxLA0KICAgICAgICAgICJtYXhfc2l6ZSI6IDEwLA0K
ICAgICAgICAgICJzdGVwcyI6IFsNCiAgICAgICAgICAgICAgICB7ICJvcCI6ICJ0YWtlIiwNCiAg
ICAgICAgICAgICAgICAgICJpdGVtIjogLTUxMSwNCiAgICAgICAgICAgICAgICAgICJpdGVtX25h
bWUiOiAiZmFzdHN0ZCJ9LA0KICAgICAgICAgICAgICAgIHsgIm9wIjogImNob29zZWxlYWZfZmly
c3RuIiwNCiAgICAgICAgICAgICAgICAgICJudW0iOiAwLA0KICAgICAgICAgICAgICAgICAgInR5
cGUiOiAib3NkIn0sDQogICAgICAgICAgICAgICAgeyAib3AiOiAiZW1pdCJ9XX0sDQogICAgICAg
IHsgInJ1bGVfaWQiOiA3LA0KICAgICAgICAgICJydWxlX25hbWUiOiAiZXJhc3VyZS1jb2RlIiwN
CiAgICAgICAgICAicnVsZXNldCI6IDUyLA0KICAgICAgICAgICJ0eXBlIjogMywNCiAgICAgICAg
ICAibWluX3NpemUiOiAzLA0KICAgICAgICAgICJtYXhfc2l6ZSI6IDIwLA0KICAgICAgICAgICJz
dGVwcyI6IFsNCiAgICAgICAgICAgICAgICB7ICJvcCI6ICJzZXRfY2hvb3NlbGVhZl90cmllcyIs
DQogICAgICAgICAgICAgICAgICAibnVtIjogNX0sDQogICAgICAgICAgICAgICAgeyAib3AiOiAi
dGFrZSIsDQogICAgICAgICAgICAgICAgICAiaXRlbSI6IC0xLA0KICAgICAgICAgICAgICAgICAg
Iml0ZW1fbmFtZSI6ICJkZWZhdWx0In0sDQogICAgICAgICAgICAgICAgeyAib3AiOiAiY2hvb3Nl
bGVhZl9pbmRlcCIsDQogICAgICAgICAgICAgICAgICAibnVtIjogMCwNCiAgICAgICAgICAgICAg
ICAgICJ0eXBlIjogImhvc3QifSwNCiAgICAgICAgICAgICAgICB7ICJvcCI6ICJlbWl0In1dfSwN
CiAgICAgICAgeyAicnVsZV9pZCI6IDgsDQogICAgICAgICAgInJ1bGVfbmFtZSI6ICJlY3J1bGVz
ZXQiLA0KICAgICAgICAgICJydWxlc2V0IjogNTMsDQogICAgICAgICAgInR5cGUiOiAzLA0KICAg
ICAgICAgICJtaW5fc2l6ZSI6IDMsDQogICAgICAgICAgIm1heF9zaXplIjogMjAsDQogICAgICAg
ICAgInN0ZXBzIjogWw0KICAgICAgICAgICAgICAgIHsgIm9wIjogInNldF9jaG9vc2VsZWFmX3Ry
aWVzIiwNCiAgICAgICAgICAgICAgICAgICJudW0iOiA1fSwNCiAgICAgICAgICAgICAgICB7ICJv
cCI6ICJ0YWtlIiwNCiAgICAgICAgICAgICAgICAgICJpdGVtIjogLTEsDQogICAgICAgICAgICAg
ICAgICAiaXRlbV9uYW1lIjogImRlZmF1bHQifSwNCiAgICAgICAgICAgICAgICB7ICJvcCI6ICJj
aG9vc2VfaW5kZXAiLA0KICAgICAgICAgICAgICAgICAgIm51bSI6IDAsDQogICAgICAgICAgICAg
ICAgICAidHlwZSI6ICJvc2QifSwNCiAgICAgICAgICAgICAgICB7ICJvcCI6ICJlbWl0In1dfV0s
DQogICJ0dW5hYmxlcyI6IHsgImNob29zZV9sb2NhbF90cmllcyI6IDAsDQogICAgICAiY2hvb3Nl
X2xvY2FsX2ZhbGxiYWNrX3RyaWVzIjogMCwNCiAgICAgICJjaG9vc2VfdG90YWxfdHJpZXMiOiA1
MCwNCiAgICAgICJjaG9vc2VsZWFmX2Rlc2NlbmRfb25jZSI6IDEsDQogICAgICAicHJvZmlsZSI6
ICJmaXJlZmx5IiwNCiAgICAgICJvcHRpbWFsX3R1bmFibGVzIjogMSwNCiAgICAgICJsZWdhY3lf
dHVuYWJsZXMiOiAwLA0KICAgICAgInJlcXVpcmVfZmVhdHVyZV90dW5hYmxlcyI6IDEsDQogICAg
ICAicmVxdWlyZV9mZWF0dXJlX3R1bmFibGVzMiI6IDF9fQ0K

--_002_B9C8EFBF13B1354DB5FA000660D66DD00C18CBCEPEXCVZYM14corpo_--
