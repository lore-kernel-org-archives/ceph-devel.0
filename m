From: <ghislain.chevalier@orange.com>
Subject: RE: NO pg created for erasure-coded pool
Date: Thu, 16 Oct 2014 15:40:00 +0000
Message-ID: <6136_1413474000_543FE6D0_6136_10542_1_B9C8EFBF13B1354DB5FA000660D66DD00C190070@PEXCVZYM14.corporate.adroot.infra.ftgroup>
References: <495_1413299690_543D3DEA_495_10637_1_B9C8EFBF13B1354DB5FA000660D66DD00C18CBCE@PEXCVZYM14.corporate.adroot.infra.ftgroup>
 <543D48C0.8040108@dachary.org>
 <32273_1413360033_543E29A1_32273_4484_1_B9C8EFBF13B1354DB5FA000660D66DD00C18D178@PEXCVZYM14.corporate.adroot.infra.ftgroup>
 <543E60AE.30506@dachary.org>
 <25839_1413381708_543E7E4B_25839_7399_1_B9C8EFBF13B1354DB5FA000660D66DD00C18D441@PEXCVZYM14.corporate.adroot.infra.ftgroup>,<543E9395.2050103@dachary.org>
 <12314_1413388377_543E9859_12314_88_1_e31a4ed3-8007-4fdf-bece-520a699e62c3@PEXCVZYH01.corporate.adroot.infra.ftgroup>
 <543EAA32.5010408@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relais-ias91.francetelecom.com ([193.251.215.91]:19585 "EHLO
	relais-inet.francetelecom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751228AbaJPPkF convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Oct 2014 11:40:05 -0400
In-Reply-To: <543EAA32.5010408@dachary.org>
Content-Language: fr-FR
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Loic,

Excuse me for replying late

=46irst of all, Ii upgraded the platform to 0.80.7.

I turned osd and mon  in debug mode as mentionned

I re create the erasure-coded pool ecpool

At pool creation no "create_lock_pg" in osd logs ; no message in mon lo=
g
At object creation (rados put) I got=20
2014-10-16 16:29:29.700916 7f060accc700  7 mon.monitor03@2(peon).log v8=
91323 update_from_paxos applying incremental log 891323 2014-10-16 16:2=
9:28.369129 osd.5 10.192.134.123:6801/369 141 : [WRN] slow request 480.=
926547 seconds old, received at 2014-10-16 16:21:27.442543: osd_op(clie=
nt.1238183.0:
1 chat.wmv [writefull 0~3189321] 112.952dd230 ondisk+write e11938) v4 c=
urrently waiting for pg to exist locally

Without pg what could I expect...

The pool is listed by rados lspools or I can get some information by ce=
ph osd pool stats ecpool (id=3D113)

I created a replicated pool (poupool:114) and I got a lot of message as=
 followed on osd  targeted by the ruleset 0 (5,6,7,8,9)=20
2014-10-16 16:49:53.268083 7f1c31bb8700 20 osd.8 11942 _create_lock_pg =
pgid 114.6d
2014-10-16 16:49:53.268254 7f1c31bb8700  7 osd.8 11942 _create_lock_pg =
pg[114.6d( empty local-les=3D0 n=3D0 ec=3D11941 les/c 0/11941 11941/119=
41/11941) [9,8,5] r=3D1 lpr=3D0 crt=3D0'0 inactive]

I checked again the crushmap and nothing seems incorrect. So, I can't u=
nderstand where the problem is.

Best regards
NB : How can I switch back to a normal level of log?


-----Message d'origine-----
De=A0: Loic Dachary [mailto:loic@dachary.org]=20
Envoy=E9=A0: mercredi 15 octobre 2014 19:09
=C0=A0: CHEVALIER Ghislain IMT/OLPS; ceph-devel@vger.kernel.org
Objet=A0: Re: [Ceph-Devel] NO pg created for erasure-coded pool

Hi,

And nothing in any of the OSDS ? Since there are no errors in the MON t=
here must be something wrong in the OSD.

When the OSD is creating the PG you should see

   _create_lock_pg pgid

from

    https://github.com/ceph/ceph/blob/firefly/src/osd/OSD.cc#L1995

if you temporarily set the debug level to 20 with

ceph tell osd.* injectargs -- --debug-osd 20

If you still don't get anything at least this will narrow down the sear=
ch ;-)

Cheers

On 15/10/2014 08:52, ghislain.chevalier@orange.com wrote:
> Hi,
>=20
> oups..
>=20
> nothing relevant in mon logs.
>=20
> this message in some osd logs.
> 2014-10-15 17:03:45.303295 7fb296a21700  0 --=20
> 10.192.134.122:6804/16878 >> 10.192.134.123:6809/21505 pipe(0x2219c80=
=20
> sd=3D36 :41933 s=3D2 pgs=3D626 cs=3D355 l=3D0 c=3D0x398a580).fault wi=
th nothing to=20
> send, going to standby
>=20
> FYi, I can store in another pool (e.g. data).
>=20
> =20
> ________________________________________
> De : Loic Dachary [loic@dachary.org]
> Envoy=E9 : mercredi 15 octobre 2014 17:32 =C0 : CHEVALIER Ghislain=20
> IMT/OLPS; ceph-devel@vger.kernel.org Objet : Re: [Ceph-Devel] NO pg=20
> created for erasure-coded pool
>=20
> Hi Ghislain,
>=20
> Any error messages in the mon / osd ?
>=20
> Cheers
>=20
> On 15/10/2014 07:01, ghislain.chevalier@orange.com wrote:
>> Hi...
>>
>> Strange, you said strange...
>>
>> I created a replicated pool (if it was what you asked for) as=20
>> followed root@p-sbceph11:~# ceph osd pool create strangepool 128 128=
=20
>> replicated pool 'strangepool' created root@p-sbceph11:~# ceph osd=20
>> pool set strangepool crush_ruleset 53 set pool 108 crush_ruleset to=20
>> 53 root@p-sbceph11:~# ceph osd pool get strangepool size
>> size: 3
>> root@p-sbceph11:~#  rados lspools | grep strangepool strangepool=20
>> root@p-sbceph11:~# ceph df
>> GLOBAL:
>>     SIZE       AVAIL      RAW USED     %RAW USED
>>     97289M     69667M       27622M         28.39
>> POOLS:
>>     NAME                   ID      USED       %USED     MAX AVAIL   =
  OBJECTS
>>     data                   0       12241M     12.58        11090M   =
      186
>>     metadata               1            0         0        11090M   =
        0
>>     rbd                    2            0         0        13548M   =
        0
>>     .rgw.root              3         1223         0        11090M   =
        4
>>     .rgw.control           4            0         0        11090M   =
        8
>>     .rgw                   5        13036         0        11090M   =
       87
>>     .rgw.gc                6            0         0        11090M   =
       32
>>     .log                   7            0         0        11090M   =
        0
>>     .intent-log            8            0         0        11090M   =
        0
>>     .usage                 9            0         0        11090M   =
        0
>>     .users                 10         139         0        11090M   =
       13
>>     .users.email           11         100         0        11090M   =
        9
>>     .users.swift           12          43         0        11090M   =
        4
>>     .users.uid             13        3509         0        11090M   =
       22
>>     .rgw.buckets.index     15           0         0        11090M   =
       31
>>     .rgw.buckets           16       1216M      1.25        11090M   =
     2015
>>     atelier01              87           0         0         7393M   =
        0
>>     atelier02              94      28264k      0.03        11090M   =
        4
>>     atelier02cache         98       6522k         0        20322M   =
        2
>>     strangepool            108          0         0            5E   =
        0
>>
>> The pool is created and it doesn't work...
>> rados -p strangepool put remains inactive...
>>
>> If there are active pgs for strangepool, it's surely because they we=
re created with the default ruleset =3D 0.
>>
>> The problem seems to be in the control of the rule 53 ;  note that, =
for debugging, the ruleset-failure-domain was previously set to osd ins=
tead of host. I don't think it's relevant.
>>
>> Finally, I don't know if you wanted me to create a replicated pool u=
sing a erasure ruleset or simply a new erasure-coded pool.
>>
>> Creating a new erasure-coded pool also fails.
>>
>> We also tried to create an erasure-coded pool on another platform us=
ing a standard crushmap, and it fails too.
>>
>> Best regards
>>
>> -----Message d'origine-----
>> De : Loic Dachary [mailto:loic@dachary.org] Envoy=E9 : mercredi 15=20
>> octobre 2014 13:55 =C0 : CHEVALIER Ghislain IMT/OLPS;=20
>> ceph-devel@vger.kernel.org Objet : Re: [Ceph-Devel] NO pg created fo=
r=20
>> erasure-coded pool
>>
>> Hi Ghislain,
>>
>> This is indeed strange, the pool exists
>>
>> pool 100 'ecpool' erasure size 3 min_size 2 crush_ruleset 52=20
>> object_hash rjenkins pg_num 128 pgp_num 128 last_change 11849 flags=20
>> hashpspool stripe_width 4096
>>
>> but ceph pg dump shows no sign of the expected PG (i.e. starting wit=
h 100. in the output if I'm not mistaken).
>>
>> Could you create another pool using the same ruleset and check if yo=
u see errors in the mon / osd logs when you do so ?
>>
>> Cheers
>>
>> On 15/10/2014 01:00, ghislain.chevalier@orange.com wrote:
>>> Hi,
>>>
>>> Cause erasure-code is at the top of your mind...
>>>
>>> Here are the files
>>>
>>> Best regards
>>>
>>> -----Message d'origine-----
>>> De : Loic Dachary [mailto:loic@dachary.org] Envoy=E9 : mardi 14=20
>>> octobre
>>> 2014 18:01 =C0 : CHEVALIER Ghislain IMT/OLPS;=20
>>> ceph-devel@vger.kernel.org Objet : Re: [Ceph-Devel] NO pg created=20
>>> for erasure-coded pool
>>>
>>> Ah, my bad, did not go to the end of the list ;-)
>>>
>>> could you share the output of ceph pg dump and ceph osd dump ?
>>>
>>> On 14/10/2014 08:14, ghislain.chevalier@orange.com wrote:
>>>> Hi,
>>>>
>>>> Here is the list of the types. host is type 1
>>>>   "types": [
>>>>         { "type_id": 0,
>>>>           "name": "osd"},
>>>>         { "type_id": 1,
>>>>           "name": "host"},
>>>>         { "type_id": 2,
>>>>           "name": "platform"},
>>>>         { "type_id": 3,
>>>>           "name": "datacenter"},
>>>>         { "type_id": 4,
>>>>           "name": "root"},
>>>>         { "type_id": 5,
>>>>           "name": "appclient"},
>>>>         { "type_id": 10,
>>>>           "name": "diskclass"},
>>>>         { "type_id": 50,
>>>>           "name": "appclass"}],
>>>>
>>>> And there are 5 hosts with 2 osds each at the end of the tree.
>>>>
>>>> Best regards
>>>> -----Message d'origine-----
>>>> De : Loic Dachary [mailto:loic@dachary.org] Envoy=E9 : mardi 14=20
>>>> octobre
>>>> 2014 16:44 =C0 : CHEVALIER Ghislain IMT/OLPS;=20
>>>> ceph-devel@vger.kernel.org Objet : Re: [Ceph-Devel] NO pg created=20
>>>> for eruasre-coded pool
>>>>
>>>> Hi,
>>>>
>>>> The ruleset has
>>>>
>>>> { "op": "chooseleaf_indep",
>>>>           "num": 0,
>>>>           "type": "host"},
>>>>
>>>> but it does not look like your tree has a bucket of type host in i=
t.
>>>>
>>>> Cheers
>>>>
>>>> On 14/10/2014 06:20, ghislain.chevalier@orange.com wrote:
>>>>> HI,
>>>>>
>>>>> THX Lo=EFc for your quick reply.
>>>>>
>>>>> Here is the result of ceph osd tree
>>>>>
>>>>> As showed at the last ceph day in Paris, we have multiple root bu=
t the ruleset 52 entered the crushmap on root default.
>>>>>
>>>>> # id    weight  type name       up/down reweight
>>>>> -100    0.09998 root diskroot
>>>>> -110    0.04999         diskclass fastsata
>>>>> 0       0.009995                        osd.0   up      1
>>>>> 1       0.009995                        osd.1   up      1
>>>>> 2       0.009995                        osd.2   up      1
>>>>> 3       0.009995                        osd.3   up      1
>>>>> -120    0.04999         diskclass slowsata
>>>>> 4       0.009995                        osd.4   up      1
>>>>> 5       0.009995                        osd.5   up      1
>>>>> 6       0.009995                        osd.6   up      1
>>>>> 7       0.009995                        osd.7   up      1
>>>>> 8       0.009995                        osd.8   up      1
>>>>> 9       0.009995                        osd.9   up      1
>>>>> -5      0.2     root approot
>>>>> -50     0.09999         appclient apprgw
>>>>> -501    0.04999                 appclass fastrgw
>>>>> 0       0.009995                                osd.0   up      1
>>>>> 1       0.009995                                osd.1   up      1
>>>>> 2       0.009995                                osd.2   up      1
>>>>> 3       0.009995                                osd.3   up      1
>>>>> -502    0.04999                 appclass slowrgw
>>>>> 4       0.009995                                osd.4   up      1
>>>>> 5       0.009995                                osd.5   up      1
>>>>> 6       0.009995                                osd.6   up      1
>>>>> 7       0.009995                                osd.7   up      1
>>>>> 8       0.009995                                osd.8   up      1
>>>>> 9       0.009995                                osd.9   up      1
>>>>> -51     0.09999         appclient appstd
>>>>> -511    0.04999                 appclass faststd
>>>>> 0       0.009995                                osd.0   up      1
>>>>> 1       0.009995                                osd.1   up      1
>>>>> 2       0.009995                                osd.2   up      1
>>>>> 3       0.009995                                osd.3   up      1
>>>>> -512    0.04999                 appclass slowstd
>>>>> 4       0.009995                                osd.4   up      1
>>>>> 5       0.009995                                osd.5   up      1
>>>>> 6       0.009995                                osd.6   up      1
>>>>> 7       0.009995                                osd.7   up      1
>>>>> 8       0.009995                                osd.8   up      1
>>>>> 9       0.009995                                osd.9   up      1
>>>>> -1      0.09999 root default
>>>>> -2      0.09999         datacenter nanterre
>>>>> -3      0.09999                 platform sandbox
>>>>> -13     0.01999                         host p-sbceph13
>>>>> 0       0.009995                                        osd.0   u=
p      1
>>>>> 5       0.009995                                        osd.5   u=
p      1
>>>>> -14     0.01999                         host p-sbceph14
>>>>> 1       0.009995                                        osd.1   u=
p      1
>>>>> 6       0.009995                                        osd.6   u=
p      1
>>>>> -15     0.01999                         host p-sbceph15
>>>>> 2       0.009995                                        osd.2   u=
p      1
>>>>> 7       0.009995                                        osd.7   u=
p      1
>>>>> -12     0.01999                         host p-sbceph12
>>>>> 3       0.009995                                        osd.3   u=
p      1
>>>>> 8       0.009995                                        osd.8   u=
p      1
>>>>> -11     0.01999                         host p-sbceph11
>>>>> 4       0.009995                                        osd.4   u=
p      1
>>>>> 9       0.009995                                        osd.9   u=
p      1
>>>>>
>>>>> Best regards
>>>>>
>>>>> -----Message d'origine-----
>>>>> De : Loic Dachary [mailto:loic@dachary.org] Envoy=E9 : mardi 14=20
>>>>> octobre
>>>>> 2014 12:12 =C0 : CHEVALIER Ghislain IMT/OLPS;=20
>>>>> ceph-devel@vger.kernel.org Objet : Re: [Ceph-Devel] NO pg created=
=20
>>>>> for eruasre-coded pool
>>>>>
>>>>>
>>>>>
>>>>> On 14/10/2014 02:07, ghislain.chevalier@orange.com wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Context :
>>>>>> Ceph : Firefly 0.80.6
>>>>>> Sandbox Platform  : Ubuntu 12.04 LTS, 5 VM (VMware), 3 mons, 10=20
>>>>>> osd
>>>>>>
>>>>>>
>>>>>> Issue:
>>>>>> I created an erasure-coded pool using the default profile
>>>>>> --> ceph osd pool create ecpool 128 128 erasure default
>>>>>> the erasure-code rule was dynamically created and associated to =
the pool.
>>>>>> root@p-sbceph14:/etc/ceph# ceph osd crush rule dump erasure-code=
=20
>>>>>> {
>>>>>> "rule_id": 7,
>>>>>>   "rule_name": "erasure-code",
>>>>>>   "ruleset": 52,
>>>>>>   "type": 3,
>>>>>>   "min_size": 3,
>>>>>>   "max_size": 20,
>>>>>>   "steps": [
>>>>>>         { "op": "set_chooseleaf_tries",
>>>>>>           "num": 5},
>>>>>>         { "op": "take",
>>>>>>           "item": -1,
>>>>>>           "item_name": "default"},
>>>>>>         { "op": "chooseleaf_indep",
>>>>>>           "num": 0,
>>>>>>           "type": "host"},
>>>>>>         { "op": "emit"}]}
>>>>>> root@p-sbceph14:/var/log/ceph# ceph osd pool get ecpool=20
>>>>>> crush_ruleset
>>>>>> crush_ruleset: 52
>>>>>
>>>>>> No error message was displayed at pool creation but no pgs were =
created.
>>>>>> --> rados lspools confirms the pool is created but rados/ceph df=
=20
>>>>>> --> shows no pg for this pool
>>>>>>
>>>>>> The command  "rados -p ecpool put services /etc/services" is=20
>>>>>> inactive
>>>>>> (stalled) and the following message is encountered in ceph.log
>>>>>> 2014-10-14 10:36:50.189432 osd.5 10.192.134.123:6804/21505 799 :
>>>>>> [WRN] slow request 960.230073 seconds old, received at 2014-10-1=
4
>>>>>> 10:20:49.959255: osd_op(client.1192643.0:1 services [writefull=20
>>>>>> 0~19281] 100.5a48a9c2 ondisk+write e11869) v4 currently waiting=20
>>>>>> for pg to exist locally
>>>>>>
>>>>>> I don't know if I missed something or if the problem is somewher=
e else..
>>>>>
>>>>> The erasure-code rule displayed will need at least three hosts. I=
f there are not enough hosts with OSDs the mapping will fail and put wi=
ll hang until an OSD becomes available to complete the mapping of OSDs =
to the PGs. What does your ceph osd tree shows ?
>>>>>
>>>>> Cheers
>>>>>
>>>>>>
>>>>>> Best regards
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> ________________________________________________________________=
_
>>>>>> __ _ _ _ ___________________________________________________
>>>>>>
>>>>>> Ce message et ses pieces jointes peuvent contenir des=20
>>>>>> informations confidentielles ou privilegiees et ne doivent donc=20
>>>>>> pas etre diffuses, exploites ou copies sans autorisation. Si vou=
s=20
>>>>>> avez recu ce message par erreur, veuillez le signaler a l'expedi=
teur et le detruire ainsi que les pieces jointes. Les messages electron=
iques etant susceptibles d'alteration, Orange decline toute responsabil=
ite si ce message a ete altere, deforme ou falsifie. Merci.
>>>>>>
>>>>>> This message and its attachments may contain confidential or=20
>>>>>> privileged information that may be protected by law; they should=
 not be distributed, used or copied without authorisation.
>>>>>> If you have received this email in error, please notify the send=
er and delete this message and its attachments.
>>>>>> As emails may be altered, Orange is not liable for messages that=
 have been modified, changed or falsified.
>>>>>> Thank you.
>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>>>>>> in the body of a message to majordomo@vger.kernel.org More=20
>>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>
>>>>>
>>>>> --
>>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>>
>>>>>
>>>>> _________________________________________________________________=
_
>>>>> __ _ _ ___________________________________________________
>>>>>
>>>>> Ce message et ses pieces jointes peuvent contenir des information=
s=20
>>>>> confidentielles ou privilegiees et ne doivent donc pas etre=20
>>>>> diffuses, exploites ou copies sans autorisation. Si vous avez rec=
u=20
>>>>> ce message par erreur, veuillez le signaler a l'expediteur et le =
detruire ainsi que les pieces jointes. Les messages electroniques etant=
 susceptibles d'alteration, Orange decline toute responsabilite si ce m=
essage a ete altere, deforme ou falsifie. Merci.
>>>>>
>>>>> This message and its attachments may contain confidential or=20
>>>>> privileged information that may be protected by law; they should =
not be distributed, used or copied without authorisation.
>>>>> If you have received this email in error, please notify the sende=
r and delete this message and its attachments.
>>>>> As emails may be altered, Orange is not liable for messages that =
have been modified, changed or falsified.
>>>>> Thank you.
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
>>>>> in the body of a message to majordomo@vger.kernel.org More=20
>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> --
>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>
>>>>
>>>> __________________________________________________________________=
_
>>>> __ _ ___________________________________________________
>>>>
>>>> Ce message et ses pieces jointes peuvent contenir des informations=
=20
>>>> confidentielles ou privilegiees et ne doivent donc pas etre=20
>>>> diffuses, exploites ou copies sans autorisation. Si vous avez recu=
=20
>>>> ce message par erreur, veuillez le signaler a l'expediteur et le d=
etruire ainsi que les pieces jointes. Les messages electroniques etant =
susceptibles d'alteration, Orange decline toute responsabilite si ce me=
ssage a ete altere, deforme ou falsifie. Merci.
>>>>
>>>> This message and its attachments may contain confidential or=20
>>>> privileged information that may be protected by law; they should n=
ot be distributed, used or copied without authorisation.
>>>> If you have received this email in error, please notify the sender=
 and delete this message and its attachments.
>>>> As emails may be altered, Orange is not liable for messages that h=
ave been modified, changed or falsified.
>>>> Thank you.
>>>>
>>>
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>
>>>
>>> ___________________________________________________________________=
_
>>> __ ___________________________________________________
>>>
>>> Ce message et ses pieces jointes peuvent contenir des informations=20
>>> confidentielles ou privilegiees et ne doivent donc pas etre=20
>>> diffuses, exploites ou copies sans autorisation. Si vous avez recu=20
>>> ce message par erreur, veuillez le signaler a l'expediteur et le de=
truire ainsi que les pieces jointes. Les messages electroniques etant s=
usceptibles d'alteration, Orange decline toute responsabilite si ce mes=
sage a ete altere, deforme ou falsifie. Merci.
>>>
>>> This message and its attachments may contain confidential or=20
>>> privileged information that may be protected by law; they should no=
t be distributed, used or copied without authorisation.
>>> If you have received this email in error, please notify the sender =
and delete this message and its attachments.
>>> As emails may be altered, Orange is not liable for messages that ha=
ve been modified, changed or falsified.
>>> Thank you.
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>>
>> ____________________________________________________________________=
_
>> ____________________________________________________
>>
>> Ce message et ses pieces jointes peuvent contenir des informations=20
>> confidentielles ou privilegiees et ne doivent donc pas etre diffuses=
,=20
>> exploites ou copies sans autorisation. Si vous avez recu ce message=20
>> par erreur, veuillez le signaler a l'expediteur et le detruire ainsi=
 que les pieces jointes. Les messages electroniques etant susceptibles =
d'alteration, Orange decline toute responsabilite si ce message a ete a=
ltere, deforme ou falsifie. Merci.
>>
>> This message and its attachments may contain confidential or=20
>> privileged information that may be protected by law; they should not=
 be distributed, used or copied without authorisation.
>> If you have received this email in error, please notify the sender a=
nd delete this message and its attachments.
>> As emails may be altered, Orange is not liable for messages that hav=
e been modified, changed or falsified.
>> Thank you.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20
> _____________________________________________________________________=
_
> ___________________________________________________
>=20
> Ce message et ses pieces jointes peuvent contenir des informations=20
> confidentielles ou privilegiees et ne doivent donc pas etre diffuses,=
=20
> exploites ou copies sans autorisation. Si vous avez recu ce message=20
> par erreur, veuillez le signaler a l'expediteur et le detruire ainsi =
que les pieces jointes. Les messages electroniques etant susceptibles d=
'alteration, Orange decline toute responsabilite si ce message a ete al=
tere, deforme ou falsifie. Merci.
>=20
> This message and its attachments may contain confidential or=20
> privileged information that may be protected by law; they should not =
be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender an=
d delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have=
 been modified, changed or falsified.
> Thank you.
>=20

--
Lo=EFc Dachary, Artisan Logiciel Libre


_______________________________________________________________________=
__________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations conf=
identielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez =
recu ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les message=
s electroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme=
 ou falsifie. Merci.

This message and its attachments may contain confidential or privileged=
 information that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and =
delete this message and its attachments.
As emails may be altered, Orange is not liable for messages that have b=
een modified, changed or falsified.
Thank you.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
