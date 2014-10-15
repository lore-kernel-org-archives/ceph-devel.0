From: Loic Dachary <loic@dachary.org>
Subject: Re: NO pg created for erasure-coded pool
Date: Wed, 15 Oct 2014 08:32:37 -0700
Message-ID: <543E9395.2050103@dachary.org>
References: <495_1413299690_543D3DEA_495_10637_1_B9C8EFBF13B1354DB5FA000660D66DD00C18CBCE@PEXCVZYM14.corporate.adroot.infra.ftgroup> <543D48C0.8040108@dachary.org> <32273_1413360033_543E29A1_32273_4484_1_B9C8EFBF13B1354DB5FA000660D66DD00C18D178@PEXCVZYM14.corporate.adroot.infra.ftgroup> <543E60AE.30506@dachary.org> <25839_1413381708_543E7E4B_25839_7399_1_B9C8EFBF13B1354DB5FA000660D66DD00C18D441@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="aLFh1pJ07F37GQANpk6WrHDTCTHAlwUD3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45966 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751678AbaJOPcl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Oct 2014 11:32:41 -0400
In-Reply-To: <25839_1413381708_543E7E4B_25839_7399_1_B9C8EFBF13B1354DB5FA000660D66DD00C18D441@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aLFh1pJ07F37GQANpk6WrHDTCTHAlwUD3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ghislain,

Any error messages in the mon / osd ?

Cheers

On 15/10/2014 07:01, ghislain.chevalier@orange.com wrote:
> Hi...
>=20
> Strange, you said strange...
>=20
> I created a replicated pool (if it was what you asked for) as followed
> root@p-sbceph11:~# ceph osd pool create strangepool 128 128 replicated
> pool 'strangepool' created
> root@p-sbceph11:~# ceph osd pool set strangepool crush_ruleset 53=20
> set pool 108 crush_ruleset to 53
> root@p-sbceph11:~# ceph osd pool get strangepool size
> size: 3
> root@p-sbceph11:~#  rados lspools | grep strangepool
> strangepool
> root@p-sbceph11:~# ceph df
> GLOBAL:
>     SIZE       AVAIL      RAW USED     %RAW USED=20
>     97289M     69667M       27622M         28.39=20
> POOLS:
>     NAME                   ID      USED       %USED     MAX AVAIL     O=
BJECTS=20
>     data                   0       12241M     12.58        11090M      =
   186=20
>     metadata               1            0         0        11090M      =
     0=20
>     rbd                    2            0         0        13548M      =
     0=20
>     .rgw.root              3         1223         0        11090M      =
     4=20
>     .rgw.control           4            0         0        11090M      =
     8=20
>     .rgw                   5        13036         0        11090M      =
    87=20
>     .rgw.gc                6            0         0        11090M      =
    32=20
>     .log                   7            0         0        11090M      =
     0=20
>     .intent-log            8            0         0        11090M      =
     0=20
>     .usage                 9            0         0        11090M      =
     0=20
>     .users                 10         139         0        11090M      =
    13=20
>     .users.email           11         100         0        11090M      =
     9=20
>     .users.swift           12          43         0        11090M      =
     4=20
>     .users.uid             13        3509         0        11090M      =
    22=20
>     .rgw.buckets.index     15           0         0        11090M      =
    31=20
>     .rgw.buckets           16       1216M      1.25        11090M      =
  2015=20
>     atelier01              87           0         0         7393M      =
     0=20
>     atelier02              94      28264k      0.03        11090M      =
     4=20
>     atelier02cache         98       6522k         0        20322M      =
     2=20
>     strangepool            108          0         0            5E      =
     0
>=20
> The pool is created and it doesn't work...
> rados -p strangepool put remains inactive...
>=20
> If there are active pgs for strangepool, it's surely because they were =
created with the default ruleset =3D 0.
>=20
> The problem seems to be in the control of the rule 53 ;  note that, for=
 debugging, the ruleset-failure-domain was previously set to osd instead =
of host. I don't think it's relevant.
>=20
> Finally, I don't know if you wanted me to create a replicated pool usin=
g a erasure ruleset or simply a new erasure-coded pool.
>=20
> Creating a new erasure-coded pool also fails.
>=20
> We also tried to create an erasure-coded pool on another platform using=
 a standard crushmap, and it fails too.
