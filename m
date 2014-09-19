From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: severe librbd performance degradation in Giant
Date: Fri, 19 Sep 2014 12:09:41 +0200 (CEST)
Message-ID: <05b6cb89-4c21-4377-8418-0c9a24fd1e62@mailpro>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2784639B@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:55729 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaISKJv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 06:09:51 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2784639B@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Sage Weil <sweil@redhat.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org, Haomai Wang <haomaiwang@gmail.com>

>>What tool are you using ? I used fio rbd.=20

fio rbd too


[global]
ioengine=3Drbd
clientname=3Dadmin
pool=3Dtest
rbdname=3Dtest
invalidate=3D0=20
#rw=3Dread
#rw=3Drandwrite
#rw=3Dwrite
rw=3Drandread
bs=3D4k
direct=3D1
numjobs=3D2
group_reporting=3D1
size=3D10G

[rbd_iodepth32]
iodepth=3D32



I just notice something strange

with rbd_cache=3Dtrue , I got around 60000iops  (and I don't see any ne=
twork traffic)

So maybe they are a bug in fio ?
maybe this is related to:


http://tracker.ceph.com/issues/9391
"fio rbd driver rewrites same blocks"

----- Mail original -----=20

De: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>, "Haomai Wang" <haom=
aiwang@gmail.com>=20
Cc: "Sage Weil" <sweil@redhat.com>, "Josh Durgin" <josh.durgin@inktank.=
com>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Jeudi 18 Septembre 2014 20:02:49=20
Objet: RE: severe librbd performance degradation in Giant=20

Alexandre,=20
What tool are you using ? I used fio rbd.=20

Also, I hope you have Giant package installed in the client side as wel=
l and rbd_cache =3Dtrue is set on the client conf file.=20
=46YI, firefly librbd + librados and Giant cluster will work seamlessly=
 and I had to make sure fio rbd is really loading giant librbd (if you =
have multiple copies around , which was in my case) for reproducing it.=
=20

Thanks & Regards=20
Somnath=20

-----Original Message-----=20
=46rom: Alexandre DERUMIER [mailto:aderumier@odiso.com]=20
Sent: Thursday, September 18, 2014 2:49 AM=20
To: Haomai Wang=20
Cc: Sage Weil; Josh Durgin; ceph-devel@vger.kernel.org; Somnath Roy=20
Subject: Re: severe librbd performance degradation in Giant=20

>>According http://tracker.ceph.com/issues/9513, do you mean that rbd=20
>>cache will make 10x performance degradation for random read?=20

Hi, on my side, I don't see any degradation performance on read (seq or=
 rand) with or without.=20

firefly : around 12000iops (with or without rbd_cache) giant : around 1=
2000iops (with or without rbd_cache)=20

(and I can reach around 20000-30000 iops on giant with disabling optrac=
ker).=20


rbd_cache only improve write performance for me (4k block )=20



----- Mail original -----=20

De: "Haomai Wang" <haomaiwang@gmail.com>=20
=C3=80: "Somnath Roy" <Somnath.Roy@sandisk.com>=20
Cc: "Sage Weil" <sweil@redhat.com>, "Josh Durgin" <josh.durgin@inktank.=
com>, ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Jeudi 18 Septembre 2014 04:27:56=20
Objet: Re: severe librbd performance degradation in Giant=20

According http://tracker.ceph.com/issues/9513, do you mean that rbd cac=
he will make 10x performance degradation for random read?=20