>=20
> Best regards
>=20
> -----Message d'origine-----
> De : Loic Dachary [mailto:loic@dachary.org]=20
> Envoy=E9 : mercredi 15 octobre 2014 13:55
> =C0 : CHEVALIER Ghislain IMT/OLPS; ceph-devel@vger.kernel.org
> Objet : Re: [Ceph-Devel] NO pg created for erasure-coded pool
>=20
> Hi Ghislain,
>=20
> This is indeed strange, the pool exists
>=20
> pool 100 'ecpool' erasure size 3 min_size 2 crush_ruleset 52 object_has=
h rjenkins pg_num 128 pgp_num 128 last_change 11849 flags hashpspool stri=
pe_width 4096
>=20
> but ceph pg dump shows no sign of the expected PG (i.e. starting with 1=
00. in the output if I'm not mistaken).
>=20
> Could you create another pool using the same ruleset and check if you s=
ee errors in the mon / osd logs when you do so ?
>=20
> Cheers
>=20
> On 15/10/2014 01:00, ghislain.chevalier@orange.com wrote:
>> Hi,
>>
>> Cause erasure-code is at the top of your mind...
>>
>> Here are the files
>>
>> Best regards
>>
>> -----Message d'origine-----
>> De : Loic Dachary [mailto:loic@dachary.org] Envoy=E9 : mardi 14 octobr=
e=20
>> 2014 18:01 =C0 : CHEVALIER Ghislain IMT/OLPS; ceph-devel@vger.kernel.o=
rg=20
>> Objet : Re: [Ceph-Devel] NO pg created for erasure-coded pool
>>
>> Ah, my bad, did not go to the end of the list ;-)
>>
>> could you share the output of ceph pg dump and ceph osd dump ?
>>
>> On 14/10/2014 08:14, ghislain.chevalier@orange.com wrote:
>>> Hi,
>>>
>>> Here is the list of the types. host is type 1
>>>   "types": [
>>>         { "type_id": 0,
>>>           "name": "osd"},
>>>         { "type_id": 1,
>>>           "name": "host"},
>>>         { "type_id": 2,
>>>           "name": "platform"},
>>>         { "type_id": 3,
>>>           "name": "datacenter"},
>>>         { "type_id": 4,
>>>           "name": "root"},
>>>         { "type_id": 5,
>>>           "name": "appclient"},
>>>         { "type_id": 10,
>>>           "name": "diskclass"},
>>>         { "type_id": 50,
>>>           "name": "appclass"}],
>>>
>>> And there are 5 hosts with 2 osds each at the end of the tree.
>>>
>>> Best regards
>>> -----Message d'origine-----
>>> De : Loic Dachary [mailto:loic@dachary.org] Envoy=E9 : mardi 14 octob=
re
>>> 2014 16:44 =C0 : CHEVALIER Ghislain IMT/OLPS;=20
>>> ceph-devel@vger.kernel.org Objet : Re: [Ceph-Devel] NO pg created for=
=20
>>> eruasre-coded pool
>>>
>>> Hi,
>>>
>>> The ruleset has
>>>
>>> { "op": "chooseleaf_indep",
>>>           "num": 0,
>>>           "type": "host"},
>>>
>>> but it does not look like your tree has a bucket of type host in it.
>>>
>>> Cheers
>>>
>>> On 14/10/2014 06:20, ghislain.chevalier@orange.com wrote:
>>>> HI,
>>>>
>>>> THX Lo=EFc for your quick reply.
>>>>
>>>> Here is the result of ceph osd tree
>>>>
>>>> As showed at the last ceph day in Paris, we have multiple root but t=
he ruleset 52 entered the crushmap on root default.
>>>>
>>>> # id    weight  type name       up/down reweight
>>>> -100    0.09998 root diskroot
>>>> -110    0.04999         diskclass fastsata
>>>> 0       0.009995                        osd.0   up      1
>>>> 1       0.009995                        osd.1   up      1
>>>> 2       0.009995                        osd.2   up      1
>>>> 3       0.009995                        osd.3   up      1
>>>> -120    0.04999         diskclass slowsata
>>>> 4       0.009995                        osd.4   up      1
>>>> 5       0.009995                        osd.5   up      1
>>>> 6       0.009995                        osd.6   up      1
>>>> 7       0.009995                        osd.7   up      1
>>>> 8       0.009995                        osd.8   up      1
>>>> 9       0.009995                        osd.9   up      1
>>>> -5      0.2     root approot
>>>> -50     0.09999         appclient apprgw
>>>> -501    0.04999                 appclass fastrgw
>>>> 0       0.009995                                osd.0   up      1
>>>> 1       0.009995                                osd.1   up      1
>>>> 2       0.009995                                osd.2   up      1
>>>> 3       0.009995                                osd.3   up      1
>>>> -502    0.04999                 appclass slowrgw
>>>> 4       0.009995                                osd.4   up      1
>>>> 5       0.009995                                osd.5   up      1
>>>> 6       0.009995                                osd.6   up      1
>>>> 7       0.009995                                osd.7   up      1
>>>> 8       0.009995                                osd.8   up      1
>>>> 9       0.009995                                osd.9   up      1
>>>> -51     0.09999         appclient appstd
>>>> -511    0.04999                 appclass faststd
>>>> 0       0.009995                                osd.0   up      1
>>>> 1       0.009995                                osd.1   up      1
>>>> 2       0.009995                                osd.2   up      1
>>>> 3       0.009995                                osd.3   up      1
>>>> -512    0.04999                 appclass slowstd
>>>> 4       0.009995                                osd.4   up      1
>>>> 5       0.009995                                osd.5   up      1
>>>> 6       0.009995                                osd.6   up      1
>>>> 7       0.009995                                osd.7   up      1
>>>> 8       0.009995                                osd.8   up      1
>>>> 9       0.009995                                osd.9   up      1
>>>> -1      0.09999 root default
>>>> -2      0.09999         datacenter nanterre
>>>> -3      0.09999                 platform sandbox
>>>> -13     0.01999                         host p-sbceph13
>>>> 0       0.009995                                        osd.0   up  =
    1
>>>> 5       0.009995                                        osd.5   up  =
    1
>>>> -14     0.01999                         host p-sbceph14
>>>> 1       0.009995                                        osd.1   up  =
    1
>>>> 6       0.009995                                        osd.6   up  =
    1
>>>> -15     0.01999                         host p-sbceph15
>>>> 2       0.009995                                        osd.2   up  =
    1
>>>> 7       0.009995                                        osd.7   up  =
    1
>>>> -12     0.01999                         host p-sbceph12
>>>> 3       0.009995                                        osd.3   up  =
    1
>>>> 8       0.009995                                        osd.8   up  =
    1
>>>> -11     0.01999                         host p-sbceph11
>>>> 4       0.009995                                        osd.4   up  =
    1
>>>> 9       0.009995                                        osd.9   up  =
    1
>>>>
>>>> Best regards
>>>>
>>>> -----Message d'origine-----
>>>> De : Loic Dachary [mailto:loic@dachary.org] Envoy=E9 : mardi 14=20
>>>> octobre
>>>> 2014 12:12 =C0 : CHEVALIER Ghislain IMT/OLPS;=20
>>>> ceph-devel@vger.kernel.org Objet : Re: [Ceph-Devel] NO pg created=20
>>>> for eruasre-coded pool
>>>>
>>>>
>>>>
>>>> On 14/10/2014 02:07, ghislain.chevalier@orange.com wrote:
>>>>> Hi all,
>>>>>
>>>>> Context :
>>>>> Ceph : Firefly 0.80.6
>>>>> Sandbox Platform  : Ubuntu 12.04 LTS, 5 VM (VMware), 3 mons, 10 osd=

>>>>>
>>>>>
>>>>> Issue:
>>>>> I created an erasure-coded pool using the default profile
>>>>> --> ceph osd pool create ecpool 128 128 erasure default
>>>>> the erasure-code rule was dynamically created and associated to the=
 pool.
>>>>> root@p-sbceph14:/etc/ceph# ceph osd crush rule dump erasure-code {
>>>>> "rule_id": 7,
>>>>>   "rule_name": "erasure-code",
>>>>>   "ruleset": 52,
>>>>>   "type": 3,
>>>>>   "min_size": 3,
>>>>>   "max_size": 20,
>>>>>   "steps": [
>>>>>         { "op": "set_chooseleaf_tries",
>>>>>           "num": 5},
>>>>>         { "op": "take",
>>>>>           "item": -1,
>>>>>           "item_name": "default"},
>>>>>         { "op": "chooseleaf_indep",
>>>>>           "num": 0,
>>>>>           "type": "host"},
>>>>>         { "op": "emit"}]}
>>>>> root@p-sbceph14:/var/log/ceph# ceph osd pool get ecpool=20
>>>>> crush_ruleset
>>>>> crush_ruleset: 52
>>>>
>>>>> No error message was displayed at pool creation but no pgs were cre=
ated.
>>>>> --> rados lspools confirms the pool is created but rados/ceph df=20
>>>>> --> shows no pg for this pool
>>>>>
>>>>> The command  "rados -p ecpool put services /etc/services" is=20
>>>>> inactive
>>>>> (stalled) and the following message is encountered in ceph.log
>>>>> 2014-10-14 10:36:50.189432 osd.5 10.192.134.123:6804/21505 799 :=20
>>>>> [WRN] slow request 960.230073 seconds old, received at 2014-10-14
>>>>> 10:20:49.959255: osd_op(client.1192643.0:1 services [writefull=20
>>>>> 0~19281] 100.5a48a9c2 ondisk+write e11869) v4 currently waiting for=
=20
>>>>> pg to exist locally
>>>>>
>>>>> I don't know if I missed something or if the problem is somewhere e=
lse..
>>>>
>>>> The erasure-code rule displayed will need at least three hosts. If t=
here are not enough hosts with OSDs the mapping will fail and put will ha=
ng until an OSD becomes available to complete the mapping of OSDs to the =
PGs. What does your ceph osd tree shows ?
>>>>
>>>> Cheers
>>>>
>>>>>
>>>>> Best regards
>>>>> =20
>>>>> =20
>>>>> =20
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> ___________________________________________________________________=