On Thu, Sep 18, 2014 at 7:44 AM, Somnath Roy <Somnath.Roy@sandisk.com> =
wrote:=20
> Josh/Sage,=20
> I should mention that even after turning off rbd cache I am getting ~=
20% degradation over Firefly.=20
>=20
> Thanks & Regards=20
> Somnath=20
>=20
> -----Original Message-----=20
> From: Somnath Roy=20
> Sent: Wednesday, September 17, 2014 2:44 PM=20
> To: Sage Weil=20
> Cc: Josh Durgin; ceph-devel@vger.kernel.org=20
> Subject: RE: severe librbd performance degradation in Giant=20
>=20
> Created a tracker for this.=20
>=20
> http://tracker.ceph.com/issues/9513=20
>=20
> Thanks & Regards=20
> Somnath=20
>=20
> -----Original Message-----=20
> From: ceph-devel-owner@vger.kernel.org=20
> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy=20
> Sent: Wednesday, September 17, 2014 2:39 PM=20
> To: Sage Weil=20
> Cc: Josh Durgin; ceph-devel@vger.kernel.org=20
> Subject: RE: severe librbd performance degradation in Giant=20
>=20
> Sage,=20
> It's a 4K random read.=20
>=20
> Thanks & Regards=20
> Somnath=20
>=20
> -----Original Message-----=20
> From: Sage Weil [mailto:sweil@redhat.com]=20
> Sent: Wednesday, September 17, 2014 2:36 PM=20
> To: Somnath Roy=20
> Cc: Josh Durgin; ceph-devel@vger.kernel.org=20
> Subject: RE: severe librbd performance degradation in Giant=20
>=20
> What was the io pattern? Sequential or random? For random a slowdown =
makes sense (tho maybe not 10x!) but not for sequentail....=20
>=20
> s=20
>=20
> On Wed, 17 Sep 2014, Somnath Roy wrote:=20
>=20
>> I set the following in the client side /etc/ceph/ceph.conf where I a=
m running fio rbd.=20
>>=20
>> rbd_cache_writethrough_until_flush =3D false=20
>>=20
>> But, no difference. BTW, I am doing Random read, not write. Still th=
is setting applies ?=20
>>=20
>> Next, I tried to tweak the rbd_cache setting to false and I *got bac=
k* the old performance. Now, it is similar to firefly throughput !=20
>>=20
>> So, loks like rbd_cache=3Dtrue was the culprit.=20
>>=20
>> Thanks Josh !=20
>>=20
>> Regards=20
>> Somnath=20
>>=20
>> -----Original Message-----=20
>> From: Josh Durgin [mailto:josh.durgin@inktank.com]=20
>> Sent: Wednesday, September 17, 2014 2:20 PM=20
>> To: Somnath Roy; ceph-devel@vger.kernel.org=20
>> Subject: Re: severe librbd performance degradation in Giant=20
>>=20
>> On 09/17/2014 01:55 PM, Somnath Roy wrote:=20
>> > Hi Sage,=20
>> > We are experiencing severe librbd performance degradation in Giant=
 over firefly release. Here is the experiment we did to isolate it as a=
 librbd problem.=20
>> >=20
>> > 1. Single OSD is running latest Giant and client is running fio rb=
d on top of firefly based librbd/librados. For one client it is giving =
~11-12K iops (4K RR).=20
>> > 2. Single OSD is running Giant and client is running fio rbd on to=
p of Giant based librbd/librados. For one client it is giving ~1.9K iop=
s (4K RR).=20
>> > 3. Single OSD is running latest Giant and client is running Giant =
based ceph_smaiobench on top of giant librados. For one client it is gi=
ving ~11-12K iops (4K RR).=20
>> > 4. Giant RGW on top of Giant OSD is also scaling.=20
>> >=20
>> >=20
>> > So, it is obvious from the above that recent librbd has issues. I =
will raise a tracker to track this.=20
>>=20
>> For giant the default cache settings changed to:=20
>>=20
>> rbd cache =3D true=20
>> rbd cache writethrough until flush =3D true=20
>>=20
>> If fio isn't sending flushes as the test is running, the cache will =
stay in writethrough mode. Does the difference remain if you set rbd ca=
che writethrough until flush =3D false ?=20
>>=20
>> Josh=20
>>=20
>> ________________________________=20
>>=20
>> PLEASE NOTE: The information contained in this electronic mail messa=
ge is intended only for the use of the designated recipient(s) named ab=
ove. If the reader of this message is not the intended recipient, you a=
re hereby notified that you have received this message in error and tha=
t any review, dissemination, distribution, or copying of this message i=
s strictly prohibited. If you have received this communication in error=
, please notify the sender by telephone or e-mail (as shown above) imme=
diately and destroy any and all copies of this message in your possessi=
on (whether hard copies or electronically stored copies).=20
>>=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=
=20
>> info at http://vger.kernel.org/majordomo-info.html=20
>>=20
>>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at http://vger.kernel.org/majordomo-info.html=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at http://vger.kernel.org/majordomo-info.html=20



--=20
Best Regards,=20

Wheat=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