>>>>> _ _ _ ___________________________________________________
>>>>>
>>>>> Ce message et ses pieces jointes peuvent contenir des informations =

>>>>> confidentielles ou privilegiees et ne doivent donc pas etre=20
>>>>> diffuses, exploites ou copies sans autorisation. Si vous avez recu =

>>>>> ce message par erreur, veuillez le signaler a l'expediteur et le de=
truire ainsi que les pieces jointes. Les messages electroniques etant sus=
ceptibles d'alteration, Orange decline toute responsabilite si ce message=
 a ete altere, deforme ou falsifie. Merci.
>>>>>
>>>>> This message and its attachments may contain confidential or=20
>>>>> privileged information that may be protected by law; they should no=
t be distributed, used or copied without authorisation.
>>>>> If you have received this email in error, please notify the sender =
and delete this message and its attachments.
>>>>> As emails may be altered, Orange is not liable for messages that ha=
ve been modified, changed or falsified.
>>>>> Thank you.
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"=20
>>>>> in the body of a message to majordomo@vger.kernel.org More=20
>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> --
>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>
>>>>
>>>> ____________________________________________________________________=

>>>> _ _ ___________________________________________________
>>>>
>>>> Ce message et ses pieces jointes peuvent contenir des informations=20
>>>> confidentielles ou privilegiees et ne doivent donc pas etre=20
>>>> diffuses, exploites ou copies sans autorisation. Si vous avez recu=20
>>>> ce message par erreur, veuillez le signaler a l'expediteur et le det=
ruire ainsi que les pieces jointes. Les messages electroniques etant susc=
eptibles d'alteration, Orange decline toute responsabilite si ce message =
a ete altere, deforme ou falsifie. Merci.
>>>>
>>>> This message and its attachments may contain confidential or=20
>>>> privileged information that may be protected by law; they should not=
 be distributed, used or copied without authorisation.
>>>> If you have received this email in error, please notify the sender a=
nd delete this message and its attachments.
>>>> As emails may be altered, Orange is not liable for messages that hav=
e been modified, changed or falsified.
>>>> Thank you.
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>>>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>
>>>
>>> _____________________________________________________________________=

>>> _ ___________________________________________________
>>>
>>> Ce message et ses pieces jointes peuvent contenir des informations=20
>>> confidentielles ou privilegiees et ne doivent donc pas etre diffuses,=
=20
>>> exploites ou copies sans autorisation. Si vous avez recu ce message=20
>>> par erreur, veuillez le signaler a l'expediteur et le detruire ainsi =
que les pieces jointes. Les messages electroniques etant susceptibles d'a=
lteration, Orange decline toute responsabilite si ce message a ete altere=
, deforme ou falsifie. Merci.
>>>
>>> This message and its attachments may contain confidential or=20
>>> privileged information that may be protected by law; they should not =
be distributed, used or copied without authorisation.
>>> If you have received this email in error, please notify the sender an=
d delete this message and its attachments.
>>> As emails may be altered, Orange is not liable for messages that have=
 been modified, changed or falsified.
>>> Thank you.
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
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


--aLFh1pJ07F37GQANpk6WrHDTCTHAlwUD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ+k5UACgkQ8dLMyEl6F20sdwCgkOjCLFjmiQJAlnTbJ6cTK3o5
CSYAn04kyq+2BBaOA6piIT1YlAbFBxHn
=SDqz
-----END PGP SIGNATURE-----

--aLFh1pJ07F37GQANpk6WrHDTCTHAlwUD3--
